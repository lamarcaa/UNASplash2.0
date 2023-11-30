import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/Components/btnPrincipal.dart';
import 'package:desafio/Components/dataPicker.dart';
import 'package:desafio/Components/dropdown.dart';
import 'package:desafio/Components/textField.dart';
import 'package:desafio/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:search_cep/search_cep.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:validatorless/validatorless.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const CadastraAtleta(
    titulo: 'teste',
    texto: 'teste',
  ));
}

class CadastraAtleta extends StatefulWidget {
  final String titulo;
  final String texto;

  const CadastraAtleta({
    Key? key,
    required this.titulo,
    required this.texto,
  }) : super(key: key);

  @override
  State<CadastraAtleta> createState() => _CadastraAtletaState();
}

Future<void> cadastrarUsuario(
    String tipoUsuario, String nome, String email, BuildContext context) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: '123456');

    String userId = userCredential.user!.uid;
    await FirebaseFirestore.instance
        .collection('pre_cadastro')
        .doc(userId)
        .set({
      'email': email,
      'nome': nome,
      'tipoUsuario': tipoUsuario,
      'status': tipoUsuario == 'Atleta' ? 'incompleto' : 'ativo',
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$nome cadastrado com sucesso!"),
      ),
    );
  } catch (e) {
    print('n foi: $e');
  }
}

