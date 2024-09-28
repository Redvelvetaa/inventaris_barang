import 'dart:convert';
import 'package:http/http.dart' as http;
import 'barang.dart';

class ApiService {
  final String baseUrl =
      'http://192.168.147.26/api_inventaris/'; // Ganti dengan URL API Anda
  Future<List<Barang>> getBarang() async {
    final response = await http.get(Uri.parse('$baseUrl/read.php'));
    if (response.statusCode == 200) {
      try {
        List<dynamic> data = json.decode(response.body);
        print('Raw data: $data'); // Tambahkan log untuk memeriksa data mentah
        return data.map((json) {
          print('Parsing item: $json'); // Tambahkan log sebelum parsing
          return Barang.fromJson(json);
        }).toList();
      } catch (e) {
        print('Error during parsing: $e');
        throw Exception('Failed to parse data');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> addBarang(Barang barang) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(barang.toJson()),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}'); // Log response body
    if (response.statusCode != 200) {
      throw Exception('Failed to add data');
    }
  }

  Future<void> updateBarang(Barang barang) async {
    final response = await http.post(
      Uri.parse('$baseUrl/update.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(barang.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update data');
    }
  }

  Future<void> deleteBarang(int kodeBarang) async {
    final response = await http.post(
      Uri.parse('$baseUrl/delete.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'kode_barang': kodeBarang}),
    );
    if (response.statusCode != 200) {
      print('Error: ${response.body}');
      throw Exception('Failed to delete data');
    }
  }
}
