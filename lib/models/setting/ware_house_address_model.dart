import 'package:client_app/core/servers/app_servers.dart';
import 'package:client_app/screen/widget/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

abstract class WareHouseAddressModel extends ChangeNotifier {
  void updateLocation(LatLng location, String address);
  void updateLocationIcon(String icon);
  void warehouseAddress(BuildContext context);
  void setSelectedCity(String city, BuildContext context);

  late TextEditingController neighborhoodController;
  late TextEditingController landmarkController;
  late TextEditingController locationNameController;

  LatLng? selectedLocation;
  String selectedAddress = '';
  String selectedLocationIcon = '🏠';
  String? selectedCity;

    final List<Map<String, dynamic>> locationIcons = [
      {'icon': '🏠', 'label': 'المنزل'},
      {'icon': '💼', 'label': 'العمل'},
      {'icon': '🏪', 'label': 'المتجر'},
      {'icon': '📦', 'label': 'المستودع'},
      {'icon': '🏢', 'label': 'المكتب'},
      {'icon': '📍', 'label': 'أخرى'},
    ];

  final List<String> cities = [
    'بغداد',
    'البصرة',
    'نينوى',
    'أربيل',
    'السليمانية',
    'كركوك',
    'دهوك',
    'النجف',
    'كربلاء',
    'الديوانية',
    'المثنى',
    'ذي قار',
    'واسط',
    'ميسان',
    'القادسية',
    'الأنبار',
    'صلاح الدين',
    'ديالى',
    'بابل',
  ];
}

class WareHouseAddressModelImpl extends WareHouseAddressModel {
  WareHouseAddressModelImpl(BuildContext context) {
    final appServices = Provider.of<AppServices>(context, listen: false);

    neighborhoodController = TextEditingController(
      text: appServices.shared.getString('neighborhood') ?? '',
    );

    landmarkController = TextEditingController(
      text: appServices.shared.getString('landmark') ?? '',
    );

    locationNameController = TextEditingController(
      text: appServices.shared.getString('locationName') ?? '',
    );

    selectedCity = appServices.shared.getString('selectedCity') ?? '';
  }

  @override
  dispose() {
    neighborhoodController.dispose();
    landmarkController.dispose();
    locationNameController.dispose();
    super.dispose();
  }

  @override
  void updateLocation(LatLng location, String address) {
    selectedLocation = location;
    selectedAddress = address;
    notifyListeners();
  }

  @override
  void updateLocationIcon(String icon) {
    selectedLocationIcon = icon;
    notifyListeners();
  }

  @override
  void warehouseAddress(BuildContext context) {
    final appServices = Provider.of<AppServices>(context, listen: false);

    if (selectedCity == null ||
        neighborhoodController.text.isEmpty ||
        landmarkController.text.isEmpty ||
        locationNameController.text.isEmpty ||
        appServices.getSavedLatLng(context).isBlank!) {
      customSnackbar('خطأ', 'يرجى ملء جميع الحقول بشكل صحيح قبل المتابعة.');
    } else {
      customSnackbar('نجاح', 'تم حفظ عنوان المستودع بنجاح.');

      appServices.shared.setString('selectedCity', selectedCity!);

      appServices.shared.setString(
        'neighborhood',
        neighborhoodController.text.trim(),
      );

      appServices.shared.setString('landmark', landmarkController.text.trim());

      appServices.shared.setString(
        'locationName',
        locationNameController.text.trim(),
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/HomePageState',
        (route) => false,
      );
    }
  }

  @override
  void setSelectedCity(String city, BuildContext context) {
    final appServices = Provider.of<AppServices>(context, listen: false);

    selectedCity = city;
    appServices.shared.setString('selectedCity', city);
    notifyListeners();
  }
}
