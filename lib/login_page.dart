// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';


class loginStatefull extends StatefulWidget{
  const loginStatefull({super.key});

  @override
  State<StatefulWidget> createState() {
    return loginState();
  }
}

class loginState extends State<loginStatefull>{
  TextEditingController usernameController = TextEditingController();
  TextEditingController paswwordController = TextEditingController();
  http.Client client = http.Client();
  final Uri url = Uri.parse('http://127.0.0.1:8000/api/login/');

  BoxDecoration borderStyle(){
    return  const BoxDecoration(
        color: Color.fromARGB(255, 70, 70, 70),
        borderRadius: BorderRadius.all(Radius.circular(8))

    );
  }

  InputDecoration decorationInput(String labelTexty){
    return InputDecoration(
      border: InputBorder.none,
              prefixIcon: const Icon(Icons.person),
              prefixIconColor: Theme.of(context).colorScheme.secondary,
              contentPadding: const EdgeInsets.symmetric(vertical: 5),
              labelStyle: const TextStyle(fontSize: 19 , color: Color.fromARGB(115, 255, 255, 255) , fontWeight: FontWeight.w400),
              labelText: labelTexty
            );
  }

  Future<void> LoginUser() async{
    String username = usernameController.text;
    String password = paswwordController.text;

    Map <String , dynamic> userInf = {
      "username":username,
      "password":password
    };
    try{
      // final response = await http.post(
      // Uri.parse('http://127.0.0.1:8000/api/login/'),
      // body:userInf
      // );

      final response = await client.post(
        url,
        body: userInf
      );

      if(response.statusCode == 200){
        final Map<String,dynamic> responseData = json.decode(response.body);
        final token = responseData['token'];
        print(token);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", token);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          return const homeStateFull();
        } ));
      }
      else{

      }
    }catch(e){
      print(e);
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Log in"), centerTitle:true,),
      body: Column(children: [
        Container(
          decoration: borderStyle(),
          margin: const EdgeInsets.symmetric(horizontal: 25 , vertical: 10),
          child: TextField(
            style: TextStyle(fontSize: 18 , color:Theme.of(context).colorScheme.secondary),
            decoration: decorationInput("Username"),
            controller: usernameController,
          ),
        ),
        Container(
          decoration: borderStyle(),
          margin: const EdgeInsets.symmetric(horizontal: 25 , vertical: 10),
          child: TextField(
            obscureText: true,
            style: TextStyle(fontSize: 18 , color:Theme.of(context).colorScheme.secondary),
            decoration: decorationInput("Password"),
            controller: paswwordController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                TextButton(onPressed: (){}, child: Text("Forgot password?" , style: TextStyle(color: Theme.of(context).colorScheme.secondary,),))
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          width: double.infinity,
          child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  shadowColor: Colors.white,
                  foregroundColor: Colors.black
                ),
                onPressed: LoginUser,
                child: const Text("Sign in")),
        ),
      ],),
    );
  }
}