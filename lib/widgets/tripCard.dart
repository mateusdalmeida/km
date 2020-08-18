import 'package:flutter/material.dart';

class TripCard extends StatelessWidget {
  final Map trip;

  String dateFormat(epoch) {
    String data = DateTime.fromMillisecondsSinceEpoch(epoch).toString();
    return data.substring(8, 10) +
        "." +
        data.substring(5, 7) +
        "." +
        data.substring(0, 4);
  }

  TripCard({Key key, @required this.trip}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
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
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Text(
                            trip['initial'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 45),
                          ),
                          Text("km")
                        ]),
                  ]),
              Icon(Icons.fast_forward),
              Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text(
                      trip['final'] == null ? '----' : trip['final'].toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
                    ),
                    Text("km")
                  ]),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(dateFormat(trip['epoch']).substring(0, 2),
                      style:
                          TextStyle(fontSize: 33, fontWeight: FontWeight.bold)),
                  Text(dateFormat(trip['epoch']).substring(2),
                      style: TextStyle(fontSize: 25))
                ],
              ),
              Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    trip['road'] == null ? '--' : trip['road'].toString(),
                    style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                  ),
                  Text("km")
                ],
              ),
            ],
          ),
          // Observer(builder: (context) {
          //   if (trip['obs'] != null)
          //     return Text(trip['obs']);
          //   else
          //     return SizedBox();
          // }),
        ],
      ),
    );
  }
}
