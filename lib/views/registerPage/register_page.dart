import 'dart:async';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suche_app/util/constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _dropdownValueSexo = null;
  DateTime _dateTime;

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'E-mail',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Insira o E-mail',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNomeTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nome',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.name,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.drive_file_rename_outline,
                color: Colors.white,
              ),
              hintText: 'Insira o Nome',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSobrenomeTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Sobrenome',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.name,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.drive_file_rename_outline,
                color: Colors.white,
              ),
              hintText: 'Insira o Sobrenome',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGeneroTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Gênero',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.center,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(
                Icons.transgender,
                color: Colors.white,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: DropdownButton<String>(
                  value: _dropdownValueSexo,
                  icon: const Icon(Icons.arrow_downward, color: Colors.white),
                  iconSize: 24,
                  isExpanded: true,
                  elevation: 16,
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: Color(0xFF2B387D),
                  underline: Container(
                    height: 0,
                    color: Colors.white54,
                  ),
                  hint: _dropdownValueSexo != null
                      ? null
                      : Text('Selecione o sexo',
                          style: kHintTextStyle, textScaleFactor: 1.2),
                  onChanged: (String newValue) {
                    setState(() {
                      _dropdownValueSexo = newValue;
                    });
                  },
                  items: <String>[
                    'Masculino',
                    'Feminino',
                    'Outros',
                    'Prefiro não falar'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        textScaleFactor: 1.2,
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIdadeTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Data de Nascimento',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            readOnly: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.calendar_today,
                color: Colors.white,
              ),
              hintText: _dateTime == null
                  ? 'Insira a data de nascimento'
                  : UtilData.obterDataDDMMAAAA(_dateTime),
              hintStyle: kHintTextStyle,
            ),
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1920),
                lastDate: DateTime.now(),
              ).then((date) {
                setState(() {
                  _dateTime = date;
                });
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSenhaTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Senha',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.visiblePassword,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.password,
                color: Colors.white,
              ),
              hintText: 'Insira a Senha',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmaSenhaTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Confirme a Senha',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.visiblePassword,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.password,
                color: Colors.white,
              ),
              hintText: 'Confirme a Senha',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          padding: EdgeInsets.all(15),
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () => print('clicou cadastrar'),
        //Navigator.pushNamedAndRemoveUntil(context, homeRoute, (route) => false)
        child: Text(
          'CADASTRAR',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF2B3647),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Suche',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0),

                      // colocar aqui elementos
                      _buildEmailTF(),
                      SizedBox(height: 10.0),
                      _buildNomeTF(),
                      SizedBox(height: 10.0),
                      _buildSobrenomeTF(),
                      SizedBox(height: 10.0),
                      _buildGeneroTF(),
                      SizedBox(height: 10.0),
                      _buildIdadeTF(),
                      SizedBox(height: 10.0),
                      _buildSenhaTF(),
                      SizedBox(height: 10.0),
                      _buildConfirmaSenhaTF(),
                      _buildRegisterBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
