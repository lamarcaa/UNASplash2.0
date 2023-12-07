import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/Components/botaoVazado.dart';
import 'package:desafio/Components/btnPrincipal.dart';
import 'package:desafio/Pages/cadastraAtleta.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void main() {
  runApp(
    const PerfilAtleta(
      nome: 'Usuário teste',
      tipoUsuario: 'Atleta',
      userEmail: 'teste@gmail.com',
      status: 'teste',
      rg: 'RG do Atleta',
      cpf: 'CPF do Atleta',
      nacionalidade: 'Nacionalidade do Atleta',
      naturalidade: 'Naturalidade do Atleta',
      telPessoal: 'Telefone de Emergência do Atleta',

      telEmergencia: 'Telefone de Emergência do Atleta',
      cep: 'CEP do Atleta',
      rua: 'Rua do Atleta',
      bairro: 'Bairro do Atleta',
      cidade: 'Cidade do Atleta',
      estado: 'Estado do Atleta',
      // opcionais
      nomeMae: 'Nome da Mãe do Atleta',
      nomePai: 'Nome do Pai do Atleta',
      clubeOrigem: 'Clube de Origem do Atleta',
      localTrabalho: 'Local de Trabalho do Atleta',
      convenio: 'Convênio do Atleta',
      alergia: false,
      telResidencial: 'Telefone Residencial do Atleta',
      telTrabalho: 'Telefone do Trabalho do Atleta',
      telMae: 'Telefone da Mãe do Atleta',
      telPai: 'Telefone do Pai do Atleta',
      telOutro: 'Outro Telefone do Atleta',
      dataNascimento: null,
      opSexo: '',
    ),
  );
}

class PerfilAtleta extends StatelessWidget {
  final String nome;
  final String tipoUsuario;
  final String userEmail;
  final String? status;
  final String rg;
  final String cpf;
  final String nacionalidade;
  final String naturalidade;
  final String telPessoal;

  final String telEmergencia;
  final String cep;
  final String rua;
  final String bairro;
  final String cidade;
  final String estado;
  // opcionais
  final String? nomeMae;
  final String? nomePai;
  final String? clubeOrigem;
  final String? localTrabalho;
  final String? convenio;
  final bool? alergia;
  final String? telResidencial;
  final String? telTrabalho;
  final String? telMae;
  final String? telPai;
  final String? telOutro;
  final String? dataNascimento;
  final String? opSexo;

  const PerfilAtleta({
    Key? key,
    required this.nome,
    required this.tipoUsuario,
    required this.userEmail,
    this.status,
    required this.rg,
    required this.cpf,
    required this.nacionalidade,
    required this.naturalidade,
    required this.telPessoal,
    required this.telEmergencia,
    required this.cep,
    required this.rua,
    required this.bairro,
    required this.cidade,
    required this.estado,
    // opcionais
    this.nomeMae,
    this.nomePai,
    this.clubeOrigem,
    this.localTrabalho,
    this.convenio,
    this.alergia,
    this.telResidencial,
    this.telTrabalho,
    this.telMae,
    this.telPai,
    this.telOutro,
    this.dataNascimento,
    this.opSexo,
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 20, 0, 20),
                          child: Text(
                            'Informações Pessoais',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Nome completo: $nome',
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Sexo: $opSexo',
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Data de Nascimento: $dataNascimento',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Tipo de usuário: $tipoUsuario',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'E-mail: $userEmail',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'RG: $rg',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'CPF: $cpf',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Nacionalidade: $nacionalidade',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Naturalidade: $naturalidade',
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
                              0, 20, 0, 20),
                          child: Text(
                            'Contato',
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Telefone de Pessoal: $telPessoal',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Telefone de Emergência: $telEmergencia',
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
                              0, 20, 0, 20),
                          child: Text(
                            'Endereço',
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'CEP: $cep',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Rua: $rua',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Bairro: $bairro',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Cidade: $cidade',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Estado: $estado',
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
                              0, 20, 0, 20),
                          child: Text(
                            'Informações Opcionais',
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Nome da Mãe: $nomeMae',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Nome da Pai: $nomePai',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Clube de Origem: $clubeOrigem',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Local de Trabalho: $localTrabalho',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Convênio Médico : $convenio',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Atleta tem alergia a medicamentos? $alergia',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Telefone Residencial $telResidencial',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Telefone de Trabalho $telTrabalho',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Telefone da mãe: $telMae',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Telefone do pai: $telPai',
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 8, 16, 8),
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
                                    'Outro telefone: $telOutro',
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
              const Text(
                'Deseja validar as informações do Atleta?',
              ),
              const SizedBox(
                height: 20,
              ),
              BotaoPrincipal(
                largura: 1,
                labelText: 'Sim',
                onPressed: () {
                  validarAtleta(context, userEmail);
                },
              ),
              const SizedBox(
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
