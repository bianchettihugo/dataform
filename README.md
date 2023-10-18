# Dataform

A Flutter package to fetch data from a form as a Map. <br>
With this package, you don't need to manage a lot of text controllers in a form anymore! Simply call a function when the users tap the button at the end of your form and get all the data in a Map, ready to be transformed into JSON and sent to an API!

## Usage

```dart
Scaffold(
  // Wrap your form in a DataForm widget. No need to use Form from Flutter
  body: DataForm(  
    builder: (context) {
      return Column(
        children: [
          // The [id] is used to identify the field in the [Map]. The [id] must be
          // unique for each field and contain "/" if you want to nest the field
          // inside the map. Example, fields with the following ids:
          //
          //
          // * user/name
          // * user/age
          // * user/address/street
          // * user/address/number
          // * admin
          //
          //
          // will result in the following map:
          //
          // 
          // {
          //   "user": {
          //     name: "...",
          //     age: "...",
          //     address: {
          //       street: "...",
          //       number: "...",
          //     }
          //   },
          //  "admin": "...",
          // }
          // 
          //
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
```

### Installation

Add the following line to `pubspec.yaml`:

```yaml
dependencies:
  dataform: ^1.0.2
```
