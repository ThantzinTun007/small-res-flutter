class Order {
  final int? orderId;
  final DateTime orderDate;
  final int employeeId;
  final int? tableId;
  final String orderType;
  final double totalAmount;

  Order({
    this.orderId,
    required this.orderDate,
    required this.employeeId,
     this.tableId,
    required this.orderType,
    required this.totalAmount,
  });

  Map<String, dynamic> toJson() => {
        'order_date': orderDate.toIso8601String(),
        'employee_id': employeeId,
        'table_id': tableId,
        'order_type': orderType,
        'total_amount': totalAmount,
      };
}