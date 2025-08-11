import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suncore_mobile/src/core/models/kyc_status.dart';
import 'package:suncore_mobile/src/core/repositories/dashboard_repository.dart';
import 'package:suncore_mobile/src/core/theme/app_theme.dart';
import 'package:suncore_mobile/src/features/asic/asic_management_screen.dart';
import 'package:suncore_mobile/src/features/dashboard/bloc/kyc/kyc_bloc.dart';
import 'package:suncore_mobile/src/features/dashboard/bloc/kyc/kyc_event.dart';
import 'package:suncore_mobile/src/features/dashboard/bloc/kyc/kyc_state.dart';
import 'package:suncore_mobile/src/features/performance/performance_screen.dart';
import 'package:suncore_mobile/src/features/settings/settings_screen.dart';
import 'package:suncore_mobile/src/features/statements/statements_screen.dart';
import 'package:suncore_mobile/src/features/support/support_screen.dart';
import 'package:suncore_mobile/src/features/upgrades/upgrades_screen.dart';
import 'package:suncore_mobile/src/features/wallet/wallet_screen.dart';

class DashboardScreen extends StatelessWidget {
  final String userName;
  final VoidCallback onLogout;

  const DashboardScreen({
    super.key,
    required this.userName,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) =>
          KycBloc(dashboardRepository: DashboardRepository())
            ..add(LoadKycStatus()),
      child: Scaffold(
        backgroundColor: theme.colorScheme.background,
        appBar: AppBar(
          backgroundColor: theme.colorScheme.surface,
          title: Text(
            'Client Dashboard',
            style: TextStyle(color: theme.colorScheme.onSurface),
          ),
          iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
          actions: [
            IconButton(
              icon: Icon(Icons.settings, color: theme.colorScheme.onSurface),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              ),
            ),
            IconButton(
              icon: Icon(Icons.logout, color: theme.colorScheme.onSurface),
              onPressed: onLogout,
              tooltip: 'Logout',
            ),
          ],
        ),
        body: BlocBuilder<KycBloc, KycState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, $userName!',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onBackground,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (state is KycLoaded) _buildKycStatusCard(state.status),
                  // Earnings Card
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Estimated Earnings',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildEarningRow(
                            context,
                            '24 Hours',
                            '0.00042 BTC',
                            '\$16.80',
                          ),
                          _buildEarningRow(
                            context,
                            '7 Days',
                            '0.00294 BTC',
                            '\$117.60',
                          ),
                          _buildEarningRow(
                            context,
                            '30 Days',
                            '0.0126 BTC',
                            '\$504.00',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Hardware Performance
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Hardware Performance',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onBackground,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildPerformanceIndicator(
                        context,
                        'Uptime',
                        '99.2%',
                        AppTheme.successColor,
                      ),
                      _buildPerformanceIndicator(
                        context,
                        'Efficiency',
                        '38 J/TH',
                        AppTheme.accentColor,
                      ),
                      _buildPerformanceIndicator(
                        context,
                        'Hashrate',
                        '140 TH/s',
                        AppTheme.secondaryColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Recent Activity
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       'Recent Activity',
                  //       style: theme.textTheme.titleMedium?.copyWith(
                  //         fontWeight: FontWeight.bold,
                  //         color: theme.colorScheme.onBackground,
                  //       ),
                  //     ),
                  //     const SizedBox(height: 12),
                  //     _buildActivityItem(context, 'Daily Payout', 'Today, 08:00', '+0.00042 BTC'),
                  //     _buildActivityItem(context, 'Management Fee', 'Oct 1, 2023', '-0.005 BTC'),
                  //     _buildActivityItem(context, 'Monthly Payout', 'Sep 1, 2023', '+0.042 BTC'),
                  //   ],
                  // ),
                  // _buildSectionHeader(context, 'Key Performance Metrics'),
                  // const SizedBox(height: 8),
                  // _buildPerformanceMetricsCard(context),
                  // const SizedBox(height: 24),

                  // Quick Access Section
                  _buildSectionHeader(context, 'Quick Access'),
                  const SizedBox(height: 8),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    childAspectRatio: 1.2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: [
                      _buildQuickAction(
                        context,
                        Icons.account_balance_wallet,
                        'Wallet',
                        WalletScreen(),
                      ),
                      _buildQuickAction(
                        context,
                        Icons.bar_chart,
                        'Performance',
                        PerformanceScreen(),
                      ),
                      _buildQuickAction(
                        context,
                        Icons.hardware,
                        'My ASICs',
                        AsicManagementScreen(),
                      ),
                      _buildQuickAction(
                        context,
                        Icons.upgrade,
                        'Upgrades',
                        UpgradesScreen(),
                      ),
                      _buildQuickAction(
                        context,
                        Icons.description,
                        'Statements',
                        StatementsScreen(),
                      ),
                      _buildQuickAction(
                        context,
                        Icons.support,
                        'Support',
                        SupportScreen(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Live Data Section
                  _buildSectionHeader(context, 'Live Data'),
                  const SizedBox(height: 8),
                  _buildLiveDataSection(context, width),
                  const SizedBox(height: 24),

                  // Learning Hub Section
                  _buildSectionHeader(context, 'Learning Hub'),
                  const SizedBox(height: 8),
                  _buildLearningHubSection(context),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEarningRow(
    BuildContext context,
    String timeframe,
    String btcAmount,
    String usdAmount,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              timeframe,
              style: TextStyle(
                fontSize: 16,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                btcAmount,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              Text(
                usdAmount,
                style: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKycStatusCard(KycStatus status) {
    Color statusColor;
    debugPrint('statusColor ${status.toString()}');
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

  Widget _buildPerformanceIndicator(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.onBackground,
      ),
    );
  }

  Widget _buildQuickAction(
    BuildContext context,
    IconData icon,
    String label,
    Widget destination,
  ) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: theme.colorScheme.surface,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 28, color: theme.colorScheme.primary),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLiveDataSection(BuildContext context, double width) {
    final theme = Theme.of(context);
    // Simulated data for charts
    final List<double> btcPrices = [
      29000,
      29250,
      29100,
      29300,
      29500,
      29700,
      29650,
    ];
    final List<double> spyPrices = [440, 442, 441, 443, 444, 443, 442];
    final List<double> miningRates = [120, 122, 118, 125, 123, 127, 130];
    final List<String> timeLabels = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];

    return Column(
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BTC vs Market Indices (Last 7 Days)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 200,
                  width: width * 0.8,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CustomPaint(
                    painter: _ChartPainter(
                      primaryData: btcPrices,
                      secondaryData: spyPrices,
                      labels: timeLabels,
                      primaryColor: theme.colorScheme.primary,
                      secondaryColor: AppTheme.accentColor,
                      primaryLabel: 'BTC (×1000)',
                      secondaryLabel: 'SPY (×100)',
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Simulated data showing BTC correlation with S&P 500',
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mining Performance (TH/s)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 200,
                  width: width,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CustomPaint(
                    painter: _ChartPainter(
                      primaryData: miningRates,
                      labels: timeLabels,
                      primaryColor: AppTheme.successColor,
                      primaryLabel: 'Hashrate',
                      showSecondary: false,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Simulated hashrate data from connected miners',
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLearningHubSection(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildLearningHubItem(
              context,
              'Energy Optimization Tips',
              Icons.bolt,
              () => _showEnergyTips(context),
            ),
            Divider(height: 24, color: theme.dividerColor),
            _buildLearningHubItem(
              context,
              'Latest ASIC Models',
              Icons.hardware,
              () => _showLatestAsics(context),
            ),
            Divider(height: 24, color: theme.dividerColor),
            _buildLearningHubItem(
              context,
              'Company Updates',
              Icons.new_releases,
              () => _showCompanyUpdates(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLearningHubItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 24, color: theme.colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ],
        ),
      ),
    );
  }

  void _showEnergyTips(BuildContext context) {
    // Implementation
  }

  void _showLatestAsics(BuildContext context) {
    // Implementation
  }

  void _showCompanyUpdates(BuildContext context) {
    // Implementation
  }
}

class _ChartPainter extends CustomPainter {
  final List<double> primaryData;
  final List<double>? secondaryData;
  final List<String> labels;
  final Color primaryColor;
  final Color? secondaryColor;
  final String primaryLabel;
  final String? secondaryLabel;
  final bool showSecondary;

  _ChartPainter({
    required this.primaryData,
    this.secondaryData,
    required this.labels,
    this.primaryColor = Colors.blue,
    this.secondaryColor,
    required this.primaryLabel,
    this.secondaryLabel,
    this.showSecondary = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Calculate scaling factors
    final primaryMax = primaryData.reduce((a, b) => a > b ? a : b);
    final primaryMin = primaryData.reduce((a, b) => a < b ? a : b);
    final primaryRange = primaryMax - primaryMin;
    final heightScale = size.height * 0.8 / primaryRange;

    // Draw primary data line
    paint.color = primaryColor;
    _drawDataLine(canvas, size, primaryData, primaryMin, heightScale, paint);

    // Draw secondary data line if applicable
    if (showSecondary && secondaryData != null) {
      final secondaryMax = secondaryData!.reduce((a, b) => a > b ? a : b);
      final secondaryMin = secondaryData!.reduce((a, b) => a < b ? a : b);
      final secondaryRange = secondaryMax - secondaryMin;
      final secondaryHeightScale = size.height * 0.8 / secondaryRange;

      paint.color = secondaryColor!;
      _drawDataLine(
        canvas,
        size,
        secondaryData!,
        secondaryMin,
        secondaryHeightScale,
        paint,
      );
    }

    // Draw axes and labels
    _drawAxes(canvas, size);
  }

  void _drawDataLine(
    Canvas canvas,
    Size size,
    List<double> data,
    double minVal,
    double scale,
    Paint paint,
  ) {
    final path = Path();
    final xStep = size.width / (data.length - 1);

    for (int i = 0; i < data.length; i++) {
      final x = i * xStep;
      final y = size.height - ((data[i] - minVal) * scale) - size.height * 0.1;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      // Draw data points
      canvas.drawCircle(Offset(x, y), 3, paint..style = PaintingStyle.fill);
    }

    canvas.drawPath(path, paint);
  }

  void _drawAxes(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;

    // X-axis
    canvas.drawLine(
      Offset(0, size.height - 20),
      Offset(size.width, size.height - 20),
      paint,
    );

    // Y-axis
    canvas.drawLine(Offset(30, 0), Offset(30, size.height - 20), paint);

    // Labels
    final textStyle = TextStyle(color: Colors.grey[600], fontSize: 10);
    final textSpan = TextSpan(text: '', style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    // X-axis labels
    final xStep = size.width / (labels.length - 1);
    for (int i = 0; i < labels.length; i++) {
      if (i % 2 == 0) {
        // Show every other label for clarity
        textPainter.text = TextSpan(text: labels[i], style: textStyle);
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(i * xStep - textPainter.width / 2, size.height - 18),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
