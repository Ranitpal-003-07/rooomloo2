import 'package:flutter/material.dart';

class FindPGScreen extends StatefulWidget {
  const FindPGScreen({super.key});

  @override
  State<FindPGScreen> createState() => _FindPGScreenState();
}

class _FindPGScreenState extends State<FindPGScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for PGs...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.filter_list),
                label: const Text("Filters"),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Replace with actual PG data count
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.home, size: 40, color: Colors.blue),
                      title: Text('PG Name $index'),
                      subtitle: Text('Location: City $index\nPrice: ₹${3000 + (index * 500)}'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigate to PG Details Page
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
