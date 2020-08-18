import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:km/controller.dart';
import 'package:km/widgets/gasCard.dart';
import 'package:km/widgets/tripCard.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //km disponiveis
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Row(
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Observer(builder: (context) {
                          return Text(
                            controller.disponible.toInt().toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 80),
                          );
                        }),
                        Text("km")
                      ]),
                ),
                //card da trip
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: TripCard(trip: controller.lastTrip),
                ),
                // card da gasolina
                GasCard(gas: controller.lastGas)
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.brown[300],
        child: Row(
          children: [
            Expanded(
                child: MaterialButton(
                    height: MediaQuery.of(context).size.height / 12,
                    onPressed: () {
                      _showGasSheet();
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.local_gas_station),
                        Text("Gasolina"),
                      ],
                    ))),
            Container(
              height: MediaQuery.of(context).size.height / 12,
              width: 1,
              color: Colors.brown[50],
            ),
            Expanded(
                child: MaterialButton(
                    height: MediaQuery.of(context).size.height / 12,
                    onPressed: () {
                      _showtripSheet(controller.lastTrip);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.time_to_leave),
                        Text("Viagem"),
                      ],
                    )))
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
            padding: MediaQuery.of(context).viewInsets,
            child: Form(
              key: _formGasKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Nova Gasolina",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 35),
                        ),
                        TextFormField(
                          controller: valorController,
                          autofocus: true,
                          decoration: InputDecoration(labelText: "Valor"),
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
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.brown[300],
                    child: Expanded(
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: MediaQuery.of(context).size.height / 12,
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
                      ),
                    ),
                  )
                ],
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
            padding: MediaQuery.of(context).viewInsets,
            child: Form(
              key: _formTripKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Novo Km",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 35)),
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
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.brown[300],
                    child: Expanded(
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: MediaQuery.of(context).size.height / 12,
                        child: Text("Salvar"),
                        onPressed: () {
                          if (_formTripKey.currentState.validate()) {
                            if (isNew) {
                              var newTrip = {
                                "epoch": DateTime.now().millisecondsSinceEpoch,
                                "initial": int.parse(kmController.text),
                                "obs": obsController.text
                              };
                              if (obsController.text == '')
                                newTrip.remove("obs");
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
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
