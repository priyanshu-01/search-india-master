import 'package:flutter/material.dart';
import 'package:search_india/main_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    runApp(EasyLocalization(
      child: MyApp(),
      supportedLocales: [
        Locale('hi', 'IN'),
        Locale('en', 'IN'),
        Locale('bn', 'IN')
      ],
      path: 'resources/language_json',
    ));
  }


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        EasyLocalization.of(context).delegate,
      ],
      supportedLocales: EasyLocalization.of(context).supportedLocales,
      locale: EasyLocalization.of(context).locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {'/': (context) => MainPage()},
    );
  }
}
