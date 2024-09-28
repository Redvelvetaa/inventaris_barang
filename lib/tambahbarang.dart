import 'package:flutter/material.dart';
import 'api_service.dart';
import 'barang.dart';

class AddBarangPage extends StatefulWidget {
  const AddBarangPage({super.key});

  @override
  _AddBarangPageState createState() => _AddBarangPageState();
}

class _AddBarangPageState extends State<AddBarangPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaBarangController = TextEditingController();
  final _jenisBarangController = TextEditingController();
  final _merkController = TextEditingController();
  final _keadaanController = TextEditingController();
  final _tahunMasukController = TextEditingController();
  final _jumlahBarangController = TextEditingController();
  final _statusController = TextEditingController();
  @override
  void dispose() {
    _namaBarangController.dispose();
    _jenisBarangController.dispose();
    _merkController.dispose();
    _keadaanController.dispose();
    _tahunMasukController.dispose();
    _jumlahBarangController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final barang = Barang(
        kodeBarang: 0, // API biasanya akan mengatur kode_barang secaraotomatis
        namaBarang: _namaBarangController.text,
        jenisBarang: _jenisBarangController.text,
        merk: _merkController.text,
        keadaan: _keadaanController.text,
        tahunMasuk: int.tryParse(_tahunMasukController.text) ?? 0,
        jumlahBarang: int.tryParse(_jumlahBarangController.text) ?? 0,
        status: _statusController.text,
      );
      ApiService().addBarang(barang).then((_) {
        Navigator.pop(context); // Kembali ke halaman sebelumnya
      }).catchError((error) {
        // Tampilkan error jika gagal
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menambahkan barang: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Tambah Barang'), backgroundColor: const Color(0xFF6A9C89)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaBarangController,
                decoration: const InputDecoration(labelText: 'Nama Barang'),
                validator: (value) => value?.isEmpty ?? true
                    ? 'Nama barang tidak boleh kosong'
                    : null,
              ),
              TextFormField(
                controller: _jenisBarangController,
                decoration: const InputDecoration(labelText: 'Jenis Barang'),
                validator: (value) => value?.isEmpty ?? true
                    ? 'Jenis barang tidak boleh kosong'
                    : null,
              ),
              TextFormField(
                controller: _merkController,
                decoration: const InputDecoration(labelText: 'Merk'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Merk tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _keadaanController,
                decoration: const InputDecoration(labelText: 'Keadaan'),
                validator: (value) => value?.isEmpty ?? true
                    ? 'Keadaan tidak boleh kosong'
                    : null,
              ),
              TextFormField(
                controller: _tahunMasukController,
                decoration: const InputDecoration(labelText: 'Tahun Masuk'),
                keyboardType: TextInputType.number,
                validator: (value) => int.tryParse(value ?? '') == null
                    ? 'Tahun masuk harus berupa angka'
                    : null,
              ),
              TextFormField(
                controller: _jumlahBarangController,
                decoration: const InputDecoration(labelText: 'Jumlah Barang'),
                keyboardType: TextInputType.number,
                validator: (value) => int.tryParse(value ?? '') == null
                    ? 'Jumlah barang harus berupa angka'
                    : null,
              ),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(labelText: 'Status'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Status tidak boleh kosong' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
