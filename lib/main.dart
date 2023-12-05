import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/Components/botaoSecundario.dart';
import 'package:desafio/Components/botaoVazado.dart';
import 'package:desafio/Pages/atleta.dart';
import 'package:desafio/Pages/atletaPendente.dart';
import 'package:desafio/Pages/cadastraAtleta.dart';
import 'package:desafio/Pages/primeiroAcesso.dart';
import 'package:desafio/Pages/treinador.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  Future<void> verificaLogin(
      BuildContext context, String email, String senha) async {
    if (email.isEmpty || senha.isEmpty) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Digite suas credenciais para logar',
        ),
      );
      exit(0);
    }

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('cadastro_finalizado')
        .where('email', isEqualTo: email)
        .where('senhaCadastrada', isEqualTo: senha)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot userSnapshot = querySnapshot.docs.first;
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      String senhaUsuario = userData['senhaCadastrada'];
      String emailUsuario = userData['email'];
      String statusUsuario = userData['status'];
      String tipoUsuario = userData['tipo_usuario'];
      String nomeUsuario = userData['nome'];

      if (senhaUsuario == senha && emailUsuario == email) {
        switch (statusUsuario) {
          case 'aguardando':
            mudaStatus(emailUsuario, senhaUsuario, context);
            break;
          case 'ativo':
            autenticaUsuario(context, email, senha, tipoUsuario);
            break;
          case 'incompleto':
            verificaAtleta(context, email, tipoUsuario, nomeUsuario);
            break;
          case 'pendente':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AtletaPendente()),
            );
            break;
        }
      } else {
        print('email e senha nao bateu');
      }
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Usuário ou senha incorretos',
        ),
      );
    }
  }

  Future<void> verificaAtleta(BuildContext context, String email,
      String tipoUsuario, String nome) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('cadastro_finalizado')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot userSnapshot = querySnapshot.docs.first;

      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      String nomeUsuario = userData['nome'];
      String emailUsuario = userData['email'];

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CadastraAtleta(
            titulo: 'Bem-Vindo!',
            texto:
                'É um prazer ter você aqui, $nome! Vi que você ainda não terminou seu cadastro... Assim que finalizar suas informações você já poderá utilizar o aplicativo',
            nomeUsuario: nomeUsuario,
            emailUsuario: emailUsuario,
            status: 'pendente',
          ),
        ),
      );
    }
  }

  Future<void> mudaStatus(
      String emailUsuario, String senhaUsuario, BuildContext context) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('cadastro_finalizado')
        .where('email', isEqualTo: emailUsuario)
        .where('senhaCadastrada', isEqualTo: senhaUsuario)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot userSnapshot = querySnapshot.docs.first;

      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      String tipoUsuario = userData['tipo_usuario'];
      String idDoc = userSnapshot.id;

      await FirebaseFirestore.instance
          .collection('cadastro_finalizado')
          .doc(idDoc)
          .update({'status': 'ativo'});

      cadastraAutentication(emailUsuario, senhaUsuario, tipoUsuario, context);
    } else {
      print('nao encontrou o doc');
    }
  }

  Future<void> cadastraAutentication(String email, String senha,
      String tipoUsuario, BuildContext context) async {
    print('teste');
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      User? user = userCredential.user;
      print('usuario criado');
      redireciona(tipoUsuario, context, email);
    } catch (e) {
      print('usuario n criou ${e}');
    }
  }

  Future<void> redireciona(String tipoUsuario, BuildContext context,
      [String? email]) async {
    switch (tipoUsuario) {
      case 'administrador':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdmPage()),
        );
        break;
      case 'treinador':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TreinadorPage()),
        );
        break;
      case 'atleta':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AtletaPage()),
        );
        break;
      default:
    }
  }

  Future<void> autenticaUsuario(BuildContext context, String email,
      String senha, String tipoUsuario) async {
    print(email);
    print(senha);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      redireciona(tipoUsuario, context);
    } catch (e) {
      print('Erro ao cadastrar usuário: $e');
    }
  }

  void mostrarBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          width: 200,
          child: Column(
            children: [Text('Digite seu email:')],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://i.imgur.com/ba0aEf2.jpg',
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                color: Colors.black54.withOpacity(0.7),
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
                      obscureText: false,
                      controller: senhaController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 100),
                      child: InkWell(
                        onTap: () {
                          mostrarBottomSheet(context);
                        },
                        child: Text(
                          'Esqueceu sua senha? Clique Aqui!',
                          style: GoogleFonts.lexendDeca(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BotaoPrincipal(
                      labelText: 'Login',
                      largura: 0.7,
                      onPressed: () {
                        verificaLogin(context, emailController.text,
                            senhaController.text);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BotaoVazado(
                      labelText: 'Primeiro Acesso',
                      largura: 0.7,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PrimeiroAcesso()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
