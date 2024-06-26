import 'package:flutter/material.dart';
import 'package:task_manager_app/core/constants/constants.dart';


class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
        required this.hint,
        this.maxLines = 1,
        this.controller,
        this.onSaved,
        this.isPassword,
        this.suffix,

        this.onChanged});

  final String hint;
  final int maxLines;
  final bool? isPassword;
  final Widget? suffix;
  final TextEditingController? controller;

  final void Function(String?)? onSaved;

  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      onSaved: onSaved,
      obscureText: isPassword ?? false,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Field is required ';
        } else {
          return null;
        }
      },
      cursorColor: kPrimaryColor,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(kPrimaryColor),
        suffixIcon: suffix,

      ),
    );
  }

  OutlineInputBorder buildBorder([color]) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          8,
        ),
        borderSide: BorderSide(
          color: color ?? Colors.white,
        ));
  }
}