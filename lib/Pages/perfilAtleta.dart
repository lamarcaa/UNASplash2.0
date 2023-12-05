import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/Components/botaoVazado.dart';
import 'package:desafio/Components/btnPrincipal.dart';
import 'package:desafio/Pages/cadastraAtleta.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void main() {
  runApp(PerfilAtleta(
      nome: 'Usuário teste',
      tipoUsuario: 'Atleta',
      userEmail: 'teste@gmail.com',
      rg: 'teste@gmail.com'));
}

class PerfilAtleta extends StatelessWidget {
  final String nome;
  final String tipoUsuario;
  final String userEmail;
  final String? status;
  final String rg;

  const PerfilAtleta({
    Key? key,
    required this.nome,
    required this.tipoUsuario,
    required this.userEmail,
    this.status,
    required this.rg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xff6750A4),
      ),
      home: Scaffold(
        body: Container(
          color: const Color(0xFFB5B5B5),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar.large(
                backgroundColor: const Color(0xFFB5B5B5),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  'Perfil do Atleta',
                  style: GoogleFonts.lexendDeca(
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  width: 140,
                  child: Stack(
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0.00, 0.00),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                'https://i.imgur.com/F43Zm3W.png',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    nome,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lexendDeca(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(bottom: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 2,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x33000000),
                        offset: Offset(0, -1),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                          child: Text(
                            'Informações',
                            style: GoogleFonts.lexendDeca(
                              color: const Color(0xFF101213),
                              fontSize: 22,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 16, 8),
                                child: Icon(
                                  Icons.person,
                                  color: Color(0xFF57636C),
                                  size: 24,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 12, 0),
                                  child: Text(
                                    nome,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          const Color.fromARGB(255, 44, 44, 44),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 16, 8),
                                child: Icon(
                                  Icons.info,
                                  color: Color(0xFF57636C),
                                  size: 24,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 12, 0),
                                  child: Text(
                                    tipoUsuario,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          const Color.fromARGB(255, 44, 44, 44),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 16, 8),
                                child: Icon(
                                  Icons.email,
                                  color: Color(0xFF57636C),
                                  size: 24,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 12, 0),
                                  child: Text(
                                    userEmail,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          const Color.fromARGB(255, 44, 44, 44),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 16, 8),
                                child: Icon(
                                  Icons.info_outline,
                                  color: Color(0xFF57636C),
                                  size: 24,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 12, 0),
                                  child: Text(
                                    rg,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          const Color.fromARGB(255, 44, 44, 44),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: status == "incompleto",
                          child: BotaoPrincipal(
                            largura: 0.95,
                            labelText: 'Finalizar Cadastro',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CadastraAtleta(
                                    titulo: 'Cadastre',
                                    texto:
                                        'Preencha o formulário para cadastrar todas as informações do atleta',
                                    nomeUsuario: nome,
                                    emailUsuario: userEmail,
                                    status: 'ativo',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Visibility(
                          visible: status == "pendente",
                          child: BotaoPrincipal(
                            largura: 0.95,
                            labelText: 'Valida Usuário',
                            onPressed: () {
                              mostrarBottomSheet(context);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void mostrarBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                'Deseja validar as informações do Atleta?',
              ),
              SizedBox(
                height: 20,
              ),
              BotaoPrincipal(
                largura: 1,
                labelText: 'Sim',
                onPressed: () {
                  validarAtleta(context, userEmail);
                },
              ),
              SizedBox(
                height: 20,
              ),
              BotaoVazado(
                largura: 1,
                labelText: 'Não',
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}

Future<void> validarAtleta(BuildContext context, String email) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('cadastro_finalizado')
      .where('email', isEqualTo: email)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    try {
      String documentId = querySnapshot.docs[0].id;
      await FirebaseFirestore.instance
          .collection('cadastro_finalizado')
          .doc(documentId)
          .update({
        'status': 'ativo',
      });

      Navigator.pop(context);

      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(
          message: 'Atleta validado com sucesso!',
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
