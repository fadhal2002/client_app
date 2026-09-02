import 'package:client_app/models/login_model.dart';
import 'package:client_app/screen/view/home/HomePage/AddDelivery/Location_Picker_screen.dart';
import 'package:client_app/screen/widget/auth/WareHouseAddress/address_input_field.dart';
import 'package:client_app/screen/widget/auth/WareHouseAddress/city_dropdown_field.dart';
import 'package:client_app/screen/widget/auth/WareHouseAddress/location_picker_field.dart';
import 'package:flutter/material.dart';
import 'package:client_app/screen/widget/continue_button.dart';
import 'package:client_app/screen/widget/header_ilustration.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class WarehouseAddressScreen extends StatefulWidget {
  const WarehouseAddressScreen({super.key});

  @override
  State<WarehouseAddressScreen> createState() => _WarehouseAddressScreenState();
}

class _WarehouseAddressScreenState extends State<WarehouseAddressScreen> {
  LatLng? _selectedLocation;
  String _selectedAddress = '';

  void _updateLocation(LatLng location, String address) {
    setState(() {
      _selectedLocation = location;
      _selectedAddress = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModelImp>(
      create: (context) => LoginModelImp(context),
      child: WareHouseAddressScreenView(
        onLocationSelected: _updateLocation,
        selectedLocation: _selectedLocation,
        selectedAddress: _selectedAddress,
      ),
    );
  }
}

class WareHouseAddressScreenView extends StatelessWidget {
  final Function(LatLng, String) onLocationSelected;
  final LatLng? selectedLocation;
  final String selectedAddress;

  const WareHouseAddressScreenView({
    super.key,
    required this.onLocationSelected,
    this.selectedLocation,
    this.selectedAddress = '',
  });

  @override
  Widget build(BuildContext context) {
    final loginModel = context.read<LoginModelImp>();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1A1E2C)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'عنوان البيع أو المخزن',
          style: TextStyle(
            color: Color(0xFF1A1E2C),
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderIlustration(
                title: 'أين موقع البيع أو المخزن؟',
                subtitle:
                    'قم بتحديد موقع البيع أو المخزن الرئيسي لتسهيل عملية الطلب',
                icon: Icons.storefront,
              ),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.08),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    AddressInputField(
                      label: 'اسم الموقع',
                      hint: 'مثال: المنزل، العمل، المتجر',
                      icon: Icons.home_outlined,
                      controller: loginModel.locationNameController,
                    ),
                    const SizedBox(height: 16),
                    Selector<LoginModelImp, String?>(
                      selector: (context, loginModel) =>
                          loginModel.selectedCity,
                      builder: (context, selectedCity, child) {
                        return CityDropdownField(
                          label: 'المحافظة',
                          hint: 'اختر المحافظة',
                          icon: Icons.location_city_outlined,
                          selectedValue: loginModel.selectedCity,
                          items: loginModel.cities,
                          onChanged: (value) {
                            loginModel.setSelectedCity(value!, context);
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    AddressInputField(
                      label: 'المنطقة / الحي',
                      hint: 'أدخل اسم المنطقة أو الحي',
                      icon: Icons.place_outlined,
                      controller: loginModel.neighborhoodController,
                    ),
                    const SizedBox(height: 16),
                    AddressInputField(
                      label: 'أقرب نقطة دالة',
                      hint: 'أدخل أقرب نقطة دالة (مثل: مقابل مجمع البركة)',
                      icon: Icons.room_outlined,
                      controller: loginModel.landmarkController,
                    ),
                    const SizedBox(height: 16),
                    // Updated LocationPickerField with location callback
                    LocationPickerField(
                      label: 'الموقع على الخريطة',
                      hint: selectedAddress.isNotEmpty
                          ? selectedAddress
                          : 'اضغط لتحديد الموقع على الخريطة',
                      icon: Icons.map_outlined,
                      selectedLocation: selectedLocation,
                      onLocationSelected: onLocationSelected,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => Container(
                            height: MediaQuery.of(context).size.height,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(0),
                              ),
                            ),
                            child: LocationPickerScreen(
                              isForLogin: true,
                              onLocationSelected: (location, address) {
                                onLocationSelected(location, address);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ContinueButton(
                onTap: () {
                  loginModel.warehouseAddress(context);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
