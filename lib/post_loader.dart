import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class postLoader extends StatelessWidget {
  const postLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child:Lottie.asset("assets/images/post.json", width: 200,
        height: 200,
        fit: BoxFit.contain,),
    );
  }
}