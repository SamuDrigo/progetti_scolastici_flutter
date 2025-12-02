import 'package:flutter/material.dart';
import 'package:esercizio_2_3/contact.dart';
import 'package:esercizio_2_3/contactDetail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const ContactListScreen(
        title: 'Lista di contatti che hanno i broccoli',
      ),
    );
  }
}

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key, required this.title});

  final String title;

  @override
  State<ContactListScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ContactListScreen> {
  final List<Contact> contacts = [
    Contact(
      name: 'Andrea',
      surname: 'Rossi',
      phoneNumber: ['+39 351 847 3641', '+39 347 459 4460'],
    ),
    Contact(
      name: 'Alessio',
      surname: 'Verdi',
      phoneNumber: ['+39 375 658 9575'],
    ),
    Contact(
      name: 'Sofia',
      surname: 'Bianchi',
      phoneNumber: ['+39 329 745 1234', '+39 338 456 7890'],
    ),
    Contact(
      name: 'Giacomo',
      surname: 'Neri',
      phoneNumber: ['+39 347 558 4567', '+39 347 765 4321'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            title: Text("${contact.name} ${contact.surname}"),
            onTap: () async {
              final updated = await Navigator.push<Contact?>(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactDetailScreen(contact: contact),
                ),
              );
              if (updated != null) {
                setState(() {
                  contacts[index] = updated;
                });
              }
            },
          );
        },
      ),
    );
  }
}
