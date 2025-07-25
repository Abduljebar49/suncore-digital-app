import 'package:flutter/material.dart';

class UpgradesScreen extends StatelessWidget {
  const UpgradesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upgrade Options')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cashless Promotions
            const Text(
              'Cashless Upgrade Promotions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildUpgradeOption(
              'Antminer S21 Hyd',
              'Trade in 2x S19 XP for 1x S21 Hyd',
              'Hashrate: 335 TH/s',
              'Power Efficiency: 16 J/TH',
            ),
            _buildUpgradeOption(
              'Whatsminer M60',
              'Trade in 3x M50 for 2x M60',
              'Hashrate: 186 TH/s',
              'Power Efficiency: 22 J/TH',
            ),
            const SizedBox(height: 24),

            // New Hardware Options
            const Text(
              'New Hardware Options',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildNewHardwareOption('Antminer S19 XP', '140 TH/s', '\$2,499'),
            _buildNewHardwareOption('Whatsminer M50S', '126 TH/s', '\$2,199'),
            _buildNewHardwareOption('Avalon A1266', '130 TH/s', '\$2,299'),
          ],
        ),
      ),
    );
  }

  Widget _buildUpgradeOption(
    String model,
    String promotion,
    String hashrate,
    String efficiency,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Use column layout for narrow screens, row for wider ones
            final bool useColumnLayout = constraints.maxWidth < 400;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(promotion, style: TextStyle(color: Colors.blue[700])),
                const SizedBox(height: 8),

                // Responsive layout for specs
                if (useColumnLayout) ...[
                  _buildSpecChip(hashrate),
                  const SizedBox(height: 8),
                  _buildSpecChip(efficiency),
                ] else
                  Row(
                    children: [
                      Flexible(child: _buildSpecChip(hashrate)),
                      const SizedBox(width: 8),
                      Flexible(child: _buildSpecChip(efficiency)),
                    ],
                  ),

                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity, // Make button full width
                  child: ElevatedButton(
                    
                    onPressed: () {},
                    child: const Text('Request Upgrade'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Updated _buildSpecChip to handle text overflow
  // Widget _buildSpecChip(String text) {
  //   return Flexible(
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //       decoration: BoxDecoration(
  //         color: Colors.grey[200],
  //         borderRadius: BorderRadius.circular(16),
  //       ),
  //       child: Text(
  //         text,
  //         overflow: TextOverflow.ellipsis,
  //         maxLines: 1,
  //         style: const TextStyle(fontSize: 12),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildNewHardwareOption(String model, String hashrate, String price) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.hardware),
        title: Text(model),
        subtitle: Text(hashrate),
        trailing: Text(
          price,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildSpecChip(String text) {
    return Chip(
      label: Text(text),
      backgroundColor: Colors.grey[200],
      labelStyle: const TextStyle(fontSize: 12),
    );
  }
}
