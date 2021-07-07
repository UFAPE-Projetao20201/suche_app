// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:brasil_fields/brasil_fields.dart';
import 'package:mdi/mdi.dart';
import 'package:suche_app/http/http_error.dart';
import 'package:validators/validators.dart';

// Project imports:
import 'package:suche_app/model/user.dart';
import 'package:suche_app/provider/user_provider.dart';
import 'package:suche_app/services/storage.dart';
import 'package:suche_app/util/constants.dart';
import 'package:suche_app/util/custom_colors.dart';
import 'package:suche_app/util/util.dart';
import 'package:suche_app/views/components/form_components.dart';
import 'package:suche_app/views/components/page_components.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({Key? key}) : super(key: key);

  @override
  _RegisterUserPageState createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  String? _dropdownValueSexo;
  DateTime? _dateTime;
  bool _passwordVisible = false;
  bool _absorbing = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _birthController = TextEditingController();

  final RegExp nameExp = new RegExp(r"^[A-Z a-zÀ-ÖØ-öø-ÿ]+$", caseSensitive: false);

  List<String> genderList = [
  'Masculino',
  'Feminino',
  'Outros',
  'Prefiro não informar'
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text("Cadastro Usuário"),
      ),*/
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
                  child: Center(
                    child: SafeArea(
                      child: SingleChildScrollView(
                        key: Key('ScrollCadastro'),
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.0,
                          vertical: 40.0,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Cadastre-se',
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
                                  // E-mail TF
                                  FormComponents.buildCustomTextForm(
                                    'E-mail',
                                    _emailController,
                                    TextInputType.emailAddress,
                                    (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'O e-mail é um campo obrigatório';
                                      } else if (!isEmail(value)) {
                                        return 'Insira um e-mail válido';
                                      } else {
                                        return null;
                                      }
                                    },
                                    Mdi.emailVariant,
                                    'Insira seu e-mail',
                                  ),
                                  SizedBox(height: 10.0),
                                  // Nome TF
                                  FormComponents.buildCustomTextForm(
                                    'Nome',
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
                                    'Insira seu nome',
                                  ),
                                  SizedBox(height: 10.0),
                                  // Sobrenome TF
                                  FormComponents.buildCustomTextForm(
                                    'Sobrenome',
                                    _surnameController,
                                    TextInputType.name,
                                        (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'O sobrenome é um campo obrigatório';
                                      } else if (!nameExp.hasMatch(value)) {
                                        return 'Insira um sobrenome válido (a-z A-Z)';
                                      } else {
                                        return null;
                                      }
                                    },
                                    Mdi.formTextbox,
                                    'Insira seu sobrenome',
                                  ),
                                  SizedBox(height: 10.0),
                                  // Telefone TF
                                  FormComponents.buildCustomTextForm(
                                    'Telefone',
                                    _phoneController,
                                    TextInputType.phone,
                                    (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'O telefone é um campo obrigatório';
                                      } else if (!(Util.sanitizePhone(value).length == 10 || Util.sanitizePhone(value).length == 11)) {
                                        return 'Número de telefone inválido';
                                      } else {
                                        return null;
                                      }
                                    },
                                    Mdi.phone,
                                    'Insira seu número',
                                    listTextInputFormatter: [FilteringTextInputFormatter.digitsOnly, TelefoneInputFormatter()]
                                  ),
                                  SizedBox(height: 10.0),
                                  // Gênero TF
                                  FormComponents.buildCustomForm(
                                    'Gênero',
                                    _phoneController,
                                    Center(
                                      child: DropdownButtonFormField<String>(
                                        key: Key("dropgenero"),
                                        value: _dropdownValueSexo,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'O gênero é um campo obrigatório';
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
                                          prefixIcon: Icon(Mdi.genderMaleFemale, color: Colors.white,),
                                          prefixText: "   ", // espaçador
                                          hintStyle: kHintTextStyle,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.zero
                                        ),
                                        style: const TextStyle(color: Colors.white),
                                        dropdownColor: CustomColors.orangePrimary,
                                        hint: _dropdownValueSexo != null
                                            ? null
                                            : Text('Selecione o sexo',
                                            style: kHintTextStyle,
                                            textScaleFactor: 1.2),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _dropdownValueSexo = newValue;
                                          });
                                        },
                                        items: genderList
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
                                  // Data de nascimento TF
                                  FormComponents.buildCustomTextForm(
                                    'Data de nascimento',
                                    _birthController,
                                    TextInputType.datetime,
                                    (value) {
                                      if (_birthController.text.isEmpty) {
                                        return 'A data é um campo obrigatório';
                                      } else {
                                        return null;
                                      }
                                    },
                                    Mdi.calendarStar,
                                    _birthController.text.isEmpty
                                        ? 'Insira a data de nascimento'
                                        : UtilData.obterDataDDMMAAAA(_dateTime!),
                                    readOnly: true,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1920),
                                        lastDate: DateTime.now(),
                                      ).then((date) {
                                        setState(() {
                                          if(date != null) {
                                            _dateTime = date;
                                            _birthController.text = UtilData.obterDataDDMMAAAA(date);
                                          } else {
                                            _dateTime = null;
                                            _birthController.clear();
                                          }
                                        });
                                      });
                                    },
                                  ),
                                  SizedBox(height: 10.0),
                                  // Senha TF
                                  FormComponents.buildCustomTextForm(
                                    'Senha',
                                    _passwordController,
                                    TextInputType.text,
                                        (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'A senha é um campo obrigatório';
                                      } else if (value.length < 8) {
                                        return 'A senha é muito curta';
                                      } else {
                                        return null;
                                      }
                                    },
                                    Mdi.formTextboxPassword,
                                    'Insira a sua senha',
                                    obscureText: !_passwordVisible,
                                    suffixIconButton: IconButton(
                                      icon: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: CustomColors.orangePrimary.shade300,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                  ),

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

                                            final UserProvider _apiClient =
                                            new UserProvider();

                                            await _apiClient.createUser(
                                              name: _nameController.text,
                                              surname: _surnameController.text,
                                              email: _emailController.text,
                                              birthDate: _dateTime.toString(),
                                              gender: _dropdownValueSexo.toString(),
                                              password: _passwordController.text,
                                              phone: Util.sanitizePhone(_phoneController.text),
                                            );

                                            //Guardando o usuário de forma segura localmente
                                            final SecureStorage secureStorage = SecureStorage();

                                            //Lendo o usuário de forma segura localmente
                                            String? value = await secureStorage.readSecureData('user');
                                            User user = User.fromJson(jsonDecode(value!),);

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
                                              arguments: user,
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
                                                  content: Text('Email ou Telefone já existem no sistema! (400)'),
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
