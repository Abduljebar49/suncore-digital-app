import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suncore_mobile/src/core/models/kyc_status.dart';
import 'package:suncore_mobile/src/core/repositories/dashboard_repository.dart';
import 'package:suncore_mobile/src/features/dashboard/bloc/kyc/kyc_bloc.dart';
import 'package:suncore_mobile/src/features/dashboard/bloc/kyc/kyc_event.dart';
import 'package:suncore_mobile/src/features/dashboard/bloc/kyc/kyc_state.dart';

class ClientDashboardScreen extends StatelessWidget {
  final String userName;
  final VoidCallback onLogout;

  const ClientDashboardScreen({
    super.key,
    required this.userName,
    required this.onLogout,
  });

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
    return BlocProvider(
      create: (context) =>
          KycBloc(dashboardRepository: DashboardRepository())
            ..add(LoadKycStatus()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('$userName\'s Mining Overview'),
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<KycBloc, KycState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (state is KycLoaded) _buildKycStatusCard(state.status),
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
                          _buildEarningRow(
                            '24 Hours',
                            '0.00042 BTC',
                            '\$16.80',
                          ),
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
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildPerformanceIndicator(
                        'Uptime',
                        '99.2%',
                        Colors.green,
                      ),
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
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
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
            );
          },
        ),
      ),
    );
  }

  Widget _buildKycStatusCard(KycStatus status) {
    Color statusColor;
    switch (status.status) {
      case 'APPROVED':
        statusColor = Colors.green;
        break;
      case 'PENDING':
        statusColor = Colors.orange;
        break;
      case 'REJECTED':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'KYC Verification',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text('Status: ', style: TextStyle(fontSize: 16)),
                Text(
                  status.status,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Email: ${status.email}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
