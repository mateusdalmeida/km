import 'package:flutter/material.dart';

Widget gasCard(Map gas) {
  String dateFormat(epoch) {
    String data = DateTime.fromMillisecondsSinceEpoch(epoch).toString();
    return data.substring(8, 10) +
        "." +
        data.substring(5, 7) +
        "." +
        data.substring(0, 4);
  }

  List splitValor = gas['valor'].toStringAsFixed(2).split('.');
  List splitPreco = gas['preco'].toStringAsFixed(2).split('.');
  List splitLitros = gas['litros'].toStringAsFixed(2).split('.');

  return Container(
    padding: EdgeInsets.all(20),
    color: Colors.brown[50],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              RotatedBox(quarterTurns: -1, child: Text("Valor")),
              Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    splitValor[0],
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                  ),
                  Text("." + splitValor[1])
                ],
              )
            ],
          ),
          Row(
            children: [
              RotatedBox(quarterTurns: -1, child: Text("Preço")),
              Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    splitPreco[0],
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                  ),
                  Text("." + splitPreco[1])
                ],
              )
            ],
          ),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(dateFormat(gas['epoch']).substring(0, 2),
                    style:
                        TextStyle(fontSize: 33, fontWeight: FontWeight.bold)),
                Text(dateFormat(gas['epoch']).substring(2),
                    style: TextStyle(fontSize: 25))
              ],
            ),
            Row(
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(
                  splitLitros[0],
                  style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                ),
                Text("." + splitLitros[1] + " lts")
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
