import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/loading_widget.dart';

class DetailScreen extends StatefulWidget {
  final String endpoint;
  final int id;

  const DetailScreen({super.key, required this.endpoint, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final ApiService _apiService = ApiService();
  dynamic _item;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadDetail();
  }

  Future<void> _loadDetail() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      dynamic data;
      switch (widget.endpoint) {
        case 'departments':
          data = await _apiService.getDepartmentDetail(widget.id);
          break;
        case 'presidents':
          data = await _apiService.getPresidentDetail(widget.id);
          break;
        case 'typical_dishes':
          data = await _apiService.getTypicalDishDetail(widget.id);
          break;
        default:
          throw Exception('Endpoint no soportado');
      }
      setState(() {
        _item = data;
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
      appBar: AppBar(title: const Text('Detalle')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const LoadingWidget(message: 'Cargando detalle...');
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
              onPressed: _loadDetail,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    if (_item == null) {
      return const Center(child: Text('No hay información disponible'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: _buildDetailContent(),
        ),
      ),
    );
  }

  Widget _buildDetailContent() {
    switch (widget.endpoint) {
      case 'departments':
        return _buildDepartmentDetail();
      case 'presidents':
        return _buildPresidentDetail();
      case 'typical_dishes':
        return _buildTypicalDishDetail();
      default:
        return const Text('Vista de detalle no implementada');
    }
  }

  Widget _buildDepartmentDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              _item.name[0],
              style: const TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildDetailRow('Nombre:', _item.name),
        _buildDetailRow('Descripción:', _item.description),
        _buildDetailRow('Población:', '${_item.population} habitantes'),
        _buildDetailRow('Área:', '${_item.area} km²'),
      ],
    );
  }

  Widget _buildPresidentDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              _item.name[0],
              style: const TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildDetailRow('Nombre:', _item.fullName),
        _buildDetailRow('Partido Político:', _item.politicalParty),
        _buildDetailRow('Inicio del Periodo:', _item.startPeriodDate),
        if (_item.endPeriodDate != null)
          _buildDetailRow('Fin del Periodo:', _item.endPeriodDate),
        if (_item.description != null)
          _buildDetailRow('Descripción:', _item.description),
      ],
    );
  }

  Widget _buildTypicalDishDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_item.imageUrl != null && _item.imageUrl.isNotEmpty)
          Center(
            child: Image.network(
              _item.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported, size: 50),
                );
              },
            ),
          ),
        if (_item.imageUrl == null || _item.imageUrl.isEmpty)
          Container(
            height: 200,
            color: Colors.grey[300],
            child: const Icon(Icons.fastfood, size: 50),
          ),
        const SizedBox(height: 20),
        _buildDetailRow('Nombre:', _item.name),
        _buildDetailRow('Descripción:', _item.description),
        _buildDetailRow('Ingredientes:', _item.ingredients),
        _buildDetailRow(
          'Departamento:',
          _item.department?.name ?? 'ID: ${_item.departmentId}',
        ),

        if (_item.department != null) ...[
          const SizedBox(height: 20),
          const Text(
            'Información del Departamento',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildDetailRow('Capital:', _item.department!.cityCapital),
          _buildDetailRow('Municipios:', '${_item.department!.municipalities}'),
          _buildDetailRow('Superficie:', '${_item.department!.surface} km²'),
          _buildDetailRow('Población:', '${_item.department!.population} hab.'),
          _buildDetailRow('Prefijo Telefónico:', _item.department!.phonePrefix),

          if (_item.department!.region != null) ...[
            const SizedBox(height: 10),
            _buildDetailRow('Región:', _item.department!.region!.name),
            _buildDetailRow(
              'Descripción Región:',
              _item.department!.region!.description,
            ),
          ],

          if (_item.department!.country != null) ...[
            const SizedBox(height: 20),
            const Text(
              'Información del País',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildDetailRow('País:', _item.department!.country!.name),
            _buildDetailRow(
              'Capital:',
              _item.department!.country!.stateCapital,
            ),
            _buildDetailRow(
              'Moneda:',
              '${_item.department!.country!.currency} (${_item.department!.country!.currencyCode})',
            ),
            _buildDetailRow(
              'Huso Horario:',
              _item.department!.country!.timeZone,
            ),
            _buildDetailRow(
              'Idiomas:',
              _item.department!.country!.languages.join(', '),
            ),
            _buildDetailRow('Región:', _item.department!.country!.region),
            _buildDetailRow('Subregión:', _item.department!.country!.subRegion),
          ],
        ],
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16)),
          const Divider(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _apiService.dispose();
    super.dispose();
  }
}
