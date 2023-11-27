import 'dart:async';
import 'package:desafio/Components/btnPrincipal.dart';
import 'package:desafio/Components/dataPicker.dart';
import 'package:desafio/Components/dropdown.dart';
import 'package:desafio/Components/textField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cronometro extends StatefulWidget {
  const Cronometro({super.key});

  @override
  State<Cronometro> createState() => _CronometroState();
}

void main() {
  runApp(const MaterialApp(
    home: Cronometro(),
  ));
}

class _CronometroState extends State<Cronometro> {
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
        digitoMili = (milisegundos >= 10) ? "$milisegundos" : "0$milisegundos";
        digitoSeg = (segundos >= 10) ? "$segundos" : "0$segundos";
        digitoMin = (minutos >= 10) ? "$minutos" : "0$minutos";
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      infoIniciais();
    });
  }

  void infoIniciais() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
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
        );
      },
    );
  }

  void trataCampos() {
    if (FreqCardiacaInicial.text.isEmpty) {
      // showTopSnackBar(
      //   Overlay.of(context),
      //   CustomSnackBar.info(
      //     message: "Digite a frequência cardíaca!",
      //   ),
      // );
    } else {
      Navigator.pop(context);
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
                  [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 30),
                      child: Text(
                        'Cronometre as voltas do treino avaliativo',
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
                      SingleChildScrollView(
                        child: Container(
                          child: Form(
                            child: Column(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 70,
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
        return Container(
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
                DataPicker(onDateSelected: onDateSelected),
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
                  onPressed: () {},
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void onDateSelected(DateTime selectedDate) {
    print("Data selecionada: $selectedDate");
  }
}
