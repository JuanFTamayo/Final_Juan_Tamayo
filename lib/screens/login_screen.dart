import 'package:final_juan_tamayo/components/loader_component.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  _showGoogleLoginButton() {

     return Row(
      children: <Widget>[
        Expanded(
          child: ElevatedButton.icon(
            onPressed: (){}, 
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

  _loginGoogle() {}
}