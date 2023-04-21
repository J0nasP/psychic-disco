import 'package:flutter/material.dart';

class CustomUser extends StatefulWidget {
  const CustomUser({super.key});

  @override
  CustomUserState createState() {
    return CustomUserState();
  }
}

class CustomUserState extends State<CustomUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User",
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
            ),
            Text(
              'Hello User!',
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/map');
              },
              child: const Text("Find Route"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Theme Packages'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/options');
              },
              child: const Text('Options'),
            ),
          ],
        ),
      ),
    );
  }
}
