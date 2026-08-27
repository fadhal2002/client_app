import 'package:client_app/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResendCodeSection extends StatelessWidget {
  const ResendCodeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<LoginModelImp>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "لم يصلك رمز التحقق؟ ",
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        if (model.isResendEnabled)
          GestureDetector(
            onTap: () {
              model.resendCode();
            },
            child: const Text(
              'إعادة الإرسال',
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
              color: const Color(0xFF7B2FF7).withValues(alpha: 0.1),
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
                  'إعادة الإرسال خلال ${model.countdown}s',
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
    );
  }
}
