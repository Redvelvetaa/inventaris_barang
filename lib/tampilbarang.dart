import 'package:flutter/material.dart';
import 'package:inventaris_barang/tambahbarang.dart';
import 'api_service.dart';
import 'barang.dart';
import 'editbarang.dart'; // Import halaman edit
class BarangList extends StatefulWidget {
  const BarangList({super.key});

 @override
 _BarangListState createState() => _BarangListState();
}
class _BarangListState extends State<BarangList> {
 late Future<List<Barang>> futureBarang;
 @override
 void initState() {
 super.initState();
 futureBarang = ApiService().getBarang();
 }
 void _confirmDelete(BuildContext context, Barang barang) {
 showDialog(
 context: context,
 builder: (context) {
 return AlertDialog(
 title: const Text('Konfirmasi'),
 content: Text('Apakah Anda yakin ingin menghapus${barang.namaBarang}?'),
 actions: [
 TextButton(
 onPressed: () {
 Navigator.pop(context); // Tutup dialog
 },
 child: const Text('Batal'),
 ),
 TextButton(
 onPressed: () {
 ApiService().deleteBarang(barang.kodeBarang).then((_) {
 setState(() {
 futureBarang = ApiService().getBarang(); // Memuat ulang daftar barang setelah dihapus
 });
Navigator.pop(context); // Tutup dialog
 });
 },
 child: const Text('Hapus'),
 ),
 ],
 );
 },
 );
 }
 @override
 Widget build(BuildContext context) {
 return Scaffold(
 appBar: AppBar(
 title: const Text('Daftar Barang'),
 backgroundColor: const Color(0xFF6A9C89),
 ),
 body: FutureBuilder<List<Barang>>(
 future: futureBarang,
 builder: (context, snapshot) {
 if (snapshot.connectionState == ConnectionState.waiting) {
 return const Center(child: CircularProgressIndicator());
 } else if (snapshot.hasError) {
 return Center(child: Text('Terjadi kesalahan:${snapshot.error}'));
 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
 return const Center(child: Text('Tidak ada barang yang tersedia.'));
 } else {
 return ListView.builder(
 itemCount: snapshot.data!.length,
 itemBuilder: (context, index) {
 final barang = snapshot.data![index];
 return Container(
 margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
 padding: const EdgeInsets.all(12),
 decoration: BoxDecoration(
 color: Colors.white,
borderRadius: BorderRadius.circular(8),
 boxShadow: [
 BoxShadow(
 color: Colors.grey.withOpacity(0.3),
 spreadRadius: 2,
blurRadius: 5,
offset: const Offset(0, 3), // shadow direction: bottom right
 ),
 ],
 ),
child: ListTile(
 title: Text(barang.namaBarang, style:
const TextStyle(fontWeight: FontWeight.bold)),
 subtitle: Column(
 crossAxisAlignment: CrossAxisAlignment.start,
 children: [
 Text('Jenis: ${barang.jenisBarang}'),
 Text('Merk: ${barang.merk}'),
 Text('Keadaan: ${barang.keadaan}'),
 Text('Tahun Masuk: ${barang.tahunMasuk}'),
 Text('Jumlah: ${barang.jumlahBarang}'),
 Text('Status: ${barang.status}'),
 ],
 ),
trailing: Row(
 mainAxisSize: MainAxisSize.min,
children: [
 IconButton(
 icon: const Icon(Icons.edit),
 onPressed: () async {
 final result = await Navigator.push(
 context,
MaterialPageRoute(
 builder: (context) => EditBarangPage(barang:barang),
 ),
 );
 if (result == true) {
 setState(() {
 futureBarang = ApiService().getBarang(); //Memuat ulang daftar barang setelah diupdate
 });
 }
 },
 ),
IconButton(
 icon: const Icon(Icons.delete),
 onPressed: () {
 _confirmDelete(context, barang); // Tampilkandialog konfirmasi sebelum hapus
 },
 ),
 ],
 ),
 ),
 );
 },
 );
 }
 },
 ),
 floatingActionButton: FloatingActionButton(
 onPressed: () {
 Navigator.push(
 context,
 MaterialPageRoute(builder: (context) => AddBarangPage()), //Ganti dengan halaman tambah barang Anda
 ).then((_) {
 setState(() {
 futureBarang = ApiService().getBarang(); // Memuat ulang daftar barang setelah ditambahkan
 });
 });
 },
 child: const Icon(Icons.add),
 ),
 );
 }
}