class _CadastraAtletaState extends State<CadastraAtleta> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController rgController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController nacionalidadeController = TextEditingController();
  final TextEditingController naturalidadeController = TextEditingController();
  final TextEditingController telPessoalController = TextEditingController();
  final TextEditingController telEmergenciaController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  final TextEditingController nomeMaeController = TextEditingController();
  final TextEditingController nomePaiController = TextEditingController();
  final TextEditingController clubeOrigemController = TextEditingController();
  final TextEditingController localTrabalhoController = TextEditingController();
  final TextEditingController convMedController = TextEditingController();
  final TextEditingController medicamentoController = TextEditingController();
  final TextEditingController telResidController = TextEditingController();
  final TextEditingController telTrabController = TextEditingController();
  final TextEditingController telMaeController = TextEditingController();
  final TextEditingController telPaiController = TextEditingController();
  final TextEditingController telOutroController = TextEditingController();

  bool value1 = false;
  bool value2 = true;
  bool escondeBtn = false;
  bool telResidencial = false;
  bool telTrabalho = false;
  bool telMae = false;
  bool telPai = false;
  bool telOutros = false;
  bool telNao = true;
  bool validadeEmail = false;

  String tipoDeUsuario = 'Administrador';
  String sexoDoUsuario = 'Masculino';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<String> op = ['Administrador', 'Treinador', 'Atleta'];
    List<String> opSexo = ['Masculino', 'Feminino', 'Outro'];
    String usuarioSelecionado = 'Administrador';
    String sexoSelecionado = 'Masculino';

    // Future<void> cadastrarUsuario(String tipoUsuario, String nome, String email,
    //     BuildContext context) async {
    //   try {
    //     UserCredential userCredential = await FirebaseAuth.instance
    //         .createUserWithEmailAndPassword(email: email, password: '123456');

    //     String userId = userCredential.user!.uid;
    //     await FirebaseFirestore.instance
    //         .collection('usuarios')
    //         .doc(userId)
    //         .set({
    //       'email': email,
    //       'nome': nome,
    //       'tipoUsuario': tipoDeUsuario,
    //       'status': tipoUsuario == 'Atleta' ? 'incompleto' : 'ativo',
    //     });
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text("$nome cadastrado com sucesso!"),
    //       ),
    //     );
    //   } catch (e) {
    //     print('n foi: $e');
    //   }
    // }

    Future<void> buscarCep() async {
      final postmonSearchCep = PostmonSearchCep();
      final infoCepJSON =
          await postmonSearchCep.searchInfoByCep(cep: '14315706');
      print(infoCepJSON);
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
                widget.titulo,
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
                      widget.texto,
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
            Form(
              key: _formKey,
              child: SliverToBoxAdapter(
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
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'INFORMAÇÕES PESSOAIS',
                                              style: GoogleFonts.lexendDeca(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                const SizedBox(
                                  height: 50,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 10),
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
                                            text: 'Nome completo do atleta',
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
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 0, 10),
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
                                            text: 'E-mail do atleta',
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, insira um e-mail válido.';
                                    }

                                    if (!RegExp(
                                            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                        .hasMatch(value)) {
                                      return 'Por favor, insira um e-mail válido.';
                                    }

                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onChanged: (value) {
                                    validadeEmail = true;
                                    _formKey.currentState?.validate();
                                  },
                                ),

                                Padding(
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
                                            text: 'Sexo do atleta',
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
                                  options: opSexo,
                                  value: sexoSelecionado,
                                  onChanged: (value) {
                                    setState(() {
                                      sexoSelecionado = value ?? 'Masculino';
                                      sexoDoUsuario = usuarioSelecionado;
                                    });
                                  },
                                  labelText: '',
                                  largura: 0.95,
                                ),
                                Padding(
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
                                            text: 'RG do atleta',
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
                                  labelText: 'RG',
                                  largura: 0.95,
                                  obscureText: false,
                                  controller: rgController,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(9),
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 0, 10),
                                  child: Row(children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '5. ',
                                            style: GoogleFonts.lexendDeca(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'CPF do atleta',
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
                                  labelText: 'CPF',
                                  largura: 0.95,
                                  obscureText: false,
                                  controller: cpfController,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(11),
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 0, 10),
                                  child: Row(children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '6. ',
                                            style: GoogleFonts.lexendDeca(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Nacionalidade do atleta',
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
                                  labelText: 'Nacionalidade',
                                  largura: 0.95,
                                  obscureText: false,
                                  controller: nacionalidadeController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[a-zA-Z]'))
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 0, 10),
                                  child: Row(children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '7. ',
                                            style: GoogleFonts.lexendDeca(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Naturalidade do atleta',
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
                                  labelText: 'Naturalidade',
                                  largura: 0.95,
                                  obscureText: false,
                                  controller: naturalidadeController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[a-zA-Z]'))
                                  ],
                                ),

                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 0, 10),
                                  child: Row(children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '8. ',
                                            style: GoogleFonts.lexendDeca(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                'Data de nascimento do atleta',
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
                                const DataPicker(
                                    onDateSelected: onDateSelected),
                                const SizedBox(
                                  height: 50,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'INFORMAÇÕES DE CONTATO',
                                              style: GoogleFonts.lexendDeca(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                const SizedBox(
                                  height: 50,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 0, 10),
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
                                            text: 'Telefone pessoal do atleta',
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
                                  labelText: 'Telefone pessoal',
                                  largura: 0.95,
                                  obscureText: false,
                                  controller: telPessoalController,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(11),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 0, 10),
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
                                                'Telefone de emergência do atleta',
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
                                  labelText: 'Telefone de emergência',
                                  largura: 0.95,
                                  obscureText: false,
                                  controller: telEmergenciaController,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(11),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'INFORMAÇÕES RESIDENCIAIS',
                                              style: GoogleFonts.lexendDeca(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                const SizedBox(
                                  height: 50,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 0, 10),
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
                                            text: 'CEP do atleta',
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
                                  labelText: 'CEP',
                                  largura: 0.95,
                                  obscureText: false,
                                  controller: cepController,
                                  onChanged: (teste) {
                                    buscarCep();
                                  },
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 0, 10),
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
                                            text: 'Rua do atleta',
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
                                  labelText: 'Rua',
                                  largura: 0.95,
                                  obscureText: false,
                                  controller: ruaController,
                                ),
                                Padding(
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
                                            text: 'Numero do atleta',
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
                                  labelText: 'Numero',
                                  largura: 0.95,
                                  obscureText: false,
                                  controller: numeroController,
                                ),
                                Padding(
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
                                            text: 'Bairro  do atleta',
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
                                  labelText: 'Bairro',
                                  largura: 0.95,
                                  obscureText: false,
                                  controller: bairroController,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 0, 10),
                                  child: Row(children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '5. ',
                                            style: GoogleFonts.lexendDeca(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Cidade do atleta',
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
                                  labelText: 'Cidade',
                                  largura: 0.95,
                                  obscureText: false,
                                  controller: cidadeController,
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'ANEXOS',
                                              style: GoogleFonts.lexendDeca(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                const SizedBox(
                                  height: 50,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.image,
                                                color: Colors.black45,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Atestado Médico Admissional',
                                                style: GoogleFonts.lexendDeca(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.image,
                                                color: Colors.black45,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Foto do RG',
                                                style: GoogleFonts.lexendDeca(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.image,
                                                color: Colors.black45,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Foto do CPF',
                                                style: GoogleFonts.lexendDeca(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.image,
                                                color: Colors.black45,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Comprovante de Residência',
                                                style: GoogleFonts.lexendDeca(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.image,
                                                color: Colors.black45,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Foto 3x4',
                                                style: GoogleFonts.lexendDeca(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.image,
                                                color: Colors.black45,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Regulamento Assinado',
                                                style: GoogleFonts.lexendDeca(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'INFORMAÇÕES OPCIONAIS',
                                              style: GoogleFonts.lexendDeca(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                const SizedBox(
                                  height: 50,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 0, 10),
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
                                            text: 'Nome da mãe do atleta',
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
                                  labelText: 'Nome da mãe',
                                  largura: 0.95,
                                  obscureText: false,
                                  controller: telPessoalController,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 0, 10),
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
                                            text: 'Nome da pai do atleta',
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
                                  labelText: 'Nome da pai',
                                  largura: 0.95,
                                  obscureText: false,
                                  controller: telPessoalController,
                                ),
                                Padding(
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
                                            text: 'Clube de origem do atleta',
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
                                  labelText: 'Clube de origem',
                                  largura: 0.95,
                                  obscureText: false,
                                  controller: telPessoalController,
                                ),
                                Padding(
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
                                            text: 'Local de trabalho do atleta',
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
                                  labelText: 'Local de trabalho',
                                  largura: 0.95,
                                  obscureText: false,
                                  controller: telPessoalController,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 0, 10),
                                  child: Row(children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '5. ',
                                            style: GoogleFonts.lexendDeca(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Convênio Médico do Atleta',
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
                                  labelText: 'Convênio Médico',
                                  largura: 0.95,
                                  obscureText: false,
                                  controller: telPessoalController,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 0, 10),
                                  child: Row(children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '6. ',
                                            style: GoogleFonts.lexendDeca(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Tem alergia a medicamentos?',
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
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: value1,
                                          onChanged: (newValue1) {
                                            setState(() {
                                              escondeBtn = true;
                                              value1 = newValue1!;
                                              if (value1) {
                                                value2 = false;
                                              }
                                            });
                                          },
                                          activeColor: Colors.green,
                                        ),
                                        Text(
                                          'Sim',
                                          style: GoogleFonts.lexendDeca(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 50,
                                        ),
                                        Checkbox(
                                          value: value2,
                                          onChanged: (newValue2) {
                                            setState(() {
                                              escondeBtn = false;
                                              value2 = newValue2!;
                                              if (value2) {
                                                value1 = false;
                                              }
                                            });
                                          },
                                          activeColor: Colors.green,
                                        ),
                                        Text(
                                          'Não',
                                          style: GoogleFonts.lexendDeca(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Visibility(
                                  visible: escondeBtn,
                                  child: TextFieldPadrao(
                                    labelText: 'Digite os medicamentos',
                                    largura: 0.95,
                                    obscureText: false,
                                    controller: telPessoalController,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 0, 10),
                                  child: Row(children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '7. ',
                                            style: GoogleFonts.lexendDeca(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                'Deseja adicionar mais telefones?',
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
                                const SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            children: [
                                              Checkbox(
                                                value: telResidencial,
                                                onChanged: (newValue2) {
                                                  setState(() {
                                                    telResidencial =
                                                        !telResidencial;
                                                  });
                                                },
                                                activeColor: Colors.green,
                                              ),
                                              Text(
                                                'Telefone Residencial',
                                                style: GoogleFonts.lexendDeca(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start, // Adicionado para alinhar à direita
                                            children: [
                                              Checkbox(
                                                value: telTrabalho,
                                                onChanged: (newValue2) {
                                                  setState(() {
                                                    telTrabalho = !telTrabalho;
                                                  });
                                                },
                                                activeColor: Colors.green,
                                              ),
                                              Text(
                                                'Local de Trabalho',
                                                style: GoogleFonts.lexendDeca(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            children: [
                                              Checkbox(
                                                value: telMae,
                                                onChanged: (newValue1) {
                                                  setState(() {
                                                    telMae = !telMae;
                                                  });
                                                },
                                                activeColor: Colors.green,
                                              ),
                                              Text(
                                                'Telefone da mãe',
                                                style: GoogleFonts.lexendDeca(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start, // Adicionado para alinhar à direita
                                            children: [
                                              Checkbox(
                                                value: telPai,
                                                onChanged: (newValue2) {
                                                  setState(() {
                                                    telPai = !telPai;
                                                  });
                                                },
                                                activeColor: Colors.green,
                                              ),
                                              Text(
                                                'Telefone do pai',
                                                style: GoogleFonts.lexendDeca(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Checkbox(
                                                value: telOutros,
                                                onChanged: (newValue1) {
                                                  setState(() {
                                                    telOutros = !telOutros;
                                                    // }
                                                  });
                                                },
                                                activeColor: Colors.green,
                                              ),
                                              Text(
                                                'Outros',
                                                style: GoogleFonts.lexendDeca(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Visibility(
                                  visible: telResidencial,
                                  child: Column(
                                    children: [
                                      TextFieldPadrao(
                                        labelText: 'Telefone residêncial',
                                        largura: 0.95,
                                        obscureText: false,
                                        controller: telPessoalController,
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: telTrabalho,
                                  child: Column(
                                    children: [
                                      TextFieldPadrao(
                                        labelText: 'Telefone do trabalho',
                                        largura: 0.95,
                                        obscureText: false,
                                        controller: telPessoalController,
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: telMae,
                                  child: Column(
                                    children: [
                                      TextFieldPadrao(
                                        labelText: 'Telefone da mãe',
                                        largura: 0.95,
                                        obscureText: false,
                                        controller: telPessoalController,
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: telPai,
                                  child: Column(
                                    children: [
                                      TextFieldPadrao(
                                        labelText: 'Telefone do pai',
                                        largura: 0.95,
                                        obscureText: false,
                                        controller: telPessoalController,
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: telOutros,
                                  child: Column(
                                    children: [
                                      TextFieldPadrao(
                                        labelText: 'Outro número de telefone',
                                        largura: 0.95,
                                        obscureText: false,
                                        controller: telPessoalController,
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                                // BotaoPrincipal(
                                //     largura: 0.95,
                                //     labelText: 'Cadastrar Usuário',
                                //     onPressed: () {}),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        print('foi');
                                        // Faça alguma coisa aqui se a validação for bem-sucedida
                                      } else {
                                        print('n foi');
                                        // Faça alguma coisa aqui se a validação falhar
                                      }
                                    });
                                  },
                                  child: Text('Submit'),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void onDateSelected(DateTime selectedDate) {
  final dntNascimnetoAtleta = selectedDate;
}
