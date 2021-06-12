import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mdi/mdi.dart';
import 'package:suche_app/http/http_error.dart';
import 'package:suche_app/util/constants.dart';
import 'package:suche_app/util/custom_colors.dart';
import 'package:suche_app/views/components/form_components.dart';
import 'package:suche_app/views/components/page_components.dart';

class RegisterEventPage extends StatefulWidget {
  const RegisterEventPage({Key? key}) : super(key: key);

  @override
  _RegisterEventPageState createState() => _RegisterEventPageState();
}

class _RegisterEventPageState extends State<RegisterEventPage>{
  String? _dropdownValueCategory;
  bool _absorbing = false;
  DateTime? _dateTime;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _keywordsController = TextEditingController(); //Criar função para tratar o texto recebido e gerar uma lista de palavras?
  TextEditingController _dateController = TextEditingController();
  TextEditingController _priceController = TextEditingController(); //Criar função para tratar o texto recebido e gerar um valor sem cifrão, virgula e afins?
  TextEditingController _platformController = TextEditingController();

  final RegExp nameExp = new RegExp(r"^[A-Z a-zÀ-ÖØ-öø-ÿ]+$", caseSensitive: false);
  final RegExp textExp = new RegExp(r"^[A-Z a-zÀ-ÖØ-öø-ÿ]+$", caseSensitive: false); // verificar se está de acordo para textos longos

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

  final _formKey = GlobalKey<FormState>();

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
                  height: double.infinity,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 30.0,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Cadastrar Evento',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20.0),
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
                                  } else if (!textExp.hasMatch(value)) {
                                    return 'Insira um texto válido (a-z A-Z)';
                                  } else {
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
                                  } else if (!textExp.hasMatch(value)) {
                                    return 'Insira um texto válido (a-z A-Z)';
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

                              // Nome TF
                              FormComponents.buildCustomTextForm(
                                'Platafoma',
                                _platformController,
                                TextInputType.name,
                                    (value) {
                                  if (!nameExp.hasMatch(value!)) {
                                    return 'Insira um nome válido (a-z A-Z)';
                                  } else {
                                    return null;
                                  }
                                },
                                Mdi.application,
                                'Insira a plataforma do evento',
                              ),
                              SizedBox(height: 10.0),

                              // Endereço





                              Container(
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
                                  onPressed: () async {
                                    print('Clicou cadastrar evento');
                                    if (_formKey.currentState!.validate()) {
                                      try {
                                        // Desabilita a tela para não receber toques
                                        setState(() {
                                          _absorbing = true;
                                        });

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Processando dados...'),
                                          ),
                                        );

                                        // Re-habilita a tela para receber toques
                                        setState(() {
                                          _absorbing = false;
                                        });

                                        ScaffoldMessenger.of(context)
                                            .clearSnackBars();

                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          homeRoute,
                                              (route) => false,
                                        );
                                      } catch (erro) {

                                        // Re-habilita a tela para receber toques
                                        setState(() {
                                          _absorbing = false;
                                        });

                                        if (erro == HttpError.notFound) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content:
                                              Text('Ocorreu um erro! (404)'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        } else if (erro == HttpError.badRequest) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text('Ocorreu um erro! (400)'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text('Erro no cadastro!'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      }
                                    }
                                  },
                                  child: Text(
                                    'CADASTRAR',
                                    style: TextStyle(
                                      color: CustomColors.orangePrimary,
                                      letterSpacing: 1.5,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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