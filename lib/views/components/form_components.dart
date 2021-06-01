import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suche_app/util/constants.dart';

class FormComponents {

  static Column buildCustomTextForm(String _title, TextEditingController _emailController, TextInputType _textInputType, String? Function(String?) _validator, IconData _icon, String _hintText, {bool? obscureText, IconButton? suffixIconButton}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _title,
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          decoration: kBoxDecorationStyle,
          height: 70.0,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: TextFormField(
            controller: _emailController,
            keyboardType: _textInputType,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: _validator,
            cursorColor: Colors.white,
            obscureText: obscureText != null ? obscureText : false,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                _icon,
                color: Colors.white,
              ),
              suffixIcon: suffixIconButton != null ? suffixIconButton : null,
              prefixIconConstraints: BoxConstraints(minWidth: 0,),
              prefixText: "   ", // espaçador
              hintText: _hintText,
              hintStyle: kHintTextStyle,
              errorStyle: kErrorTextStyle,
            ),
          ),
        ),
      ],
    );
  }

}