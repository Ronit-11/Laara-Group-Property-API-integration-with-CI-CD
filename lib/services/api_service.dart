import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_endpoint_integration_with_github_actions/models/property_model.dart';

class ApiService {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final String fetchPropertiesSubDir = dotenv.env['FETCH_PROPERTIES_SUB_DIR']!;
  final String appId = dotenv.env['APP_ID']!;

  // Fetch properties list
  Future<List<Property>> fetchProperties() async {
    final response = await http.get(
      Uri.parse('$baseUrl$fetchPropertiesSubDir'),
      headers: {
        'x-app-id': appId,
      },
    );
    print('started fetch properties');
    debugPrint(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> propertiesJson = json.decode(response.body)['data'];
      return propertiesJson.map((json) => Property.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load properties');
    }
  }

  // Fetch detailed property info by ID
  Future<Property> fetchPropertyDetails(String propertyId) async {
    final response = await http.get(
      Uri.parse('$baseUrl$propertyId'),
      headers: {
        'x-app-id': appId,
      },
    );
    print('started fetch detailed property');
    debugPrint(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> propertyDetailsJson = json.decode(response.body)['data'];
      return Property.fromJson(propertyDetailsJson);
    } else {
      throw Exception('Failed to load property details');
    }
  }
}