import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suche_app/util/constants.dart';

class FormComponents {

  static Column buildCustomTextForm(String _title,
      TextEditingController _controller, TextInputType _textInputType,
      String? Function(String?) _validator, IconData _icon, String _hintText,
      {bool? obscureText, IconButton? suffixIconButton, List<TextInputFormatter>? listTextInputFormatter, bool? readOnly, void Function()? onTap,}) {
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
            controller: _controller,
            keyboardType: _textInputType,
            inputFormatters: listTextInputFormatter != null ? listTextInputFormatter : null,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            readOnly: readOnly != null ? readOnly : false,
            onTap: onTap != null ? onTap : null,
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

  static Column buildCustomForm(String _title,
      TextEditingController _controller, Widget _widget) {
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
          child: _widget,
        ),
      ],
    );
  }

}