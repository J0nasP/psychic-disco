import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  final usernameValidation = ValidationBuilder().email().build();
  final passwordValidation = ValidationBuilder().minLength(4).build();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
      ),
      backgroundColor: Colors.deepPurple,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/png/logo-no-background.png'),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                  validator: usernameValidation,
                  style: TextStyle(color: Colors.yellow),
                ),
                SizedBox(
                  height: 17,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  validator: passwordValidation,
                  style: TextStyle(color: Colors.yellow),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing...')),
                        );
                        Navigator.pushNamed(context, '/map');
                      }
                    },
                    child: const Text('Submit')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
