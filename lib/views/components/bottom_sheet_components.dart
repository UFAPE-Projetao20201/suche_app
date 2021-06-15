import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mdi/mdi.dart';
import 'package:suche_app/http/http_error.dart';
import 'package:suche_app/model/user.dart';
import 'package:suche_app/provider/user_provider.dart';
import 'package:suche_app/util/custom_colors.dart';
import 'package:suche_app/util/util.dart';
import 'package:suche_app/views/components/form_components.dart';

class BottomSheetComponents {
  static promoterBottomSheet(
    BuildContext context,
    GlobalKey<FormState> _formKey,
    TextEditingController _cpfCnpjlController, User _user,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: CustomColors.orangePrimary.shade400,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20.0),
                    Text(
                      'Torne-se Promotor',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'Por segurança, para tornar-se promotor de eventos, precisamos que informe seu CPF ou CNPJ.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // CPF/CNPJ TF
                        FormComponents.buildCustomTextForm('CPF/CNPJ',
                            _cpfCnpjlController, TextInputType.number, (value) {
                              if (value == null || value.isEmpty) {
                                return 'O CPF/CNPJ é um campo obrigatório';
                              } else if (!(Util.sanitizeCpfCnpj(value).length ==
                                  11 ||
                                  Util.sanitizeCpfCnpj(value).length == 14)) {
                                return 'Insira um CPF/CNPJ válido';
                              } else {
                                return null;
                              }
                            }, Mdi.cardAccountDetails, 'Insira o CPF/CNPJ',
                            listTextInputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              CpfOuCnpjFormatter()
                            ]),
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
                                  // TODO: Fix - Snackbars aparecendo ao fundo
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Processando dados...'),
                                    ),
                                  );

                                  final UserProvider _apiClient =
                                  new UserProvider();

                                  await _apiClient.setPromoterUser(
                                    email: _user.email,
                                    cpfCnpj: Util.sanitizeCpfCnpj(_cpfCnpjlController.text),
                                    token: _user.token,
                                  );

                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();

                                  Navigator.pop(context);
                                } catch (erro) {
                                  // TODO: Fix - Snackbars aparecendo ao fundo
                                  if (erro == HttpError.notFound) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Ocorreu um erro! (404)',
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else if (erro == HttpError.badRequest) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Ocorreu um erro! (400)',
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Erro no cadastro!',
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                }
                              }
                            },
                            child: Text(
                              'ATUALIZAR',
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
        );
      },
    );
  }
}
