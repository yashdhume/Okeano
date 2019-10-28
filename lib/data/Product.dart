class Product {
  final String name;
  final String description;
  final String price;
  final String url;
  final String store;
  final String image;
  Product({this.name, this.description, this.price, this.url, this.store, this.image});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      url: json['url'] as String,
      store: json['store'] as String,
      image: json['image'] as String,
    );
  }
}