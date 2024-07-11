import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class PropertyDetailsPage extends StatelessWidget {
  final String propertyId;

  PropertyDetailsPage({required this.propertyId});

  void _sharePropertyLink(BuildContext context) {
    final String propertyLink = 'https://example.com/property/$propertyId'; // Substitua pelo seu link

    Share.share('Confira este imóvel: $propertyLink');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Imóvel'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => _sharePropertyLink(context),
          ),
        ],
      ),
      body: Center(
        child: Text('Detalhes do Imóvel com ID: $propertyId'),
      ),
    );
  }
}
