import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterConfig on WidgetTester {
  Future<void> pumpWidgetWithApp(Widget widget) async {
    await pumpWidget(
      MaterialApp(
        supportedLocales: const [
          Locale('pt', 'BR'),
          Locale('pt'),
          Locale('en'),
        ],
        locale: const Locale('en'),
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xff6D67D0),
        ),
        home: Builder(
          builder: (context) {
            return Scaffold(body: widget);
          },
        ),
      ),
    );
  }
}
