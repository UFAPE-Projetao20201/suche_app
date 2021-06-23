// Flutter imports:
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:brasil_fields/brasil_fields.dart';
import 'package:suche_app/model/event.dart';
import 'package:suche_app/model/user.dart';
import 'package:suche_app/provider/event_provider.dart';
import 'package:suche_app/services/storage.dart';
import 'package:suche_app/util/constants.dart';

// Project imports:
import 'package:suche_app/util/custom_colors.dart';
import 'package:suche_app/util/util.dart';
import 'package:suche_app/views/components/page_components.dart';
import 'components/event_description_step.dart';
import 'components/event_location_step.dart';

class RegisterEventPage extends StatefulWidget {
  final User user;

  const RegisterEventPage({Key? key, required this.user}) : super(key: key);

  @override
  _RegisterEventPageState createState() => _RegisterEventPageState();
}

class _RegisterEventPageState extends State<RegisterEventPage> {
  String? _dropdownValueCategory;
  String? _dropdownValueType;
  bool _absorbing = false;
  DateTime? _dateTime;
  int _indexStepper = 0;
  bool _isOnline = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _keywordsController = TextEditingController(); //Criar função para tratar o texto recebido e gerar uma array de palavras?
  TextEditingController _dateController = TextEditingController();
  TextEditingController _priceController = TextEditingController(); //Criar função para tratar o texto recebido e gerar um valor sem cifrão, virgula e afins?
  TextEditingController _linkController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _cepController = TextEditingController();

  final RegExp nameExp = new RegExp(r"^[A-Z a-zÀ-ÖØ-öø-ÿ]+$", caseSensitive: false);

  List<String> categoryList = [
    'Artes',
    'Shows',
    'Gastronomia',
    'Infantil',
    'Bem-estar',
    'Comédia',
    'Compra',
    'Dança',
    'Esporte',
    'Festa',
    'Filme',
    'Fitness',
    'Jardinagem',
  ];

  List<String> typeEventList = [
    'Presencial',
    'Online',
  ];

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  _onChangedDropdownCategory(String? newValue) {
    setState(() {
      _dropdownValueCategory = newValue;
    });
  }

  _onChangedDropdownType(String? newValue) {
    setState(() {
      _dropdownValueType = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Evento"),
      ),
      body: AbsorbPointer(
        absorbing: _absorbing,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                PageComponents.buildBackgroundContainer(),
                Container(
                  color: CustomColors.orangePrimary.shade400,
                  height: double.infinity,
                  width: double.infinity,
                  child: Stepper(
                    currentStep: _indexStepper,
                    onStepCancel: () {
                      if (_indexStepper > 0) {
                        setState(() {
                          _indexStepper -= 1;
                        });
                      }
                    },
                    onStepContinue: () async {
                      if (_indexStepper <= 0) {
                        if(_formKey1.currentState!.validate()){
                          setState(() {
                            _indexStepper += 1;
                          });
                        }
                      }else if (_indexStepper == 1) {
                        setState(() {
                        });
                        if(_formKey2.currentState!.validate()){
                          setState(() {
                            //Desabilitando o toque da tela
                            _absorbing = true;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Processando dados...'),
                            ),
                          );

                          final EventProvider _apiClient = new EventProvider();

                          // Variável booleana para evento online/presencial
                          if (_typeController.text == 'Presencial'){
                            _isOnline = false;
                          }else if (_typeController.text == 'Online'){
                            _isOnline = true;
                          }

                          await _apiClient.createEvent(
                            token: widget.user.token,
                            promoter: widget.user.getId(),
                            name: _nameController.text,
                            description: _descriptionController.text,
                            category: _dropdownValueCategory.toString(),
                            value: double.parse(_priceController.text.substring(3,_priceController.text.length).replaceAll(",",".")),
                            date: _dateTime.toString(),
                            keywords: _keywordsController.text.split(","), //Refatorar futuramente tratando de uma forma mais robusta
                            localization: {
                              "street": _streetController.text,
                              "city": _cityController.text,
                              "CEP": Util.sanitizeCEP(_cepController.text),
                              "number": _numberController.text},
                            link: _linkController.text,
                            isOnline: _isOnline,
                            isLocal: !_isOnline,
                          ).then((value) => showDialog(context: context, builder: (ctx) => AlertDialog(
                            title: Text('Parabéns!', style: TextStyle(
                              color: CustomColors.orangePrimary.shade400,
                              fontFamily: 'OpenSans',
                              fontSize: 30.0,
                              fontWeight: FontWeight.w900,
                            ),),
                            content: Text('Evento criado com sucesso!', style: TextStyle(
                              color: CustomColors.orangePrimary.shade400,
                              fontFamily: 'OpenSans',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w900,
                            ),),
                            backgroundColor: CustomColors.colorLightGray,
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  homeRoute,
                                      (route) => false,
                                  arguments: widget.user,
                                ),
                                child: const Text('OK'),
                              ),
                            ],
                          )) );

                          // Re-habilita a tela para receber toques
                          setState(() {
                            _absorbing = false;
                          });

                          ScaffoldMessenger.of(context)
                              .clearSnackBars();

                        }
                      }
                    },
                    onStepTapped: (int index) {
                      setState(() {
                        _indexStepper = index;
                      });
                    },
                    steps: <Step>[
                      Step(
                        title: const Text(
                          'Informações do Evento',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: EventDescriptionStep.buildEventDescriptionStep(
                          _formKey1,
                          _nameController,
                          _descriptionController,
                          _categoryController,
                          _dropdownValueCategory,
                          _onChangedDropdownCategory,
                          categoryList,
                          _keywordsController,
                          _dateController,
                          _dateTime,
                          () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(3000),
                            ).then(
                              (date) {
                                setState(
                                  () {
                                    if (date != null) {
                                      _dateTime = date;
                                      _dateController.text =
                                          UtilData.obterDataDDMMAAAA(date);
                                    } else {
                                      _dateTime = null;
                                      _dateController.clear();
                                    }
                                  },
                                );
                              },
                            );
                          },
                          _priceController,
                          _linkController,
                          _typeController,
                          _dropdownValueType,
                          _onChangedDropdownType,
                          typeEventList,
                        ),
                      ),
                      Step(
                        title: Text(
                          'Local do Evento',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: EventLocationStep.buildEventDescriptionStep(
                            _formKey2,
                            _streetController,
                            _numberController,
                            _cityController,
                            _cepController),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
