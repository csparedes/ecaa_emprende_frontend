import 'package:ecaa_emprende_app/routes/handlers.dart';
import 'package:fluro/fluro.dart';

class MyFluroRouter {
  static final FluroRouter router = FluroRouter();
  static String homeRoute = '/';
  static String blankRoute = '/blank';
  static String welcomeRoute = '/welcome';
  static void configureRoutes() {
    router.define(
      homeRoute,
      handler: Handlers.home,
      transitionType: TransitionType.fadeIn,
      transitionDuration: const Duration(seconds: 1),
    );
    router.define(
      blankRoute,
      handler: Handlers.blank,
      transitionType: TransitionType.fadeIn,
      transitionDuration: const Duration(seconds: 1),
    );
    router.define(
      welcomeRoute,
      handler: Handlers.welcome,
      transitionType: TransitionType.fadeIn,
      transitionDuration: const Duration(seconds: 1),
    );
  }
}
