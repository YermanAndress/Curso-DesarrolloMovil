import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taller 1 Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Variable de estado para el título
  String _titulo = "Hola, Flutter";

  void _cambiarTitulo() {
    setState(() {
      // Alternar el título
      if (_titulo == "Hola, Flutter") {
        _titulo = "¡Título cambiado!";
      } else {
        _titulo = "Hola, Flutter";
      }
    });

    // Mostrar SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Título actualizado"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(_titulo),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            const Text(
              'German Andres Rojas Cardona',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                  width: 100,
                  height: 100,
                ),
                Image.asset(
                  'assets/logo.png', 
                  width: 100, 
                  height: 100,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 100),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // 2. Botón para cambiar el título (setState)
            ElevatedButton(
              onPressed: _cambiarTitulo,
              child: const Text("Cambiar Título AppBar"),
            ),

            const Divider(height: 50),

            // 3. Widget Adicional: Container con bordes y colores
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Este es un Container decorado (Widget Adicional 1)",
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),

            // 4. Widget Adicional: ListView (Simple)
            const Text("Lista de elementos (Widget Adicional 2):"),
            SizedBox(
              height: 200, // Altura fija para el ListView dentro de una Column
              child: ListView(
                children: const [
                  ListTile(leading: Icon(Icons.star), title: Text("Elemento 1")),
                  ListTile(leading: Icon(Icons.favorite), title: Text("Elemento 2")),
                  ListTile(leading: Icon(Icons.sunny), title: Text("Elemento 3")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}