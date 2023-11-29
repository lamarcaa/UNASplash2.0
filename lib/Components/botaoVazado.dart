import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BotaoVazado extends StatelessWidget {
  final String labelText;
  final double largura;
  final VoidCallback? onPressed;

  const BotaoVazado({
    Key? key,
    required this.largura,
    required this.labelText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        elevation: 0,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: Color(0xFF4B39EF),
            width: 2.0, // Largura da borda
          ),
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * largura,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Center(
          child: Text(
            labelText,
            style: GoogleFonts.lexendDeca(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4B39EF),
            ),
          ),
        ),
      ),
    );
  }
}
