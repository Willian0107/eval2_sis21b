import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa el paquete Firestore
import 'pages/lista_registros.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crud Firebase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Backend Cloud Firestore'),
    );
  }
}

class MyForm extends StatelessWidget {
  final TextEditingController idController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();

  void _guardarDatos() {
    FirebaseFirestore.instance.collection('tb-categoria').add({
      'id': idController.text,
      'estado': estadoController.text,
      'nombre': nombreController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
          MediaQuery.of(context).size.width * 0.2), // Agrega un padding del 20%
      child: Column(
        children: [
          TextFormField(
            controller: idController,
            decoration: InputDecoration(labelText: 'ID'),
          ),
          TextFormField(
            controller: estadoController,
            decoration: InputDecoration(labelText: 'Estado'),
          ),
          TextFormField(
            controller: nombreController,
            decoration: InputDecoration(labelText: 'Nombre'),
          ),
          ElevatedButton(
            onPressed: _guardarDatos,
            child: Text('Guardar'),
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyForm(),
            SizedBox(height: 20),
            Expanded(
              child: ListaRegistros(), // Usa la vista de los registros aquí
            ),
          ],
        ),
      ),
    );
  }
}
