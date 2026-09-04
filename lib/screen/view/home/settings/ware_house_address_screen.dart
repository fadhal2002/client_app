import 'package:client_app/models/map_model.dart';
import 'package:client_app/models/setting/ware_house_address_model.dart';
import 'package:client_app/screen/view/home/HomePage/AddDelivery/Location_Picker_screen.dart';
import 'package:client_app/screen/widget/auth/WareHouseAddress/address_input_field.dart';
import 'package:client_app/screen/widget/auth/WareHouseAddress/city_dropdown_field.dart';
import 'package:client_app/screen/widget/auth/WareHouseAddress/location_picker_field.dart';
import 'package:client_app/screen/widget/custom_app_bar.dart';
import 'package:client_app/screen/widget/home/settings/LocationSetup/location_Icon_section.dart';
import 'package:flutter/material.dart';
import 'package:client_app/screen/widget/continue_button.dart';
import 'package:client_app/screen/widget/header_ilustration.dart';
import 'package:provider/provider.dart';

class WareHouseAddressScreen extends StatelessWidget {
  const WareHouseAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WareHouseAddressModelImpl>(
          create: (_) => WareHouseAddressModelImpl(context),
        ),
        ChangeNotifierProvider<MapModelImpl>(
          create: (_) => MapModelImpl(context),
        ),
      ],
      child: WareHouseAddressScreenView(),
    );
  }
}

class WareHouseAddressScreenView extends StatelessWidget {
  const WareHouseAddressScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final wareHouseAddressModel = context.read<WareHouseAddressModelImpl>();
    final mapModel = context.read<MapModelImpl>();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: CustomAppBar(title: 'إعداد الموقع الرئيسي'),
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
                    // ===== Location Icon Selection =====
                    LocationIconSection(),
                    const SizedBox(height: 16),

                    AddressInputField(
                      label: 'اسم الموقع',
                      hint: 'مثال: المنزل، العمل، المتجر',
                      icon: Icons.home_outlined,
                      controller: wareHouseAddressModel.locationNameController,
                    ),
                    const SizedBox(height: 16),
                    Selector<WareHouseAddressModelImpl, String?>(
                      selector: (context, wareHouseAddressModel) =>
                          wareHouseAddressModel.selectedCity,
                      builder: (context, selectedCity, child) {
                        return CityDropdownField(
                          label: 'المحافظة',
                          hint: 'اختر المحافظة',
                          icon: Icons.location_city_outlined,
                          selectedValue: wareHouseAddressModel.selectedCity,
                          items: wareHouseAddressModel.cities,
                          onChanged: (value) {
                            wareHouseAddressModel.setSelectedCity(
                              value!,
                              context,
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    AddressInputField(
                      label: 'المنطقة / الحي',
                      hint: 'أدخل اسم المنطقة أو الحي',
                      icon: Icons.place_outlined,
                      controller: wareHouseAddressModel.neighborhoodController,
                    ),
                    const SizedBox(height: 16),
                    AddressInputField(
                      label: 'أقرب نقطة دالة',
                      hint: 'أدخل أقرب نقطة دالة (مثل: مقابل مجمع البركة)',
                      icon: Icons.room_outlined,
                      controller: wareHouseAddressModel.landmarkController,
                    ),
                    const SizedBox(height: 16),

                    LocationPickerField(
                      label: 'الموقع على الخريطة',
                      hint: wareHouseAddressModel.selectedAddress.isNotEmpty
                          ? wareHouseAddressModel.selectedAddress
                          : 'اضغط لتحديد الموقع على الخريطة',
                      icon: Icons.map_outlined,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider.value(
                              value: mapModel,
                              child: const LocationPickerScreen(),
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
                  wareHouseAddressModel.warehouseAddress(context);
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
