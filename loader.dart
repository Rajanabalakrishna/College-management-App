import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child:Lottie.asset("assets/images/loading.json", width: 200,
        height: 200,
        fit: BoxFit.contain,),
    );
  }
}