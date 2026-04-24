import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:parcial2/models/establecimiento_model.dart';
import 'package:parcial2/services/api_service.dart';

class EstablecimientoFormView extends StatefulWidget {
  final Establecimiento? establecimiento;
  const EstablecimientoFormView({super.key, this.establecimiento});

  @override
  State<EstablecimientoFormView> createState() =>
      _EstablecimientoFormViewState();
}

class _EstablecimientoFormViewState extends State<EstablecimientoFormView> {
  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();

  late TextEditingController _nameCtrl, _nitCtrl, _dirCtrl, _telCtrl;
  XFile? _pickedFile;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.establecimiento?.nombre);
    _nitCtrl = TextEditingController(text: widget.establecimiento?.nit);
    _dirCtrl = TextEditingController(text: widget.establecimiento?.direccion);
    _telCtrl = TextEditingController(text: widget.establecimiento?.telefono);
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() => _pickedFile = pickedFile);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final formData = FormData.fromMap({
      'nombre': _nameCtrl.text,
      'nit': _nitCtrl.text,
      'direccion': _dirCtrl.text,
      'telefono': _telCtrl.text,
      if (_pickedFile != null)
        'logo': kIsWeb
            ? MultipartFile.fromBytes(
                await _pickedFile!.readAsBytes(),
                filename: "logo.jpg",
              )
            : await MultipartFile.fromFile(_pickedFile!.path),
    });

    try {
      if (widget.establecimiento == null) {
        await _apiService.createEstablecimiento(formData);
      } else {
        await _apiService.updateEstablecimiento(
          widget.establecimiento!.id!,
          formData,
        );
      }
      if (mounted) context.pop(true);
    } catch (e) {
      debugPrint("Error guardando: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.establecimiento == null
              ? "Nuevo Establecimiento"
              : "Editar Detalles",
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24), // Un poco más de aire
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: _inputStyle("Nombre del Negocio", Icons.business),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nitCtrl,
              decoration: _inputStyle(
                "NIT / Identificación",
                Icons.badge_outlined,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _dirCtrl,
              decoration: _inputStyle(
                "Dirección Física",
                Icons.location_on_outlined,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _telCtrl,
              keyboardType: TextInputType.phone,
              decoration: _inputStyle(
                "Teléfono de Contacto",
                Icons.phone_android,
              ),
            ),
            const SizedBox(height: 30),

            // --- Selector de Imagen Moderno ---
            Text(
              "Logo del establecimiento",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: _pickedFile != null
                      ? (kIsWeb
                            ? Image.network(
                                _pickedFile!.path,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(_pickedFile!.path),
                                fit: BoxFit.cover,
                              ))
                      : (widget.establecimiento?.logo != null
                            ? Image.network(
                                widget.establecimiento!.logo!,
                                fit: BoxFit.cover,
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 40,
                                    color: colorScheme.primary,
                                  ),
                                  const SizedBox(height: 8),
                                  const Text("Toca para subir una foto"),
                                ],
                              )),
                ),
              ),
            ),

            const SizedBox(height: 40),

            FilledButton.icon(
              onPressed: _save,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.save_rounded),
              label: const Text(
                "Guardar Cambios",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputStyle(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none, // Borde más limpio
      ),
      filled: true,
      fillColor: Colors.blue.withValues(alpha: (0.05)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
}
