import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:km/controller.dart';
import 'package:km/widgets/gasCard.dart';
import 'package:km/widgets/tripCard.dart';

class ListAll extends StatelessWidget {
  final String type;

  ListAll({Key key, @required this.type}) : super(key: key);
  final Controller controller = Controller();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Observer(builder: (context) {
            List gasList = controller.gasMap.values.toList();
            List tripList = controller.tripMap.values.toList();
            return ListView.separated(
                padding: const EdgeInsets.all(32.0),
                itemBuilder: (context, index) {
                  if (type == 'gas')
                    return gasCard(gasList.reversed.toList()[index]);
                  else
                    return tripCard(tripList.reversed.toList()[index]);
                },
                separatorBuilder: (context, index) => SizedBox(height: 32),
                itemCount: type == 'gas' ? gasList.length : tripList.length);
          }),
        ),
      ),
    );
  }
}
