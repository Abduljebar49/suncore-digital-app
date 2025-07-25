import 'package:flutter/material.dart';

class ClientDashboardScreen extends StatelessWidget {
  final String userName;
  final VoidCallback onLogout;

  const ClientDashboardScreen({
    super.key,
    required this.userName,
    required this.onLogout,
  });
  // Helper method to build earning rows
  Widget _buildEarningRow(
    String timeframe,
    String btcAmount,
    String usdAmount,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(timeframe, style: const TextStyle(fontSize: 16)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                btcAmount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                usdAmount,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to build performance indicators
  Widget _buildPerformanceIndicator(String label, String value, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text(value, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  // Helper method to build activity items
  Widget _buildActivityItem(String title, String date, String amount) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.currency_bitcoin, color: Colors.orange),
      title: Text(title),
      subtitle: Text(date),
      trailing: Text(amount),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$userName\'s Mining Overview'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Earnings Summary (Read-only)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Estimated Earnings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildEarningRow('24 Hours', '0.00042 BTC', '\$16.80'),
                    _buildEarningRow('7 Days', '0.00294 BTC', '\$117.60'),
                    _buildEarningRow('30 Days', '0.0126 BTC', '\$504.00'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Hardware Performance
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Hardware Performance',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                _buildPerformanceIndicator('Uptime', '99.2%', Colors.green),
                _buildPerformanceIndicator(
                  'Efficiency',
                  '38 J/TH',
                  Colors.blue,
                ),
                _buildPerformanceIndicator(
                  'Hashrate',
                  '140 TH/s',
                  Colors.purple,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Recent Activity
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recent Activity',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                _buildActivityItem(
                  'Daily Payout',
                  'Today, 08:00',
                  '+0.00042 BTC',
                ),
                _buildActivityItem(
                  'Management Fee',
                  'Oct 1, 2023',
                  '-0.005 BTC',
                ),
                _buildActivityItem(
                  'Monthly Payout',
                  'Sep 1, 2023',
                  '+0.042 BTC',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
