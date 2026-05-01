import 'package:flutter/material.dart';

class PaymentMethod extends StatefulWidget {
  final Function(String)? onPaymentMethodChanged;

  const PaymentMethod({super.key, this.onPaymentMethodChanged});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  String _selectedPaymentMethod = 'cash'; // Default payment method

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF4158D0).withOpacity(0.05),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4158D0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.payment,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'طريقة الدفع',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1E2C),
                      ),
                    ),
                  ],
                ),
              ),

              RadioListTile<String>(
                value: 'cash',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                  // Notify parent widget if callback is provided
                  if (widget.onPaymentMethodChanged != null) {
                    widget.onPaymentMethodChanged!(_selectedPaymentMethod);
                  }
                },
                title: const Text('الدفع عند الاستلام'),
                subtitle: const Text('ادفع نقداً عند استلام الطلب'),
                secondary: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.money,
                    color: Color(0xFF4CAF50),
                    size: 20,
                  ),
                ),
                activeColor: const Color(0xFF4158D0),
              ),

              RadioListTile<String>(
                value: 'card',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                  // Notify parent widget if callback is provided
                  if (widget.onPaymentMethodChanged != null) {
                    widget.onPaymentMethodChanged!(_selectedPaymentMethod);
                  }
                },
                title: const Text('بطاقة ائتمان'),
                subtitle: const Text('Visa, Mastercard, Mada'),
                secondary: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4158D0).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.credit_card,
                    color: Color(0xFF4158D0),
                    size: 20,
                  ),
                ),
                activeColor: const Color(0xFF4158D0),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Method to get the current selected payment method (optional)
  String getSelectedPaymentMethod() {
    return _selectedPaymentMethod;
  }
}
