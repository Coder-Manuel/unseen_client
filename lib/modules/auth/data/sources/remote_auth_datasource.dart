import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RemoteAuthDatasource {
  Future<AuthResponse> loginWithPassword({required Map<String, dynamic> data});
  Future<AuthResponse> loginWithOAuth({
    required Map<String, dynamic> data,
    OAuthProvider provider = OAuthProvider.google,
  });
  Future<AuthResponse> signUp({
    required String password,
    String? email,
    String? phone,
    Map<String, dynamic>? data,
  });
  Future<void> logout();
}

class RemoteAuthDatasourceImpl extends RemoteAuthDatasource {
  final SupabaseClient client;

  RemoteAuthDatasourceImpl({required this.client});

  @override
  Future<AuthResponse> loginWithPassword({required Map<String, dynamic> data}) {
    return client.auth.signInWithPassword(
      email: data['email'],
      phone: data['phone'],
      password: data['password'],
    );
  }

  @override
  Future<AuthResponse> loginWithOAuth({
    required Map<String, dynamic> data,
    OAuthProvider provider = OAuthProvider.google,
  }) {
    return client.auth.signInWithIdToken(
      provider: provider,
      idToken: data['idToken'],
      accessToken: data['accessToken'],
    );
  }

  @override
  Future<AuthResponse> signUp({
    required String password,
    String? email,
    String? phone,
    Map<String, dynamic>? data,
  }) {
    return client.auth.signUp(password: password, email: email, phone: phone);
  }

  @override
  Future<void> logout() {
    return client.auth.signOut();
  }
}
