import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mdi/mdi.dart';
import 'package:suche_app/util/constants.dart';
import 'package:suche_app/util/custom_colors.dart';
import 'package:suche_app/util/util.dart';
import 'package:suche_app/views/components/form_components.dart';
import 'package:suche_app/views/components/page_components.dart';

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
                        title: const Text('Informações do Evento',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),),
                        content: Container(
                          color: CustomColors.orangePrimary.shade400,
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 10.0,
                            ),
                            child: Form(
                              key: _formKey1,
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
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _dropdownValueCategory = newValue;
                                              });
                                            },
                                            items: categoryList
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
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(3000),
                                          ).then((date) {
                                            setState(() {
                                              if(date != null) {
                                                _dateTime = date;
                                                _dateController.text = UtilData.obterDataDDMMAAAA(date);
                                              } else {
                                                _dateTime = null;
                                                _dateController.clear();
                                              }
                                            });
                                          });
                                        },
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
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _dropdownValueType = newValue;
                                              });
                                            },
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
                        ),
                      ),
                      Step(
                        title: Text('Local do Evento', style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),),
                        content: Container(
                          color: CustomColors.orangePrimary.shade400,
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 10.0,
                            ),
                            child: Form(
                              key: _formKey2,
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
                        ),
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