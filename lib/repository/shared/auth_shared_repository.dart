import 'package:shared_preferences/shared_preferences.dart';

class AuthSharedRepository {
  final SharedPreferences _sharedPreferences;

  AuthSharedRepository(this._sharedPreferences);

  void setTokens(String accessToken, String refreshToken) {
    _sharedPreferences.setString("access", accessToken);
    _sharedPreferences.setString("refresh", refreshToken);
  }

  void clear() {
    _sharedPreferences.remove("access");
    _sharedPreferences.remove("refresh");
    _sharedPreferences.remove("email");
    _sharedPreferences.remove("id");
  }

  void setEmail(String username) {
    _sharedPreferences.setString("email", username);
  }

  void setId(int id) {
    _sharedPreferences.setInt("id", id);
  }

  int? getId() {
    return _sharedPreferences.getInt("id");
  }

  String? getEmail() {
    return _sharedPreferences.getString("username");
  }

  String getAccessToken() {
    return _sharedPreferences.getString("access") ?? "";
  }

  String getRefreshToken() {
    return _sharedPreferences.getString("refresh") ?? "";
  }
}
