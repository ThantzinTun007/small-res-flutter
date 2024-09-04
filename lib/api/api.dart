import 'dart:convert';
import 'package:small_res/models/employee.model.dart';
import 'package:small_res/models/menuItem.model.dart';
import 'package:http/http.dart' as http;
import 'package:small_res/models/tables.dart';

class Api {
  static const apiUrl = 'http://localhost:8080/api/res';

  Future<List<MenuItem>> getMenuItem() async {
    final response = await http.get(Uri.parse('$apiUrl/menuitems'));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body) as List;
      return decodedData
          .map((menuItem) => MenuItem.fromJson(menuItem))
          .toList();
    } else {
      throw Exception('Something happended');
    }
  }

  Future<bool> registerEmployee(
    String name,
    String position,
    double salary,
    String hireDate,
    String phone,
    String email,
    String password,
    int role,
  ) async {
    final employee = await http.post(
      Uri.parse('$apiUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'position': position,
        'salary': salary,
        'hire_date': hireDate,
        'phone': phone,
        'email': email,
        'password': password,
        'role': role
      }),
    );

    print('Response status: ${employee.statusCode}');
    print('Response body: ${employee.body}');

    return employee.statusCode == 200;
  }

  Future<List<Employee>> getAllEmployee() async {
    final response = await http.get(Uri.parse('$apiUrl/employees'));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body) as List;
      return decodedData
          .map((employee) => Employee.fromJson(employee))
          .toList();
    } else {
      throw Exception('Error in Employee!');
    }
  }

  Future<List<TableModel>> fetchTables() async {
    final response = await http.get(Uri.parse('$apiUrl/findAllTables'));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => TableModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tables');
    }
  }
}
