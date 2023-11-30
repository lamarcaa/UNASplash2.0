import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldPadrao extends StatelessWidget {
  final String labelText;
  final double largura;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode; // Adicionando autovalidateMode
  final void Function(String)? onChanged; // Adicionando onChanged

  const TextFieldPadrao({
    Key? key,
    required this.labelText,
    required this.largura,
    required this.obscureText,
    required this.controller,
    this.validator,
    this.inputFormatters,
    this.autovalidateMode, // Parâmetro opcional
    this.onChanged, // Parâmetro opcional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * largura,
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        validator: validator,
        inputFormatters: inputFormatters,
        autovalidateMode:
            autovalidateMode, // Passando autovalidateMode para TextFormField
        onChanged: onChanged, // Passando onChanged para TextFormField
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.lexendDeca(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: const Color(0xFF95A1AC),
          ),
          hintStyle: const TextStyle(
            color: Color(0xFF95A1AC),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
        ),
        style: GoogleFonts.lexendDeca(
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: const Color.fromARGB(255, 72, 72, 72),
        ),
      ),
    );
  }
}
