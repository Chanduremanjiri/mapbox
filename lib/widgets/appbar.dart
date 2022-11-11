import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: const BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
          color: Color(0xffa52f2f),),
        child: Row(
          children: const [
            SizedBox(width: 10,),
            Text('WCE Wandering',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),)
          ],
        ),
      ),
    );
  }
}
