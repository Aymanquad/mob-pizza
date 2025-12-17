import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider({Locale initialLocale = const Locale('en')})
      : _locale = initialLocale;

  Locale _locale;

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale != locale) {
      _locale = locale;
      notifyListeners();
    }
  }

  void toggleLocale() {
    _locale = _locale.languageCode == 'en'
        ? const Locale('es')
        : const Locale('en');
    notifyListeners();
  }
}
