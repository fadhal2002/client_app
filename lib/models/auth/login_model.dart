import 'package:client_app/core/functions/custom_snackbar.dart';
import 'package:client_app/core/servers/app_servers.dart';
import 'package:client_app/screen/view/auth/otp_verification.dart';
import 'package:client_app/screen/view/auth/ware_house_address_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class LoginModel extends ChangeNotifier {
  void login(BuildContext context);
  void nameInputAndAccountType(BuildContext context);
  void setSelectedAccountType(String accountType, BuildContext context);
  void editProfile(BuildContext context, GlobalKey<FormState> formKey);
  void warehouseAddress(BuildContext context);
  void setSelectedCity(String city, BuildContext context);
  void startCountdown();
  void startInitialTimer();
  void resendCode();

  var countdown = 0;
  var isResendEnabled = true;

  String VerificationCode = '123456';
  String UserEnteredCode = '';
  String? selectedAccountType;
  String? selectedCity;

  late TextEditingController phoneNumber;
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController neighborhoodController;
  late TextEditingController landmarkController;

  final List<String> cities = [
    'بغداد',
    'البصرة',
    'نينوى',
    'أربيل',
    'السليمانية',
    'كركوك',
    'دهوك',
    'النجف',
    'كربلاء',
    'الديوانية',
    'المثنى',
    'ذي قار',
    'واسط',
    'ميسان',
    'القادسية',
    'الأنبار',
    'صلاح الدين',
    'ديالى',
    'بابل',
  ];

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

    neighborhoodController = TextEditingController(
      text: appServices.shared.getString('neighborhood') ?? '',
    );

    landmarkController = TextEditingController(
      text: appServices.shared.getString('landmark') ?? '',
    );

    selectedCity = appServices.shared.getString('selectedCity');

    selectedAccountType = appServices.shared.getString('accountType');
  }

  @override
  void dispose() {
    neighborhoodController.dispose();
    landmarkController.dispose();
    phoneNumber.dispose();
    firstName.dispose();
    lastName.dispose();
    super.dispose();
  }

  AppServices getAppServices(BuildContext context) {
    return Provider.of<AppServices>(context, listen: false);
  }

  @override
  void login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final FirebaseAuth auth = FirebaseAuth.instance;

      Future<User?> signInWithCredential(PhoneAuthCredential credential) async {
        try {
          UserCredential userCredential = await auth.signInWithCredential(
            credential,
          );
          return userCredential.user;
        } catch (e) {
          print(
            '================================================ Sign in failed: $e',
          );
          return null;
        }
      }

      // Step 1: Send verification code to user's phone
      await auth.verifyPhoneNumber(
        phoneNumber: '+964${phoneNumber.text}',

        // Android only: Auto-retrieval of SMS code
        verificationCompleted: (PhoneAuthCredential credential) async {
          await signInWithCredential(credential);
        },

        // Handle errors
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            customSnackbar('', 'الرقم الذي ادخلته غير صحيح');
          }
        },

        // Code successfully sent - save verificationId
        codeSent: (String verificationId, int? resendToken) {
          print(
            '====================================== SMS code sent to ${phoneNumber.text}',
          );
        },

        // Auto-retrieval timeout
        codeAutoRetrievalTimeout: (String verificationId) {
          print('====================================== Auto-retrieval');
        },
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider.value(
            value: this,
            child: const OtpVerification(),
          ),
        ),
      );
    } else {
      customSnackbar('خطأ', 'حدث خطأ');
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

  @override
  void nameInputAndAccountType(BuildContext context) {
    // Validate names
    if (firstName.text.isEmpty || lastName.text.isEmpty) {
      customSnackbar('خطأ', 'يرجى إدخال الاسم الأول واسم العائلة');
      return;
    }

    // Validate account type selection
    if (selectedAccountType == null) {
      customSnackbar('خطأ', 'يرجى اختيار نوع الحساب');
      return;
    }

    // Save names
    getAppServices(
      context,
    ).shared.setString('firstName', firstName.text.trim());
    getAppServices(context).shared.setString('lastName', lastName.text.trim());

    // Save account type
    getAppServices(
      context,
    ).shared.setString('accountType', selectedAccountType!);
    getAppServices(context).shared.setString('screen', 'homePage');

    customSnackbar('نجاح', 'تم حفظ البيانات بنجاح');

    getAppServices(context).login();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider.value(
          value: this,
          child: const WarehouseAddressScreen(),
        ),
      ),
    );
  }

  @override
  void setSelectedAccountType(String accountType, BuildContext context) {
    final appServices = Provider.of<AppServices>(context, listen: false);

    selectedAccountType = accountType;
    appServices.shared.setString('accountType', accountType);
    notifyListeners();
  }

  @override
  void editProfile(BuildContext context, GlobalKey<FormState> formKey) {
    final appServices = Provider.of<AppServices>(context, listen: false);

    if (firstName.text.isEmpty ||
        lastName.text.isEmpty ||
        !formKey.currentState!.validate()) {
      customSnackbar('خطأ', 'يرجى ملء جميع الحقول بشكل صحيح قبل المتابعة.');
    } else {
      customSnackbar('نجاح', 'تم تحديث الملف الشخصي بنجاح.');

      appServices.shared.setString('firstName', firstName.text.trim());

      appServices.shared.setString('lastName', lastName.text.trim());

      appServices.shared.setString('phoneNumber', phoneNumber.text.trim());

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/HomePageState',
        (route) => false,
      );
    }
  }

  @override
  void warehouseAddress(BuildContext context) {
    final appServices = Provider.of<AppServices>(context, listen: false);

    if (selectedCity == null ||
        neighborhoodController.text.isEmpty ||
        landmarkController.text.isEmpty) {
      customSnackbar('خطأ', 'يرجى ملء جميع الحقول بشكل صحيح قبل المتابعة.');
    } else {
      customSnackbar('نجاح', 'تم حفظ عنوان المستودع بنجاح.');

      appServices.shared.setString('selectedCity', selectedCity!);

      appServices.shared.setString(
        'neighborhood',
        neighborhoodController.text.trim(),
      );

      appServices.shared.setString('landmark', landmarkController.text.trim());

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/HomePageState',
        (route) => false,
      );
    }
  }

  @override
  void setSelectedCity(String city, BuildContext context) {
    final appServices = Provider.of<AppServices>(context, listen: false);

    selectedCity = city;
    appServices.shared.setString('selectedCity', city);
    notifyListeners();
  }
}
