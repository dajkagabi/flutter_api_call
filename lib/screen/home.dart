import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest Api Call'),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final name = user['name']['first'];
            final email = user['email'];
            final imageUrl = user['picture']['thumbnail'];
            return ListTile(
              //  leading: CircleAvatar(child: Text('${index + 1}')),
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(imageUrl)),

              //(name.toString())
              title: Text(name),
              subtitle: Text(email),
            );
          }),
      floatingActionButton: FloatingActionButton(onPressed: fetchUsers),
    );
  }

  void fetchUsers() async {
    //Print error
    debugPrint('fetchUsers called');
    const url = 'https://randomuser.me/api/?results= 25';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      users = json['results'];
    });

    //Print error
    debugPrint('fetchUsers completed');
  }
}
