// Flutter imports:
import 'dart:async';

import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mdi/mdi.dart';
import 'package:suche_app/model/event.dart';
import 'package:suche_app/model/user.dart';
import 'package:suche_app/provider/event_provider.dart';
import 'package:suche_app/util/constants.dart';

// Project imports:
import 'package:suche_app/util/custom_colors.dart';
import 'package:suche_app/views/components/form_components.dart';
import 'package:suche_app/views/eventsPages/listEventsPage/components/event_tile_component.dart';

class ListEventsPage extends StatefulWidget {
  final User user;

  const ListEventsPage({Key? key, required this.user}) : super(key: key);

  @override
  _ListEventsPageState createState() => _ListEventsPageState();
}

class _ListEventsPageState extends State<ListEventsPage> {
  bool _switchTypeEventValue = true;
  List<Event> eventList = [];
  bool erro = false;
  bool loading = false;
  String? _dropdownValueCategory;
  Timer? searchOnStoppedTyping;

  TextEditingController _categoryController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  final RegExp nameExp = new RegExp(r"^[A-Z a-zÀ-ÖØ-öø-ÿ]+$", caseSensitive: false);

  List<String> _categoryList = [
    'Todas',
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
  void initState() {
    super.initState();
    getEvents();
    //_nameController.addListener(_onChangeHandler);
  }

  _onChangeHandler(value ) {
    const duration = Duration(milliseconds:800); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping!.cancel()); // clear timer
    }
    setState(() => searchOnStoppedTyping = new Timer(duration, () => getEvents()));
  }


  getEvents() async {
    setState(() {
      loading = true;
    });

    if(_switchTypeEventValue){
      await getPresentialEvent(_nameController.text, _dropdownValueCategory);
    } else {
      await getOnlineEvent(_nameController.text, _dropdownValueCategory);
    }

    setState(() {
      loading = false;
    });
  }

  getPresentialEvent(String? name, String? category) async {
    print('carregando getPresentialEvent');

    setState(() {
      eventList = [];
    });

    final EventProvider _apiClient = EventProvider();

    try {
      if (category == 'Todas' || category == 'Categoria'){
        category = null;
      }
      if(name == ''){
        name = null;
      }
      var eventListResponse = await _apiClient.listPresentialEvents(name, category);

      setState(() {
        for (int i = 0; i < eventListResponse.length; i++) {
          Event event = Event.fromJson(eventListResponse[i]);
          eventList.add(event);
        }
      });
      print(eventList.isEmpty);
      print(eventList.length);
    } on Exception catch (e) {
      print('excecao -> ' + e.toString());
    }
  }

  getOnlineEvent(String? name, String? category) async {
    print('carregando getOnlineEvent');
    setState(() {
      eventList = [];
    });

    final EventProvider _apiClient = EventProvider();

    try {
      if (category == 'Todas' || category == 'Categoria'){
        category = null;
      }
      if(name == ''){
        name = null;
      }
      var eventListResponse = await _apiClient.listOnlineEvents(name, category);

      setState(() {
        for (int i = 0; i < eventListResponse.length; i++) {
          Event event = Event.fromJson(eventListResponse[i]);
          eventList.add(event);
        }
      });
      print(eventList.isEmpty);
      print(eventList.length);
    } on Exception catch (e) {
      print('excecao -> ' + e.toString());
    }
  }

  error() {
    setState(() {
      loading = false;
      erro = true;
    });
  }


  // listEvents

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !erro,
      replacement: Text('erro'),
      child: Container(
          color: CustomColors.colorLightGray,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              /*SizedBox(height: 20.0),
              Text(
                'Eventos',
                style: TextStyle(
                  color: CustomColors.orangePrimary.shade400,
                  fontFamily: 'OpenSans',
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                ),
              ),*/
              SizedBox(height: 5.0),
              SafeArea(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // Form Nome
                            Flexible(
                              child: Container(
                                decoration: kBoxSearchDecorationStyle,
                                height: 45.0,
                                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                                child: TextFormField(
                                  controller: _nameController,
                                  keyboardType: TextInputType.name,
                                  onChanged: _onChangeHandler,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'OpenSans',
                                  ),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    return null;
                                  },
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Mdi.magnify,
                                      color: Colors.white,
                                    ),
                                    prefixIconConstraints: BoxConstraints(minWidth: 0,),
                                    prefixText: "   ", // espaçador
                                    hintText: 'Pesquisar Evento',
                                    hintStyle: kHintTextStyle,
                                    errorStyle: kErrorTextStyle,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),

                        Row(
                           children: [
                             // Form Categoria
                             Flexible(
                               child: FormComponents.buildCustomFormSearch(
                                 _categoryController,
                                 Center(
                                   child: DropdownButtonFormField<String>(
                                     value: _dropdownValueCategory,
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
                                         : Text('Categoria',
                                         style: kHintTextStyle,
                                         textScaleFactor: 1.2),
                                     onChanged: (String? newValue) {
                                       setState(() {
                                         _dropdownValueCategory = newValue;
                                         getEvents();
                                       });
                                     },
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
                             ),

                             SizedBox(width: 10,),

                             //Botão Switch
                             FlutterSwitch(
                               width: 150.0,
                               height: 45.0,
                               toggleSize: 45.0,
                               borderRadius: 30.0,
                               padding: 8.0,
                               valueFontSize: 16,
                               showOnOff: true,
                               toggleColor: CustomColors.colorLightGray,//
                               activeColor: CustomColors.orangePrimary.shade400,
                               activeText: "Prensencial",
                               activeTextColor: CustomColors.colorLightGray,//
                               activeTextFontWeight: FontWeight.w900 ,
                               inactiveColor: CustomColors.orangePrimary.shade400,
                               inactiveText: "Virtual",
                               inactiveTextColor: CustomColors.colorLightGray,//
                               inactiveTextFontWeight: FontWeight.w900,
                               value: _switchTypeEventValue,
                               onToggle: (val) {
                                 setState(() {
                                   _switchTypeEventValue = !_switchTypeEventValue;
                                   getEvents();
                                 });
                               },
                             ),
                           ],
                         ),
                      ],
                    ),
                  ),
                ),
              ),
              //SizedBox(height: 20.0),
              Divider(
                color: CustomColors.colorOrangeSecondary,
              ),
              Visibility(
                visible: !loading,
                replacement: Flexible(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                child:  Visibility(
                  visible: eventList.isNotEmpty,
                  replacement: Flexible(
                    child: Center(
                      child: Text(
                      'Não há eventos cadastrados',
                      textAlign: TextAlign.center,
                        style: TextStyle(
                        color: CustomColors.orangePrimary.shade400,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    ),
                  ),
                  child: Expanded(
                    child:ListView.builder(
                      itemCount: eventList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Column(
                            children: [
                              EventTileComponent.buildEventTileComponent(
                                  eventList[index]),
                              Divider(
                                color: CustomColors.colorOrangeSecondary,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )

            ],

          )
      ),
    );
  }
}
