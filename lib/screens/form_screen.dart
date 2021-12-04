import 'package:final_juan_tamayo/components/loader_component.dart';
import 'package:final_juan_tamayo/models/token.dart';

import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  final Token token;
  
  

  FormScreen({required this.token,});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  bool _loader = false;

  
  String _email = '';
  String _emailError = '';
  bool _emailShowError = false;
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Final'
        ),
      ),
       body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _showEmail(),
                
              ],
            ),
          ),
          _loader ? LoaderComponent(text: 'Por favor espere...',) : Container(),
        ],
      ),
    );
    
  }

  Widget _showEmail() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Ingresa email...',
          labelText: 'Email',
          errorText: _emailShowError ? _emailError : null,
          suffixIcon: Icon(Icons.email),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          ),
        ),
        onChanged: (value) {
          _email = value;
        },
      ),
    );
  }
}