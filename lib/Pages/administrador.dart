import 'package:desafio/Pages/cadastraUser.dart';
import 'package:desafio/Pages/perfil.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/Components/appBar.dart';
import 'package:desafio/Components/cardPerfil.dart';
import 'package:desafio/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AdmPage(),
    );
  }
}

Future<List<Map<String, dynamic>>> getDocuments(String collectionPath) async {
  final collection = FirebaseFirestore.instance.collection(collectionPath);
  final querySnapshot = await collection.orderBy('nome').get();
  final documents = querySnapshot.docs;

  final List<Map<String, dynamic>> dataList = [];
  for (final doc in documents) {
    dataList.add({
      'id': doc.id,
      ...doc.data(),
    });
  }

  return dataList;
}

class AdmPage extends StatefulWidget {
  const AdmPage({super.key});

  @override
  _AdmPageState createState() => _AdmPageState();
}

class _AdmPageState extends State<AdmPage> {
  List<Map<String, dynamic>> infoUsuario = [];
  String userEmail = 'g.lamarca@outlook.com';

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchUserEmail(); // Obtenha o e-mail do usuário autenticado ao inicializar a página
  }

  Future<void> fetchData() async {
    final data = await getDocuments('pre_cadastro');
    data.sort((a, b) => (a['nome'] as String).compareTo(b['nome'] as String));

    setState(() {
      infoUsuario = data;
    });
  }

  // Função para obter o e-mail do usuário autenticado
  Future<void> fetchUserEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userEmail = user.email ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppBarPersonalizada(
              nome: 'Administrador',
              titulo: 'Gerencie e cadastre novos usuários!',
            ),
            const SizedBox(
              height: 10,
            ),
            for (final usuario in infoUsuario)
              InkWell(
                child: CardPerfil(
                  nome: usuario['nome'] ?? '',
                  tipoUsuario: usuario['tipoUsuario'] ?? '',
                  status: '',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Perfil(
                        nome: usuario['nome'] ?? '',
                        tipoUsuario: usuario['tipoUsuario'] ?? '',
                        userEmail: userEmail,
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CadastraUser()),
          );
        },
        backgroundColor: const Color(0xFF4B39EF),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
