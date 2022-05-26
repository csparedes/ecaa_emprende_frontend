import 'package:ecaa_emprende_app/pages/blank_page.dart';
import 'package:ecaa_emprende_app/pages/home_page.dart';
import 'package:ecaa_emprende_app/pages/welcome_page.dart';
import 'package:fluro/fluro.dart';

class Handlers {
  static Handler home = Handler(
    handlerFunc: ((context, parameters) {
      return const HomePage();
    }),
  );
  static Handler blank = Handler(
    handlerFunc: ((context, parameters) {
      return const BlankPage();
    }),
  );
  static Handler welcome = Handler(
    handlerFunc: ((context, parameters) {
      return const WelcomePage();
    }),
  );
}
