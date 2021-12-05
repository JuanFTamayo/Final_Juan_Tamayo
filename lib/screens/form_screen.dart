import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:final_juan_tamayo/components/loader_component.dart';
import 'package:final_juan_tamayo/helpers/constants.dart';
import 'package:final_juan_tamayo/models/token.dart';
import 'package:final_juan_tamayo/models/user.dart';
import 'package:final_juan_tamayo/screens/login_screen.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FormScreen extends StatefulWidget {
  final Token token;
  var user;
  

  FormScreen({required this.token,required this.user});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  bool _loader = false;
  
  var rating= 3.0;
  
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
                _showTheBest(),
                _showTheWorst(),
                _showRemarks(),
                _showRating(),
                SizedBox(height: 40,),
                _showButtons()
                
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
          hintText: 'Ingresa lo mejor del curso...',
          labelText: 'Lo mejor',
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
          hintText: 'Ingresa lo peor del curso...',
          labelText: 'Lo peor',
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
          hintText: 'Ingresa comentarios...',
          labelText: 'Comentarios',
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

  Widget _showRating() {
    return Container(
      child: Column(
        children: [
          RatingBar.builder(
          itemCount: 5,
          initialRating: rating,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (ur) {
            rating=ur;
            print(rating);
          }, 
          
          ),
          Text('Calificacion')
        ],
      ),
      
    );
  }

   Widget _showButtons() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              child: Text('Guardar'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return Color(0xFF120E43);
                  }
                ),
              ),
              onPressed: () => _save(), 
            ),
          ),
        ],
      ),
    );
  }

   bool _validateFields() {
    bool isValid = true;

    if (_email.isEmpty) {
      isValid = false;
      _emailShowError = true;
      _emailError = 'Debes ingresar tu email.';
    } else if (!EmailValidator.validate(_email)) {
      isValid = false;
      _emailShowError = true;
      _emailError = 'Debes ingresar un email válido.';
    } else {
      _emailShowError = false;
    }

    if (_theBest.isEmpty) {
      isValid = false;
      _theBestShowError = true;
      _theBestError = 'Debes ingresar lo mejor.';
    
    } else {
      _theBestShowError = false;
    }

    if (_theWorst.isEmpty) {
      isValid = false;
      _theWorstShowError = true;
      _theWorstError = 'Debes ingresar lo peor.';
    
    } else {
      _theWorstShowError = false;
    }

    if (_remarks.isEmpty) {
      isValid = false;
      _remarksShowError = true;
      _remarksError = 'Debes ingresar los comentarios.';
    
    } else {
      _remarksShowError = false;
    }

    setState(() { });
    return isValid;
  }

  _save() async{
     if (!_validateFields()) {
      return;
    }

var request= {"email":_email,
 "qualification": rating.toInt(),
    "theBest": _theBest,
    "theWorst": _theWorst,
    "remarks": _remarks

};
var bodyRequest = jsonEncode(request);
var url= Uri.parse('${Constants.apiUrl}/api/Finals');
var response= await http.post(url,
      headers: {
        'content-type' : 'application/json',
        'accept' : 'application/json',
        'authorization': 'bearer ${widget.token.token}',
      },
      body: bodyRequest,);

    setState(() {
      _loader=true;
    });
    print('wenas');
    

    var body= response.body;
    print(body);

    if(response.statusCode >= 400) {
      await showAlertDialog(
        context: context,
        title: 'Error', 
        message: 'fallo.',
        actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
        ]
      );    
      return;
    }

    if(response.statusCode >= 200 && response.statusCode <=400) {
      await showAlertDialog(
        context: context,
        title: 'guardado con exito', 
        message: body,
        actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
        ]
      );    
       Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) => LoginScreen()
      )
    );
    }
  }
}