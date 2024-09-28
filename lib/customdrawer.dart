import 'package:flutter/material.dart';
import 'package:inventaris_barang/tampilbarang.dart';
import 'login.dart'; // Pastikan halaman login diimport agar bisa diarahkan ke login page

class CustomDrawer extends StatelessWidget {
  final bool isAdmin;
  const CustomDrawer({super.key, required this.isAdmin});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menu',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          if (isAdmin) ...[
            ListTile(
              title: const Text('Manage Barang'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BarangList()), //Navigasi ke halaman ProductPage
                );
              },
            ),
            ListTile(
              title: const Text('Manage Pegawai'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Manage Users'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ] else ...[ //side bar untuk user-yog
            ListTile(
              title: const Text('Daftar Barang'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Pinjam Barang'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Log out'),
            onTap: () {
              // Menampilkan dialog konfirmasi untuk logout
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Konfirmasi'),
                    content: const Text('Apakah Anda yakin ingin logout?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Batal'),
                        onPressed: () {
                          Navigator.pop(context); // Tutup dialog
                        },
                      ),
                      TextButton(
                        child: const Text('Log out'),
                        onPressed: () {
                          Navigator.pop(context); // Tutup dialog
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LoginPage()), // Kembali ke login page
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
