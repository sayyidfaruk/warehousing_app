class Product {
  final String name;
  final int price;
  final int qty;
  final String attr;
  final int weight;
  final String issuer;

  Product({
    required this.name,
    required this.price,
    required this.qty,
    required this.attr,
    required this.weight,
    required this.issuer
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'],
      qty: json['qty'],
      attr: json['attr'],
      weight: json['weight'],
      issuer: json['issuer']);
  }
}
