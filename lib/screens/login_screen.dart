import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:final_juan_tamayo/components/loader_component.dart';
import 'package:final_juan_tamayo/helpers/constants.dart';
import 'package:final_juan_tamayo/models/token.dart';
import 'package:final_juan_tamayo/models/user.dart';

import 'package:final_juan_tamayo/screens/form_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loader= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xFF51E1ED),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 120,),
                _showLogo(),
                SizedBox(height: 20,),
                _showButton()
                
              ],
            ),
          ),
          _loader ? LoaderComponent(text: 'Por favor espere...') : Container(),
        ],
      ),
      
    );
  }

  Widget _showLogo() {
     return Image(
      image: AssetImage('assets/Logo.png'),
      width: 300,
      fit: BoxFit.fill,
    );
  }

  Widget _showButton() {
     return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          
          _showGoogleLoginButton(),
          
        ],
      ),
    );
  }

  Widget _showGoogleLoginButton() {

     return Row(
      children: <Widget>[
        Expanded(
          child: ElevatedButton.icon(
            onPressed: ()=> _loginGoogle(), 
            icon: FaIcon(
              FontAwesomeIcons.google,
              color: Colors.red,
            ), 
            label: Text('Iniciar sesión con Google'),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black
            )
          )
        )
      ],
    );
  }

  void _loginGoogle() async {
    setState(() {
      _loader = true;
    });

    var googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    var user = await googleSignIn.signIn();

    if (user == null) {
      setState(() {
        _loader = false;
      });
 
      await showAlertDialog(
        context: context,
        title: 'Error',
        message: 'Hubo un problema al obtener el usuario de Google, por favor intenta más tarde.',
        actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
        ]
      );    
      return;
    }

    Map<String, dynamic> request = {
      'email': user.email,
      'id': user.id,
      'loginType': 1,
      'fullName': user.displayName,
      'photoURL': user.photoUrl,
    };

    await _socialLogin(request);
  }

  Future _socialLogin(Map<String, dynamic> request) async {
    var url = Uri.parse('${Constants.apiUrl}/api/Account/SocialLogin');
    var bodyRequest = jsonEncode(request);
    var response = await http.post(
      url,
      headers: {
        'content-type' : 'application/json',
        'accept' : 'application/json',
      },
      body: bodyRequest,
    );

    setState(() {
      _loader = false;
    });

    if(response.statusCode >= 400) {
      await showAlertDialog(
        context: context,
        title: 'Error', 
        message: 'El usuario ya inció sesión previamente por email o por otra red social.',
        actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
        ]
      );    
      return;
    }

    var body = response.body;

   

    var decodedJson = jsonDecode(body);
    var token = Token.fromJson(decodedJson);
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) => FormScreen(token: token,user: request)
      )
    );
  }
}