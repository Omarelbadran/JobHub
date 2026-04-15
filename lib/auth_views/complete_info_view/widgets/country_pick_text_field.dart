import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CountryPickTextField extends StatelessWidget {
  final Iterable<String>? autofillHints;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool readOnly;
  final void Function()? onTap;
  final ValueChanged<CountryCode>? onCountryChanged;
  const CountryPickTextField(
       {super.key,
       this.autofillHints,
         this.controller,
         this.validator,
         this.keyboardType,
         this.readOnly = false,
         this.onTap,
         this.onCountryChanged,
       });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        autofillHints: autofillHints,
        onTap: onTap,
        readOnly: readOnly,
        controller: controller,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onFieldSubmitted: (value) {},
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          vertical: 18.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(
            color: Colors.black
        ),
        ),
        hintText: 'Phone Number',
        hintStyle: TextStyle(
          color: Colors.black
        ),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.arrow_drop_down_outlined),
            CountryCodePicker(
              initialSelection: 'EG',
              showCountryOnly: false,
              showOnlyCountryWhenClosed: false,
              padding: EdgeInsets.zero,
              onChanged: onCountryChanged,
            ),
          ],
        ),
        suffixIcon: Icon(Icons.phone_android_outlined),
      )
    );
  }
}
