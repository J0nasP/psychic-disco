import 'package:flutter/material.dart';

class CustomOptions extends StatefulWidget {
  const CustomOptions({super.key});

  @override
  CustomOptionsState createState() {
    return CustomOptionsState();
  }
}

class CustomOptionsState extends State<CustomOptions> {
  bool _valu = false;
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Options'),
        centerTitle: true,
        leading: BackButton(
          onPressed: () => Navigator.pop(context, '/user'),
        ),
      ),
      backgroundColor: Colors.deepPurple,
      body: Column(
        children: [
          CheckboxListTile(
            tileColor: Colors.white,
            title: const Text('World War 2'),
            selected: _valu,
            value: _valu,
            onChanged: (value1) {
              setState(() {
                _valu = value1 ?? false;
              });
            },
          ),
          CheckboxListTile(
            tileColor: Colors.white,
            title: const Text('Viking Era'),
            selected: _value,
            value: _value,
            onChanged: (value) {
              setState(() {
                _valu = value ?? false;
              });
            },
          ),
        ],
      ),
    );
  }
}
