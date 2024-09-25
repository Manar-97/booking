import 'hotel.dart';

class HotelDM extends Hotel {
  // static const String collectionName = "hotels";
  // String? id;
  // String? name;
  // String? description;
  // String? location;
  // double? price;
  HotelDM(
      {required String name,
      required String description,
      required double price,
      required String location,
      required String id})
      : super(
            id: id,
            name: name,
            description: description,
            price: price,
            location: location);

  factory HotelDM.fromFirestore(Map<String, dynamic>? json,String id) {
    return HotelDM(
      id: json?["id"],
      name: json?["name"],
      description: json?["description"],
      price: json?["price"],
      location: json?["location"],
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
