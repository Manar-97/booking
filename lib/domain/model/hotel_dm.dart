import 'package:cloud_firestore/cloud_firestore.dart';

class HotelDM {
  static const String collectionName = "hotels";
  final String? id;
  final String? name;
  final String? description;
  final String? location;
  final num? price;
  HotelDM(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.location});

  factory HotelDM.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return HotelDM(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      location: data['location'] ?? '',
      price: data['price'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "location": location,
    };
  }
}
