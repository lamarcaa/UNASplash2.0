import 'package:desafio/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarPersonalizada extends StatelessWidget {
  final String nome;
  final String titulo;

  const AppBarPersonalizada(
      {Key? key, required this.nome, required this.titulo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 36, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bem-vindo,',
                    style: GoogleFonts.lexendDeca(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black87,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      nome,
                      style: GoogleFonts.lexendDeca(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF4B39EF),
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('UNASplash'),
                        content: const Text('Deseja sair?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                              // Adicione a lógica de logout aqui
                              await FirebaseAuth.instance.signOut();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()),
                              );
                            },
                            child: const Text('Sair do aplicativo'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0x4C4B39EF),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF4B39EF),
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Container(
                      width: 40,
                      height: 40,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        'https://i.imgur.com/F43Zm3W.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
          child: Center(
            child: Text(
              titulo,
              style: GoogleFonts.lexendDeca(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black45,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
