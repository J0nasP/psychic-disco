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
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  validator: usernameValidation,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 17,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  validator: passwordValidation,
                  style: TextStyle(color: Colors.white),
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
