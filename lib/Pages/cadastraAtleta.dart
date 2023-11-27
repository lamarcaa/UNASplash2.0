import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/Components/btnPrincipal.dart';
import 'package:desafio/Components/dataPicker.dart';
import 'package:desafio/Components/dropdown.dart';
import 'package:desafio/Components/textField.dart';
import 'package:desafio/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(CadastraAtleta());
}

class CadastraAtleta extends StatefulWidget {
  const CadastraAtleta({Key? key}) : super(key: key);

  @override
  State<CadastraAtleta> createState() => _CadastraAtletaState();
}

Future<void> cadastrarUsuario(
    String tipoUsuario, String nome, String email, BuildContext context) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: '123456');

    String userId = userCredential.user!.uid;
    await FirebaseFirestore.instance.collection('pre_cadastro').doc(userId).set({
      'email': email,
      'nome': nome,
      'tipoUsuario': tipoUsuario,
      'status': tipoUsuario == 'Atleta' ? 'incompleto' : 'ativo',
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${nome} cadastrado com sucesso!"),
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
  final TextEditingController ruaController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
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

  String tipoDeUsuario = 'Administrador';
  String sexoDoUsuario = 'Masculino';
  Widget build(BuildContext context) {
    String usuarioSelecionado = 'Administrador';
    List<String> op = ['Administrador', 'Treinador', 'Atleta'];
    String sexoSelecionado = 'Masculino';
    List<String> opSexo = ['Masculino', 'Feminino', 'Outro'];

    Future<void> cadastrarUsuario(String tipoUsuario, String nome, String email,
        BuildContext context) async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: '123456');

        String userId = userCredential.user!.uid;
        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(userId)
            .set({
          'email': email,
          'nome': nome,
          'tipoUsuario': tipoDeUsuario,
          'status': tipoUsuario == 'Atleta' ? 'incompleto' : 'ativo',
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${nome} cadastrado com sucesso!"),
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
                      'Preencha o formulário e finalize o cadastro do atleta!',
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
                                controller: emailController,
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
                                controller: emailController,
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
                                controller: emailController,
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
                                controller: emailController,
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
                                          text: 'Data de nascimento do atleta',
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
                              const DataPicker(onDateSelected: onDateSelected),
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
                                controller: emailController,
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
                                controller: emailController,
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
                                controller: emailController,
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
                                controller: emailController,
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
                                controller: emailController,
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
                                controller: emailController,
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
                                controller: emailController,
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
                                padding: EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.image,
                                              color: Colors.black45,
                                            ),
                                            SizedBox(
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
                                padding: EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.image,
                                              color: Colors.black45,
                                            ),
                                            SizedBox(
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
                                padding: EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.image,
                                              color: Colors.black45,
                                            ),
                                            SizedBox(
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
                                padding: EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.image,
                                              color: Colors.black45,
                                            ),
                                            SizedBox(
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
                                padding: EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.image,
                                              color: Colors.black45,
                                            ),
                                            SizedBox(
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
                                padding: EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.image,
                                              color: Colors.black45,
                                            ),
                                            SizedBox(
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
                                controller: emailController,
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
                                controller: emailController,
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
                                controller: emailController,
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
                                controller: emailController,
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
                                controller: emailController,
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
                              SizedBox(
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
                                      SizedBox(
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
                              SizedBox(
                                height: 30,
                              ),
                              Visibility(
                                visible: escondeBtn,
                                child: TextFieldPadrao(
                                  labelText: 'Digite os medicamentos',
                                  largura: 0.95,
                                  obscureText: false,
                                  controller: emailController,
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
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
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
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
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
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start, // Adicionado para alinhar à direita
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
                              SizedBox(height: 20),
                              Visibility(
                                visible: telResidencial,
                                child: Column(
                                  children: [
                                    TextFieldPadrao(
                                      labelText: 'Telefone residêncial',
                                      largura: 0.95,
                                      obscureText: false,
                                      controller: emailController,
                                    ),
                                    SizedBox(height: 20),
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
                                      controller: emailController,
                                    ),
                                    SizedBox(height: 20),
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
                                      controller: emailController,
                                    ),
                                    SizedBox(height: 20),
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
                                      controller: emailController,
                                    ),
                                    SizedBox(height: 20),
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
                                      controller: emailController,
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                              BotaoPrincipal(
                                  largura: 0.95,
                                  labelText: 'Cadastrar Usuário',
                                  onPressed: () {}),
                              SizedBox(
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
          ],
        ),
      ),
    );
  }
}

void onDateSelected(DateTime selectedDate) {
  final dntNascimnetoAtleta = selectedDate;
}
