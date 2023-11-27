import 'package:desafio/Components/btnPrincipal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardPerfil extends StatelessWidget {
  final String nome;
  final String tipoUsuario;
  final String? status;

  const CardPerfil({
    Key? key,
    required this.nome,
    required this.tipoUsuario,
    this.status,
  }) : super(key: key);

  Icon getStatusIcon() {
    if (status == 'ativo') {
      return Icon(Icons.check_circle, color: Colors.green);
    } else if (status == 'incompleto') {
      return Icon(Icons.warning_rounded, color: Colors.orange[400]);
    } else {
      // Caso pendente ou null
      return Icon(Icons.access_time, color: Colors.grey);
    }
  }

  Color? getStatusColor() {
    if (status == 'incompleto') {
      return Colors.orange[400];
    } else {
      return Colors.grey;
    }
  }

  String getStatusText() {
    if (status == 'ativo') {
      return 'ativo';
    } else if (status == 'incompleto') {
      return 'incompleto';
    } else {
      return 'pendente';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width * 0.95,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Color.fromARGB(25, 0, 0, 0),
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(15, 8, 8, 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 50,
              height: 50,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    'https://i.imgur.com/F43Zm3W.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 5, 0, 0),
                    child: Text(
                      nome,
                      style: GoogleFonts.lexendDeca(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF14181B),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 4, 0, 0),
                    child: Text(
                      tipoUsuario,
                      style: GoogleFonts.lexendDeca(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF57636C),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (status !=
                null) // Verifica se o status é fornecido antes de exibi-lo
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    getStatusIcon(), // Use a função para obter o ícone dinamicamente
                    SizedBox(width: 4),
                    Text(
                      getStatusText(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color:
                            getStatusColor(), // Use a função para obter a cor dinamicamente
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
            
    );
  }
}
