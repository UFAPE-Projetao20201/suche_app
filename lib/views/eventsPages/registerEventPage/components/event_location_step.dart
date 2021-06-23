// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:brasil_fields/brasil_fields.dart';
import 'package:mdi/mdi.dart';

// Project imports:
import 'package:suche_app/util/custom_colors.dart';
import 'package:suche_app/util/util.dart';
import 'package:suche_app/views/components/form_components.dart';

class EventLocationStep{

  static buildEventDescriptionStep(
      Key _formKey,
      TextEditingController _streetController,
      TextEditingController _numberController,
      TextEditingController _cityController,
      TextEditingController _cepController,
      ) {
    final RegExp nameExp = new RegExp(r"^[A-Z a-zÀ-ÖØ-öø-ÿ]+$", caseSensitive: false);

    return Container(
      color: CustomColors.orangePrimary.shade400,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  // Rua TF
                  FormComponents.buildCustomTextForm(
                    'Rua',
                    _streetController,
                    TextInputType.name,
                        (value) {
                      if (value == null || value.isEmpty) {
                        return 'O nome da rua é um campo obrigatório';
                      } else if (!nameExp.hasMatch(value)) {
                        return 'Insira um nome de rua válido (a-z A-Z)';
                      } else {
                        return null;
                      }
                    },
                    Mdi.roadVariant,
                    'Insira o nome da rua',
                  ),
                  SizedBox(height: 10.0),

                  // Numero TF
                  FormComponents.buildCustomTextForm(
                    'Número',
                    _numberController,
                    TextInputType.number,
                        (value) {
                      if (value == null || value.isEmpty) {
                        return 'O número é um campo obrigatório';
                      } else if (!nameExp.hasMatch(value)) {
                        return 'Insira um número válido (a-z A-Z)';
                      } else {
                        return null;
                      }
                    },
                    Mdi.numeric,
                    'Insira o número',
                  ),
                  SizedBox(height: 10.0),

                  // Cidade TF
                  FormComponents.buildCustomTextForm(
                    'Cidade',
                    _cityController,
                    TextInputType.name,
                        (value) {
                      if (value == null || value.isEmpty) {
                        return 'O nome da cidade é um campo obrigatório';
                      } else if (!nameExp.hasMatch(value)) {
                        return 'Insira um nome de cidade válido (a-z A-Z)';
                      } else {
                        return null;
                      }
                    },
                    Mdi.city,
                    'Insira o nome da cidade',
                  ),
                  SizedBox(height: 10.0),

                  // CEP TF
                  FormComponents.buildCustomTextForm(
                    'CEP',
                    _cepController,
                    TextInputType.number,
                        (value) {
                      if (value == null || value.isEmpty) {
                        return 'O CEP é um campo obrigatório';
                      } else if (!!(Util.sanitizePhone(value).length == 8)) {
                        return 'Insira um CEP válido';
                      } else {
                        return null;
                      }
                    },
                    Mdi.earth,
                    'Insira o CEP',
                    listTextInputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      CepInputFormatter()],
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
