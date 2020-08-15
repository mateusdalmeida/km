// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Controller on ControllerBase, Store {
  Computed<double> _$disponibleComputed;

  @override
  double get disponible =>
      (_$disponibleComputed ??= Computed<double>(() => super.disponible,
              name: 'ControllerBase.disponible'))
          .value;

  final _$gasMapAtom = Atom(name: 'ControllerBase.gasMap');

  @override
  ObservableMap<dynamic, dynamic> get gasMap {
    _$gasMapAtom.reportRead();
    return super.gasMap;
  }

  @override
  set gasMap(ObservableMap<dynamic, dynamic> value) {
    _$gasMapAtom.reportWrite(value, super.gasMap, () {
      super.gasMap = value;
    });
  }

  final _$lastGasAtom = Atom(name: 'ControllerBase.lastGas');

  @override
  ObservableMap<dynamic, dynamic> get lastGas {
    _$lastGasAtom.reportRead();
    return super.lastGas;
  }

  @override
  set lastGas(ObservableMap<dynamic, dynamic> value) {
    _$lastGasAtom.reportWrite(value, super.lastGas, () {
      super.lastGas = value;
    });
  }

  final _$litrosTotaisAtom = Atom(name: 'ControllerBase.litrosTotais');

  @override
  double get litrosTotais {
    _$litrosTotaisAtom.reportRead();
    return super.litrosTotais;
  }

  @override
  set litrosTotais(double value) {
    _$litrosTotaisAtom.reportWrite(value, super.litrosTotais, () {
      super.litrosTotais = value;
    });
  }

  final _$tripMapAtom = Atom(name: 'ControllerBase.tripMap');

  @override
  ObservableMap<dynamic, dynamic> get tripMap {
    _$tripMapAtom.reportRead();
    return super.tripMap;
  }

  @override
  set tripMap(ObservableMap<dynamic, dynamic> value) {
    _$tripMapAtom.reportWrite(value, super.tripMap, () {
      super.tripMap = value;
    });
  }

  final _$lastTripAtom = Atom(name: 'ControllerBase.lastTrip');

  @override
  ObservableMap<dynamic, dynamic> get lastTrip {
    _$lastTripAtom.reportRead();
    return super.lastTrip;
  }

  @override
  set lastTrip(ObservableMap<dynamic, dynamic> value) {
    _$lastTripAtom.reportWrite(value, super.lastTrip, () {
      super.lastTrip = value;
    });
  }

  final _$kmTotaisAtom = Atom(name: 'ControllerBase.kmTotais');

  @override
  int get kmTotais {
    _$kmTotaisAtom.reportRead();
    return super.kmTotais;
  }

  @override
  set kmTotais(int value) {
    _$kmTotaisAtom.reportWrite(value, super.kmTotais, () {
      super.kmTotais = value;
    });
  }

  final _$ControllerBaseActionController =
      ActionController(name: 'ControllerBase');

  @override
  dynamic addToGasMap(DocumentSnapshot item) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.addToGasMap');
    try {
      return super.addToGasMap(item);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addToTripMap(DocumentSnapshot item) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.addToTripMap');
    try {
      return super.addToTripMap(item);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
gasMap: ${gasMap},
lastGas: ${lastGas},
litrosTotais: ${litrosTotais},
tripMap: ${tripMap},
lastTrip: ${lastTrip},
kmTotais: ${kmTotais},
disponible: ${disponible}
    ''';
  }
}
