import 'package:client_app/controller/home/custom_map_controller.dart';
import 'package:client_app/screen/view/home/HomePage/AddDelivery/route_map_screen.dart';
import 'package:client_app/screen/widget/continue_button.dart';
import 'package:client_app/screen/widget/home/HomePage/Map/location_picker.dart';
import 'package:client_app/screen/widget/home/HomePage/Map/location_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationPickerScreen extends StatelessWidget {
  const LocationPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CustomMapControllerImp());
    return Scaffold(
      body: GetBuilder<CustomMapControllerImp>(
        builder: (controller) {
          return Stack(
            children: [
              LocationPicker(),

              LocationSearchBar(),

              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: ContinueButton(
                  onTap: () {
                    
                    Get.to(() => RouteMapScreen());
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
