import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownPadrao extends StatefulWidget {
  final List<String> options;
  final String value;
  final ValueChanged<String?> onChanged;
  final String labelText;
  final double largura;

  DropdownPadrao({
    required this.options,
    required this.value,
    required this.onChanged,
    required this.labelText,
    required this.largura,
  });

  @override
  _DropdownPadraoState createState() => _DropdownPadraoState();
}

class _DropdownPadraoState extends State<DropdownPadrao> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * widget.largura,
      child: DropdownButtonFormField<String>(
        value: widget.value,
        items: widget.options.map((option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: widget.labelText,
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
        onChanged: widget.onChanged,
      ),
    );
  }
}
