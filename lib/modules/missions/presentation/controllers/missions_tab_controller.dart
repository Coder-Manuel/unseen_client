import 'package:get/get.dart';
import 'package:unseen/core/utils/toast.dart';
import 'package:unseen/modules/missions/domain/entities/mission.entity.dart';
import 'package:unseen/modules/missions/domain/usecases/get_my_missions.usecase.dart';

enum MissionFilter { all, active, pending, completed }

class MissionsTabController extends GetxController {
  final _getMyMissionsUseCase = Get.find<GetMyMissionsUseCase>();

  // ── State ─────────────────────────────────────────────────────────────────
  final RxList<MissionEntity> _missions = <MissionEntity>[].obs;
  final Rx<MissionFilter> activeFilter = MissionFilter.all.obs;
  final RxBool isLoading = true.obs;

  // ── Derived ───────────────────────────────────────────────────────────────

  List<MissionEntity> get filteredMissions {
    final filter = activeFilter.value;
    return switch (filter) {
      MissionFilter.all => _missions.toList(),
      MissionFilter.active => _missions
          .where(
            (m) =>
                m.status == MissionStatus.live ||
                m.status == MissionStatus.accepted,
          )
          .toList(),
      MissionFilter.pending =>
        _missions.where((m) => m.status == MissionStatus.open).toList(),
      MissionFilter.completed => _missions
          .where(
            (m) =>
                m.status == MissionStatus.completed ||
                m.status == MissionStatus.cancelled,
          )
          .toList(),
    };
  }

  // ── Lifecycle ─────────────────────────────────────────────────────────────

  @override
  void onReady() {
    super.onReady();
    fetchMissions();
  }

  // ── Actions ───────────────────────────────────────────────────────────────

  void setFilter(MissionFilter filter) => activeFilter.value = filter;

  Future<void> fetchMissions() async {
    isLoading.value = true;
    final response = await _getMyMissionsUseCase(null);
    isLoading.value = false;

    response.fold(
      (err) => Toast.error(err.message),
      (missions) => _missions.assignAll(missions),
    );
  }
}
