import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up_todo/screens/main_page.dart';
import 'package:up_todo/service/storage_service.dart';
import 'package:up_todo/theme_provider.dart';
import 'package:up_todo/utils/my_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  StorageService.getInstance();

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en', 'US'),
        Locale('uz', 'UZ'),
        Locale('ru', 'RU'),
      ],
      path: 'assets/translations',
      child: MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ], child: const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: Styles.themeData(
          !context.watch<ThemeProvider>().getIsLight(), context),
      themeMode: context.watch<ThemeProvider>().getIsLight()
          ? ThemeMode.dark
          : ThemeMode.light,
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
