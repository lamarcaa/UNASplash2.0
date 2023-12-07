import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/Components/botaoVazado.dart';
import 'package:desafio/Components/btnPrincipal.dart';
import 'package:desafio/Components/dataPicker.dart';
import 'package:desafio/Components/dropdown.dart';
import 'package:desafio/Components/textField.dart';
import 'package:desafio/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Cronometro extends StatefulWidget {
  const Cronometro({super.key});

  @override
  State<Cronometro> createState() => _CronometroState();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(home: Cronometro()));
}

class _CronometroState extends State<Cronometro> {
  late Future<List<String>> nomesAtletasFuture;
  String? atletaSelecionado;
  String atletaDoTreino = '';
  final TextEditingController freqInicialController = TextEditingController();
  final TextEditingController freqFinalController = TextEditingController();
  int milisegundos = 0;
  int segundos = 0;
  int minutos = 0;
  String guardaMili = "00";
  String guardaSeg = "00";
  String guardaMin = "00";
  Timer? timer;
  bool started = false;
  List<String> voltas = [];
  List<String> estiloTreino = <String>[
    'Crawl',
    'Costas',
    'Peito',
    'Borboleta',
    'Medley'
  ];
  String dropdownValue = 'Crawl';
  String digitoMili = "00";
  String digitoSeg = "00";
  String digitoMin = "00";
  IconData iconeBotao = Icons.play_arrow;
  final FreqCardiacaInicial = TextEditingController();
  final FreqCardiacaFinal = TextEditingController();

  bool btnData1 = false;

  DateTime? dataSelecionada;

  void paraCronometro() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void resetaCronometro() {
    timer!.cancel();
    setState(() {
      milisegundos = 0;
      segundos = 0;
      minutos = 0;

      guardaMili = "00";
      guardaSeg = "00";
      guardaMin = "00";

      digitoMili = "00";
      digitoSeg = "00";
      digitoMin = "00";

      voltas.clear();

      started = false;
    });
  }

  void salvaVoltas() {
    String volta = "$digitoMin:$digitoSeg:$digitoMili";
    setState(() {
      voltas.add(volta);
    });
  }

