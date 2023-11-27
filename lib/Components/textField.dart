import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldPadrao extends StatelessWidget {
  final String labelText;
  final double largura;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const TextFieldPadrao({
    Key? key,
    required this.labelText,
    required this.largura,
    required this.obscureText,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * largura,
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.lexendDeca(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Color(0xFF95A1AC),
          ),
          hintStyle: TextStyle(
            color: Color(0xFF95A1AC),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
        ),
        style: GoogleFonts.lexendDeca(
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: Color.fromARGB(255, 72, 72, 72),
        ),
      ),
    );
  }
}
