import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';

part 'controller.g.dart';

class Controller = ControllerBase with _$Controller;
final db = Firestore.instance;

abstract class ControllerBase with Store {
  ControllerBase() {
    db.collection("gas").orderBy("epoch").snapshots().forEach((docs) {
      docs.documentChanges.forEach((changes) {
        switch (changes.type) {
          case DocumentChangeType.removed:
            break;
          default:
            addToGasMap(changes.document);
            break;
        }
      });
    });
    db.collection("trip").orderBy("epoch").snapshots().forEach((docs) {
      docs.documentChanges.forEach((changes) {
        switch (changes.type) {
          case DocumentChangeType.removed:
            break;
          default:
            addToTripMap(changes.document);
            break;
        }
      });
    });
  }

  //gas
  @observable
  ObservableMap gasMap = ObservableMap();

  @observable
  ObservableMap lastGas =
      ObservableMap.of({"preco": 0, "valor": 0, "epoch": 0});

  @observable
  double litrosTotais = 0;

  //trip
  @observable
  ObservableMap tripMap = ObservableMap();

  @observable
  ObservableMap lastTrip = ObservableMap.of({"initial": 0, "epoch": 0});

  @observable
  int kmTotais = 0;

  @computed
  double get disponible => (litrosTotais * 10) - kmTotais;

  @action
  addToGasMap(DocumentSnapshot item) {
    gasMap[item.documentID] = item.data;
    lastGas.clear();
    lastGas.addAll(item.data);
    lastGas['litros'] = lastGas['valor'] / lastGas['preco'];
    litrosTotais += lastGas['litros'];
  }

  @action
  addToTripMap(DocumentSnapshot item) {
    Map aux = item.data;
    aux['id'] = item.documentID;
    tripMap[item.documentID] = aux;
    lastTrip.clear();
    lastTrip.addAll(aux);
    if (lastTrip['final'] != null) {
      lastTrip['road'] = lastTrip['final'] - lastTrip['initial'];
      kmTotais += lastTrip['road'];
    }
  }
}
