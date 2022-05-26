import 'package:ecaa_emprende_app/api/backend_api.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginProvider extends ChangeNotifier {
  Future<bool> postLogin() async {
    final dataLogin = {
      "user": dotenv.env['USER'],
      "password": dotenv.env['PASSWORD'],
    };
    final consulta = await BackendConnection.postHttp('/login', dataLogin);
    dotenv.env['TOKEN'] = consulta['token'];
    return true;
  }
}
