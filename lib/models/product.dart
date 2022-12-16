class Product {
  final String id;
  final String title;
  final String description;
  final String imageURL;
  final double price;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageURL,
      required this.price,
      this.isFavorite = false});
}
