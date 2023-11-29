import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/Components/btnPrincipal.dart';
import 'package:desafio/Components/dropdown.dart';
import 'package:desafio/Components/textField.dart';
import 'package:desafio/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(home: PrimeiroAcesso()));
}

class PrimeiroAcesso extends StatefulWidget {
  const PrimeiroAcesso({Key? key}) : super(key: key);

  @override
  State<PrimeiroAcesso> createState() => _PrimeiroAcessoState();
}

class _PrimeiroAcessoState extends State<PrimeiroAcesso> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController tempSenhaController = TextEditingController();
  final TextEditingController senhaFinalController = TextEditingController();
  final TextEditingController comparaSenhaFinalController =
      TextEditingController();
  bool controlaBtn = false;
  String tipoDeUsuario = 'administrador';

  @override
  Widget build(BuildContext context) {
    print("chegou");

    Future<void> comparaUser(String email, String tempSenha) async {
      if (email.isEmpty && tempSenha.isEmpty) {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.info(
            message: 'Digite suas credenciais',
          ),
        );
        exit(0);
      }

      CollectionReference cadastroFinalizadoCollection =
          FirebaseFirestore.instance.collection('cadastro_finalizado');

      try {
        QuerySnapshot querySnapshot = await cadastroFinalizadoCollection
            .where('email', isEqualTo: email)
            .get();

        if (querySnapshot.docs.isEmpty) {
          try {
            CollectionReference preCadastroCollection =
                FirebaseFirestore.instance.collection('pre_cadastro');

            QuerySnapshot querySnapshot = await preCadastroCollection
                .where('email', isEqualTo: email)
                .where('senha_temp', isEqualTo: tempSenha)
                .get();

            if (querySnapshot.docs.isNotEmpty) {
              setState(() {
                controlaBtn = true;
              });
              print("encontrou");
            } else {
              showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.error(
                  message: 'Email ou senha incorretos',
                ),
              );
            }
          } catch (e) {
            print(e);
          }
        } else {
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.error(
              message: 'Usuário já realizou o primeiro acesso',
            ),
          );
          exit(0);
        }
      } catch (e) {}
    }

    Future<void> finalizaCadastro(
      String email,
      String novaSenha,
      String comparaSenha,
    ) async {
      if (novaSenha == comparaSenha) {
        print("As senhas são iguais");

        CollectionReference cadastroFinalizadoCollection =
            FirebaseFirestore.instance.collection('cadastro_finalizado');

        try {
          QuerySnapshot querySnapshot = await cadastroFinalizadoCollection
              .where('email', isEqualTo: email)
              .get();

          if (querySnapshot.docs.isEmpty) {
            try {
              CollectionReference preCadastroCollection =
                  FirebaseFirestore.instance.collection('pre_cadastro');

              QuerySnapshot querySnapshot = await preCadastroCollection
                  .where('email', isEqualTo: email)
                  .get();

              if (querySnapshot.docs.isNotEmpty) {
                DocumentSnapshot userSnapshot = querySnapshot.docs.first;
                Map<String, dynamic> userData =
                    userSnapshot.data() as Map<String, dynamic>;

                String tipoUsuario = userData['tipoUsuario'];
                String nome = userData['nome'];

                await cadastroFinalizadoCollection.add({
                  'nome': nome,
                  'email': email,
                  'tipo_usuario': tipoUsuario,
                  'status': 'aguardando',
                  'senhaCadastrada': novaSenha
                });

                Navigator.pop(context);

                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.success(
                    message: 'Senha cadastrada, você já pode logar',
                  ),
                );
              } else {
                print('Usuário não encontrado');
              }
            } catch (e) {
              print('Erro ao buscar ou cadastrar usuário: $e');
            }
          } else {
            print('usuario fez primeiro acesso');
          }
        } catch (e) {}
      } else {
        print("As senhas são diferentes");
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
                'Primeiro Acesso',
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
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                    child: Text(
                      'Bem-vindo ao UNASplash, o aplicativo de natação da UNAERP! Para realizar seu primeiro acesso, primeiro um administrador precisa ter cadastrado seu e-email e criado sua senha temporária',
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
                                        text: 'Digite o email cadastrado',
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
                              labelText: 'Email',
                              largura: 0.95,
                              controller: emailController,
                              obscureText: false,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
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
                                        text: 'Digite sua senha temporária',
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
                              labelText: 'Senha temporária',
                              largura: 0.95,
                              controller: tempSenhaController,
                              obscureText: true,
                            ),
                            Visibility(
                              visible: controlaBtn,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 0, 10),
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
                                          text: 'Digite sua nova senha',
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
                            ),
                            Visibility(
                              visible: controlaBtn,
                              child: TextFieldPadrao(
                                labelText: 'Nova senha',
                                largura: 0.95,
                                controller: senhaFinalController,
                                obscureText: true,
                              ),
                            ),
                            Visibility(
                              visible: controlaBtn,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 0, 10),
                                child: Row(children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '4. ',
                                          style: GoogleFonts.lexendDeca(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Confirme sua nova senha',
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
                            ),
                            Visibility(
                              visible: controlaBtn,
                              child: TextFieldPadrao(
                                labelText: 'Confirme sua nova senha',
                                largura: 0.95,
                                controller: comparaSenhaFinalController,
                                obscureText: true,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Visibility(
                              visible: !controlaBtn,
                              child: BotaoPrincipal(
                                largura: 0.95,
                                labelText: 'Verificar usuário',
                                onPressed: () {
                                  comparaUser(emailController.text,
                                      tempSenhaController.text);
                                },
                              ),
                            ),
                            Visibility(
                              visible: controlaBtn,
                              child: BotaoPrincipal(
                                largura: 0.95,
                                labelText: 'Finalizar Cadastro',
                                onPressed: () {
                                  finalizaCadastro(
                                      emailController.text,
                                      senhaFinalController.text,
                                      comparaSenhaFinalController.text);
                                },
                              ),
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
