import 'package:flutter_endpoint_integration_with_github_actions/screens/property_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_endpoint_integration_with_github_actions/providers/property_provider.dart';
import 'package:provider/provider.dart';

class PropertyListScreen extends StatefulWidget {
  PropertyListScreen({super.key});

  @override
  _PropertyListScreenState createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch properties only once when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final propertyProvider = Provider.of<PropertyProvider>(context, listen: false);
      propertyProvider.fetchProperties().then((_) {
        print('All Properties data in property_list_screen: print');
        print(propertyProvider.properties);
        debugPrint('All Properties data in property_list_screen: debugprint');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final propertyProvider = Provider.of<PropertyProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Properties List')),
      body: propertyProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: propertyProvider.properties.length,
              itemBuilder: (ctx, index) {
                final property = propertyProvider.properties[index];
                return ListTile(
                  title:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                property.name,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                'Address: ${property.address.street}, ${property.address.town}, ${property.address.country}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey, 
                                ),
                              ),
                            ],
                          ),

                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (property.propertyImages.isNotEmpty)
                        Container(
                          width: double.infinity,
                          height: 200,
                          child: Image.network(
                            property.propertyImages[0].url,
                            fit: BoxFit.cover,
                          ),
                        ),
                      SizedBox(height: 10),
                      Text(
                        property.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  onTap: () async {
                    final propertyProvider = Provider.of<PropertyProvider>(context, listen: false);
                    final propertyId = property.id;
                    // Fetch the property details and update its contents
                    await propertyProvider.fetchPropertyDetails(propertyId.toString(), index);
                    
                    // Navigate to the PropertyDetailScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PropertyDetailScreen(propertyId: property.id),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}