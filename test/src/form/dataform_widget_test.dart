import 'package:dataform/src/form/dataform_field.dart';
import 'package:dataform/src/form/dataform_widget.dart';
import 'package:dataform/src/widgets/dataform_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_utils.dart';

void main() {
  testWidgets('dataform widget test', (tester) async {
    var data = <String, dynamic>{};
    await tester.pumpWidgetWithApp(
      DataForm(
        builder: (context) => Column(
          children: [
            DataFormTextField<String>(
              id: 'user/name/first',
              key: const ValueKey('first_name'),
              onSaved: (value) {
                final _ = value;
              },
            ),
            DataFormTextField<String>(
              id: 'user/name/last',
              key: const ValueKey('last_name'),
              formatter: (value) => value?.toUpperCase() ?? '',
              onSaved: (value) {
                final _ = value;
              },
            ),
            DataFormTextField<String>(
              id: 'user/email',
              key: const ValueKey('email'),
              onSaved: (value) {
                final _ = value;
              },
            ),
            const DataFormField(
              id: 'space',
              value: 20,
              child: SizedBox(width: 20),
            ),
            ElevatedButton(
              child: const Text('press'),
              onPressed: () {
                data = DataFormState.of(context).fetchData()!;
              },
            ),
          ],
        ),
      ),
    );

    await tester.enterText(
      find.byKey(
        const ValueKey('first_name'),
      ),
      'John',
    );
    await tester.enterText(
      find.byKey(
        const ValueKey('last_name'),
      ),
      'Doe',
    );
    await tester.enterText(
      find.byKey(
        const ValueKey('email'),
      ),
      'johndoe@example.com',
    );
    await tester.tap(find.text('press'));
    await tester.pump();

    expect(data, {
      'user': {
        'name': {
          'first': 'John',
          'last': 'DOE',
        },
        'email': 'johndoe@example.com',
      },
      'space': 20,
    });
  });

  testWidgets('dataform widget validation test', (tester) async {
    Map<String, dynamic>? data;
    await tester.pumpWidgetWithApp(
      DataForm(
        builder: (context) => Column(
          children: [
            DataFormTextField<String>(
              id: 'user/name/first',
              key: const ValueKey('first_name'),
              validator: (value) {
                if (int.tryParse(value!) == null) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) {
                final _ = value;
              },
            ),
            DataFormTextField<String>(
              id: 'user/name/last',
              key: const ValueKey('last_name'),
              formatter: (value) => value?.toUpperCase() ?? '',
              onSaved: (value) {
                final _ = value;
              },
            ),
            DataFormTextField<String>(
              id: 'user/email',
              key: const ValueKey('email'),
              onSaved: (value) {
                final _ = value;
              },
            ),
            const DataFormField(
              id: 'space',
              value: 20,
              child: SizedBox(width: 20),
            ),
            ElevatedButton(
              child: const Text('press'),
              onPressed: () {
                data = DataFormState.of(context).fetchData();
              },
            ),
          ],
        ),
      ),
    );

    await tester.enterText(
      find.byKey(
        const ValueKey('first_name'),
      ),
      'John',
    );
    await tester.enterText(
      find.byKey(
        const ValueKey('last_name'),
      ),
      'Doe',
    );
    await tester.enterText(
      find.byKey(
        const ValueKey('email'),
      ),
      'johndoe@example.com',
    );
    await tester.tap(find.text('press'));
    await tester.pump();

    expect(data, null);
  });
}
