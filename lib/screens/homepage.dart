import 'package:flutter/material.dart';
import '../widgets/appbar.dart';
import '../widgets/button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyAppBar(),
          Button(buttonText: 'Press', onTap: (){print("Hello");}, height: 20, width: 50, fontSize: 16)
        ],
      ),
    );
  }
}
