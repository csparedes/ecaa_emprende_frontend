import 'package:cool_alert/cool_alert.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'package:ecaa_emprende_app/provider/login_provider.dart';
import 'package:ecaa_emprende_app/routes/routes.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('assets/logo_pucesi.png'),
                  fit: BoxFit.cover,
                  width: 600,
                ),
                const Image(
                  image: AssetImage('assets/logo_ecaa.jpg'),
                ),
                const SizedBox(height: 15),
                Text(
                  'La Ecaa emprende',
                  style: GoogleFonts.roboto(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Segunda edición',
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    letterSpacing: 2,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: MaterialButton(
        onPressed: () async {
          final loginProvider = LoginProvider();
          await loginProvider
              .postLogin()
              .then((value) =>
                  Navigator.pushNamed(context, MyFluroRouter.homeRoute))
              .catchError(
                (onError) => CoolAlert.show(
                  context: context,
                  type: CoolAlertType.error,
                  text: 'Necesita conexión a Internet',
                ),
              );
        },
        color: const Color.fromARGB(255, 32, 136, 35),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 150, minHeight: 60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.login,
                color: Colors.white,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                'Acceder',
                style: GoogleFonts.roboto(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
