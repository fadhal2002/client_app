import 'package:client_app/core/functions/custom_snackbar.dart';
import 'package:client_app/core/servers/app_servers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class LoginModel extends ChangeNotifier {
  login(BuildContext context);
  void startCountdown();
  void startInitialTimer();
  void resendCode();

  var countdown = 0;
  var isResendEnabled = true;

  String VerificationCode = '123456';
  String UserEnteredCode = '';

  late TextEditingController phoneNumber;
  late TextEditingController firstName;
  late TextEditingController lastName;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
}

class LoginModelImp extends LoginModel {
  LoginModelImp(BuildContext context) {
    final appServices = Provider.of<AppServices>(context, listen: false);
    phoneNumber = TextEditingController(
      text: appServices.shared.getString('phoneNumber') ?? '',
    );
    firstName = TextEditingController(
      text: appServices.shared.getString('firstName') ?? '',
    );
    lastName = TextEditingController(
      text: appServices.shared.getString('lastName') ?? '',
    );
  }

  AppServices getAppServices(BuildContext context) {
    return Provider.of<AppServices>(context, listen: false);
  }

  @override
  void login(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final appServices = getAppServices(context);
      appServices.shared.setString("phoneNumber", phoneNumber.text.trim());
      Navigator.pushNamed(context, '/OtpVerification');
    } else {
      customSnackbar('خطأ', 'الرقم الذي أدخلته غير صحيح.');
    }
    notifyListeners();
  }

  @override
  void startInitialTimer() {
    isResendEnabled = true;
    countdown = 0;
    notifyListeners();
  }

  @override
  void resendCode() {
    startCountdown();
    customSnackbar('نجاح', 'تم إرسال رمز OTP جديد إلى رقم هاتفك.');
  }

  @override
  void startCountdown() {
    if (countdown > 0) return;

    isResendEnabled = false;
    countdown = 5;

    Future.doWhile(() async {
      notifyListeners();
      await Future.delayed(const Duration(seconds: 1));
      if (countdown > 0) {
        countdown--;
        return true;
      } else {
        isResendEnabled = true;
        notifyListeners();
        return false;
      }
    });
  }
}
