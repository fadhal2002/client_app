import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:get/get.dart';

class PhoneNumberInput extends StatelessWidget {
  final void Function(PhoneNumber)? onInputChanged;
  final TextEditingController controller;
  final String? hintText, isoCode;
  final IconData? suffixIcon;
  final bool? isObscure;
  final void Function()? onSuffixIconTap;
  // final void Function(bool isValid) onInputValidated;

  const PhoneNumberInput({
    super.key,
    required this.onInputChanged,
    required this.isoCode,
    required this.controller,
    this.hintText,
    this.suffixIcon,
    this.isObscure,
    this.onSuffixIconTap,
    // required this.onInputValidated,
  });

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      searchBoxDecoration: InputDecoration(
        hintText: 'search_country'.tr,
        hintStyle: TextStyle(
          color: Colors.grey[500],
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: const Color(0xFF7B2FF7),
          size: 20,
        ),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF7B2FF7), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
        suffixIconConstraints: const BoxConstraints(maxHeight: 24),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      initialValue: PhoneNumber(isoCode: isoCode),
      onInputChanged: onInputChanged,
      selectorConfig: const SelectorConfig(
        leadingPadding: 20,
        setSelectorButtonAsPrefixIcon: true,
        selectorType: PhoneInputSelectorType.DIALOG,
      ),
      autoValidateMode: AutovalidateMode.disabled,
      textFieldController: controller,
      formatInput: true,
      keyboardType: TextInputType.phone,
      inputDecoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey[400],
          fontWeight: FontWeight.w400,
        ),
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF7B2FF7),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF7B2FF7), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red[300]!, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red[400]!, width: 2),
        ),
        suffixIcon: suffixIcon != null
            ? InkWell(
                onTap: onSuffixIconTap,
                borderRadius: BorderRadius.circular(12),
                child: Icon(
                  suffixIcon,
                  color: const Color(0xFF7B2FF7),
                  size: 22,
                ),
              )
            : null,
      ),
    );
  }
}
