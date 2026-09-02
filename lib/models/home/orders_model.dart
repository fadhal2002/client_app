import 'package:client_app/core/servers/app_servers.dart';
import 'package:client_app/screen/view/home/HomePage/AddDelivery/package_destination_screen.dart';
import 'package:client_app/screen/widget/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class OrdersModel extends ChangeNotifier {
  changeSelectedAddress(String? address);
  changeSelectedPickupType(String? type);
  changeSelectedVehicleType(String? type);
  void performPackageSourceAction(BuildContext context);

  String? selectedAddress;
  String? selectedPickupType;
  String? selectedVehicleType;

  final List<String> savedAddresses = [];

  final List<Map<String, dynamic>> pickupTypes = [
    {
      'title': 'توصيل محلي (First Mile)',
      'subtitle': 'سائق يجي للبيج',
      'icon': Icons.local_shipping_outlined,
    },
    {
      'title': 'إيصال ذاتي',
      'subtitle': 'البيج يوصل الطرد بنفسه لمكتب/كراج',
      'icon': Icons.person_outline,
    },
  ];

  final List<String> vehicleTypes = [
    'سيارة صغيرة',
    'سيارة متوسطة',
    'شاحنة صغيرة',
    'شاحنة كبيرة',
  ];
}

class OrdersModelImpl extends OrdersModel {
  OrdersModelImpl(BuildContext context) {
    final appServices = Provider.of<AppServices>(context, listen: false);

    savedAddresses.add(
      '${appServices.shared.getString('locationName')} - ${appServices.shared.getString('neighborhood')}، ${appServices.shared.getString('selectedCity')}',
    );
  }

  @override
  changeSelectedAddress(String? address) {
    selectedAddress = address;
    notifyListeners();
  }

  @override
  changeSelectedPickupType(String? type) {
    selectedPickupType = type;
    notifyListeners();
  }

  @override
  changeSelectedVehicleType(String? type) {
    selectedVehicleType = type;
    notifyListeners();
  }

  @override
  void performPackageSourceAction(BuildContext context) {
    if (selectedAddress == null ||
        selectedPickupType == null ||
        selectedVehicleType == null) {
      customSnackbar('خطأ', 'يرجى اختيار جميع الخيارات قبل المتابعة.');
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PackageDestinationScreen(),
        ),
      );
    }
  }
}
