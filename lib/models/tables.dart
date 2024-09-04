class TableModel {
  final int tableId;
  final int tableNumber;
  final int capacity;
  final String location;

  TableModel({
    required this.tableId,
    required this.tableNumber,
    required this.capacity,
    required this.location,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      tableId: json['table_id'],
      tableNumber: json['table_number'],
      capacity: json['capacity'],
      location: json['location'],
    );
  }
}
