import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/Components/botaoVazado.dart';
import 'package:desafio/Components/btnPrincipal.dart';
import 'package:desafio/Components/textField.dart';
import 'package:desafio/Pages/administrador.dart';
import 'package:desafio/Pages/atleta.dart';
import 'package:desafio/Pages/atletaPendente.dart';
import 'package:desafio/Pages/cadastraAtleta.dart';
import 'package:desafio/Pages/primeiroAcesso.dart';
import 'package:desafio/Pages/treinador.dart';
import 'package:desafio/firebase_options.dart';
import 'package:desafio/model/armazenaId.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                FirebaseIdProvider()), 
      ],
      child: MaterialApp(
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

FirebaseFirestore db = FirebaseFirestore.instance;

TextEditingController emailRecuperaController = TextEditingController();

TextEditingController rgRecuperaController = TextEditingController();

TextEditingController cpfRecuperaController = TextEditingController();

TextEditingController emailController = TextEditingController();

TextEditingController senhaController = TextEditingController();

TextEditingController senha2Controller = TextEditingController();

bool btnRecupera1 = false;
bool btnRecupera2 = false;

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    initState() {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          verificaLogin(_auth.currentUser!.uid, context);
        }
      });
    }

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
                        verificaLoginUsuario(context, emailController.text,
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

  verificaLogin(String userId, BuildContext context) {
    final docRef = db.collection("cadastro_finalizado").doc(userId);
    docRef.get().then((DocumentSnapshot documentSnapshot) {
      final Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      final String tipo = data["Tipo"];
      switch (tipo) {
        case 'Administrador':
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const AdmPage()),
              (route) => false);
          break;
        case 'Treinador':
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const TreinadorPage()),
              (route) => false);

          break;
        case 'Atleta':
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const AtletaPage()),
              (route) => false);
          break;
      }
    });
  }

  Future<void> verificaLoginUsuario(
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
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot userSnapshot = querySnapshot.docs.first;
      String idUsuario = userSnapshot.id;

      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      String emailUsuario = userData['email'] ?? '';
      String statusUsuario = userData['status'] ?? '';
      String tipoUsuario = userData['tipo_usuario'] ?? '';
      String nomeUsuario = userData['nome'] ?? '';

      print('ID do usuário: $idUsuario');
      armazenarId(idUsuario, context);

      if (emailUsuario == email) {
        switch (statusUsuario) {
          case 'aguardando':
            mudaStatus(emailUsuario, senha, context);
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
        print('Email e senha não bateram');
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

    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      redireciona(tipoUsuario, context);
    } catch (e) {
      print('Usuário não encontrado, criando novo usuário: $e');

      try {
        UserCredential newUserCredential =
            await auth.createUserWithEmailAndPassword(
          email: email,
          password: senha,
        );

        // Novo usuário criado, redireciona
        redireciona(tipoUsuario, context);
      } catch (e) {
        print('Erro ao criar usuário: $e');
      }
    }
  }

  Future<void> cadastraNovaSenha(BuildContext context, String senha,
      String confirmaSenha, String email) async {
    print(senha);
    print(confirmaSenha);
    print(email);

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cadastro_finalizado')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        print('achou');
        DocumentSnapshot userSnapshot = querySnapshot.docs.first;

        await FirebaseFirestore.instance
            .collection('cadastro_finalizado')
            .doc(userSnapshot.id);

        Navigator.pop(context);
        Navigator.pop(context);

        final FirebaseAuth auth = FirebaseAuth.instance;

        final User? user = auth.currentUser;

        if (user != null) {
          try {
            // Update the password
            await user.updatePassword(senha);
            print('Password updated successfully');
          } catch (e) {
            print('Error updating password: $e');
          }
        } else {
          print('User is null');
        }

        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message: 'Senha alterada com sucesso',
          ),
        );

        print('Senha atualizada com sucesso!');
      } else {
        print('Nenhum usuário encontrado.');
      }
    } catch (e) {
      print('Erro ao executar a consulta: $e');
    }
  }

  void mostrarBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SingleChildScrollView(
          child: Container(
            color: Colors.grey,
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  'Digite seu email:',
                  style: GoogleFonts.lexendDeca(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldPadrao(
                  labelText: 'Email',
                  largura: 0.85,
                  obscureText: false,
                  controller: emailRecuperaController,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                BotaoPrincipal(
                  largura: 0.85,
                  labelText: 'Recuperar Senha',
                  onPressed: () {
                    resetarSenha(
                      context,
                      emailRecuperaController.text,
                      cpfRecuperaController.text,
                      rgRecuperaController.text,
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> resetarSenha(
      BuildContext context, String email, String cpf, String rg) async {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  void armazenarId(String id, BuildContext context) {
    print('chegou 2');
    final FirebaseIdProvider firebaseIdProvider =
        Provider.of<FirebaseIdProvider>(context, listen: false);

    firebaseIdProvider.setFirebaseId(id);
  }
}
