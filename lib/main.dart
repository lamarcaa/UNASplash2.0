import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  Future<void> verificaLogin(BuildContext context, email, String senha) async {
    if (email.isEmpty || senha.isEmpty) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.info(
          message: "Digite suas credenciais para logar",
        ),
      );
    } else {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: senha,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdmPage()),
        );
      } on FirebaseAuthException catch (e) {
        print('Erro durante o login: $e');

        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          print(
              'Credenciais inválidas. Por favor, verifique seu email e senha.');
        } else {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              message: "E-mail ou senha inválidos, tente novamente",
            ),
          );
        }
      }
    }
  }

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
                SizedBox(
                  height: 30,
                ),
                TextFieldPadrao(
                  labelText: 'Email',
                  largura: 0.7,
                  controller: emailController,
                  obscureText: false,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFieldPadrao(
                  labelText: 'Senha',
                  largura: 0.7,
                  obscureText: true,
                  controller: senhaController,
                ),
                SizedBox(
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: InkWell(
                    onTap: () {},
                    child: Text(
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
