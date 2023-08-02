import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/styles.dart';

import '../const/color.dart';
import '../helpers/sizes.dart';

class CommonTextField {
  outlinedTextField({
    TextEditingController? controller,
    String? Function(String?)? validator,
    Function(String?)? onChanged,
    String? hintText,
  }) {
    return TextFormField(
      autofocus: true,
      controller: controller,
      keyboardType: TextInputType.text,
      style: sTitleMedium,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: ww() * 0.05),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ConstColor.greyColor),
              borderRadius: BorderRadius.circular(30)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: ConstColor.greyColor),
              borderRadius: BorderRadius.circular(30)),
          hintText: hintText,
          hintStyle: sTitleMedium.copyWith(color: Colors.white.withOpacity(0.8))
          // prefixIcon: const Padding(
          //   padding: EdgeInsets.all(15),
          //   child: Text('+91 '),
          // ),
          ),
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     return "Please Enter a Phone Number";
      //   } else if (!RegExp(
      //           r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
      //       .hasMatch(value)) {
      //     return "Please Enter a Valid Phone Number";
      //   } else {
      //     return null;
      //   }
      // },
    );
  }
}
