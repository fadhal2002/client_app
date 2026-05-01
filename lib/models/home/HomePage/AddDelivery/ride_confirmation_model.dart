import 'package:client_app/core/functions/custom_snackbar.dart';
import 'package:flutter/material.dart';

abstract class RideConfirmationModel extends ChangeNotifier {
  calculatePrice(String distance, String duration, String vehicleType);
  formatPrice(double price, {bool showSymbol});
  updateVehicleMarkup(Map<String, double> newMarkup);
  updateBaseRates({double? newBaseFare, double? newPerKmRate});
  selectVehicleType(String vehicleType);
  applyPromo();

  String? errorText;
  String _selectedVehicleType = 'economy';
  String get selectedVehicleType => _selectedVehicleType;

  double baseFare = 2500.0;
  double perKmRate = 850.0;
  double perMinuteRate = 150.0;
  double minFare = 4000.0;
  double bookingFee = 500.0;
  double? finalPrice2;
  double discount = 0.0;

  Map<String, double> vehicleMarkup = {
    'economy': 1.00, // 0% increase
    'fast': 1.25, // 25% increase
    'heavy': 1.50, // 50% increase
  };

  final TextEditingController controller = TextEditingController();
}

class RideConfirmationModelImpl extends RideConfirmationModel {
  @override
  calculatePrice(String distance, String duration, String vehicleType) {
    double surgeMultiplier = 1.0;

    double distanceInKm =
        double.tryParse(distance.replaceAll(' كم', '').replaceAll(' km', '')) ??
        0.0;

    double durationInMinutes =
        double.tryParse(
          duration.replaceAll(' دقيقة', '').replaceAll(' min', ''),
        ) ??
        0.0;

    double distancePrice = distanceInKm * perKmRate;
    double durationPrice = durationInMinutes * perMinuteRate;

    double subtotal = baseFare + distancePrice + durationPrice + bookingFee;

    double withSurge = subtotal * surgeMultiplier;

    double afterMinFare = withSurge > minFare ? withSurge : minFare;

    double markup = vehicleMarkup[vehicleType] ?? 1.00;
    double finalPrice = afterMinFare * markup;

    finalPrice2 = (finalPrice / 50).round() * 50;

    if (discount > 0) {
      finalPrice2 = finalPrice2! - (finalPrice2! * discount);
    }

    return finalPrice2;
  }

  @override
  String formatPrice(double price, {bool showSymbol = true}) {
    String formattedPrice = price.toStringAsFixed(0);

    // Add thousand separators
    String result = '';
    int length = formattedPrice.length;
    for (int i = 0; i < length; i++) {
      if (i > 0 && (length - i) % 3 == 0) {
        result += ',';
      }
      result += formattedPrice[i];
    }

    if (showSymbol) {
      return '$result د.ع';
    }
    return result;
  }

  @override
  void updateVehicleMarkup(Map<String, double> newMarkup) {
    vehicleMarkup = newMarkup;
    notifyListeners();
  }

  @override
  void updateBaseRates({
    double? newBaseFare,
    double? newPerKmRate,
    double? newPerMinuteRate,
    double? newMinFare,
    double? newBookingFee,
  }) {
    baseFare = newBaseFare ?? baseFare;
    perKmRate = newPerKmRate ?? perKmRate;
    perMinuteRate = newPerMinuteRate ?? perMinuteRate;
    minFare = newMinFare ?? minFare;
    bookingFee = newBookingFee ?? bookingFee;
    notifyListeners();
  }

  @override
  void selectVehicleType(String vehicleType) {
    _selectedVehicleType = vehicleType;
    notifyListeners();
  }

  @override
  void applyPromo() {
    String code = controller.text.trim();

    if (code.isEmpty) {
      notifyListeners();
      customSnackbar('رمز الخصم مطلوب', 'يرجى إدخال رمز الخصم', isWhite: true);
      return;
    }

    if (code == 'SAVE10') {
      discount = 0.10;
      errorText = null;
    } else if (code == 'SAVE20') {
      discount = 0.20;
      errorText = null;
    } else {
      discount = 0.0;
      customSnackbar(
        'رمز غير صالح',
        'الرمز الذي أدخلته غير صالح',
        isWhite: true,
      );
    }

    if (finalPrice2 == null) return;

    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
