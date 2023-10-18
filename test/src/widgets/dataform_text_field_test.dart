import 'package:dataform/src/form/dataform_widget.dart';
import 'package:dataform/src/widgets/dataform_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_utils.dart';

void main() {
  testWidgets('dataform text field tests', (tester) async {
    await tester.pumpWidgetWithApp(
      const DataFormTextField(id: 'id'),
    );

    expect(find.byType(DataFormTextField), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(
      tester.widget(find.byType(DataFormTextField)),
      isA<DataFormTextField>().having((t) => t.id, 'id', 'id'),
    );
  });

  testWidgets('dataform text field functional test', (tester) async {
    await tester.pumpWidgetWithApp(
      DataForm(
        builder: (context) => Column(
          children: [
            const DataFormTextField(id: 'id'),
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

    await tester.enterText(find.byType(TextFormField), 'test');
    await tester.tap(find.text('press'));
    await tester.pump();

    expect(find.byType(DataFormTextField), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(
      tester.widget(find.byType(DataFormTextField)),
      isA<DataFormTextField>().having((t) => t.id, 'id', 'id'),
    );
  });

  testWidgets('dataform text field functional test 2', (tester) async {
    await tester.pumpWidgetWithApp(
      DataForm(
        builder: (context) => Column(
          children: [
            DataFormTextField<String>(
              id: 'id',
              formatter: (value) => value?.toUpperCase() ?? '',
              onSaved: (value) {
                final _ = value;
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

    await tester.enterText(find.byType(TextFormField), 'test');
    await tester.tap(find.text('press'));
    await tester.pump();

    expect(find.byType(DataFormTextField<String>), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(
      tester.widget(find.byType(DataFormTextField<String>)),
      isA<DataFormTextField<String>>().having((t) => t.id, 'id', 'id'),
    );
  });
}
