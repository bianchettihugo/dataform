import 'package:dataform/src/form/dataform_widget.dart';
import 'package:dataform/src/widgets/dataform_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_utils.dart';

void main() {
  testWidgets('dataform checkbox test', (tester) async {
    await tester.pumpWidgetWithApp(
      const DataFormCheckbox(text: 'text'),
    );

    expect(find.byType(DataFormCheckbox), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);
  });

  testWidgets('dataform checkbox functional test', (tester) async {
    await tester.pumpWidgetWithApp(
      DataForm(
        builder: (context) => Column(
          children: [
            const DataFormCheckbox(
              text: 'text',
              checkboxPosition: CheckboxPosition.left,
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

    expect(find.byType(DataFormCheckbox), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);
  });

  testWidgets('dataform checkbox functional test 2', (tester) async {
    await tester.pumpWidgetWithApp(
      DataForm(
        builder: (context) => Column(
          children: [
            DataFormCheckbox(
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

    expect(find.byType(DataFormCheckbox), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);
  });
}
