class MyValidationes {
  // Método estático para validar la cédula
  static bool cedula(String cedula) {
    final List<int> multiplos = [2, 1, 2, 1, 2, 1, 2, 1, 2];
    if (cedula.length != 10) {
      return false;
    }
    if (int.parse(cedula.substring(0, 2)) > 24) {
      return false;
    }
    if (int.parse(cedula[2]) > 5) {
      return false;
    }
    final cedulaStringList = cedula.split('');
    List<int> lista = List.filled(10, 0);
    for (var i = 0; i < cedulaStringList.length; i++) {
      lista[i] = int.parse(cedulaStringList[i]);
    }
    List<int> result = List.filled(9, 0);
    for (var i = 0; i < multiplos.length; i++) {
      result[i] = multiplos[i] * lista[i];
      if (result[i] >= 10) {
        result[i] = result[i] - 9;
      }
    }
    int sumResult = 0;
    for (int element in result) {
      sumResult += element;
    }
    if (10 - (sumResult % 10) == lista[9]) {
      return true;
    }
    return false;
  }
}
