import 'package:flutter/material.dart';
import 'package:flutter_endpoint_integration_with_github_actions/services/api_service.dart';
import 'package:flutter_endpoint_integration_with_github_actions/models/property_model.dart';

class PropertyProvider with ChangeNotifier {
  ApiService apiService = ApiService();

  List<Property> _properties = [];
  List<Property> get properties => _properties;

  Property? _selectedProperty;
  Property? get selectedProperty => _selectedProperty;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Fetch all properties
  Future<void> fetchProperties() async {
    _isLoading = true;
    notifyListeners();
    try {
      final properties = await apiService.fetchProperties();
      if (properties.isNotEmpty) {
        _properties = properties;
      } else {
        _properties = [];
      }
      print("Properties fetched succesfully : print");
      debugPrint('Properties fetched: succesfully: debugprint');
    } catch (error) {
      print('Error fetching properties: $error');
      _properties = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch detailed information about a specific property
  Future<void> fetchPropertyDetails(String propertyId, int index) async {
    _isLoading = true;
    notifyListeners();

    try {
      final propertyDetail = await apiService.fetchPropertyDetails(propertyId);
      print('Property details fetched succesfully: print');
      _properties[index] = propertyDetail as Property;

    } catch (error) {
      print('Error fetching property details: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
