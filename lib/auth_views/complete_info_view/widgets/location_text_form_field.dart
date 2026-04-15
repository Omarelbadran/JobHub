import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class LocationTextFormField extends StatelessWidget {
  final Iterable<String>? autofillHints;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool readOnly;
  final void Function()? onTap;
  const LocationTextFormField({
    super.key,
    this.autofillHints,
    this.controller,
    this.validator,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
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
          hintText: 'Location',
          hintStyle: TextStyle(
              color: Colors.black
          ),
          prefixIcon: Icon(Icons.search),
        )
    );
  }
}