  void iniciaCronometro() {
    if (freqInicialController.text.isEmpty) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Você não digitou a frequencia cardíaca inicial',
        ),
      );
      exit(0);
    } else {
      started = true;
      timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        setState(() {
          milisegundos++;
          if (milisegundos >= 100) {
            milisegundos = 0;
            segundos++;
            if (segundos >= 60) {
              segundos = 0;
              minutos++;
            }
          }
          digitoMili =
              (milisegundos >= 10) ? "$milisegundos" : "0$milisegundos";
          digitoSeg = (segundos >= 10) ? "$segundos" : "0$segundos";
          digitoMin = (minutos >= 10) ? "$minutos" : "0$minutos";
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    nomesAtletasFuture = consultarAtletas();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      infoIniciais();
    });
  }

  void infoIniciais() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  FutureBuilder<List<String>>(
                    future: nomesAtletasFuture,
                    builder: (context, snapshot) {
                      List<String> nomesAtletas = snapshot.data ?? [];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FutureBuilder<List<String>>(
                            future: nomesAtletasFuture,
                            builder: (context, snapshot) {
                              List<String> nomesAtletas = snapshot.data ?? [];
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DropdownButton<String?>(
                                    value: atletaSelecionado,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        atletaSelecionado = newValue;
                                      });
                                    },
                                    items: [
                                      DropdownMenuItem<String?>(
                                        value: atletaSelecionado,
                                        child: Text('Selecione um atleta'),
                                      ),
                                      ...nomesAtletas
                                          .map((String nome) =>
                                              DropdownMenuItem<String?>(
                                                value: nome,
                                                child: Text(nome),
                                              ))
                                          .toList(),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                ],
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  Row(
                    children: [
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
                              text: 'Que estilo será avaliado?',
                              style: GoogleFonts.lexendDeca(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownPadrao(
                    options: estiloTreino,
                    value: 'Crawl',
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value ?? '';
                      });
                    },
                    labelText: '',
                    largura: 0.95,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: RichText(
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
                                    'Qual a frquência cardíaca inicial do atleta?',
                                style: GoogleFonts.lexendDeca(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFieldPadrao(
                    labelText: 'Frequência cardíaca inicial',
                    largura: 0.95,
                    controller: freqInicialController,
                    obscureText: false,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BotaoPrincipal(
                    largura: 0.95,
                    labelText: 'Iniciar Treino',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> trataCampos(
    String? usuario,
    String? estilo,
    String? freqInicial,
    DateTime dataAvaliacao,
    String? freqFinal,
    BuildContext context,
  ) async {
    print('Usuario: $usuario');
    print('Estilo: $estilo');
    print('Frequencia Inicial: $freqInicial');
    print('Data Avaliacao: $dataAvaliacao');
    print('Frequencia Final: $freqFinal');

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('cadastro_finalizado')
        .where('nome', isEqualTo: usuario)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot userSnapshot = querySnapshot.docs.first;
      String idAtleta = userSnapshot.id;

      try {
        await FirebaseFirestore.instance.collection('info_treino').doc().set({
          'idAtleta': idAtleta,
          'nome': usuario,
          'estilo': estilo,
          'frequencia_cardiaca_inicial': freqInicial,
          'dtn_avaliacao': dataAvaliacao,
          'frequencia_cardiaca_final': freqFinal
        });

        cadastraVoltas(idAtleta, context);
      } catch (e) {
        print(e);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text("Nome ou email inválidos"),
        //   ),
        // );
      }
    }
  }

  Future<void> cadastraVoltas(String idAtleta, BuildContext context) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('info_treino')
          .where('idAtleta', isEqualTo: idAtleta)
          .limit(1) 
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String idInfoTreino = querySnapshot.docs.first.id;

        // Cadastra as voltas no documento voltas_treino do atleta
        await FirebaseFirestore.instance
            .collection('voltas_treino')
            .doc(idAtleta)
            .set({
          'idAtleta': idAtleta,
          'idInfoTreino': idInfoTreino,
          'voltas': voltas
              .asMap()
              .entries
              .map((entry) => {
                    'numeroVolta': entry.key + 1,
                    'tempo': entry.value,
                  })
              .toList(),
        });

        Navigator.pop(context);
        Navigator.pop(context);

        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message: "Treino Cadastrado",
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<String>> consultarAtletas() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cadastro_finalizado')
          .where('tipo_usuario', isEqualTo: 'atleta')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Mapeia os nomes dos atletas para a lista
        List<String> nomesAtletas = querySnapshot.docs
            .map((DocumentSnapshot document) => document['nome'] as String)
            .toList();

        // Adiciona prints para verificar os nomes dos atletas
        //print('Nomes dos Atletas (lista): $nomesAtletas');
        // for (var nome in nomesAtletas) {
        //   print('Atleta: $nome');
        // }

        return nomesAtletas;
      } else {
        return [];
      }
    } catch (e) {
      print('Erro ao consultar atletas: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    Color cronometroColor =
        (segundos >= 10) ? const Color(0xFFFF1100) : const Color(0xFF02FF0A);
    double progress = (segundos * 1000 + milisegundos) / 10000;
    Color cor = const Color(0xFF4B39EF);

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
                  'Treino Avaliativo',
                  style: GoogleFonts.lexendDeca(
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [],
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
                      SingleChildScrollView(
                        child: Container(
                          child: Form(
                            child: Column(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "$digitoMin:$digitoSeg:$digitoMili",
                                      style: GoogleFonts.lexendDeca(
                                        fontSize: 80,
                                        fontWeight: FontWeight.w300,
                                        color: cronometroColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 70,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: Icon(
                                              iconeBotao,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onTap: () {
                                            if (!started) {
                                              iniciaCronometro();
                                              setState(() {
                                                iconeBotao = Icons.pause;
                                              });
                                            } else {
                                              paraCronometro();
                                              setState(() {
                                                iconeBotao = Icons.play_arrow;
                                              });
                                            }
                                          },
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        InkWell(
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: cor,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: const Icon(
                                              Icons.loop_rounded,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onTap: () {
                                            salvaVoltas();
                                          },
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        InkWell(
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onTap: () {
                                            resetaCronometro();
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 50),
                                    SingleChildScrollView(
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                1,
                                        child: ListView.builder(
                                          itemCount: voltas.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${index + 1}ª volta:',
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 30,
                                                  ),
                                                  Text(
                                                    voltas[index],
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
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
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: cor,
            foregroundColor: Colors.white,
            onPressed: () {
              infoFinais(context);
              voltas.forEach((String volta) {
                print(volta);
              });
            },
            icon: const Icon(Icons.done),
            label: const Text(
              'Finalizar',
              style: TextStyle(color: Colors.white),
            ),
          )),
    );
  }

  void infoFinais(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Row(
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: '1. ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54,
                              ),
                            ),
                            TextSpan(
                              text: 'Data da realização da avaliação',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: Colors.white,
                        child: CalendarDatePicker(
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          onDateChanged: (value) {
                            setState(() {
                              dataSelecionada = value;
                              //print(dataSelecionada);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: '2. ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54,
                              ),
                            ),
                            TextSpan(
                              text: 'Frequência Cardíaca Final',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldPadrao(
                    labelText: 'Frequência cardíaca final',
                    largura: 0.95,
                    controller: freqFinalController,
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BotaoPrincipal(
                    largura: 1,
                    labelText: 'Finalizar Treino Avaliativo',
                    onPressed: () {
                      //cadastraVoltas();
                      trataCampos(
                          atletaSelecionado,
                          dropdownValue,
                          freqInicialController.text,
                          dataSelecionada!,
                          freqFinalController.text,
                          context);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void onDateSelected(DateTime selectedDate) {
    // print("Data selecionada: $selectedDate");
  }
}
