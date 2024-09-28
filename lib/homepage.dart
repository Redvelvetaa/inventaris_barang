import 'package:flutter/material.dart';
import 'customdrawer.dart';

class HomePage extends StatelessWidget {
  final bool isAdmin;
  const HomePage({super.key, required this.isAdmin});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: CustomDrawer(isAdmin: isAdmin),
      body: Center(
        child: Text(isAdmin ? 'Welcome, Admin!' : 'Welcome, User!'),
      ),
    );
  }
}
