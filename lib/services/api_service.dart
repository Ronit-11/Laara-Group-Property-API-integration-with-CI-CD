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
    try {
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
    } catch (e) {
      print('Error fetching properties: $e');
      throw e;
    }
  }

  // Fetch detailed property info by ID
  Future<Property> fetchPropertyDetails(String propertyId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$propertyId'),
        headers: {
          'x-app-id': appId,
        },
      );
      if (response.statusCode == 200) {
        return Property.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load property details');
      }
    } catch (e) {
      print('Error fetching property details: $e');
      throw e;
    }
  }
}