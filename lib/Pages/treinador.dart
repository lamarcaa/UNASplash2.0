import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/Components/appBar.dart';
import 'package:desafio/Components/cardPerfil.dart';
import 'package:desafio/Pages/cadastraUser.dart';
import 'package:desafio/Pages/cronometro.dart';
import 'package:desafio/Pages/perfil.dart';
import 'package:desafio/Pages/perfilAtleta.dart';
import 'package:desafio/Pages/perfilTreino.dart';
import 'package:desafio/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    home: TreinadorPage(),
  ));
}

class TreinadorPage extends StatefulWidget {
  const TreinadorPage({Key? key}) : super(key: key);

  @override
  _TreinadorPageState createState() => _TreinadorPageState();
}

class _TreinadorPageState extends State<TreinadorPage>
    with AutomaticKeepAliveClientMixin {
  late Future<List<Map<String, dynamic>>> users;
  late Future<List<Map<String, dynamic>>> treinos;

  @override
  void initState() {
    super.initState();
    users = loadUsers();
    treinos = loadTreinos();
  }

  Future<List<Map<String, dynamic>>> loadUsers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('cadastro_finalizado')
              .where('tipo_usuario', isEqualTo: 'atleta')
              .get();

      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Erro ao carregar usuários: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> loadTreinos() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('info_treino').get();

      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Erro ao carregar treinos: $e');
      rethrow;
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black12,
        body: Column(
          children: [
            const AppBarPersonalizada(
              nome: 'Treinador',
              titulo:
                  'Gerencie os treinos valiativos, faça a análise comparativa e cadastre usuários!',
            ),
            Container(
              color: Colors.white,
              child: const TabBar(
                tabs: [
                  Tab(
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.pool_outlined),
                        SizedBox(width: 8),
                        Text('Treinos'),
                      ],
                    ),
                  ),
                  Tab(
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.analytics_outlined),
                        SizedBox(width: 8),
                        Text('Análises'),
                      ],
                    ),
                  ),
                  Tab(
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person),
                        SizedBox(width: 8),
                        Text('Usuários'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                children: [
                  _buildUserTreino(),
                  const Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CardPerfil(
                        nome: 'Gabriel Lamarca Galdino da Silva',
                        tipoUsuario: 'Clique para analisar',
                      ),
                    ],
                  ),
                  _buildUserList(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Cronometro(),
              ),
            );
          },
          backgroundColor: const Color(0xFF4B39EF),
          child: const Icon(
            Icons.timer,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return FutureBuilder(
      future: users,
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              final usuario = snapshot.data![index];
              return InkWell(
                child: CardPerfil(
                    nome: usuario['nome'] ?? '',
                    tipoUsuario: usuario['tipo_usuario'] ?? '',
                    status: usuario['status']),
                onTap: () {
                  print(usuario);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PerfilAtleta(
                        nome: usuario['nome'] ?? '',
                        tipoUsuario: usuario['tipo_usuario'] ?? '',
                        userEmail: usuario['email'],
                        status: usuario['status'],
                        rg: usuario['rg'] ?? 'Informação não cadastrada',
                        cpf: usuario['cpf'] ?? '',
                        nacionalidade: usuario['nacionalidade'] ?? 'teste',
                        naturalidade: usuario['naturalidade'] ?? '',
                        telPessoal: usuario['telPessoa'] ?? '',
                        telEmergencia: usuario['telEmergencia'] ?? '',
                        cep: usuario['cep'] ?? '',
                        rua: usuario['rua'] ?? '',
                        bairro: usuario['bairro'] ?? '',
                        cidade: usuario['cidade'] ?? '',
                        estado: usuario['estado'] ?? '',
                        opSexo: usuario['sexo'] ?? '',
                        dataNascimento: (usuario['data_de_nascimento']
                                is Timestamp)
                            ? DateFormat('dd/MM/yyyy').format(
                                (usuario['data_de_nascimento'] as Timestamp)
                                    .toDate())
                            : (usuario['data_de_nascimento'] as String? ??
                                'Informação não cadastrada'),
                        nomeMae: usuario['nomeMae'] ?? '',
                        nomePai: usuario['nomePai'] ?? '',
                        clubeOrigem: usuario['clubeOrigem'] ?? '',
                        localTrabalho: usuario['localTrabalho'] ?? '',
                        convenio: usuario['convenio'] ?? '',
                        alergia: usuario['alergia'] ?? '',
                        telResidencial: usuario['telResidencial'] ?? '',
                        telTrabalho: usuario['telTrabalho'] ?? '',
                        telMae: usuario['telMae'] ?? '',
                        telPai: usuario['telPai'] ?? '',
                        telOutro: usuario['telOutro'] ?? '',
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildUserTreino() {
    return FutureBuilder(
      future: treinos,
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              final usuario = snapshot.data![index];
              return InkWell(
                child: CardPerfil(
                    nome: usuario['nome'] ?? '',
                    tipoUsuario: "Avaliação feita em " +
                        ((usuario['dtn_avaliacao'] as Timestamp?)?.toDate() !=
                                null
                            ? DateFormat('dd/MM/yyyy').format(
                                (usuario['dtn_avaliacao'] as Timestamp?)!
                                    .toDate()!)
                            : ''),
                    status: usuario['status']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PerfilTreinoAtleta(
                        idAtleta: usuario['idAtleta'],
                        nome: '${usuario['nome']}',
                        estilo: 'Estilo da Avaliação: ${usuario['estilo']}',
                        freqInicial:
                            'Frequência Cardíaca Inicial: ${usuario['frequencia_cardiaca_inicial']}',
                        freqFinal:
                            'Frequência Cardíaca Final: ${usuario['frequencia_cardiaca_final']}',
                        dtnAvaliacao: 'Data da avaliação: ' +
                            ((usuario['dtn_avaliacao'] as Timestamp?)
                                        ?.toDate() !=
                                    null
                                ? DateFormat('dd/MM/yyyy').format(
                                    (usuario['dtn_avaliacao'] as Timestamp?)!
                                        .toDate()!)
                                : ''),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
