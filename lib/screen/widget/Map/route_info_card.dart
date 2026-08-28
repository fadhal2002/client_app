import 'package:client_app/models/map_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteInfoCard extends StatelessWidget {
  const RouteInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final mapModel = context.read<MapModelImpl>();
    print('============================ 4 ============================');

    return  Positioned(
              bottom: 110,
              left: 20,
              right: 20,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("المسافة: ${mapModel.distance}"),
                      Text("الوقت: ${mapModel.duration}"),
                    ],
                  ),
                ),
              ),
            );
  }
}