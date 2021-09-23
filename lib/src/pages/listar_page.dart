import 'package:flutter/material.dart';
import 'package:ingreso/src/models/ingreso.dart';
import 'package:ingreso/src/services/ingresar_service.dart';
import 'package:provider/provider.dart';

class ListarPage extends StatelessWidget {
  const ListarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headlines = Provider.of<IngresarService>(context).headlines;
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial Ingreso'),
        centerTitle: true,
      ),
      body: _ListarIngreso(headlines),
    );
  }
}

class _ListarIngreso extends StatelessWidget {
  final List<Ingreso> ingreso;
  const _ListarIngreso(this.ingreso);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.ingreso.length,
      itemBuilder: (BuildContext context, int index) {
        return _Ingreso(
          ingreso: this.ingreso[index],
          index: index,
        );
      },
    );
  }
}

class _Ingreso extends StatelessWidget {
  final Ingreso ingreso;
  final int index;

  const _Ingreso({
    required this.ingreso,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text('${ingreso.tipo} - ${ingreso.placa} '),
        subtitle: Text('${ingreso.fecha}'),
      ),
    );
  }
}
