import 'dart:convert';
import 'dart:html';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/Components/btnPrincipal.dart';
import 'package:desafio/Components/dropdown.dart';
import 'package:desafio/Components/textField.dart';
import 'package:desafio/firebase_options.dart';
import 'package:desafio/helper/email.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(home: CadastraUser()));
}

class CadastraUser extends StatefulWidget {
  const CadastraUser({Key? key}) : super(key: key);

  @override
  State<CadastraUser> createState() => _CadastraUserState();
}

class _CadastraUserState extends State<CadastraUser> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String tipoDeUsuario = 'administrador';

  @override
  Widget build(BuildContext context) {
    String usuarioSelecionado = 'administrador';
    List<String> op = ['administrador', 'treinador', 'atleta'];

    String geraNumeroAleatorio() {
      Random random = Random();
      int numeroAleatorio = random.nextInt(900) + 100;
      String senhaTemp = 'unaerp$numeroAleatorio';
      return senhaTemp;
    }

    Future<void> cadastrarUsuario(String tipoUsuario, String nome, String email,
        BuildContext context) async {
      var senhaTemp = geraNumeroAleatorio();

      RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
      if (nome.isEmpty || email.isEmpty) {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.info(
            message: 'Digite as credenciais',
          ),
        );
        return;
      } else if (!regex.hasMatch(email)) {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
            message: 'Email inválido',
          ),
        );
        return;
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('pre_cadastro')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isEmpty) {
        try {
          await FirebaseFirestore.instance
              .collection('pre_cadastro')
              .doc()
              .set({
            'email': email,
            'nome': nome,
            'tipoUsuario': tipoUsuario,
            'status': tipoUsuario == 'atleta' ? 'incompleto' : 'inativo',
            'senha_temp': senhaTemp,
          });

          enviaEmail(
              nome,
              email,
              'BEM VINDO ao UNASplash, $nome! Seu usuário foi criado e agora você já pode fazer o primeiro acesso. Sua senha temporária é: $senhaTemp',
              'UNASPLASH - Pré cadastro criado');

          Navigator.pop(context);

          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.success(
              message: "Usuário criado com sucesso!",
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Nome ou email inválidos"),
            ),
          );
        }
      } else {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
            message: "Usuário já foi cadastrado",
          ),
        );
      }
    }

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xff6750A4),
      ),
      home: Scaffold(
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
                'Cadastro',
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
                      'Preencha o formulário e cadastre novos usuários no sistema!',
                      style: GoogleFonts.lexendDeca(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 1,
                      color: Colors.black12,
                    ),
                    Container(
                      color: Colors.grey[200],
                      height: MediaQuery.of(context).size.height * 1,
                      child: Form(
                        // key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                              child: Row(children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '1. ',
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Que usuário deseja cadastrar?',
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                            DropdownPadrao(
                              options: op,
                              value: usuarioSelecionado,
                              onChanged: (value) {
                                setState(() {
                                  usuarioSelecionado = value ?? 'administrador';
                                  tipoDeUsuario = usuarioSelecionado;
                                });
                              },
                              labelText: '',
                              largura: 0.95,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                              child: Row(children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '2. ',
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            'Digite o nome completo do usuário',
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                            TextFieldPadrao(
                              labelText: 'Nome',
                              largura: 0.95,
                              controller: nomeController,
                              obscureText: false,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                              child: Row(children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '3. ',
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            'Digite o e-mail completo do usuário',
                                        style: GoogleFonts.lexendDeca(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                            TextFieldPadrao(
                              labelText: 'E-mail',
                              largura: 0.95,
                              obscureText: false,
                              controller: emailController,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.warning_rounded,
                                    size: 30,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'A senha de primeiro acesso do usuário será enviada por e-mail!',
                                      style: GoogleFonts.lexendDeca(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54,
                                      ),
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            BotaoPrincipal(
                              largura: 0.95,
                              labelText: 'Cadastrar Usuário',
                              onPressed: () {
                                cadastrarUsuario(
                                    tipoDeUsuario,
                                    nomeController.text,
                                    emailController.text,
                                    context);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
