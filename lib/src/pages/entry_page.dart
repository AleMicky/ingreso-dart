import 'package:flutter/material.dart';
import 'package:ingreso/src/models/tipoIngreso.dart';
import 'package:ingreso/src/providers/entry_form_provider.dart';
import 'package:ingreso/src/services/ingresar_service.dart';
import 'package:ingreso/src/services/notifications_service.dart';
import 'package:ingreso/src/services/tipo_ingreso_service.dart';
import 'package:ingreso/src/ui/input_decorations.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Column(
              children: [
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'REGISTRO INGRESO',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ChangeNotifierProvider(
                  create: (_) => EntryFormProvider(),
                  child: _FormRntry(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormRntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final headlines = Provider.of<TipoIngresoService>(context).headlines;
    final entryForm = Provider.of<EntryFormProvider>(context);

    return Container(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: entryForm.formKey,
        child: Column(
          children: [
            _espacio(
              DropdownButtonFormField<TipoIngreso>(
                items: headlines.map((item) {
                  return new DropdownMenuItem(
                    child: new Text(item.descripcion),
                    value: item,
                  );
                }).toList(),
                //value: 2,
                onSaved: (value) => entryForm.idTipoIngreso = value!.id,
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Tipo Ingreso',
                ),
                onChanged: (opt) {
                  entryForm.iniciarEvento(opt as TipoIngreso);
                },
              ),
            ),
            entryForm.placaBool
                ? _espacio(
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: 'ASD-123',
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecorations.authInputDecoration(
                              labelText: 'Placa',
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                    ? 'Por favor ingrese un texto'
                                    : null,
                            onChanged: (value) =>
                                entryForm.placa = value.trim(),
                          ),
                        ),
                        entryForm.fotoPlaca
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Column(
                                  children: [
                                    Text('Placa'),
                                    IconButton(
                                      icon: const Icon(Icons.camera_alt),
                                      tooltip: 'Foto Placa',
                                      onPressed: _procesarImagen,
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  )
                : Container(),
            entryForm.empresaBool
                ? _espacio(
                    TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecorations.authInputDecoration(
                        labelText: 'Empresa',
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Por favor ingrese un texto'
                          : null,
                      onChanged: (value) => entryForm.empresa = value.trim(),
                    ),
                  )
                : Container(),
            entryForm.pasajeroBool
                ? _espacio(
                    DropdownButtonFormField<String>(
                        items: ['si', 'no']
                            .map((value) => DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                ))
                            .toList(),
                        // value: _opcionPasajero,
                        onSaved: (value) => print(value),
                        decoration: InputDecorations.authInputDecoration(
                          labelText: 'Pasajero',
                        ),
                        onChanged: (opt) => print(opt)),
                  )
                : Container(),
            entryForm.cedulaBool
                ? _espacio(
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecorations.authInputDecoration(
                              labelText: 'Cedula Identidad',
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                    ? 'Por favor ingrese un texto'
                                    : null,
                            onChanged: (value) =>
                                entryForm.cedula = value.trim(),
                          ),
                        ),
                        entryForm.fotoCedula
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Column(
                                  children: [
                                    Text('C.I.'),
                                    IconButton(
                                      icon: const Icon(Icons.camera_alt),
                                      tooltip: 'Foto C.I.',
                                      onPressed: _procesarImagen,
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  )
                : Container(),
            entryForm.calleBool
                ? _espacio(
                    TextFormField(
                      // initialValue: initialValue,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecorations.authInputDecoration(
                        labelText: 'Calle',
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Por favor ingrese un texto'
                          : null,
                      onChanged: (value) => entryForm.calle = value.trim(),
                    ),
                  )
                : Container(),
            entryForm.numeroBool
                ? _espacio(
                    TextFormField(
                      // initialValue: initialValue,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecorations.authInputDecoration(
                        labelText: 'Número',
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Por favor ingrese un texto'
                          : null,
                      onChanged: (value) => entryForm.numero = value.trim(),
                    ),
                  )
                : Container(),
            _espacio(
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Observación',
                ),
                keyboardType: TextInputType.text,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Por favor ingrese un texto'
                    : null,
                onChanged: (value) => entryForm.observacion = value.trim(),
              ),
            ),
            _espacio(
              Row(
                children: [
                  Expanded(
                    child: SwitchListTile(
                      title: Text('Ingreso'),
                      value: entryForm.ingreso,
                      onChanged: (valor) => entryForm.ingreso = valor,
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      disabledColor: Colors.grey,
                      elevation: 0,
                      color: Colors.deepPurple,
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              //horizontal: 80,
                              //vertical: 15,
                              ),
                          child: Text(
                            entryForm.isLoading ? 'Espera' : 'Registrar',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                      onPressed: entryForm.isLoading
                          ? null
                          : () async {
                              FocusScope.of(context).unfocus();
                              final ingresoService =
                                  Provider.of<IngresarService>(
                                context,
                                listen: false,
                              );
                              if (!entryForm.isValidForm()) return;
                              entryForm.isLoading = true;

                              final String? errorMessage =
                                  await ingresoService.crearIngreso(
                                entryForm.idTipoIngreso,
                                entryForm.empresa,
                                entryForm.placa,
                                '',
                                entryForm.cedula,
                                'no',
                                entryForm.calle,
                                entryForm.numero,
                                entryForm.ingreso ? 1 : 0,
                                entryForm.observacion,
                              );
                              if (errorMessage == null) {
                                entryForm.isLoading = false;
                              } else {
                                NotificationsService.showSnackbar(errorMessage);
                                entryForm.isLoading = false;
                              }
                            },
                    ),
                  ),
                ],
              ),
            ),
            _espacio(
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.red,
                child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 90,
                      //vertical: 15,
                    ),
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _espacio(Widget child) {
    return Column(
      children: [
        SizedBox(
          height: 8.0,
        ),
        Divider(),
        child
      ],
    );
  }

  void _procesarImagen() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    print(photo);
  }
}
