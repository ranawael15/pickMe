import 'package:flutter/material.dart';

class EditProfileInput extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final String text;

  final Widget? suffixIcon;
  final bool obscureText;

  final AutovalidateMode? autovalidateMode;

  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const EditProfileInput({
    super.key,
    required this.text,
    required this.prefixIcon,
    required this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.autovalidateMode,
    this.onChanged,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),

        TextFormField(
          controller: controller,
          validator: validator,
          autovalidateMode: autovalidateMode,
          obscureText: obscureText,
          onChanged: onChanged,
          keyboardType: keyboardType,

          style: const TextStyle(color: Colors.black),

          decoration: InputDecoration(
            hintText: hintText,

            hintStyle: const TextStyle(color: Color.fromARGB(127, 76, 70, 55)),

            fillColor: const Color(0xFFFFF1E6),
            filled: true,

            prefixIcon: Icon(prefixIcon),

            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),

            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}