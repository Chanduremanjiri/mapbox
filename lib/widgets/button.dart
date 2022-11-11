import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({Key? key,required this.buttonText,required this.onTap,required this.height,required this.width,required this.fontSize}) : super(key: key);

  final String buttonText;
  final Function? onTap;
  final double height,width,fontSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        onTap!();
      },
      child: Text(buttonText),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffa52f2f),
        textStyle: TextStyle(fontSize: fontSize),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
