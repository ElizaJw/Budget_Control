class modelCategories {
  int _tope;
  String _descripcion;

  modelCategories(this._tope, this._descripcion);

  set descripcion(String descripcion) {
    if (_validarDatoNullVacioStr(descripcion)) {
      _descripcion = descripcion;
    }
  }

  String get descripcion {
    return _descripcion;
  }

  set tope(int tope) {
    if (_validarDatoNullVacioInt(tope)) {
      _tope = tope;
    }
  }

  int get tope {
    return _tope;
  }

  bool _validarDatoNullVacioStr(String dato) {
    if (null == dato || dato.isEmpty) {
      throw ('La descripcion no debe estar vacia.');
    }
    return true;
  }

  bool _validarDatoNullVacioInt(int dato) {
    if (dato <= 0) {
      throw ('El tope debe ser mayor a 0.');
    }
    return true;
  }
}
