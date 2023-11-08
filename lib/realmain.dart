import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracker_payment/localization/lang/app_localization.dart';
import 'package:tracker_payment/modules/auth_pages/sign_in.dart';
import 'package:tracker_payment/services/share_preference_services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void realMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharePrefs.sharePrefsInit();
  sharePrefs.setItems(setCategoriesToDefault: false);
  sharePrefs.getCurrency();
  sharePrefs.getAllExpenseItemsLists();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    Locale appLocale = sharePrefs.getLocale();
    setState(() {
      this._locale = appLocale;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (this._locale == null) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800]!),
        ),
      );
    } else {
      return ScreenUtilInit(
        designSize: Size(428, 926),
        builder: (context, child) {
          return MaterialApp(
            title: 'MMAS',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: const TextTheme(
                displaySmall: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 45,
                  color: Colors.deepOrangeAccent,
                ),
                labelLarge: TextStyle(
                  fontFamily: "OpenSans",
                ),
                titleMedium: TextStyle(fontFamily: "NotoSans"),
                bodyMedium: TextStyle(fontFamily: "NotoSans"),
              ),
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo).copyWith(
                secondary: Colors.orange,
              ),
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: Colors.amberAccent,
              ),
            ),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                child: child!,
              );
            },
            home: const SignIn(),
            locale: _locale,
            localizationsDelegates: const [
              AppLocalization.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale!.languageCode && supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            supportedLocales: const [
              Locale("en", "US"),
            ],
          );
        },
      );
    }
  }
}
