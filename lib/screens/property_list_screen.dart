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
    // Fetch properties once during initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final propertyProvider = Provider.of<PropertyProvider>(context, listen: false);
      propertyProvider.fetchProperties();
    });
  }

  @override
  Widget build(BuildContext context) {
    final propertyProvider = Provider.of<PropertyProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Properties List'),
        backgroundColor: Color.fromARGB(255, 255, 203, 135),
      ),
      body: propertyProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: Color.fromARGB(224, 252, 255, 232),
              child: ListView.builder(
                itemCount: propertyProvider.properties.length,
                itemBuilder: (ctx, index) {
                  final property = propertyProvider.properties[index];

                  return InkWell(
                    onTap: () async {
                      // Fetch property details and navigate to the property detail screen
                      await propertyProvider.fetchPropertyDetails(property.id.toString(), index);
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => PropertyDetailScreen(propertyId: property.id),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.easeInOut;
                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);
                            return SlideTransition(position: offsetAnimation, child: child);
                          },
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: property.propertyImages.isNotEmpty
                                ? Image.network(
                                    property.propertyImages[0],
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: double.infinity,
                                    height: 200,
                                    color: Colors.orange[200],
                                    child: const Icon(Icons.image, size: 50, color: Colors.white),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  property.name,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orangeAccent,
                                  ),
                                ),

                                Text(
                                  '${property.address.street}, ${property.address.town}, ${property.address.country}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                
                                Text(
                                  property.description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
