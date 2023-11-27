import 'package:desafio/Components/appBar.dart';
import 'package:desafio/Components/cardPerfil.dart';
import 'package:desafio/Pages/cronometro.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: AtletaPage(),
  ));
}

class AtletaPage extends StatelessWidget {
  const AtletaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: const SingleChildScrollView(
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
              tipoUsuario: 'Treino realizado em 19/11/2023',
status: '',
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
              builder: (context) => const Cronometro(),
            ),
          );
        },
        backgroundColor: const Color(0xFF4B39EF),
        child: const Icon(
          Icons.timer,
          color: Colors.white,
        ),
      ),
    );
  }
}
