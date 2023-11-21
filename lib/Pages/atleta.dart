import 'package:desafio/Components/appBar.dart';
import 'package:desafio/Components/cardPerfil.dart';
import 'package:desafio/Pages/cadastraUser.dart';
import 'package:desafio/Pages/cronometro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    home: AtletaPage(),
  ));
}

class AtletaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarPersonalizada(
              nome: 'Atleta',
              titulo:
                  'Visualize seus restultados e registre o Treino Avaliativo de seus companheiros!',
            ),
            SizedBox(
              height: 10,
            ),
            CardPerfil(
              nome: 'Gabriel Lamarca Galdino da Silva',
              papel: 'Treino realizado em 19/11/2023',
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Cronometro(),
            ),
          );
        },
        child: Icon(Icons.timer),
        backgroundColor: Color(0xFF4B39EF),
      ),
    );
  }
}
