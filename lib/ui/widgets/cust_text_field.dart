import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      this.hint,
      this.isObscured = false,
      this.type = TextInputType.text,
      this.passwordIcon,
      this.controller,
      this.hintStyle,
      this.textStyle,
      this.maxline,
      this.minline,
      this.withBoarder = false,
      this.label,
      this.validation,
      this.prefixIcon,
      this.suffixIcon,
      this.readOnly = false,
      this.onTap});

  final String? hint;
  final String? label;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final IconButton? passwordIcon;
  final bool isObscured;
  final TextInputType? type;
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final void Function()? onTap;
  final int? maxline;
  final int? minline;
  final bool? withBoarder;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool hidden = widget.isObscured;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxline ?? 1,
      minLines: widget.minline ?? 1,
      style: widget.textStyle,
      controller: widget.controller,
      readOnly: widget.readOnly,
      keyboardType: widget.type,
      obscureText: hidden,
      obscuringCharacter: '*',
      onTap: widget.onTap,
      validator: (value) {
        if (widget.validation == null) {
          setState(() {
            errorText = null;
          });
        } else {
          setState(() {
            errorText = widget.validation!(value);
          });
        }
        return errorText;
      },
      decoration: InputDecoration(
        hintStyle: widget.hintStyle,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isObscured
            ? IconButton(
                onPressed: () {
                  setState(
                    () {
                      hidden = !hidden;
                    },
                  );
                },
                iconSize: 24,
                splashRadius: 1,
                isSelected: !hidden,
                selectedIcon: const Icon(Icons.remove_red_eye_rounded),
                icon: const Icon(Icons.hide_source),
              )
            : widget.suffixIcon,
        hintText: widget.hint,
        helperStyle: GoogleFonts.quicksand(
            fontSize: 5,
            color: const Color(0xFFADADAD),
            fontWeight: FontWeight.normal),
      ),
    );
  }
}
