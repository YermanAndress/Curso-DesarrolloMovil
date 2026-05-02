import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/loading_widget.dart';

class ListScreen extends StatefulWidget {
  final String endpoint;
  final String title;

  const ListScreen({super.key, required this.endpoint, required this.title});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final ApiService _apiService = ApiService();
  List<dynamic> _items = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      List<dynamic> data = [];
      switch (widget.endpoint) {
        case 'departamentos':
          data = await _apiService.getDepartments();
          break;
        case 'presidents':
          data = await _apiService.getPresidents();
          break;
        case 'tourist_attractions':
          data = await _apiService.getTouristAttractions();
          break;
        case 'typical_dishes':
          data = await _apiService.getTypicalDishes();
          break;
      }
      setState(() {
        _items = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const LoadingWidget(message: 'Cargando información...');
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadData,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    if (_items.isEmpty) {
      return const Center(child: Text('No hay datos disponibles'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                (index + 1).toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              _getTitle(item),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(_getSubtitle(item)),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/detail',
                arguments: {'endpoint': widget.endpoint, 'id': item.id},
              );
            },
          ),
        );
      },
    );
  }

  String _getTitle(dynamic item) {
    switch (widget.endpoint) {
      case 'departamentos':
        return item.name;
      case 'presidentes':
        return item.fullName;
      case 'tourist_attractions':
        return item.name;
      case 'typical_dishes':
        return item.name;
      default:
        return 'Sin título';
    }
  }

  String _getSubtitle(dynamic item) {
    switch (widget.endpoint) {
      case 'departamentos':
        return 'Población: ${item.population} hab. | Área: ${item.area} km²';
      case 'presidentes':
        return 'Partido: ${item.politicalParty} | Periodo: ${item.startPeriodDate}';
      case 'tourist_attractions':
        return 'Ciudad: ${item.city}';
      case 'typical_dishes':
        return 'Departamento: ${item.department?.name ?? item.departmentId} | Ingredientes: ${item.ingredients.length > 50 ? item.ingredients.substring(0, 50) + '...' : item.ingredients}';
      default:
        return '';
    }
  }

  @override
  void dispose() {
    _apiService.dispose();
    super.dispose();
  }
}
