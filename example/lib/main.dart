import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dataform/dataform.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UserForm(),
    );
  }
}

class UserForm extends StatelessWidget {
  const UserForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DataForm(
        builder: (context) {
          return Column(
            children: [
              DataFormTextField(
                id: 'user/name',
                decoration:
                    const InputDecoration.collapsed(hintText: 'User name'),
                validator: (value) {
                  return value == null || value.isEmpty ? 'Error' : null;
                },
              ),
              const SizedBox(height: 20),
              const DataFormTextField(
                decoration: InputDecoration.collapsed(hintText: 'User email'),
                id: 'user/email',
              ),
              const SizedBox(height: 20),
              DataFormTextField(
                decoration:
                    const InputDecoration.collapsed(hintText: 'User age'),
                id: 'user/age',
                formatter: (value) => int.tryParse(value ?? '') ?? -1,
                // You can optionally pass a validate function that returns a map
                // where the keys are conditions and the values are error strings
                // that will be displayed if the condition is false. Example:
                //
                // value must not be null otherwise display 'Value cannot be null!'
                //
                // int.tryParse(value) must return a number no null
                // otherwise display 'Value must be a number!'
                validate: (value) => {
                  value != null: 'Value cannot be null!',
                  int.tryParse(value ?? '') != null: 'Value must be a number!',
                },
              ),
              const SizedBox(height: 20),
              const DataFormTextField(
                decoration: InputDecoration.collapsed(hintText: 'User city'),
                id: 'user/location/city',
              ),
              const SizedBox(height: 20),
              const DataFormTextField(
                decoration: InputDecoration.collapsed(hintText: 'User state'),
                id: 'user/location/state',
              ),
              const SizedBox(height: 20),
              const DataFormTextField(
                decoration: InputDecoration.collapsed(hintText: 'Password'),
                obscureText: true,
                id: 'password',
              ),
              const SizedBox(height: 20),
              const DataformCheckbox(
                id: 'admin',
                text: 'Admin',
              ),
              const SizedBox(height: 20),
              const DataformSwitch(
                id: 'remember',
                active: true,
                text: 'Remember',
              ),
              const SizedBox(height: 20),
              // You can create your custom form fields by wrapping them in a
              // DataFormField widget.
              const DataFormField(
                id: 'space',
                value: 20,
                child: SizedBox(width: 20),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                child: const Text('SEND FORM'),
                onPressed: () {
                  // When the user presses the button, the data will be validated
                  // and if it's valid, the data will generate a map. Otherwise,
                  // fetchData will return null.
                  // The form above will generate the following map:
                  //
                  // {
                  //   "user": {
                  //     "name": "...",
                  //     "email": "...",
                  //     "age": 00,
                  //     "location": {
                  //       "city": "...",
                  //       "state": "...",
                  //     }
                  //   },
                  //   "admin": false,
                  //   "password": "...",
                  //   "remember": true,
                  //   "space": 20,
                  // }
                  //
                  // Now, if you want to send this data to an api as JSON,
                  // you can simply call json.encode(data); No need to
                  // manage a lot of text controllers anymore.
                  Map<String, dynamic>? data =
                      DataFormState.of(context).fetchData();
                  if (kDebugMode) {
                    print(data);
                  }
                },
              )
            ],
          );
        },
      ),
    );
  }
}
