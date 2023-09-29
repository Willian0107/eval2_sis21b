import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListaRegistros extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('tb-categoria').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(); // Muestra un indicador de carga mientras se cargan los datos
        }

        var registros = snapshot.data!.docs;

        return ListView.builder(
          itemCount: registros.length,
          itemBuilder: (context, index) {
            var registro = registros[index].data() as Map<String, dynamic>;
            return ListTile(
              title: Text('ID: ${registro['id']}'),
              subtitle: Text(
                  'Estado: ${registro['estado']}, Nombre: ${registro['nombre']}'),
            );
          },
        );
      },
    );
  }
}
