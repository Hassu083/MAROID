import 'package:flutter/material.dart';

class MyAction extends StatelessWidget {
  Function() ontap;
  IconData icon;
  MyAction({Key? key,required this.ontap, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 35,
        width: 40,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black38)
        ),
        child: Center(
          child: Icon(icon,color: Colors.black,),
        ),
      ),
    );
  }
}
