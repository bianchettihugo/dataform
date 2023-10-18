import 'package:dataform/src/form/dataform_widget.dart';
import 'package:dataform/src/widgets/dataform_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_utils.dart';

void main() {
  testWidgets('dataform switch test', (tester) async {
    await tester.pumpWidgetWithApp(
      const DataFormSwitch(text: 'text'),
    );

    expect(find.byType(DataFormSwitch), findsOneWidget);
    expect(find.byType(Switch), findsOneWidget);
  });

  testWidgets('dataform switch functional test', (tester) async {
    await tester.pumpWidgetWithApp(
      DataForm(
        builder: (context) => Column(
          children: [
            const DataFormSwitch(
              text: 'text',
              switchPosition: SwitchPosition.left,
            ),
            ElevatedButton(
              child: const Text('press'),
              onPressed: () {
                DataFormState.of(context).fetchData();
              },
            ),
          ],
        ),
      ),
    );

    await tester.tap(find.text('text'));
    await tester.pump();

    expect(find.byType(DataFormSwitch), findsOneWidget);
    expect(find.byType(Switch), findsOneWidget);
  });

  testWidgets('dataform switch functional test 2', (tester) async {
    await tester.pumpWidgetWithApp(
      DataForm(
        builder: (context) => Column(
          children: [
            DataFormSwitch(
              text: 'text',
              conditional: () async => true,
              description: 'test description',
              onChanged: (value) {
                final _ = value;
                return true;
              },
            ),
            ElevatedButton(
              child: const Text('press'),
              onPressed: () {
                DataFormState.of(context).fetchData();
              },
            ),
          ],
        ),
      ),
    );

    await tester.tap(find.text('text'));
    await tester.tap(find.text('press'));
    await tester.pump();

    expect(find.byType(DataFormSwitch), findsOneWidget);
    expect(find.byType(Switch), findsOneWidget);
  });
}
