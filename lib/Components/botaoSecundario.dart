import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BotaoSecundario extends StatelessWidget {
  final String labelText;
  final double largura;
  final VoidCallback? onPressed;

  const BotaoSecundario({
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
        backgroundColor: Colors.yellow,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * largura,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Center(
          child: Text(
            labelText,
            style: GoogleFonts.lexendDeca(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}