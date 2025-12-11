import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuListScreen extends StatelessWidget {
  const MenuListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        'Margherita – The Mistress',
        'Thin crust trusted by the Don.',
        12.0,
        true,
        'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80&sat=-100'
      ),
      (
        'Smoky Capo BBQ',
        'Brick oven, sweet heat.',
        15.0,
        false,
        'https://images.unsplash.com/photo-1548365328-9da9d5166be6?auto=format&fit=crop&w=800&q=80&sat=-100'
      ),
      (
        'Truffle White Hit',
        'White sauce, parmesan rain.',
        16.0,
        true,
        'https://images.unsplash.com/photo-1547496502-affa22d38842?auto=format&fit=crop&w=800&q=80&sat=-100'
      ),
      (
        'Brick Oven Don',
        'Fire-kissed crust, basil oil.',
        17.0,
        false,
        'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?auto=format&fit=crop&w=800&q=80&sat=-100'
      ),
      (
        'Caprese Hitman',
        'Fresh mozz, basil, olive mafia drizzle.',
        14.0,
        true,
        'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=800&q=80&sat=-100'
      ),
      (
        'Velvet Pepperoni',
        'Loaded curls, velvet cheese pull.',
        15.5,
        false,
        'https://images.unsplash.com/photo-1467003909585-2f8a72700288?auto=format&fit=crop&w=800&q=80&sat=-100'
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('The Hit List')),
      body: Container(
        color: const Color(0xFF1C1512),
        child: ListView(
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
              (item) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F0F0F),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF878787)),
                  boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(0, 4))],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(14),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 84,
                      height: 84,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            item.$5,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(color: const Color(0x550F0F0F)),
                          ),
                          Container(color: const Color(0x550F0F0F)),
                        ],
                      ),
                    ),
                  ),
                  title: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFFF5E8C7))),
                  subtitle: Text(item.$2, style: const TextStyle(color: Color(0xFFC6A667))),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('\$${item.$3.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFFC6A667))),
                      Text(item.$4 ? 'Veg' : 'Non-Veg', style: TextStyle(color: item.$4 ? Colors.greenAccent : Colors.redAccent)),
                    ],
                  ),
                  onTap: () => context.go('/menu/${item.$1}'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

