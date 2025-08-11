// repositories/auth_repository.dart
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:suncore_mobile/src/core/const/constants.dart';

class DashboardRepository {
  DashboardRepository();

  Future<Map<String, dynamic>> checkKycStatus() async {
    final token = await getStoredToken();
    debugPrint('token before calling API $token');
    final response = await http.get(
      Uri.parse('$baseUrl/kyc/status'),
      headers: {'Authorization': 'Bearer $token'},
    );

    final responseData = json.decode(response.body);

    if (response.statusCode == 200 && responseData['status'] == 'success') {
      return responseData['data'];
    } else {
      throw Exception(responseData['message'] ?? 'Failed to load KYC status');
    }
  }
}
