import 'dart:convert';

class Employee {
  final int employeeId;
  final String name;
  final String position;
  final double salary;
  final DateTime hireDate;
  final String phone;
  final String email;
  final int role;
  final String password;

  Employee({
    required this.employeeId,
    required this.name,
    required this.position,
    required this.salary,
    required this.hireDate,
    required this.phone,
    required this.email,
    required this.role,
    required this.password,
  });

  // Factory method to create an Employee from a JSON object
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      employeeId: json['employee_id'],
      name: json['name'],
      position: json['position'],
      salary: json['salary'].toDouble(), // Ensures salary is converted to double
      hireDate: DateTime.parse(json['hire_date']), // Parses the date string into DateTime
      phone: json['phone'],
      email: json['email'],
      role: json['role'],
      password: json['password'],
    );
  }

  // Method to convert an Employee to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'employee_id': employeeId,
      'name': name,
      'position': position,
      'salary': salary,
      'hire_date': hireDate.toIso8601String(), // Converts DateTime to ISO string
      'phone': phone,
      'email': email,
      'role': role,
      'password': password,
    };
  }

  // Method to create an Employee from a JSON string
  static Employee fromJsonString(String jsonString) {
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    return Employee.fromJson(jsonData);
  }

  // Method to convert an Employee to a JSON string
  String toJsonString() {
    final Map<String, dynamic> jsonData = toJson();
    return json.encode(jsonData);
  }
}
