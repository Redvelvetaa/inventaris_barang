import 'package:flutter/material.dart';
import 'package:inventaris_barang/tampilbarang.dart';
import 'login.dart'; // Pastikan halaman login diimport agar bisa diarahkan ke login page

class CustomDrawer extends StatelessWidget {
  final String userRole; // Bisa "admin", "pegawai", atau "user"
  CustomDrawer({required this.userRole});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          if (userRole == 'admin') ...[
            ListTile(
              title: Text('Manage Barang'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => BarangList()));
              },
            ),
            ListTile(
              title: Text('Manage Pegawai'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Manage Users'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ] else if (userRole == 'pegawai') ...[
            ListTile(
              title: Text('Daftar Barang'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Pinjam Barang'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ] else ...[
            ListTile(
              title: Text('Daftar Barang'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Pinjam Barang'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
          ListTile(
            title: Text('Profile'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Log out'),
            onTap: () {
              // Tampilkan dialog konfirmasi logout
            },
          ),
        ],
      ),
    );
  }
}
