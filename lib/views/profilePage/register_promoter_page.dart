import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mdi/mdi.dart';
import 'package:suche_app/http/http_error.dart';
import 'package:suche_app/provider/user_provider.dart';
import 'package:suche_app/util/constants.dart';
import 'package:suche_app/util/util.dart';
import 'package:suche_app/views/components/form_components.dart';
import 'package:suche_app/views/components/page_components.dart';

class RegisterPromoterPage extends StatefulWidget {
  const RegisterPromoterPage({Key? key}) : super(key: key);

  @override
  _RegisterPromoterPageState createState() => _RegisterPromoterPageState();
}

class _RegisterPromoterPageState extends State<RegisterPromoterPage> {
  bool _absorbing = false;

  TextEditingController _cpfCnpjlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro Promotor"),
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
                    ),
                    child: Form(
                        key: _formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 20.0),
                              Text(
                                'Torne-se Promotor',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                'Por segurança, para tornar-se promotor de eventos, precisamos que infor seu CPF ou CNPJ.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // CPF/CNPJ TF
                                    FormComponents.buildCustomTextForm(
                                        'CPF/CNPJ',
                                        _cpfCnpjlController,
                                        TextInputType.number, (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'O CPF/CNPJ é um campo obrigatório';
                                      } else if (!(Util.sanitizeCpfCnpj(value)
                                                  .length ==
                                              11 ||
                                          Util.sanitizeCpfCnpj(value).length ==
                                              14)) {
                                        return 'Insira um CPF/CNPJ válido';
                                      } else {
                                        return null;
                                      }
                                    }, Mdi.cardAccountDetails,
                                        'Insira o CPF/CNPJ',
                                        listTextInputFormatter: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          CpfOuCnpjFormatter()
                                        ]),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 25.0),
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          padding: EdgeInsets.all(15),
                                          elevation: 5.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (_formKey.currentState!.validate()) {
                                            try {
                                              // Desabilita a tela para não receber toques
                                              setState(() {
                                                _absorbing = true;
                                              });

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Processando dados...'),
                                                ),
                                              );

                                              final UserProvider _apiClient =
                                                  new UserProvider();

                                              await _apiClient.setPromoterUser(
                                                email: 'jose@gmail.com', //automatizar essa passagem de e-mail quando tiver acesso ao user
                                                cpfCnpj: _cpfCnpjlController.text,
                                              );

                                              // Re-habilita a tela para receber toques
                                              setState(() {
                                                _absorbing = false;
                                              });

                                              ScaffoldMessenger.of(context)
                                                  .clearSnackBars();

                                              Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                perfilRoute,
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
                                                    content: Text(
                                                        'Ocorreu um erro! (404)'),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              } else if (erro ==
                                                  HttpError.badRequest) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'Ocorreu um erro! (400)'),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content:
                                                        Text('Erro no cadastro!'),
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
                                            color: Color(0xFF527DAA),
                                            letterSpacing: 1.5,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'OpenSans',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ]),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
