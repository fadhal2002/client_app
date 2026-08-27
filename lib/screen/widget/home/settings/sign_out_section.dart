import 'package:client_app/screen/widget/custom_snackbar.dart';
import 'package:client_app/core/servers/app_servers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showSignOutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('تسجيل الخروج'),
        content: const Text('هل أنت متأكد من رغبتك في تسجيل الخروج؟'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => _signOut(context),
            child: const Text(
              'تسجيل الخروج',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}

// Perform sign out
Future<void> _signOut(BuildContext context) async {
  AppServices appServices = Provider.of<AppServices>(context, listen: false);

  try {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Sign out from Firebase
    // await FirebaseAuth.instance.signOut();

    // Close loading dialog
    Navigator.of(context).pop();

    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil('/LoginScreen', (Route<dynamic> route) => false);

    appServices.shared.clear();
  } catch (e) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }

    customSnackbar('خطأ', 'حدث خطأ أثناء تسجيل الخروج: ${e.toString()}');
  }
}
