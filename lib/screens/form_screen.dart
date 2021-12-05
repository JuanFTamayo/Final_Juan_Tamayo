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

  String _theBest = '';
  String _theBestError = '';
  bool _theBestShowError = false;
  TextEditingController _theBestController = TextEditingController();

  String _theWorst = '';
  String _theWorstError = '';
  bool _theWorstShowError = false;
  TextEditingController _theWorstController = TextEditingController();

  String _remarks = '';
  String _remarksError = '';
  bool _remarksShowError = false;
  TextEditingController _remarksController = TextEditingController();


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
                _showTheBest()
                
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

  Widget _showTheBest() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _theBestController,
        decoration: InputDecoration(
          hintText: 'Ingresa apellidos...',
          labelText: 'Apellidos',
          errorText: _theBestShowError ? _theBestError : null,
          suffixIcon: Icon(Icons.sentiment_satisfied_alt),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          ),
        ),
        onChanged: (value) {
          _theBest = value;
        },
      ),
    );
  }

   Widget _showTheWorst() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _theWorstController,
        decoration: InputDecoration(
          hintText: 'Ingresa apellidos...',
          labelText: 'Apellidos',
          errorText: _theWorstShowError ? _theWorstError : null,
          suffixIcon: Icon(Icons.sentiment_dissatisfied_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          ),
        ),
        onChanged: (value) {
          _theWorst = value;
        },
      ),
    );
  }

  Widget _showRemarks() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _remarksController,
        decoration: InputDecoration(
          hintText: 'Ingresa apellidos...',
          labelText: 'Apellidos',
          errorText: _remarksShowError ? _remarksError : null,
          suffixIcon: Icon(Icons.text_snippet),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          ),
        ),
        onChanged: (value) {
          _remarks = value;
        },
      ),
    );
  }
}