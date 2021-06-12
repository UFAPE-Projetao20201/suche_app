import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mdi/mdi.dart';
import 'package:suche_app/http/http_error.dart';
import 'package:suche_app/model/user.dart';
import 'package:suche_app/provider/user_provider.dart';
import 'package:suche_app/services/storage.dart';
import 'package:suche_app/util/constants.dart';
import 'package:suche_app/util/custom_colors.dart';
import 'package:suche_app/views/components/form_components.dart';
import 'package:suche_app/views/components/page_components.dart';
import 'package:validators/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool? _rememberMe = false;
  bool _absorbing = false;
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AbsorbPointer(
        absorbing: _absorbing,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              key: _formKey,
              child: Stack(
                children: <Widget>[
                  PageComponents.buildBackgroundContainer(),
                  Container(
                    color: CustomColors.orangePrimary.shade400,
                    height: double.infinity,
                    child: Center(
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.0,
                          // vertical: 120.0,
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
                            const SizedBox(height: 30.0),
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
                              'Insira o seu E-mail',
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            FormComponents.buildCustomTextForm(
                              'Senha',
                              _passwordController,
                              TextInputType.text,
                              (value) {
                                if (value == null || value.isEmpty) {
                                  return 'A senha é um campo obrigatório';
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
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => print(
                                  'Forgot Password Button Pressed',
                                ),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.only(right: 0.0),
                                ),
                                child: Text(
                                  'Esqueceu a senha?',
                                  style: kLabelStyle,
                                ),
                              ),
                            ),
                            Container(
                              height: 20.0,
                              child: Row(
                                children: <Widget>[
                                  Theme(
                                    data: ThemeData(
                                      unselectedWidgetColor: Colors.white,
                                    ),
                                    child: Checkbox(
                                      value: _rememberMe,
                                      checkColor: Colors.green,
                                      activeColor: Colors.white,
                                      onChanged: (value) {
                                        setState(() {
                                          _rememberMe = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Text(
                                    'Manter-me conectado',
                                    style: kLabelStyle,
                                  ),
                                ],
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
                                  // Minimiza o teclado
                                  FocusScope.of(context).unfocus();

                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      // Desabilita a tela para não receber toques
                                      setState(() {
                                        _absorbing = true;
                                      });

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Carregando...'),
                                        ),
                                      );

                                      final UserProvider _apiClient =
                                          new UserProvider();

                                      await _apiClient.userLogin(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      );

                                      // Inicialização do secure storage
                                      final SecureStorage secureStorage = SecureStorage();
                                      String userJson = await secureStorage.readSecureData('user');
                                      User user = User.fromJson(jsonDecode(userJson));

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
                                                Text('Usuário não encontrado!'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      } else if (erro == HttpError.badRequest) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text('E-mail ou senha inválidos!'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      } else {
                                        print(erro);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text('Ocorreu um erro, tente novamente!'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    }
                                  }
                                },
                                child: Text(
                                  'ENTRAR',
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
                            // _buildSignInWithText(),
                            // _buildSocialBtnRow(),
                            SizedBox(
                              height: 16,
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.of(context).pushNamed(registerUserRoute),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Não tem uma conta? ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Cadastre-se',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
      ),
    );
  }
}
