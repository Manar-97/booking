class Hotel {
  static const String collectionName = "hotels";
  final String id;
  final String name;
  final String description;
  final String location;
  final double price;
  Hotel(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.location});
}
