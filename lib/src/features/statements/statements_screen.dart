import 'package:flutter/material.dart';

class StatementsScreen extends StatelessWidget {
  const StatementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statements')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Options
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    value: '2023',
                    items: ['2023', '2022', '2021'].map((year) {
                      return DropdownMenuItem(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      labelText: 'Year',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField(
                    value: 'All',
                    items: ['All', 'Q1', 'Q2', 'Q3', 'Q4'].map((quarter) {
                      return DropdownMenuItem(
                        value: quarter,
                        child: Text(quarter),
                      );
                    }).toList(),
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      labelText: 'Quarter',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Statements List
            const Text(
              'Available Statements',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildStatementItem('Q3 2023 Statement', 'Oct 1, 2023'),
            _buildStatementItem('Q2 2023 Statement', 'Jul 1, 2023'),
            _buildStatementItem('Q1 2023 Statement', 'Apr 1, 2023'),
            _buildStatementItem('2022 Annual Statement', 'Jan 31, 2023'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatementItem(String title, String date) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
        title: Text(title),
        subtitle: Text(date),
        trailing: IconButton(
          icon: const Icon(Icons.download),
          onPressed: () {},
        ),
      ),
    );
  }
}