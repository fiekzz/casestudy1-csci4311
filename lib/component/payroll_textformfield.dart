import 'package:casestudy1/utils/ui_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PayrollTextformfield extends StatefulWidget {
  final String label;
  final bool isPlaceholder;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final String? Function(String? text)? validator;

  const PayrollTextformfield({
    super.key,
    this.isPlaceholder = false,
    this.controller,
    this.label = 'Text Field',
    this.decoration,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<PayrollTextformfield> createState() => _PayrollTextformfieldState();
}

class _PayrollTextformfieldState extends State<PayrollTextformfield> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: UiColors.oceanblue,
              width: 2,
            ), // Change color when focused
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: UiColors.oceanblue),
          ),
          hintText: widget.label,
          hintStyle: const TextStyle(
            color: Color(0xFFAAAAAA),
            fontWeight: FontWeight.w400,
          ),
          labelStyle: const TextStyle(
            color: Color(0xFF777777),
          ),
          suffixIcon: widget.obscureText
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  iconSize: 20,
                  icon: Icon(
                    !isPasswordVisible
                        ? CupertinoIcons.eye
                        : CupertinoIcons.eye_slash,
                  ),
                )
              : null,
        ),
        validator: widget.validator,
        obscureText: widget.obscureText && !isPasswordVisible,
        keyboardType: widget.keyboardType,
      ),
    );
  }
}
