import 'package:ecaa_emprende_app/helpers/validationes.dart';
import 'package:ecaa_emprende_app/provider/estudiantes_provider.dart';
import 'package:ecaa_emprende_app/provider/theme_provider.dart';
import 'package:ecaa_emprende_app/shared/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:barcode_scan2/model/android_options.dart';
import 'package:barcode_scan2/model/scan_options.dart';
import 'package:barcode_scan2/platform_wrapper.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cool_alert/cool_alert.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

TextEditingController textController = TextEditingController();
List<dynamic> usersList = [];

class _HomePageState extends State<HomePage> {
  late FocusNode myFocusNode;

  @override
  void initState() {
    myFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 10),
            Text(
              'PUCESI',
              style: GoogleFonts.roboto(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
                letterSpacing: 5,
              ),
            ),
          ],
        ),
        toolbarHeight: 60,
      ),
      drawer: const _MyCustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'La ECAA emprende',
            style: GoogleFonts.roboto(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          Container(
            constraints: const BoxConstraints(maxWidth: 300),
            child: TextField(
              controller: textController,
              autofocus: true,
              maxLength: 10,
              focusNode: myFocusNode,
              keyboardType: TextInputType.number,
              onSubmitted: (value) async {
                // if (MyValidationes.cedula(value)) {
                if (true) {
                  final providerEstudiantes = EstudiantesProvider();
                  final estudiante = await providerEstudiantes
                      .getEstudiante(textController.text);
                  // print(estudiante);
                  if (estudiante['response'] == null) {
                    textController.clear();
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.error,
                      text: 'Lo siento, no has sido invitado al evento',
                      cancelBtnText: 'Ok',
                      autoCloseDuration: const Duration(milliseconds: 2100),
                    );
                    myFocusNode.requestFocus();
                  } else {
                    final cedula = estudiante['response'][2].toString();
                    final apellidos = estudiante['response'][3].toString();
                    final nombres = estudiante['response'][4].toString();
                    final carrera = estudiante['response'][5].toString();
                    final correo = estudiante['response'][7].toString();
                    final registro = DateTime.now().toString();
                    final data = {
                      "cedula": cedula,
                      "apellidos": apellidos,
                      "nombres": nombres,
                      "carrera": carrera,
                      "correo": correo,
                      "registro": registro
                    };

                    if (await providerEstudiantes.postRegistro(data)) {
                      usersList.insert(0, data);
                      myFocusNode.requestFocus();
                      textController.clear();
                    } else {
                      textController.clear();
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.error,
                          text: 'La cédula es incorrecta',
                          cancelBtnText: 'Ok',
                          onConfirmBtnTap: () {
                            Navigator.pop(context);
                            myFocusNode.requestFocus();
                          });
                      myFocusNode.requestFocus();
                    }
                  }
                }
                // else {
                //   textController.clear();
                //   CoolAlert.show(
                //     context: context,
                //     type: CoolAlertType.error,
                //     text: 'La cédula es incorrecta',
                //     cancelBtnText: 'Ok',
                //   );
                //   myFocusNode.requestFocus();
                // }
                setState(() {});
              },
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: usersList.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  leading: const Icon(Icons.verified_user_rounded),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(usersList[index]['apellidos'].toUpperCase()),
                      Text(usersList[index]['nombres'].toUpperCase()),
                    ],
                  ),
                  subtitle:
                      Text('Cédula: ${usersList[index]['cedula'].toString()}'),
                );
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: buildFloatingButton(),
    );
  }

  FloatingActionButton buildFloatingButton() {
    // if (Platform.isAndroid) {
    //   return FloatingActionButton(
    //     onPressed: _scan,
    //     child: const Icon(Icons.add),
    //   );
    // }

    // return FloatingActionButton(
    //   onPressed: () {},
    //   child: const Icon(Icons.not_interested),
    // );
    if (defaultTargetPlatform == TargetPlatform.android) {
      return FloatingActionButton(
        onPressed: _scan,
        child: const Icon(Icons.add),
      );
    } else {
      return FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.not_interested),
      );
    }
  }

  Future<void> _scan() async {
    try {
      var result = await BarcodeScanner.scan(
        options: const ScanOptions(
          strings: {
            'cancel': 'Cancelar',
            'flash_on': 'Prender',
            'flash_off': 'Apagar',
          },
          android: AndroidOptions(
            aspectTolerance: 0,
            useAutoFocus: true,
          ),
        ),
      );

      // if (MyValidationes.cedula(result.rawContent.toString())) {
      if (true) {
        final providerEstudiantes = EstudiantesProvider();
        final estudiante = await providerEstudiantes
            .getEstudiante(result.rawContent.toString());

        if (estudiante['response'] == null) {
          textController.clear();
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: 'Lo siento, no has sido invitado al evento',
            cancelBtnText: 'Ok',
            autoCloseDuration: const Duration(milliseconds: 2100),
          );
          myFocusNode.requestFocus();
        } else {
          final cedula = estudiante['response'][2].toString();
          final apellidos = estudiante['response'][3].toString();
          final nombres = estudiante['response'][4].toString();
          final carrera = estudiante['response'][5].toString();
          final correo = estudiante['response'][7].toString();
          final registro = DateTime.now().toString();
          final data = {
            "cedula": cedula,
            "apellidos": apellidos,
            "nombres": nombres,
            "carrera": carrera,
            "correo": correo,
            "registro": registro
          };

          if (await providerEstudiantes.postRegistro(data)) {
            usersList.insert(0, data);
            myFocusNode.requestFocus();
            textController.clear();
          } else {
            textController.clear();
            CoolAlert.show(
                context: context,
                type: CoolAlertType.error,
                text: 'La cédula es incorrecta',
                cancelBtnText: 'Ok',
                onConfirmBtnTap: () {
                  Navigator.pop(context);
                  myFocusNode.requestFocus();
                });
            myFocusNode.requestFocus();
          }
        }
      }
      //  else {
      //   textController.clear();
      //   CoolAlert.show(
      //     context: context,
      //     type: CoolAlertType.error,
      //     text: 'La cédula es incorrecta',
      //     cancelBtnText: 'Ok',
      //   );
      //   myFocusNode.requestFocus();
      // }
      setState(() {});
    } on PlatformException catch (e) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: 'Error al leer la cédula, inténtelo nuevamente:\n $e',
      );
    }
  }
}

class _MyCustomDrawer extends StatefulWidget {
  const _MyCustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<_MyCustomDrawer> createState() => _MyCustomDrawerState();
}

class _MyCustomDrawerState extends State<_MyCustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo_pucesi.png'),
                  fit: BoxFit.cover,
                  // invertColors: true,
                ),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: MySharedPreferences.isDarkMode
                ? const Icon(Icons.dark_mode_outlined)
                : const Icon(Icons.light_mode_outlined),
            title: Text(
              MySharedPreferences.isDarkMode ? 'Dark Mode' : 'Light Mode',
              style: GoogleFonts.roboto(
                fontSize: 18,
                letterSpacing: 2,
              ),
            ),
            trailing: Switch(
                value: MySharedPreferences.isDarkMode,
                onChanged: (value) {
                  setState(() {
                    MySharedPreferences.isDarkMode = (value);
                    final themeProvider =
                        Provider.of<ThemeProvider>(context, listen: false);
                    value
                        ? themeProvider.setDarkMode()
                        : themeProvider.setLightMode();
                  });
                }),
          ),
        ],
      ),
    );
  }
}
