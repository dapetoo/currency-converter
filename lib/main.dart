import 'package:currency_converter/constants/theme_store.dart';
import 'package:currency_converter/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    Provider<ThemeStore>(
      create: (_) => ThemeStore(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return MaterialApp(
          title: 'Currency Calculator',
          theme: context.watch<ThemeStore>().currentThemeData,
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        );
      },
    );
  }
}
