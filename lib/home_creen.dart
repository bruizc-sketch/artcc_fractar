import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firestore_service.dart';
import 'producto.dart';
import 'producto_form_screen.dart';
import 'login_screen.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final firestore = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Inventario ArtCC Fractar'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await auth.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(Icons.add, color: Colors.black),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductoFormScreen())),
      ),
      body: StreamBuilder<List<Producto>>(
        stream: firestore.getProductos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || snapshot.data!.isEmpty) return Center(child: Text('No hay stock registrado.'));

          final productos = snapshot.data!;

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) {
              final prod = productos[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple[100],
                    child: Text(prod.categoria[0], style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                  ),
                  title: Text(prod.nombre, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Stock: ${prod.stock} | Proveedor: ${prod.proveedor}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductoFormScreen(producto: prod))),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => firestore.deleteProducto(prod.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}