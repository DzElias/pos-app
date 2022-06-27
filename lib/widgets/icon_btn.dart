import 'package:flutter/material.dart';

class IconBtn extends StatelessWidget {
  const IconBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(Icons.description),

      onTap: (){
        Navigator.pushNamed(context, "cart");
      },
    );
  }
}