import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomTextFormField extends StatelessWidget {
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final bool? obscureText;
  final Iterable<String>? autofillHints;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool readOnly;
  final void Function()? onTap;
  const CustomTextFormField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    this.obscureText = false,
    this.controller,
    this.autofillHints,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        autofillHints: autofillHints,
        obscureText: obscureText!,
        onTap: onTap,
        readOnly: readOnly,
        controller: controller,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onFieldSubmitted: (value) {},
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: 16.h, horizontal: 12.w
        ),
        prefixIcon: Icon(prefixIcon , color: Colors.black,),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.black.withValues(alpha: .2),
          border: InputBorder.none,
        prefixIconConstraints:  BoxConstraints(
          minWidth: 40.w,
          minHeight: 40.h,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black.withValues(alpha: .3),
          fontSize: 14.sp,
        ),
      )
    );
  }
}
