import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/Components/btnPrincipal.dart';
import 'package:desafio/Components/dropdown.dart';
import 'package:desafio/Components/textField.dart';
import 'package:desafio/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const CadastraUser());
}

class CadastraUser extends StatefulWidget {
  const CadastraUser({Key? key}) : super(key: key);

  @override
  State<CadastraUser> createState() => _CadastraUserState();
}

class _CadastraUserState extends State<CadastraUser> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String tipoDeUsuario = 'Administrador';
  Widget build(BuildContext context) {
    String usuarioSelecionado = 'Administrador';
    List<String> op = ['Administrador', 'Treinador', 'Atleta'];

    Future<void> cadastrarUsuario(String tipoUsuario, String nome, String email,
        BuildContext context) async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email, password: 'unasplash123');

        String userId = userCredential.user!.uid;
        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(userId)
            .set({
          'email': email,
          'nome': nome,
          'tipoUsuario': tipoUsuario,
        });
        Navigator.pop(context);

        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "${nome} cadastrado com sucesso!",
          ),
        );
      } catch (e) {
        print('n foi: $e');
      }
    }

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xff6750A4),
      ),
      home: Material(
        child: CustomScrollView(
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
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
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
                                  usuarioSelecionado = value ?? 'Administrador';
                                  tipoDeUsuario = usuarioSelecionado;
                                });
                              },
                              labelText: '',
                              largura: 0.95,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
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
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
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
                            SizedBox(
                              height: 30,
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
