import 'package:desafio/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:desafio/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: AtletaPendente(),
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xff6750A4),
    ),
  ));
}

class AtletaPendente extends StatefulWidget {
  const AtletaPendente({Key? key}) : super(key: key);

  @override
  State<AtletaPendente> createState() => _AtletaPendenteState();
}

class _AtletaPendenteState extends State<AtletaPendente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar.large(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Ops...',
              style: GoogleFonts.lexendDeca(
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 30),
                  child: Text(
                    'Vi que você já cadastrou suas informações, mas infelizmente um treinador ainda não confirmou seus dados, por favor, aguarde mais um pouquinho!',
                    style: GoogleFonts.lexendDeca(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.black38,
                    ),
                  ),
                ),
                // Adicione outros widgets aqui conforme necessário
              ],
            ),
          ),
        ],
      ),
    );
  }
}
