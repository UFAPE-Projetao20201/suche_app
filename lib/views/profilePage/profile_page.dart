import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:suche_app/model/user.dart';
import 'package:suche_app/util/custom_colors.dart';
import 'package:suche_app/views/components/bottom_sheet_components.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Atividade de edição de usuário congelada
  /*String _emailUser = "edsgerdijkstra@gmail.com";
  String _nameUser = "Edsger";
  String _surnameUser = "Dijkstra";
  String? _sexoUser = "Masculino";
  DateTime? _birthUser = DateTime.now();*/

  TextEditingController _cpfCnpjlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text("Perfil"),
      ),*/
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            // PageComponents.buildBackgroundContainer(),
            Container(
              color: CustomColors.orangePrimary.shade300,
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 1080,
                      height: 30,
                    ),
                    // Antigo form de foto caso precise usar
                    /*SizedBox(
                        height: 150,
                        width: 150,
                        child: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/images/profile example.png'),
                            ),
                            Positioned(
                              bottom: 0,
                              right: -12,
                              child: SizedBox(
                                height: 35,
                                width: 35,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    padding: EdgeInsets.all(0),
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  onPressed: () => print('clicou trocar foto'),
                                  child: Icon(
                                    Icons.add_a_photo_outlined,
                                    color: Color(0xFF527DAA),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),*/
                    Avatar(
                      name: widget.user.name + ' ' + widget.user.surname,
                      placeholderColors: [
                        Colors.white,
                      ],
                      textStyle: TextStyle(
                        color: CustomColors.orangePrimary,
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.user.name + ' ' + widget.user.surname,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Visibility(
                      visible: !widget.user.isPromoter,
                      child: ElevatedButton(
                        onPressed: () => BottomSheetComponents.promoterBottomSheet(context, _formKey, _cpfCnpjlController, widget.user),
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                          elevation: MaterialStateProperty.all(0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.approval,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Torne-se um promotor de eventos'),
                          ],
                        ),
                      ),
                      replacement: Container(),
                    ),

                    // Atividade de edição de usuário congelada
                    /*SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Informações Pessoais',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(height: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'E-mail',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Mdi.emailVariant,
                                  color: Colors.white,
                                ),
                                hintText: _emailUser,
                                hintStyle: kHintTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Nome',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextField(
                              keyboardType: TextInputType.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Mdi.formTextbox,
                                  color: Colors.white,
                                ),
                                hintText: _nameUser,
                                hintStyle: kHintTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Sobrenome',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextField(
                              keyboardType: TextInputType.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Mdi.formTextbox,
                                  color: Colors.white,
                                ),
                                hintText: _surnameUser,
                                hintStyle: kHintTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Gênero',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.center,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                Icon(
                                  Mdi.genderMaleFemale,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: DropdownButton<String>(
                                    value: _sexoUser,
                                    icon: const Icon(Icons.arrow_downward,
                                        color: Colors.white),
                                    iconSize: 24,
                                    isExpanded: true,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.white),
                                    dropdownColor: Color(0xFF2B387D),
                                    underline: Container(
                                      height: 0,
                                      color: Colors.white54,
                                    ),
                                    hint: _sexoUser != null
                                        ? null
                                        : Text('Selecione o sexo',
                                            style: kHintTextStyle,
                                            textScaleFactor: 1.2),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _sexoUser = newValue;
                                      });
                                    },
                                    items: <String>[
                                      'Masculino',
                                      'Feminino',
                                      'Outros',
                                      'Prefiro não falar'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          textScaleFactor: 1.2,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Data de Nascimento',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextField(
                              readOnly: true,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Mdi.calendarStar,
                                  color: Colors.white,
                                ),
                                hintText: _birthUser == null
                                    ? 'Insira a data de nascimento'
                                    : UtilData.obterDataDDMMAAAA(_birthUser!),
                                hintStyle: kHintTextStyle,
                              ),
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1920),
                                  lastDate: DateTime.now(),
                                ).then((date) {
                                  setState(() {
                                    _birthUser = date;
                                  });
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Senha Antiga',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextField(
                              keyboardType: TextInputType.visiblePassword,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Mdi.formTextboxPassword,
                                  color: Colors.white,
                                ),
                                hintText: 'Digite a senha antiga',
                                hintStyle: kHintTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Nova Senha',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextField(
                              keyboardType: TextInputType.visiblePassword,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Mdi.formTextboxPassword,
                                  color: Colors.white,
                                ),
                                hintText: 'Digite a nova senha',
                                hintStyle: kHintTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Repita a Nova Senha',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextField(
                              keyboardType: TextInputType.visiblePassword,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Mdi.formTextboxPassword,
                                  color: Colors.white,
                                ),
                                hintText: 'Repita a nova senha',
                                hintStyle: kHintTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
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
                          onPressed: () => print('clicou salvar'),
                          //Navigator.pushNamedAndRemoveUntil(context, homeRoute, (route) => false)
                          child: Text(
                            'SALVAR ALTERAÇÕES',
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
                      SizedBox(height: 40.0),*/
                    // aqui
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
