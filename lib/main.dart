import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:servana/service/auth/authentication_service.dart';
import 'package:servana/view/screens/section_1/splash_screen.dart';
import 'package:servana/view/screens/section_2/login_worker_screen.dart';
import 'package:servana/view/screens/section_3/home_screen.dart';
import 'package:servana/view/screens/section_5/client_notification_screen.dart';
import 'package:servana/view/screens/section_5/start_work_screen.dart';
import 'package:servana/view/screens/section_6/end_work_w_screen.dart';
import 'package:servana/view/screens/section_6/incoming_request_w_screen.dart';
import 'package:servana/view/screens/section_6/job_detail_screen.dart';
import 'package:servana/view/screens/section_6/worker_notification_screen.dart';
import 'controller/lang_controller.dart';
import 'controller/login_controller.dart';
import 'controller/signup_controller.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import '../../../l10n/app_localizations.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeProvider),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => SignUpController()),
        ChangeNotifierProvider(create: (_) => AuthenticationService()),
    //    ChangeNotifierProvider(create: (_) => TrackLocationController()),
        ChangeNotifierProvider(create: (_) => LangController()),
      //   ChangeNotifierProvider(create: (_) => CategoryController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
 // void initState() {
  //   super.initState();
  //   getToken();
  // }

  // getToken() async {
  //   String? token = await FirebaseMessaging.instance.getToken();
  //   print("token = $token ");
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LangController, ThemeProvider>(
      builder: (context, langController, themeProvider, child) {
        return MaterialApp(
          title: 'Servana',
          debugShowCheckedModeBanner: false,
          locale: langController.locale,
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
      //  home:  SplashScreen(),

      home: ClientNotificationScreen(),


        );
      },
    );
  }
}