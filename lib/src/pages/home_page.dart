import 'package:flutter/material.dart';
import 'package:ingreso/src/providers/search_form_provider.dart';
import 'package:ingreso/src/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 20.0,
          ),
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Text(
                  'CRITERIOS DE BUSQUEDA',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            IconButton(
              icon: const Icon(Icons.qr_code),
              iconSize: 150.0,
              onPressed: _submitQr,
            ),
            SizedBox(
              height: 10.0,
            ),
            ChangeNotifierProvider(
              create: (_) => SearchFormProvider(),
              child: _FormSearch(),
            ),
          ],
        ),
      ),
    );
  }

  void _submitQr() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#3D8BEF',
      'Cancelar',
      false,
      ScanMode.QR,
    );

    print(barcodeScanRes);
  }
}

class _FormSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchForm = Provider.of<SearchFormProvider>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    return Container(
      child: Form(
        key: searchForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 2,
                  ),
                ),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                counter: Text('Letras ${searchForm.matricula.length}'),
                labelText: 'Placa',
                helperText: 'Sólo es el codigo placa',
                suffixIcon: Icon(
                  Icons.car_repair_outlined,
                  color: Colors.deepPurple,
                ),
              ),
              onChanged: (value) => searchForm.matricula = value,
            ),
            Divider(),
            TextFormField(
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 2,
                  ),
                ),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                counter: Text('Letras ${searchForm.cedula.length}'),
                labelText: 'Cedula Identidad',
                helperText: 'Sólo es el codigo Cedula Identidad',
                suffixIcon: Icon(
                  Icons.credit_card_rounded,
                  color: Colors.deepPurple,
                ),
              ),
              onChanged: (value) => searchForm.cedula = value,
            ),
            Divider(),
            SizedBox(height: 15),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 15,
                  ),
                  child: Text(
                    searchForm.isLoading ? 'Espere' : 'Buscar',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
              onPressed: () {
                Navigator.pushNamed(context, 'entry');
              },
            ),
            Divider(),
            SizedBox(
              height: 5,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.amber,
              child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 70,
                    vertical: 15,
                  ),
                  child: Text(
                    'Historial Ingreso',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
              onPressed: () {
                Navigator.pushNamed(context, 'listar');
              },
            ),
            Divider(),
            SizedBox(
              height: 5,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.red,
              child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 15,
                  ),
                  child: Text(
                    'Salir',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
              onPressed: () {
                authService.logout();
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
