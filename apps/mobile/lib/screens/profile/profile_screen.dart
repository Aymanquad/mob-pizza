import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your File')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const ListTile(
              title: Text('John Doe'),
              subtitle: Text('john@example.com • +91 98765 43210'),
              trailing: Icon(Icons.edit),
            ),
            const Divider(),
            const ListTile(
              title: Text('Safehouses'),
              subtitle: Text('Home Base, Office Front'),
              trailing: Icon(Icons.chevron_right),
            ),
            const ListTile(
              title: Text('Family Loyalty'),
              subtitle: Text('Capo • 1,240 Family Points'),
              trailing: Icon(Icons.chevron_right),
            ),
            const ListTile(
              title: Text('Notifications'),
              subtitle: Text('Push • Email'),
              trailing: Icon(Icons.chevron_right),
            ),
            const Divider(),
            const ListTile(
              title: Text('House Secrets'),
              subtitle: Text('Boss Picks • Under-the-Table Deals • Family Combos'),
            ),
          ],
        ),
      ),
    );
  }
}

