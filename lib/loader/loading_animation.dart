import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class refreshLoader extends StatelessWidget {
  const refreshLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child:Lottie.asset("assets/images/big.json", width: 250,
        height: 250,
        fit: BoxFit.contain,),
    );
  }
}