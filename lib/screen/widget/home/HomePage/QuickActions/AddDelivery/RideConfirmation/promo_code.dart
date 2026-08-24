import 'package:client_app/models/home/HomePage/AddDelivery/ride_confirmation_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromoCode extends StatefulWidget {
  const PromoCode({super.key});

  @override
  State<PromoCode> createState() => _PromoCodeState();
}

class _PromoCodeState extends State<PromoCode> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<RideConfirmationModelImpl>();

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: model.controller,
            decoration: InputDecoration(
              hintText: 'أدخل رمز الخصم',
              errorText: model.errorText,
              prefixIcon: const Icon(
                Icons.local_offer,
                color: Color(0xFF4158D0),
                size: 20,
              ),
              suffixIcon: Container(
                margin: const EdgeInsets.all(4),
                child: ElevatedButton(
                  onPressed: () {
                    model.applyPromo();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4158D0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('تطبيق', style: TextStyle(fontSize: 12)),
                ),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
