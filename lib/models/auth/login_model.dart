import 'package:client_app/core/functions/custom_snackbar.dart';
import 'package:client_app/core/servers/app_servers.dart';
import 'package:flutter/material.dart';

abstract class LoginModel extends ChangeNotifier {
  login(BuildContext context);
  void startCountdown();
  void startInitialTimer();
  void resendCode();

  var countdown = 0;
  var isResendEnabled = true;

  String VerificationCode = '123456';
  String UserEnteredCode = '';

  TextEditingController phoneNumber = TextEditingController();
  late TextEditingController firstName;
  late TextEditingController lastName;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AppServices appServices = AppServices();
}

class LoginModelImp extends LoginModel {
  void onInit() {
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

  @override
  void login(BuildContext context) {
    if (formKey.currentState!.validate()) {
      appServices.shared.setString("phoneNumber", phoneNumber.text.trim());
      Navigator.pushNamed(context, '/optVerification');
    } else {
      customSnackbar(
        context,
        'Please enter a valid phone number',
        'The phone number you entered is not valid.',
      );
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
    // Implement resend code logic here
    notifyListeners();
  }

  @override
  void startCountdown() {
    // TODO: implement startCountdown
  }
}
