import 'package:flutter/material.dart';
import 'package:esercizio_2_3/contact.dart';

class EditContactScreen extends StatefulWidget {
  final Contact contact;

  const EditContactScreen({super.key, required this.contact});

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late List<TextEditingController> _phoneControllers;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact.name);
    _surnameController = TextEditingController(text: widget.contact.surname);

    _phoneControllers = widget.contact.phoneNumber
        .map((n) => TextEditingController(text: n))
        .toList();

    if (_phoneControllers.isEmpty) {
      _phoneControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    for (final c in _phoneControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _addPhoneField() {
    setState(() {
      _phoneControllers.add(TextEditingController());
    });
  }

  void _removePhoneField(int index) {
    setState(() {
      final c = _phoneControllers.removeAt(index);
      c.dispose();
    });
  }

  void _saveContact() {
    final name = _nameController.text.trim();
    final surname = _surnameController.text.trim();

    final phones = _phoneControllers
        .map((c) => c.text.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    if (name.isEmpty || surname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inserisci nome e cognome')),
      );
      return;
    }

    final updated = Contact(
      name: name,
      surname: surname,
      phoneNumber: phones,
    );

    Navigator.pop(context, updated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifica contatto'),
        actions: [
          IconButton(
            tooltip: 'Salva',
            icon: const Icon(Icons.save),
            onPressed: _saveContact,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _surnameController,
              decoration: const InputDecoration(
                labelText: 'Cognome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ListView.builder(
                itemCount: _phoneControllers.length,
                itemBuilder: (context, index) {
                  final controller = _phoneControllers[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Numero ${index + 1}',
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          tooltip: 'Rimuovi numero',
                          onPressed: () {
                            if (_phoneControllers.length <= 1) {
                              controller.clear();
                              return;
                            }
                            _removePhoneField(index);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _addPhoneField,
                    icon: const Icon(Icons.add),
                    label: const Text('Aggiungi numero'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
