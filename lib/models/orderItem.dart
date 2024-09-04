class OrderItem {
  final int? orderItemId;
  final int orderId;
  final int menuItemId;
  final int quantity;
  final double price;

  OrderItem({
    this.orderItemId,
    required this.orderId,
    required this.menuItemId,
    required this.quantity,
    required this.price,
  });

  // Factory method to create an OrderItem from a JSON object
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      orderItemId: json['order_item_id'],
      orderId: json['order_id'],
      menuItemId: json['menu_item_id'],
      quantity: json['quantity'],
      price: json['price'] is double
          ? json['price']
          : double.parse(json['price'].toString()), // Convert to double
    );
  }

  // Method to convert an OrderItem to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'order_item_id': orderItemId,
      'order_id': orderId,
      'menu_item_id': menuItemId,
      'quantity': quantity,
      'price': price,
    };
  }
}