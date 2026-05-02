import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:taller_datos_abiertos/services/colombia_service.dart';
import 'package:taller_datos_abiertos/models/presidente_model.dart';

class PresidentesListView extends StatefulWidget {
  const PresidentesListView({super.key});

  @override
  State<PresidentesListView> createState() => _PresidentesListViewState();
}

class _PresidentesListViewState extends State<PresidentesListView> {
  final ColombiaService _service = ColombiaService();
  late Future<List<Presidente>> _futurePresidentes;

  @override
  void initState() {
    super.initState();
    _futurePresidentes = _service.getPresidentes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Presidentes de Colombia")),
      body: FutureBuilder<List<Presidente>>(
        future: _futurePresidentes,
        builder: (context, snapshot) {
          // ESTADO: CARGANDO
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // ESTADO: ERROR
          else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          // ESTADO: ÉXITO
          else {
            final list = snapshot.data!;
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, i) => ListTile(
                title: Text("${list[i].name} ${list[i].lastName}"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => context.push('/presidents/detail', extra: list[i]),
              ),
            );
          }
        },
      ),
    );
  }
}
