import 'package:flutter/material.dart';
import 'package:flutter_endpoint_integration_with_github_actions/providers/property_provider.dart';
import 'package:provider/provider.dart';

class PropertyDetailScreen extends StatelessWidget {
  final int propertyId;

  const PropertyDetailScreen({super.key, required this.propertyId});

  @override
  Widget build(BuildContext context) {
    final propertyProvider = Provider.of<PropertyProvider>(context);
    final property = propertyProvider.properties.firstWhere((property) => property.id == propertyId);

    return Scaffold(
      appBar: AppBar(
        title: Text(property.name),
        backgroundColor: Color.fromARGB(255, 255, 203, 135),
      ),
      body: propertyProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
            color: Color.fromARGB(224, 252, 255, 232),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
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
                const SizedBox(height: 6),
                Text(
                  '${property.address.street}, ${property.address.town}, ${property.address.country}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),

                // Property Description
                Text(
                  property.description,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 2),

                // Property Amenities
                ExpansionTile(
                  title: Text('Amenities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  children: property.propertyAmenities
                    .where((amenity) => amenity.name.isNotEmpty)
                    .map((amenity) {
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      title: Text('${amenity.name}'),
                    );
                  }).toList(),
                ),

                // Property Policies
                ExpansionTile(
                  title: Text(
                    'Policies',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  children: property.propertyPolicies
                      .where((policy) => policy.description.isNotEmpty)
                      .map((policy) {
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      title: Text(policy.description),
                    );
                  }).toList(),
                ),


                // Meal Plan Option
                if (property.mealOptions.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(),
                    child: Text(
                      'Meal Plan: ${property.mealOptions.first.plan}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),

                // Property Languages
                const SizedBox(height: 16),
                Text(
                  'Languages Spoken:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                for (var language in property.propertyLanguages)
                  Text(
                    '- ${language}',
                    style: TextStyle(fontSize: 16),
                  ),
                const SizedBox(height: 16),

                // Staff Images (Circular Avatars)
                if (property.staffImages.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        'Meet Our Staff:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: property.staffImages.length,
                          itemBuilder: (ctx, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(property.staffImages[index]),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),   
    );
  }
}