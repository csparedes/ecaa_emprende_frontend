import 'package:ecaa_emprende_app/api/backend_api.dart';
import 'package:flutter/material.dart';

class EstudiantesProvider extends ChangeNotifier {
  Future getEstudiante(String cedula) async {
    final consulta = await BackendConnection.getHttp('/estudiantes/$cedula');
    // if (consulta['msg'] == 'No hay token en la petición') {
    //   print('No hay token en la petición');
    // }
    // print('Estudiantes get: \n' + consulta.toString());
    return consulta;
  }

  Future<bool> postRegistro(Map<String, dynamic> data) async {
    final consulta = await BackendConnection.postHttp('/estudiantes', data);
    if (consulta['msg'] == 'No hay token en la petición') {
      // print('No hay token en la petición');
      return false;
    }
    // print('Consulta:\n' + consulta.toString());
    return true;
  }
}
