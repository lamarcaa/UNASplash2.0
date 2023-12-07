import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/Components/botaoVazado.dart';
import 'package:desafio/Components/btnPrincipal.dart';
import 'package:desafio/Pages/cadastraAtleta.dart';
import 'package:desafio/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      home: PerfilTreinoAtleta(
        idAtleta: 'Usuário teste',
        nome: 'Usuário teste',
        estilo: 'Atleta',
        freqInicial: 'teste@gmail.com',
        freqFinal: 'teste@gmail.com',
        dtnAvaliacao: '',
      ),
    ),
  );
}

class PerfilTreinoAtleta extends StatelessWidget {
  final String idAtleta;
  final String nome;
  final String estilo;
  final String freqInicial;
  final String? status;
  final String freqFinal;
  final String dtnAvaliacao;

  const PerfilTreinoAtleta({
    Key? key,
    required this.idAtleta,
    required this.nome,
    required this.estilo,
    required this.freqInicial,
    this.status,
    required this.freqFinal,
    required this.dtnAvaliacao,
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
                  'Treino Avaliativo',
                  style: GoogleFonts.lexendDeca(
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
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
                              const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 12),
                          child: Text(
                            'Informações do Treino',
                            style: GoogleFonts.lexendDeca(
                              color: const Color(0xFF101213),
                              fontSize: 22,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 10, 0, 8),
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
                                    'Nome: $nome',
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
                              const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 16, 8),
                                child: Icon(
                                  Icons.format_list_bulleted_rounded,
                                  color: Color(0xFF57636C),
                                  size: 24,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 12, 0),
                                  child: Text(
                                    estilo,
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
                              const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 16, 8),
                                child: Icon(
                                  Icons.date_range,
                                  color: Color(0xFF57636C),
                                  size: 24,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 12, 0),
                                  child: Text(
                                    dtnAvaliacao,
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
                              const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 16, 8),
                                child: Icon(
                                  Icons.monitor_heart_rounded,
                                  color: Color(0xFF57636C),
                                  size: 24,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 12, 0),
                                  child: Text(
                                    freqInicial,
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
                              const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 16, 8),
                                child: Icon(
                                  Icons.monitor_heart_rounded,
                                  color: Color(0xFF57636C),
                                  size: 24,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 12, 0),
                                  child: Text(
                                    freqFinal,
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              5, 20, 20, 12),
                          child: Text(
                            'Voltas',
                            style: GoogleFonts.lexendDeca(
                              color: const Color(0xFF101213),
                              fontSize: 22,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                        StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('voltas_treino')
                              .doc(idAtleta)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data == null) {
                              return Text('No data available');
                            } else {
                              List<Map<String, dynamic>> voltas =
                                  List<Map<String, dynamic>>.from(
                                      snapshot.data!.get('voltas') ?? []);

                              return Column(
                                children: voltas
                                    .map(
                                      (volta) => Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 0, 20),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.flag_sharp,
                                              color: Color(0xFF57636C),
                                              size: 24,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Volta nº ${volta['numeroVolta']}: ${volta['tempo']}',
                                              style: GoogleFonts.lexendDeca(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: const Color.fromARGB(
                                                    255, 44, 44, 44),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              );
                            }
                          },
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
    );
  }
}
