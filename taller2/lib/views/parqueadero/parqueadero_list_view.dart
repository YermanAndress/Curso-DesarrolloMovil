import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/parqueadero.dart';
import '../../services/parqueadero_service.dart';
import '../../widgets/base_view.dart';

class ParqueaderoListView extends StatefulWidget {
  const ParqueaderoListView({super.key});

  @override
  State<ParqueaderoListView> createState() => _ParqueaderoListViewState();
}

class _ParqueaderoListViewState extends State<ParqueaderoListView> {
  //* Se crea una instancia de la clase ParqueaderoService
  final ParqueaderoService _parqueaderoService = ParqueaderoService();
  //* Se declara una variable de tipo Future que contendrá la lista de Parqueaderos
  late Future<List<Parqueadero>> _futureParqueaderos;

  @override
  void initState() {
    super.initState();
    //! Se llama al método getParqueaderos de la clase ParqueaderoService
    _futureParqueaderos = _parqueaderoService.getParqueaderos();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Parqueadero - ListView',
      //! Se crea un FutureBuilder que se encargará de construir la lista de Parqueaderos
      //! futurebuilder se utiliza para construir widgets basados en un Future
      body: FutureBuilder<List<Parqueadero>>(
        future: _futureParqueaderos,
        builder: (context, snapshot) {
          //snapshot contiene la respuesta del Future
          if (snapshot.hasData) {
            //* Se obtiene la lista de Parqueaderos
            final parqueaderos = snapshot.data!;
            //listview.builder se utiliza para construir una lista de elementos de manera eficiente
            return ListView.builder(
              itemCount: parqueaderos.length,
              itemBuilder: (context, index) {
                final parqueadero = parqueaderos[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  //* gestureDetector se utiliza para detectar gestos del usuario
                  //* en este caso se utiliza para navegar a la vista de detalle del Parqueadero
                  child: GestureDetector(
                    onTap: () {
                      context.push('/parqueadero/${parqueadero.nombre}');
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.network(
                                parqueadero.logo,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    parqueadero.nombre.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
