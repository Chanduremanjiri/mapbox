import 'package:flutter/material.dart';

class AppbarWithMenu extends StatelessWidget implements PreferredSizeWidget{
  const AppbarWithMenu({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xffa52f2f),
      title: const Text('WCE Wandering', style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      elevation: 4,
      actions: [
        IconButton(onPressed: (){print('hello');}, icon: const Icon(Icons.more_vert))
      ],
    );
  }
}
