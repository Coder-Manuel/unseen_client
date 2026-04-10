import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:unseen/core/utils/toast.dart';
import 'package:unseen/modules/missions/data/sources/remote_places_datasource.dart';
import 'package:unseen/modules/missions/domain/entities/place_suggestion.entity.dart';
import 'package:unseen/modules/missions/presentation/controllers/post_mission_controller.dart';

class LocationPickerController extends GetxController {
  final _placesDatasource = Get.find<RemotePlacesDatasource>();

  // ── State ────────────────────────────────────────────────────────────────────
  final searchCTRL = TextEditingController();

  final RxList<PlaceSuggestionEntity> suggestions =
      <PlaceSuggestionEntity>[].obs;
  final RxBool showSuggestions = false.obs;
  final RxBool isSearching = false.obs;
  final RxBool isReverseGeocoding = false.obs;
  final RxBool isFetchingLocation = false.obs;

  /// The address displayed in the bottom confirmation bar.
  final RxString selectedAddress = ''.obs;

  /// Current map centre (updated on camera move).
  final Rx<LatLng> mapCenter = const LatLng(-1.2676, 36.8108).obs;

  // ── Map controller ────────────────────────────────────────────────────────
  GoogleMapController? _mapController;
  Timer? _debounce;
  Timer? _idleDebounce;

  // ── Initialisation ─────────────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();

    // Pre-fill with the current location already chosen in PostMissionController
    final postCtrl = Get.find<PostMissionController>();
    if (postCtrl.hasLocation.value) {
      mapCenter.value = LatLng(
        postCtrl.latitude.value,
        postCtrl.longitude.value,
      );
      selectedAddress.value = postCtrl.address.value;
    }
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  // ── Search / autocomplete ──────────────────────────────────────────────────

  void onSearchChanged(String query) {
    _debounce?.cancel();

    if (query.trim().isEmpty) {
      suggestions.clear();
      showSuggestions.value = false;
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 420), () async {
      isSearching.value = true;
      try {
        final results = await _placesDatasource.getAutocompleteSuggestions(
          query: query.trim(),
          latitude: mapCenter.value.latitude,
          longitude: mapCenter.value.longitude,
        );
        suggestions.assignAll(results);
        showSuggestions.value = results.isNotEmpty;
      } catch (_) {
        // Silently fail — user can still drop a pin
      } finally {
        isSearching.value = false;
      }
    });
  }

  Future<void> onSuggestionTap(PlaceSuggestionEntity suggestion) async {
    // Dismiss keyboard + suggestions
    searchCTRL.text = suggestion.mainText;
    showSuggestions.value = false;
    suggestions.clear();
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      final details =
          await _placesDatasource.getPlaceDetails(suggestion.placeId);
      final newLatLng = LatLng(details.latitude, details.longitude);
      mapCenter.value = newLatLng;
      selectedAddress.value = details.address;

      // Animate map to the chosen place
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(newLatLng, 16),
      );
    } catch (_) {
      Toast.error('Could not load place details. Try again.');
    }
  }

  // ── Pin drop (camera idle) ─────────────────────────────────────────────────

  /// Called every time the camera position changes.
  void onCameraMove(CameraPosition position) {
    _idleDebounce?.cancel();
    mapCenter.value = position.target;
  }

  /// Called when the camera stops moving — reverse-geocode the centre.
  void onCameraIdle() {
    // Only auto-reverse-geocode when the user is NOT picking from autocomplete
    if (showSuggestions.value) return;
    _idleDebounce = Timer(const Duration(milliseconds: 600), _reverseGeocodeCenter);
  }

  Future<void> _reverseGeocodeCenter() async {
    isReverseGeocoding.value = true;
    try {
      final address = await _placesDatasource.reverseGeocode(
        latitude: mapCenter.value.latitude,
        longitude: mapCenter.value.longitude,
      );
      selectedAddress.value = address;

      // Keep the search bar in sync with what the user dropped on
      if (searchCTRL.text.isEmpty) {
        searchCTRL.text = address;
      }
    } catch (_) {
      // Fall back to coordinates
      selectedAddress.value =
          '${mapCenter.value.latitude.toStringAsFixed(5)}, '
          '${mapCenter.value.longitude.toStringAsFixed(5)}';
    } finally {
      isReverseGeocoding.value = false;
    }
  }

  // ── Current location ──────────────────────────────────────────────────────

  Future<void> useCurrentLocation() async {
    isFetchingLocation.value = true;
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        Toast.error('Location permission is permanently denied. Enable it in Settings.');
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      final newLatLng = LatLng(position.latitude, position.longitude);
      mapCenter.value = newLatLng;

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(newLatLng, 16),
      );

      // Reverse-geocode the current position
      final address = await _placesDatasource.reverseGeocode(
        latitude: position.latitude,
        longitude: position.longitude,
      );
      selectedAddress.value = address;
      searchCTRL.text = address;
    } catch (e) {
      Toast.error('Could not get your location. Please try again.');
    } finally {
      isFetchingLocation.value = false;
    }
  }

  // ── Confirm ───────────────────────────────────────────────────────────────

  void confirmLocation() {
    if (selectedAddress.value.isEmpty) {
      Toast.error('No location selected yet. Move the pin or search above.');
      return;
    }

    Get.find<PostMissionController>().setLocation(
      address: selectedAddress.value,
      latitude: mapCenter.value.latitude,
      longitude: mapCenter.value.longitude,
    );

    Get.back();
  }

  // ── Cleanup ────────────────────────────────────────────────────────────────

  @override
  void onClose() {
    _debounce?.cancel();
    _idleDebounce?.cancel();
    searchCTRL.dispose();
    _mapController?.dispose();
    super.onClose();
  }
}
