import 'package:flutter/material.dart';
import 'api_service.dart';
import 'barang.dart';

class EditBarangPage extends StatefulWidget {
  final Barang barang;
  const EditBarangPage({super.key, required this.barang});
  @override
  _EditBarangPageState createState() => _EditBarangPageState();
}

class _EditBarangPageState extends State<EditBarangPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _jenisController;
  late TextEditingController _merkController;
  late TextEditingController _keadaanController;
  late TextEditingController _tahunController;
  late TextEditingController _jumlahController;
  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.barang.namaBarang);
    _jenisController = TextEditingController(text: widget.barang.jenisBarang);
    _merkController = TextEditingController(text: widget.barang.merk);
    _keadaanController = TextEditingController(text: widget.barang.keadaan);
    _tahunController =
        TextEditingController(text: widget.barang.tahunMasuk.toString());
    _jumlahController =
        TextEditingController(text: widget.barang.jumlahBarang.toString());
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final barang = Barang(
        kodeBarang: widget.barang.kodeBarang,
        namaBarang: _namaController.text,
        jenisBarang: _jenisController.text,
        merk: _merkController.text,
        keadaan: _keadaanController.text,
        tahunMasuk: int.parse(_tahunController.text),
        jumlahBarang: int.parse(_jumlahController.text),
        status: widget.barang
            .status, // Status bisa tetap atau diperbarui sesuai kebutuhan
      );
      try {
        await ApiService().updateBarang(barang);
        Navigator.pop(
            context, true); // Kembali ke halaman daftar dengan status berhasil
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Gagal memperbarui barang')));
      }
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama Barang'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Barang tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _jenisController,
                decoration: const InputDecoration(labelText: 'Jenis Barang'),
              ),
              TextFormField(
                controller: _merkController,
                decoration: const InputDecoration(labelText: 'Merk'),
              ),
              TextFormField(
                controller: _keadaanController,
                decoration: const InputDecoration(labelText: 'Keadaan'),
              ),
              TextFormField(
                controller: _tahunController,
                decoration: const InputDecoration(labelText: 'Tahun Masuk'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _jumlahController,
                decoration: const InputDecoration(labelText: 'Jumlah Barang'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _save,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
