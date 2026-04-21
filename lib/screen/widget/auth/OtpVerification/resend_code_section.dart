import 'package:client_app/controller/auth/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResendCodeSection extends StatelessWidget {
  const ResendCodeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final LogincontrollerImp otpController = Get.find<LogincontrollerImp>();

    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Didn't receive the code? ",
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          if (otpController.isResendEnabled.value)
            GestureDetector(
              onTap: () {
                otpController.resendCode();
              },
              child: const Text(
                'Resend Code',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7B2FF7),
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF7B2FF7).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.timer_outlined,
                    size: 16,
                    color: Color(0xFF7B2FF7),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Resend in ${otpController.countdown.value}s',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF7B2FF7),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
