import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lg_ai_touristic_explorer/constants/constants.dart';
import 'package:lg_ai_touristic_explorer/screens/splash_screen.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:lg_ai_touristic_explorer/utils/theme_changer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  var delegate = await LocalizationDelegate.create(
      preferences: TranslatePreferences(),
      fallbackLocale: 'en',
      supportedLocales: ['en', 'es', 'hi', 'fr', 'it', 'ja', 'zh']);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  ThemeChanger themeChanger = await ThemeChanger.create();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(ChangeNotifierProvider(
      create: (_) => themeChanger,
      child: LocalizedApp(
        delegate,
        ScreenUtilInit(
          designSize: const Size(1920, 1080),
          minTextAdapt: true,
          splitScreenMode: false,
          child: ThisApp(),
        ),
      ),
    ));
  });
}

class ThisApp extends StatelessWidget {
  const ThisApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            localizationDelegate
          ],
          supportedLocales: localizationDelegate.supportedLocales,
          locale: localizationDelegate.currentLocale,
          title: "LG-AI-Touristic-Explorer",
          theme: themeChanger.getTheme(),
          home: SplashScreen()),
    );
  }
}

class TranslatePreferences implements ITranslatePreferences {
  static const String _selectedLocaleKey = 'selected_locale';

  @override
  Future<Locale?> getPreferredLocale() async {
    final preferences = await SharedPreferences.getInstance();

    if (!preferences.containsKey(_selectedLocaleKey)) return null;

    var locale = preferences.getString(_selectedLocaleKey);

    return localeFromString(locale.toString());
  }

  @override
  Future savePreferredLocale(Locale locale) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(_selectedLocaleKey, localeToString(locale));
  }
}
