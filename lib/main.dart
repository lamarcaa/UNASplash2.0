import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/Pages/atleta.dart';
import 'package:desafio/Pages/treinador.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'firebase_options.dart';
import 'package:desafio/Components/btnPrincipal.dart';
import 'package:desafio/Components/textField.dart';
import 'package:desafio/Pages/administrador.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  MyApp({super.key});

  Future<void> verificaLogin(
      BuildContext context, String email, String senha) async {
    if (email.isEmpty || senha.isEmpty) {
      print("digite algo");
    }

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('pre_cadastro')
          .where('email', isEqualTo: email)
          .where('senha_temp', isEqualTo: senha)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String tipoUsuario = querySnapshot.docs[0]['tipoUsuario'];
        redirectToPage(context, tipoUsuario);
      } else {
        print('Credenciais inválidas.');
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
            message: "Credenciais inválidas, tente novamente.",
          ),
        );
      }
    } catch (e) {
      print('Erro durante a verificação no Firestore: $e');
    }
  }

  void redirectToPage(BuildContext context, String tipoUsuario) {
    switch (tipoUsuario) {
      case 'administrador':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AdmPage()),
        );
        break;
      case 'treinador':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TreinadorPage()),
        );
        break;
      case 'atleta':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AtletaPage()),
        );
        break;
    }
  }

  Future<void> primeiroAcesso(
      BuildContext context, String email, String senha) async {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: Container(
            color: Colors.grey[400],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://i.imgur.com/oX5YSQe.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                Text(
                  'Bem-vindo de volta, sentimos sua falta!',
                  style: GoogleFonts.lexendDeca(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFieldPadrao(
                  labelText: 'Email',
                  largura: 0.7,
                  controller: emailController,
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldPadrao(
                  labelText: 'Senha',
                  largura: 0.7,
                  obscureText: true,
                  controller: senhaController,
                ),
                const SizedBox(
                  height: 20,
                ),
                BotaoPrincipal(
                  labelText: 'Login',
                  largura: 0.7,
                  onPressed: () {
                    verificaLogin(
                        context, emailController.text, senhaController.text);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                BotaoPrincipal(
                  labelText: 'Primeiro Acesso',
                  largura: 0.7,
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return const Text('oi');
                      },
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: InkWell(
                    onTap: () {},
                    child: const Text(
                      'Esqueceu sua senha?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
