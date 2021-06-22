// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:brasil_fields/brasil_fields.dart';
import 'package:mdi/mdi.dart';

// Project imports:
import 'package:suche_app/util/constants.dart';
import 'package:suche_app/util/custom_colors.dart';
import 'package:suche_app/views/components/form_components.dart';

class EventDescriptionStep{

  static buildEventDescriptionStep(
      Key _formKey,
      TextEditingController _nameController,
      TextEditingController _descriptionController,
      TextEditingController _categoryController,
      String? _dropdownValueCategory,
      Function(String?) _onChangedDropdownCategory,
      List<String> _categoryList,
      TextEditingController _keywordsController,
      TextEditingController _dateController,
      DateTime? _dateTime,
      Function() _onTapDateFunction,
      TextEditingController _priceController,
      TextEditingController _linkController,
      TextEditingController _typeController,
      String? _dropdownValueType,
      Function(String?) _onChangedDropdownType,
      List<String> typeEventList,
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
                  // Listagem dos elementos para cadastrar 'FormComponents.buildCustomTextForm'

                  // Nome TF
                  FormComponents.buildCustomTextForm(
                    'Nome do Evento',
                    _nameController,
                    TextInputType.name,
                        (value) {
                      if (value == null || value.isEmpty) {
                        return 'O nome é um campo obrigatório';
                      } else if (!nameExp.hasMatch(value)) {
                        return 'Insira um nome válido (a-z A-Z)';
                      } else {
                        return null;
                      }
                    },
                    Mdi.formTextbox,
                    'Insira o nome do evento',
                  ),
                  SizedBox(height: 10.0),

                  // Descrição
                  FormComponents.buildCustomTextForm(
                    'Descrição do Evento',
                    _descriptionController,
                    TextInputType.multiline,
                        (value) {
                      if (value == null || value.isEmpty) {
                        return 'A descrição é um campo obrigatório';
                      }  else {
                        return null;
                      }
                    },
                    Mdi.text,
                    'Insira a descrição do evento',
                  ),
                  SizedBox(height: 10.0),

                  // Categoria TF
                  FormComponents.buildCustomForm(
                    'Categoria do Evento',
                    _categoryController,
                    Center(
                      child: DropdownButtonFormField<String>(
                        value: _dropdownValueCategory,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'A categoria é um campo obrigatório';
                          } else {
                            return null;
                          }
                        },
                        icon: const Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                        ),
                        iconSize: 24,
                        isExpanded: true,
                        elevation: 16,
                        decoration: InputDecoration(
                            isDense: true,
                            errorStyle: kErrorTextStyle,
                            prefixIconConstraints: BoxConstraints(minWidth: 0,),
                            prefixIcon: Icon(Mdi.formatListChecks, color: Colors.white,),
                            prefixText: "   ", // espaçador
                            hintStyle: kHintTextStyle,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            contentPadding: EdgeInsets.zero
                        ),
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: CustomColors.orangePrimary,
                        hint: _dropdownValueCategory != null
                            ? null
                            : Text('Selecione a categoria',
                            style: kHintTextStyle,
                            textScaleFactor: 1.2),
                        onChanged: _onChangedDropdownCategory,
                        items: _categoryList
                            .map<DropdownMenuItem<String>>(
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  textScaleFactor: 1.2,
                                ),
                              );
                            }).toList(),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),

                  // Palavra Chave
                  FormComponents.buildCustomTextForm(
                    'Palavras-Chaves (separadas por vírgula)',
                    _keywordsController,
                    TextInputType.multiline,
                        (value) {
                      if (value == null || value.isEmpty) {
                        return 'A descrição é um campo obrigatório';
                      } else {
                        return null;
                      }
                    },
                    Mdi.textSearch,
                    'Insira as palavras-chaves',
                  ),
                  SizedBox(height: 10.0),

                  // Data do Evento
                  FormComponents.buildCustomTextForm(
                    'Data do evento',
                    _dateController,
                    TextInputType.datetime,
                        (value) {
                      if (_dateController.text.isEmpty) {
                        return 'A data é um campo obrigatório';
                      } else {
                        return null;
                      }
                    },
                    Mdi.calendarStar,
                    _dateController.text.isEmpty
                        ? 'Insira a data do evento'
                        : UtilData.obterDataDDMMAAAA(_dateTime!),
                    readOnly: true,
                    onTap: _onTapDateFunction,
                  ),
                  SizedBox(height: 10.0),

                  // Valor TF
                  FormComponents.buildCustomTextForm(
                    'Preço do Evento',
                    _priceController,
                    TextInputType.number,
                        (value) {
                      if (value == null || value.isEmpty) {
                        return 'O preço é um campo obrigatório';
                      } else if (!nameExp.hasMatch(value)) {
                        return 'Insira um preço válido';
                      } else {
                        return null;
                      }
                    },
                    Mdi.cash,
                    'Insira o preço do evento',
                    listTextInputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      RealInputFormatter(
                          centavos: true,
                          moeda: true
                      )],
                  ),
                  SizedBox(height: 10.0),

                  // Link do evento TF
                  FormComponents.buildCustomTextForm(
                    'Link do Evento',
                    _linkController,
                    TextInputType.url,
                        (value) {
                      if (!nameExp.hasMatch(value!)) {
                        return 'Insira um nome válido (a-z A-Z)';
                      } else {
                        return null;
                      }
                    },
                    Mdi.linkVariant,
                    'Insira o link do evento',
                  ),
                  SizedBox(height: 10.0),

                  // Tipo do evento
                  FormComponents.buildCustomForm(
                    'Tipo do Evento',
                    _typeController,
                    Center(
                      child: DropdownButtonFormField<String>(
                        value: _dropdownValueType,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'O tipo do evento é um campo obrigatório';
                          } else {
                            return null;
                          }
                        },
                        icon: const Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                        ),
                        iconSize: 24,
                        isExpanded: true,
                        elevation: 16,
                        decoration: InputDecoration(
                            isDense: true,
                            errorStyle: kErrorTextStyle,
                            prefixIconConstraints: BoxConstraints(minWidth: 0,),
                            prefixIcon: Icon(Mdi.calendarQuestion, color: Colors.white,),
                            prefixText: "   ", // espaçador
                            hintStyle: kHintTextStyle,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            contentPadding: EdgeInsets.zero
                        ),
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: CustomColors.orangePrimary,
                        hint: _dropdownValueType != null
                            ? null
                            : Text('Selecione o tipo do evento',
                            style: kHintTextStyle,
                            textScaleFactor: 1.2),
                        onChanged: _onChangedDropdownType,
                        items: typeEventList
                            .map<DropdownMenuItem<String>>(
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  textScaleFactor: 1.2,
                                ),
                              );
                            }).toList(),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
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
