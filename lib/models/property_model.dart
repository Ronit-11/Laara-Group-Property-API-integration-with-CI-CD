class Property {
  int id;
  String name;
  String description;
  Address address;
  Parking parking;
  List<Review> reviews;
  String guestVerificationMethod;
  List<dynamic> propertyLanguages;
  List<AccessibilityFeature> accessibilityFeatures;
  Host host;
  List<MealOption> mealOptions;
  List<dynamic> propertyImages;
  List<dynamic> staffImages;
  List<dynamic> foodImages;
  String type;
  List<Room> rooms;
  List<PropertyPolicy> propertyPolicies;
  List<Amenity> propertyAmenities;

  Property({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.parking,
    required this.reviews,
    required this.guestVerificationMethod,
    required this.propertyLanguages,
    required this.accessibilityFeatures,
    required this.host,
    required this.mealOptions,
    required this.propertyImages,
    required this.staffImages,
    required this.foodImages,
    required this.type,
    required this.rooms,
    required this.propertyPolicies,
    required this.propertyAmenities,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    var reviewsList = json['reviews'] as List? ?? [];
    return Property(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      address: Address.fromJson(json['address'] ?? {}),
      parking: Parking.fromJson(json['parking'] ?? {}),
      reviews: reviewsList.map((review) => Review.fromJson(review)).toList(),
      guestVerificationMethod: json['guestVerificationMethod'] ?? '',
      propertyLanguages: (json['propertyLanguages'] as List? ?? [])
          .map((language) => language['language']['name'])
          .toList(),
      accessibilityFeatures: (json['accessibilityFeatures'] as List? ?? [])
          .map((feature) => AccessibilityFeature.fromJson(feature['features']))
          .toList(),
      host: Host.fromJson(json['host'] ?? {}),
      mealOptions: (json['mealOptions'] as List? ?? [])
          .map((meal) => MealOption.fromJson(meal))
          .toList(),
      propertyImages: (json['propertyImages'] as List)
          .map((image) => image['images']['url'])
          .toList(),
      staffImages: (json['staffImages'] as List)
          .map((image) => image['images']['url'])
          .toList(),
      foodImages: (json['foodImages'] as List)
          .map((image) => image['images']['url'])
          .toList(),
      type: json['type'] ?? '',
      rooms: (json['rooms'] as List? ?? [])
          .map((room) => Room.fromJson(room['roomTypes']))
          .toList(),
      propertyPolicies: (json['propertyPolicies'] as List? ?? [])
          .map((policy) => PropertyPolicy.fromJson(policy['policies']))
          .toList(),
      propertyAmenities: (json['propertyAmenities'] as List? ?? [])
          .map((amenity) => Amenity.fromJson(amenity['amenities']))
          .toList(),
    );
  }

  get length => null;
}

class Address {
  String country;
  String county;
  String town;
  String street;
  double latitude;
  double longitude;
  String city;
  String physicalAddress;
  String postCode;

  Address({
    required this.country,
    required this.county,
    required this.town,
    required this.street,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.physicalAddress,
    required this.postCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      country: json['country'] ?? '',
      county: json['county'] ?? '',
      town: json['town'] ?? '',
      street: json['street'] ?? '',
      latitude: (json['latitude'] is String)
        ? double.parse(json['latitude'] ?? '0.0')
        : (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] is String)
        ? double.parse(json['longitude'] ?? '0.0')
        : (json['longitude'] ?? 0.0).toDouble(),
      city: json['city'] ?? '',
      physicalAddress: json['physicalAddress'] ?? '',
      postCode: json['postCode'] ?? '',
    );
  }
}

class Parking {
  bool availability;
  int cost;
  String location;
  bool paid;
  bool reservation;
  String type;

  Parking({
    required this.availability,
    required this.cost,
    required this.location,
    required this.paid,
    required this.reservation,
    required this.type,
  });

  factory Parking.fromJson(Map<String, dynamic> json) {
    return Parking(
      availability: json['availability'] == true,
      cost: json['cost'] ?? 0,
      location: json['location'] ?? '',
      paid: json['paid'] == true,
      reservation: json['reservation'] == true,
      type: json['type'] ?? '',
    );
  }
}

// Review format empty in json response, to be modified with the actual format
class Review {
  String content;

  Review({required this.content});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      content: json['content'] ?? '',
    );
  }
}

class AccessibilityFeature {
  String category;
  String feature;

  AccessibilityFeature({
    required this.category,
    required this.feature,
  });

  factory AccessibilityFeature.fromJson(Map<String, dynamic> json) {
    return AccessibilityFeature(
      category: json['category'] ?? '',
      feature: json['feature'] ?? '',
    );
  }
}

class Host {
  final String firstName;
  final String lastName;

  Host({
    required this.firstName, 
    required this.lastName
  });

  factory Host.fromJson(Map<String, dynamic> json) {
    return Host(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }
}

class MealOption {
  String plan;
  String description;

  MealOption({
    required this.plan, 
    required this.description
  });

  factory MealOption.fromJson(Map<String, dynamic> json) {
    return MealOption(
      plan: json['plan'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class Room {
  String description;
  String name;
  List<Pricing> pricings;
  List<dynamic> roomTypeImages;

  Room({
    required this.description,
    required this.name,
    required this.pricings,
    required this.roomTypeImages,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      description: json['description'] ?? '',
      name: json['name'] ?? '',
      pricings: (json['pricings'] as List)
          .map((roomtypePlan) => Pricing.fromJson(roomtypePlan))
          .toList(),
      roomTypeImages: (json['roomTypeImages'] as List)
          .map((image) => image['images']['url'])
          .toList(),
    );
  }
}

class Pricing {
  int id;
  int pice;
  String pricingOption;
  String pricingMode;
  int occupants;
  MealOption mealOption;

  Pricing({
    required this.id,
    required this.pice,
    required this.pricingOption,
    required this.pricingMode,
    required this.occupants,
    required this.mealOption,
  });

  factory Pricing.fromJson(Map<String, dynamic> json) {
    return Pricing(
      id: json['id'] ?? -1,
      pice: json['pice'] ?? -1,
      pricingOption: json['pricingOption'] ?? '',
      pricingMode: json['pricingMode'] ?? '',
      occupants: json['occupants'] ?? -1,
      mealOption:  MealOption.fromJson(json['mealOption'] ?? {}),
    );
  }
}

class PropertyPolicy {
  String description;
  String type;
  bool isMandatory;
  String penalty;
  String penaltyType;


  PropertyPolicy({
    required this.description, 
    required this.type, 
    required this.isMandatory, 
    required this.penalty, 
    required this.penaltyType
    });

  factory PropertyPolicy.fromJson(Map<String, dynamic> json) {
    return PropertyPolicy(
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      isMandatory: json['type'] == true,
      penalty: json['type'] ?? '',
      penaltyType: json['type'] ?? '',
    );
  }
}

class Amenity {
  final String name;
  final String category;
  final String description;
  final String icon;

  Amenity({
    required this.name,
    required this.category,
    required this.description,
    required this.icon
  });

  factory Amenity.fromJson(Map<String, dynamic> json) {
    return Amenity(
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '',
    );
  }
}

// class ImageData {
//   final String url;

//   ImageData({
//     required this.url
//   });

//   factory ImageData.fromJson(Map<String, dynamic> json) {
//     return ImageData(url: json['url'] ?? '');
//   }
// }