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
        "." +
        data.substring(5, 7) +
        "." +
        data.substring(0, 4);
  }

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
                Row(
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
                SizedBox(height: 32),
                //card da trip
                Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.brown[50],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                Row(
                                    textBaseline: TextBaseline.alphabetic,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    children: [
                                      Observer(builder: (context) {
                                        return Text(
                                          controller.lastTrip['initial']
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 45),
                                        );
                                      }),
                                      Text("km")
                                    ]),
                              ]),
                          Icon(Icons.fast_forward),
                          Row(
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                Observer(builder: (context) {
                                  String road = "----";
                                  if (controller.lastTrip['final'] != null)
                                    road =
                                        controller.lastTrip['final'].toString();
                                  return Text(
                                    road,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 45),
                                  );
                                }),
                                Text("km")
                              ]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Observer(builder: (context) {
                            return Row(
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                Text(
                                    dateFormat(controller.lastTrip['epoch'])
                                        .substring(0, 2),
                                    style: TextStyle(
                                        fontSize: 33,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    dateFormat(controller.lastTrip['epoch'])
                                        .substring(2),
                                    style: TextStyle(fontSize: 25))
                              ],
                            );
                          }),
                          Row(
                            textBaseline: TextBaseline.alphabetic,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Observer(builder: (context) {
                                String road = "--";
                                if (controller.lastTrip['road'] != null)
                                  road = controller.lastTrip['road'].toString();
                                return Text(
                                  road,
                                  style: TextStyle(
                                      fontSize: 33,
                                      fontWeight: FontWeight.bold),
                                );
                              }),
                              Text("km")
                            ],
                          ),
                        ],
                      ),
                      Observer(builder: (context) {
                        if (controller.lastTrip['obs'] != null)
                          return Text(controller.lastTrip['obs']);
                        else
                          return SizedBox();
                      }),
                    ],
                  ),
                ),

                SizedBox(height: 32),
                // card da gasolina
                Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.brown[50],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Observer(builder: (context) {
                              List splitValor = controller.lastGas['valor']
                                  .toStringAsFixed(2)
                                  .split('.');
                              return Row(
                                children: [
                                  RotatedBox(
                                      quarterTurns: -1, child: Text("Valor")),
                                  Row(
                                    textBaseline: TextBaseline.alphabetic,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    children: [
                                      Text(
                                        splitValor[0],
                                        style: TextStyle(
                                            fontSize: 45,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("." + splitValor[1])
                                    ],
                                  )
                                ],
                              );
                            }),
                            Observer(builder: (context) {
                              List splitPreco = controller.lastGas['preco']
                                  .toStringAsFixed(2)
                                  .split('.');
                              return Row(
                                children: [
                                  RotatedBox(
                                      quarterTurns: -1, child: Text("Preço")),
                                  Row(
                                    textBaseline: TextBaseline.alphabetic,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    children: [
                                      Text(
                                        splitPreco[0],
                                        style: TextStyle(
                                            fontSize: 45,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("." + splitPreco[1])
                                    ],
                                  )
                                ],
                              );
                            }),
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Observer(builder: (context) {
                            return Row(
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                Text(
                                    dateFormat(controller.lastGas['epoch'])
                                        .substring(0, 2),
                                    style: TextStyle(
                                        fontSize: 33,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    dateFormat(controller.lastGas['epoch'])
                                        .substring(2),
                                    style: TextStyle(fontSize: 25))
                              ],
                            );
                          }),
                          Observer(builder: (context) {
                            List splitLitros = controller.lastGas['litros']
                                .toStringAsFixed(2)
                                .split('.');
                            return Row(
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                Text(
                                  splitLitros[0],
                                  style: TextStyle(
                                      fontSize: 33,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("." + splitLitros[1] + " lts")
                              ],
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
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
