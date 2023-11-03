import 'package:flutter/material.dart';

class MessageSendInput extends StatelessWidget {
  const MessageSendInput({super.key,  this.hintText="", this.suffixIcon, this.prefixIcon, this.controller});

  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        filled: true,
        fillColor: Colors.green.shade100,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 0),
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintStyle: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
