import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:km/controller.dart';

final databaseReference = Firestore.instance;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController precoController = TextEditingController();
  TextEditingController valorController = TextEditingController();
  TextEditingController kmController = TextEditingController();
  TextEditingController obsController = TextEditingController();
  GlobalKey<FormState> _formGasKey = GlobalKey<FormState>();
  GlobalKey<FormState> _formTripKey = GlobalKey<FormState>();

  Controller controller = Controller();

  String dateFormat(epoch) {
    String data = DateTime.fromMillisecondsSinceEpoch(epoch).toString();
    return data.substring(8, 10) +
        "/" +
        data.substring(5, 7) +
        "/" +
        data.substring(0, 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //card do saldo
              Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  color: Colors.orange,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Km's Disponiveis"),
                      Observer(builder: (context) {
                        return Text(controller.disponible.toInt().toString());
                      })
                    ],
                  )),
              //card da trip
              Observer(builder: (context) {
                Map trip = controller.lastTrip;
                String road = '----';
                if (trip['final'] != null) {
                  road = (trip['final'] - trip['initial']).toString();
                }
                return Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    color: Colors.orange,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Ultima Viagem"),
                              Text(road + " km")
                            ]),
                        Row(children: [
                          Icon(Icons.flight_takeoff),
                          Text(trip['initial'].toString() + ' km'),
                          Expanded(child: SizedBox(height: 0)),
                          Icon(Icons.flight_land),
                          trip['final'] != null
                              ? Text(trip['final'].toString() + ' km')
                              : Text("Atual")
                        ]),
                        Text(dateFormat(trip['epoch'])),
                        trip['obs'] != null ? Text(trip['obs']) : SizedBox(),
                      ],
                    ));
              }),
              // card da gasolina
              Observer(builder: (context) {
                Map gas = controller.lastGas;
                double litros = gas['valor'] / gas['preco'];

                return Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    color: Colors.orange,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Ultimo Abastecimento"),
                        Text(dateFormat(gas['epoch'])),
                        Text("Valor - RS " + gas['valor'].toStringAsFixed(2)),
                        Text("Preço - RS " + gas['preco'].toStringAsFixed(2)),
                        Text(litros.toStringAsFixed(2) + " lts")
                      ],
                    ));
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.orange,
        child: Row(
          children: [
            Expanded(
                child: MaterialButton(
                    height: MediaQuery.of(context).size.height / 10,
                    onPressed: () {
                      _showGasSheet();
                    },
                    child: Text("Gasolina"))),
            Expanded(
                child: MaterialButton(
                    height: MediaQuery.of(context).size.height / 10,
                    onPressed: () {
                      _showtripSheet(controller.lastTrip);
                    },
                    child: Text("Viagem")))
          ],
        ),
      ),
    );
  }

  void _showGasSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Form(
                key: _formGasKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Novo Abastecimento"),
                    TextFormField(
                      controller: valorController,
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: "Valor",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) return "Valor não digitado";
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: precoController,
                      decoration: InputDecoration(
                        labelText: "Preço",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) return "Preço não digitado";
                        return null;
                      },
                    ),
                    MaterialButton(
                      elevation: 0,
                      minWidth: double.infinity,
                      color: Colors.orange,
                      textColor: Colors.white,
                      child: Text("Salvar"),
                      onPressed: () async {
                        if (_formGasKey.currentState.validate()) {
                          var gas = {
                            "epoch": DateTime.now().millisecondsSinceEpoch,
                            "preco": double.parse(precoController.text),
                            "valor": double.parse(valorController.text)
                          };
                          databaseReference
                              .collection("gas")
                              .document()
                              .setData(gas);

                          precoController.clear();
                          valorController.clear();
                          Navigator.pop(context);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _showtripSheet(Map trip) {
    bool isNew = trip['final'] != null;
    if (!isNew) {
      if (trip['obs'] != null) obsController.text = trip['obs'];
    }
    print(isNew);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Form(
                key: _formTripKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Novo Km"),
                    TextFormField(
                      controller: kmController,
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: "Km",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) return "km não digitado";
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: obsController,
                      decoration: InputDecoration(
                        labelText: "Obs",
                      ),
                    ),
                    MaterialButton(
                      elevation: 0,
                      minWidth: double.infinity,
                      color: Colors.orange,
                      textColor: Colors.white,
                      child: Text("Salvar"),
                      onPressed: () {
                        if (_formTripKey.currentState.validate()) {
                          if (isNew) {
                            var newTrip = {
                              "epoch": DateTime.now().millisecondsSinceEpoch,
                              "initial": int.parse(kmController.text),
                              "obs": obsController.text
                            };
                            if (obsController.text == '') newTrip.remove("obs");
                            databaseReference
                                .collection("trip")
                                .document()
                                .setData(newTrip);
                          } else {
                            var finalTrip = {
                              "final": int.parse(kmController.text),
                              "obs": obsController.text
                            };
                            if (obsController.text == '')
                              finalTrip.remove("obs");
                            databaseReference
                                .collection("trip")
                                .document(trip['id'])
                                .updateData(finalTrip);
                          }
                          kmController.clear();
                          obsController.clear();
                          Navigator.pop(context);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
