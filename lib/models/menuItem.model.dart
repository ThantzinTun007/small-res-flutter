class MenuItem {
  final int menuItemId;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;

  MenuItem({
    required this.menuItemId,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
  });

  // Factory method to create a MenuItem from a JSON object
  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      menuItemId: json['menu_item_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(), // Ensure price is converted to double
      category: json['category'],
      imageUrl: json['image_url'],
    );
  }

  // Method to convert a MenuItem to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'menu_item_id': menuItemId,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'image_url': imageUrl,
    };
  }
}
