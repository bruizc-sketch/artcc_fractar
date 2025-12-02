class Producto {
  final String id;
  final String nombre;
  final String proveedor; 
  final String categoria; 
  final int stock;        
  final double precio;
  final String userId;    

  Producto({
    required this.id,
    required this.nombre,
    required this.proveedor,
    required this.categoria,
    required this.stock,
    required this.precio,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'proveedor': proveedor,
      'categoria': categoria,
      'stock': stock,
      'precio': precio,
      'userId': userId,
    };
  }

  factory Producto.fromMap(Map<String, dynamic> map, String id) {
    return Producto(
      id: id,
      nombre: map['nombre'] ?? '',
      proveedor: map['proveedor'] ?? '',
      categoria: map['categoria'] ?? 'General',
      stock: map['stock'] ?? 0,
      precio: (map['precio'] ?? 0).toDouble(),
      userId: map['userId'] ?? '',
    );
  }
}