import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuListScreen extends StatelessWidget {
  const MenuListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Margherita – The Mistress', 'Thin crust trusted by the Don.', 12.0, true),
      ('Smoky Capo BBQ', 'Brick oven, sweet heat.', 15.0, false),
      ('Truffle White Hit', 'White sauce, parmesan rain.', 16.0, true),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('The Hit List')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search the Hit List…',
            ),
          ),
          const SizedBox(height: 16),
          ...items.map(
            (item) => Card(
              color: const Color(0xFF1C1512),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(14),
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFFD9A441), Color(0xFFB32222)]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                title: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text(item.$2),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('\$${item.$3.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w800)),
                    Text(item.$4 ? 'Veg' : 'Non-Veg', style: TextStyle(color: item.$4 ? Colors.greenAccent : Colors.redAccent)),
                  ],
                ),
                onTap: () => context.go('/menu/${item.$1}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

