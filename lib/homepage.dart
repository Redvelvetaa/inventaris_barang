import 'package:flutter/material.dart';
import 'customdrawer.dart';

class HomePage extends StatelessWidget {
  final String userRole; // Ganti bool isAdmin dengan String userRole
  
  HomePage({required this.userRole});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: CustomDrawer(userRole: userRole), // Kirim userRole ke CustomDrawer
      body: Center(
        child: Text(userRole == 'admin' 
            ? 'Welcome, Admin!' 
            : userRole == 'pegawai' 
            ? 'Welcome, Pegawai!' 
            : 'Welcome, User!'),
      ),
    );
  }
}

