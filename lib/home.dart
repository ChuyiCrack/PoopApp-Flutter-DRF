import 'package:flutter/material.dart';


class homeStateFull extends StatefulWidget{
  const homeStateFull({super.key});

  @override
  State<StatefulWidget> createState() {
    return homeState();
  }
}


class homeState extends State<homeStateFull>{

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("You have loged in Succesfully"),),
    );
  }
}