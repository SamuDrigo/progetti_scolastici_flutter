import 'package:flutter/material.dart';
import 'package:esercizio_2_3/contact.dart';
import 'package:esercizio_2_3/contactEdit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class ContactDetailScreen extends StatelessWidget {
  final Contact contact;

  const ContactDetailScreen({super.key, required this.contact});

  Future<void> _makePhoneCall(String number) async {
    final Uri telUri = Uri(scheme: 'tel', path: number);

    await launchUrl(telUri);
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${contact.name} ${contact.surname}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              final text =
                  '''
Contatto: "${contact.name} ${contact.surname}"
Numeri di telefono:
${contact.phoneNumber.map((n) => "- $n").join("\n")}
''';
              Share.share(text);
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updated = await Navigator.push<Contact?>(
                context,
                MaterialPageRoute(
                  builder: (_) => EditContactScreen(contact: contact),
                ),
              );

              if (updated != null) {
                Navigator.pop(context, updated);
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          for (final number in contact.phoneNumber)
            ListTile(
              leading: Text(
                "Numero: ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              title: Text(number),
              trailing: IconButton(
                icon: const Icon(Icons.call),
                onPressed: () => _makePhoneCall(number),
              ),
            ),
        ],
      ),
    );
  }
}
