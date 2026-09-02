import 'package:client_app/models/map_model.dart';
import 'package:client_app/screen/view/home/HomePage/AddDelivery/ride_confirmation_screen.dart';
import 'package:client_app/screen/widget/Map/map_search_bar.dart';
import 'package:client_app/screen/widget/Map/route_info_card.dart';
import 'package:client_app/screen/widget/Map/route_map_view.dart';
import 'package:client_app/screen/widget/continue_button.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class RouteMapScreen extends StatelessWidget {
  final LatLng pickUpPoint;
  const RouteMapScreen({super.key, required this.pickUpPoint});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapModelImpl(context),
      child: RouteMapScreenView(pickUpPoint: pickUpPoint),
    );
  }
}

class RouteMapScreenView extends StatelessWidget {
  final LatLng pickUpPoint;
  const RouteMapScreenView({super.key, required this.pickUpPoint});

  @override
  Widget build(BuildContext context) {
    final mapModel = context.read<MapModelImpl>();
    return Scaffold(
      body: Consumer<MapModelImpl>(
        builder: (BuildContext context, MapModelImpl value, Widget? child) {
          return Stack(
            children: [
              RouteMapView(pickUpPoint: pickUpPoint),

              MapSearchBar(),

              if (mapModel.distance.isNotEmpty) RouteInfoCard(),

              Positioned(
                bottom: 30,
                left: 20,
                right: 20,
                child: ContinueButton(
                  onTap: () async {
                    final address = await mapModel.getAddressFromLatLng(
                      pickUpPoint,
                    );
                    final dropOffAddress = await mapModel.getAddressFromLatLng(
                      mapModel.dropOffPoint!,
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RideConfirmationScreen(
                          pickupLocation: mapModel.pickUpPoint,
                          dropoffLocation: mapModel.dropOffPoint!,
                          pickupAddress: address,
                          dropoffAddress: dropOffAddress,
                          distance: mapModel.distance,
                          duration: mapModel.duration,
                        ),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
