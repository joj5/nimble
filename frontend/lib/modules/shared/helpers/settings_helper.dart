import 'package:shared_preferences/shared_preferences.dart';

import 'dart:developer' as developer;

class SettingsHelper {
  static SettingsHelper? _instance;
  static SharedPreferences? _preferences;

  static const String vatKey = 'vat';
  static const String currencyKey = 'currency';
  static const String walkThroughKey = 'walkThrough';
  static const String budgetPeriodKey = 'budgetPeriod';

  double get vat => _getFromDisk(vatKey) ?? 0.00;
  set vat(double value) => _saveToDisk(vatKey, value);

  String get currency => _getFromDisk(currencyKey) ?? 'BBD';
  set currency(String value) => _saveToDisk(currencyKey, value);

  bool get walkThrough => _getFromDisk(walkThroughKey) ?? true;
  set walkThrough(bool value) => _saveToDisk(walkThroughKey, value);

  String get budgetPeriod => _getFromDisk(budgetPeriodKey) ?? 'Monthly';
  set budgetPeriod(String value) => _saveToDisk(budgetPeriodKey, value);

  static Future<SettingsHelper> getInstance() async {
    _instance ??= SettingsHelper();

    _preferences ??= await SharedPreferences.getInstance();

    return _instance!;
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences!.get(key);
    developer.log(
        '(TRACE) SettingsHelper:_getFromDisk. key: $key value: $value',
        name: 'com.recurjun.moneymatters');

    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    developer.log(
        '(TRACE) SettingsHelper:_saveToDisk. key: $key value: $content',
        name: 'com.recurjun.moneymatters');

    if (content is String) {
      _preferences!.setString(key, content);
    }
    if (content is bool) {
      _preferences!.setBool(key, content);
    }
    if (content is int) {
      _preferences!.setInt(key, content);
    }
    if (content is double) {
      _preferences!.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences!.setStringList(key, content);
    }
  }
}
