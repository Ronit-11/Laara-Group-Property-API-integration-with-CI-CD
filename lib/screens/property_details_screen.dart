import 'package:flutter/material.dart';
import 'package:flutter_endpoint_integration_with_github_actions/providers/property_provider.dart';
import 'package:flutter_endpoint_integration_with_github_actions/models/property_model.dart';
import 'package:provider/provider.dart';

class PropertyDetailScreen extends StatelessWidget {
  final int propertyId;

  const PropertyDetailScreen({super.key, required this.propertyId});

  @override
  Widget build(BuildContext context) {
    final propertyProvider = Provider.of<PropertyProvider>(context);
    final property = propertyProvider.properties.firstWhere((property) => property.id == propertyId);
    
    return Scaffold(
      appBar: AppBar(title: Text(property.name)),
      body: propertyProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Text(property.propertyLanguages.join('\n')),
    );
  }
}