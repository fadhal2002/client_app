import 'package:client_app/models/login_model.dart';
import 'package:client_app/screen/widget/auth/WareHouseAddress/address_input_field.dart';
import 'package:client_app/screen/widget/auth/WareHouseAddress/city_dropdown_field.dart';
import 'package:client_app/screen/widget/auth/WareHouseAddress/location_picker_field.dart';
import 'package:flutter/material.dart';
import 'package:client_app/screen/widget/continue_button.dart';
import 'package:client_app/screen/widget/header_ilustration.dart';
import 'package:provider/provider.dart';

class WarehouseAddressScreen extends StatefulWidget {
  const WarehouseAddressScreen({super.key});

  @override
  State<WarehouseAddressScreen> createState() => _WarehouseAddressScreenState();
}

class _WarehouseAddressScreenState extends State<WarehouseAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModelImp>(
      create: (context) => LoginModelImp(context),
      child: const WareHouseAddressScreenView(),
    );
  }
}

class WareHouseAddressScreenView extends StatelessWidget {
  const WareHouseAddressScreenView({super.key});

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

              // Address Form Card
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

                    // Neighborhood Text Field
                    AddressInputField(
                      label: 'المنطقة / الحي',
                      hint: 'أدخل اسم المنطقة أو الحي',
                      icon: Icons.place_outlined,
                      controller: loginModel.neighborhoodController,
                    ),
                    const SizedBox(height: 16),

                    // Nearest Landmark
                    AddressInputField(
                      label: 'أقرب نقطة دالة',
                      hint: 'أدخل أقرب نقطة دالة (مثل: مقابل مجمع البركة)',
                      icon: Icons.room_outlined,
                      controller: loginModel.landmarkController,
                    ),
                    const SizedBox(height: 16),

                    LocationPickerField(
                      label: 'الموقع على الخريطة',
                      hint: 'اضغط لتحديد الموقع على الخريطة',
                      icon: Icons.map_outlined,
                      onTap: () {
                        print('Open map picker');
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              // Continue Button
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
    ;
  }
}
