import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'producto.dart';
import 'firestore_service.dart';

class ProductoFormScreen extends StatefulWidget {
  final Producto? producto;
  const ProductoFormScreen({super.key, this.producto});

  @override
  State<ProductoFormScreen> createState() => _ProductoFormScreenState();
}

class _ProductoFormScreenState extends State<ProductoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _proveedorCtrl = TextEditingController();
  final _stockCtrl = TextEditingController();
  final _precioCtrl = TextEditingController();
  
  String _categoria = 'Ciencias'; // REQ_03
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.producto != null) {
      _nombreCtrl.text = widget.producto!.nombre;
      _proveedorCtrl.text = widget.producto!.proveedor;
      _stockCtrl.text = widget.producto!.stock.toString();
      _precioCtrl.text = widget.producto!.precio.toString();
      _categoria = widget.producto!.categoria;
    }
  }

  void _guardar() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final user = FirebaseAuth.instance.currentUser!;

      final nuevoProducto = Producto(
        id: widget.producto?.id ?? '',
        nombre: _nombreCtrl.text,
        proveedor: _proveedorCtrl.text,
        categoria: _categoria,
        stock: int.tryParse(_stockCtrl.text) ?? 0,
        precio: double.tryParse(_precioCtrl.text) ?? 0.0,
        userId: user.uid,
      );

      final service = FirestoreService();
      if (widget.producto == null) {
        await service.addProducto(nuevoProducto);
      } else {
        await service.updateProducto(nuevoProducto);
      }
      
      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.producto == null ? 'Nuevo Material' : 'Editar Stock'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreCtrl,
                decoration: InputDecoration(labelText: 'Nombre del Kit/Material', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _proveedorCtrl,
                decoration: InputDecoration(labelText: 'Proveedor', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _stockCtrl,
                      decoration: InputDecoration(labelText: 'Stock (Cant.)', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (v) => v!.isEmpty ? 'Requerido' : null,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _precioCtrl,
                      decoration: InputDecoration(labelText: 'Precio', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              DropdownButtonFormField(
                value: _categoria,
                decoration: InputDecoration(labelText: 'Área (Categoría)', border: OutlineInputBorder()),
                items: ['Ciencias', 'Matemáticas', 'Arte', 'Tecnología'] // REQ_03
                    .map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v) => setState(() => _categoria = v.toString()),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: _isLoading ? null : _guardar,
                child: _isLoading ? CircularProgressIndicator(color: Colors.white) : Text('GUARDAR INVENTARIO'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
