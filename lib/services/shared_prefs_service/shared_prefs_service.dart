import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences? get instance => _prefs;

  setApiToken(String json) => _prefs.setString("api_token", json);
  setString(String key, String value) => _prefs.setString(key, value);

  setCounter(int json) => _prefs.setInt("counter", json);
  get getCounter => _prefs.getInt("counter") ?? 0;

  get apiToken => _prefs.getString("api_token");
  setFcmToken(String json) => _prefs.setString("fcm_token", json);
  get fcmToken => _prefs.getString("fcm_token");
  String? get idToken => _prefs.getString("idToken");

  setIsLocalProviderEnable(bool value) =>
      _prefs.setBool("isLocalProviderEnable", value);
  get isLocalProviderEnable => _prefs.getBool("isLocalProviderEnable") ?? true;

  setUser(Map<String, dynamic> val) =>
      _prefs.setString("user", jsonEncode(val));
  String? get user => _prefs.getString("user");

  setAdmin(Map<String, dynamic> val) =>
      _prefs.setString("admin", jsonEncode(val));
  String? get admin => _prefs.getString("admin");

  removeApiToken() => _prefs.remove('api_token');
  clearUser() => _prefs.remove("user");

  setIsGuestMode(bool value) => _prefs.setBool("isGuestMode", value);
  get isGuestMode => _prefs.getBool("isGuestMode") ?? false;

  setIsNotificationEnable(bool value) => _prefs.setBool("settings", value);
  get isNotificationEnable => _prefs.getBool("settings") ?? false;

  /// Primary Card Id Setter & Getter
  setPrimaryCardId(String json) => _prefs.setString("card_id", json);
  get getPrimaryCardId => _prefs.getString("card_id");
  clearPrimaryCardId() => _prefs.remove("card_id");

  /// Primary Card Id Setter & Getter
  setPrimaryCard(Map<String, dynamic> val) =>
      _prefs.setString("card", jsonEncode(val));
  get getPrimaryCard => _prefs.getString("card");
  clearPrimaryCard() => _prefs.remove("card");

  flushValue(String key) {
    _prefs.remove(key);
  }

  void flushAll() async {
    // String? fcmToken = _prefs.getString("fcm_token");
    // _prefs.clear();
    // _prefs.setString("fcm_token", fcmToken!);
    await setIsGuestMode(false);
    await _prefs.remove("user");
    await _prefs.remove("admin");
    await _prefs.remove("api_token");
    await _prefs.remove("isEmailVerified");
    await _prefs.remove("isPhoneVerified");
    await _prefs.remove("setIndentity");
    await _prefs.remove("settings");
    clearPrimaryCardId();
    clearPrimaryCard();
    // await _box.erase();
  }
}
