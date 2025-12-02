import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../models/traceability_event.dart';
import '../models/user.dart';

class ApiService {
  // Real data for public events
  Future<List<TraceabilityEventResource>> getPublicEvents(
    String batchId,
  ) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}/trace/history/public/batch/$batchId',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        final content = data['content'] as List;
        return content
            .map((e) => TraceabilityEventResource.fromJson(e))
            .toList();
      } else {
        throw Exception('Failed to load events: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching events: $e');
    }
  }

  // Mock data for unique companies
  Future<List<String>> getUniqueCompanies() async {
    await Future.delayed(const Duration(seconds: 1));
    return ['AgroFresh', 'Packers Inc', 'Logistics Co'];
  }

  // Mock data for users by company
  Future<List<User>> getUsersByCompany(String companyName) async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      User(
        id: '1',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@agrofresh.com',
        companyName: companyName,
        taxId: 'TAX123',
        companyOption: 'Producer',
        password: '',
        phoneNumber: '1234567890',
        requestedRole: 'Producer',
      ),
      User(
        id: '2',
        firstName: 'Jane',
        lastName: 'Smith',
        email: 'jane@agrofresh.com',
        companyName: companyName,
        taxId: 'TAX123',
        companyOption: 'Manager',
        password: '',
        phoneNumber: '0987654321',
        requestedRole: 'Manager',
      ),
    ];
  }

  // Mock data for company tax ID
  Future<String> getCompanyTaxId(String companyName) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return 'ES-B12345678';
  }

  // Mock data for user by ID
  Future<User> getUserById(String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    // Return a dummy user since we don't have a real DB
    return User(
      id: userId,
      firstName: 'User',
      lastName: userId,
      email: 'user$userId@example.com',
      companyName: 'AgroFresh', // Default to AgroFresh for testing
      taxId: 'TAX123',
      companyOption: 'Producer',
      password: '',
      phoneNumber: '1234567890',
      requestedRole: 'Producer',
    );
  }
}
