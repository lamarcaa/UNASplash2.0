import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/Components/appBar.dart';
import 'package:desafio/Components/cardPerfil.dart';
import 'package:desafio/Pages/cadastraUser.dart';
import 'package:desafio/Pages/cronometro.dart';
import 'package:desafio/Pages/perfil.dart';
import 'package:desafio/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: TreinadorPage(),
  ));
}

class TreinadorPage extends StatefulWidget {
  @override
  _TreinadorPageState createState() => _TreinadorPageState();
}

class _TreinadorPageState extends State<TreinadorPage>
    with AutomaticKeepAliveClientMixin {
  Future<List<Map<String, dynamic>>> loadUsers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('usuarios').get();

      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Erro ao carregar usuários: $e');
      throw e;
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
                    icon: const Row(
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
                  const Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CardPerfil(
                        nome: 'Gabriel Lamarca Galdino da Silva',
                        tipoUsuario: 'Treino realizado em 19/11/2023',
                      ),
                    ],
                  ),
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
        floatingActionButton: SpeedDial(
          backgroundColor: const Color(0xFF4B39EF),
          icon: Icons.menu,
          children: [
            SpeedDialChild(
                child: const Icon(Icons.person_add),
                label: 'Cadastrar Atleta',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CadastraUser()),
                  );
                }),
            SpeedDialChild(
                child: const Icon(Icons.timer),
                label: 'Cronômetro',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Cronometro()),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return FutureBuilder(
      future: loadUsers(),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              final usuario = snapshot.data![index];
              return InkWell(
                child: CardPerfil(
                    nome: usuario['nome'] ?? '',
                    tipoUsuario: usuario['tipoUsuario'] ?? '',
                    status: usuario['status']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Perfil(
                        nome: usuario['nome'] ?? '',
                        tipoUsuario: usuario['tipoUsuario'] ?? '',
                        userEmail: 'userEmail',
                        status: usuario['status'],
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
