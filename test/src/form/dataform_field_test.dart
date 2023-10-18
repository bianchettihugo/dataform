import 'package:dataform/src/form/dataform_field.dart';
import 'package:dataform/src/form/dataform_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_utils.dart';

void main() {
  testWidgets('dataform field functional test', (tester) async {
    await tester.pumpWidgetWithApp(
      DataForm(
        builder: (context) => Column(
          children: [
            const DataFormField(
              id: 'space',
              value: 20,
              child: SizedBox(width: 20),
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

    await tester.tap(find.text('press'));
    await tester.pump();

    expect(find.byType(DataFormField<int>), findsOneWidget);
  });

  testWidgets('dataform field functional test 2', (tester) async {
    await tester.pumpWidgetWithApp(
      DataForm(
        builder: (context) => Column(
          children: [
            DataFormField(
              id: 'space',
              value: 20,
              child: const SizedBox(width: 20),
              validator: (p0) => null,
              conditional: (data) => true,
              formatter: (p0) => null,
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

    await tester.tap(find.text('press'));
    await tester.pump();

    expect(find.byType(DataFormField<int>), findsOneWidget);
  });
}
