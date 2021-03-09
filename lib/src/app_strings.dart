import 'dart:async';
import 'package:app_strings/src/language_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppStrings<T> {
  AppStrings(this.locale, this.localizedStrings);

  final Locale locale;
  final Map<String, T> localizedStrings;

  static T of<T>(BuildContext context) {
    final strings = Localizations.of<AppStrings>(context, AppStrings);
    return strings?.localizedStrings[strings.locale.languageCode];
  }

  static Iterable<Locale> supportedLocales =
      LanguageCode.languageCodes.map((e) => Locale(e, ''));

  static Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates<T>(
      Map<String, T> localizedStrings) {
    return [
      StringsDelegate<T>(localizedStrings),
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ];
  }
}

class StringsDelegate<T> extends LocalizationsDelegate<AppStrings> {
  Locale? _currentLocale;

  StringsDelegate(this._localizedStrings);

  final Map<String, T> _localizedStrings;

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<AppStrings> load(Locale locale) async {
    _currentLocale = locale;
    return AppStrings<T>(locale, _localizedStrings);
  }

  @override
  bool shouldReload(StringsDelegate old) {
    return this._currentLocale == null ||
        this._currentLocale == old._currentLocale;
  }
}
