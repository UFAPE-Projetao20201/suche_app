import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mdi/mdi.dart';
import 'package:suche_app/util/constants.dart';
import 'package:suche_app/util/custom_colors.dart';
import 'package:suche_app/util/util.dart';
import 'package:suche_app/views/components/form_components.dart';
import 'package:suche_app/views/components/page_components.dart';

import 'components/event_description_step.dart';
import 'components/event_location_step.dart';

class RegisterEventPage extends StatefulWidget {
  const RegisterEventPage({Key? key}) : super(key: key);

  @override
  _RegisterEventPageState createState() => _RegisterEventPageState();
}

class _RegisterEventPageState extends State<RegisterEventPage> {
  String? _dropdownValueCategory;
  String? _dropdownValueType;
  bool _absorbing = false;
  DateTime? _dateTime;
  int _indexStepper = 0;

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
                    onStepContinue: () {
                      if (_indexStepper <= 0) {
                        setState(() {
                          _indexStepper += 1;
                        });
                      }else if (_indexStepper == 1) {
                        setState(() {
                          print('Terminou'); // Fazer requisição para API aqui
                        });
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