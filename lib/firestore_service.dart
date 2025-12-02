import 'package:cloud_firestore/cloud_firestore.dart';
import 'producto.dart';

class FirestoreService {
  final CollectionReference _productosRef =
      FirebaseFirestore.instance.collection('productos');

  Future<void> addProducto(Producto producto) {
    return _productosRef.add(producto.toMap());
  }

  Stream<List<Producto>> getProductos() {
    return _productosRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Producto.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    });
  }

  Future<void> updateProducto(Producto producto) {
    return _productosRef.doc(producto.id).update(producto.toMap());
  }

  Future<void> deleteProducto(String id) {
    return _productosRef.doc(id).delete();
  }
}