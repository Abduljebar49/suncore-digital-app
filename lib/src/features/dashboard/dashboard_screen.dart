import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:suncore_mobile/src/core/theme/app_theme.dart';
import 'package:suncore_mobile/src/features/settings/settings_screen.dart';
import 'package:suncore_mobile/src/features/wallet/wallet_screen.dart';

class DashboardScreen extends StatefulWidget {
  final UserProfile? user;
  final VoidCallback onLogout;
  
  const DashboardScreen({
    super.key,
    required this.user,
    required this.onLogout,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Auth0 auth0;
  late Auth0Web auth0Web;

  @override
  void initState() {
    super.initState();
    auth0 = Auth0(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);
    auth0Web = Auth0Web(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);
  }

  Future<void> logout() async {
    try {
      if (kIsWeb) {
        await auth0Web.logout(returnToUrl: 'http://localhost:3000');
      } else {
        await auth0
            .webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME'])
            .logout(useHTTPS: true);
      }
      widget.onLogout();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            if (widget.user?.profileUrl != null)
              CircleAvatar(
                backgroundImage: NetworkImage(widget.user!.profileUrl! as String),
                radius: 16,
              ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dashboard',
                  style: textTheme.titleLarge,
                ),
                if (widget.user?.name != null)
                  Text(
                    widget.user!.name!,
                    style: textTheme.bodySmall,
                  ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // User Info Card (only shown if user has email)
            if (widget.user?.email != null)
              Card(
                color: theme.cardColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      if (widget.user?.profileUrl != null)
                        CircleAvatar(
                          backgroundImage: NetworkImage(widget.user!.profileUrl! as String),
                          radius: 30,
                        ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.user?.name != null)
                              Text(
                                widget.user!.name!,
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            if (widget.user?.email != null)
                              Text(
                                widget.user!.email!,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (widget.user?.email != null) const SizedBox(height: 16),

            // Mining Status Card
            Card(
              color: theme.cardColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Mining Status',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: theme.textTheme.titleMedium?.color,
                          ),
                        ),
                        Chip(
                          label: Text(
                            'ACTIVE',
                            style: TextStyle(
                              color: AppTheme.secondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: AppTheme.backgroundColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(
                          'Hash Rate',
                          '125.4 TH/s',
                          Icons.speed,
                          theme,
                        ),
                        _buildStatItem('Uptime', '99.8%', Icons.timer, theme),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('Energy', '2.4 kWh', Icons.bolt, theme),
                        _buildStatItem(
                          'Temperature',
                          '64°C',
                          Icons.thermostat,
                          theme,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: 0.75,
                      backgroundColor: Colors.grey[800],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.secondaryColor,
                      ),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Daily quota',
                          style: TextStyle(color: AppTheme.textSecondary),
                        ),
                        Text(
                          '75% completed',
                          style: TextStyle(color: AppTheme.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Earnings Card
            Card(
              color: theme.cardColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Earnings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Today',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        Text(
                          '0.00042 BTC',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'This Week',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        Text(
                          '0.0021 BTC',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'All Time',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        Text(
                          '0.042 BTC',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'WITHDRAW EARNINGS',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Quick Actions
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.textTheme.headlineLarge?.color,
              ),
            ),
            const SizedBox(height: 8),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 1,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: [
                _buildActionButton(
                  Icons.power_settings_new,
                  'Power',
                  () {},
                  theme,
                ),
                _buildActionButton(Icons.tune, 'Optimize', () {}, theme),
                _buildActionButton(Icons.bar_chart, 'Stats', () {}, theme),
                _buildActionButton(Icons.account_balance_wallet, 'Wallet', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WalletScreen(),
                    ),
                  );
                }, theme),
                _buildActionButton(Icons.receipt, 'History', () {}, theme),
                _buildActionButton(Icons.settings, 'Settings', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                }, theme),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    String title,
    String value,
    IconData icon,
    ThemeData theme,
  ) {
    return Card(
      color: theme.cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(12),
        width: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 24, color: AppTheme.secondaryColor),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    VoidCallback onPressed,
    ThemeData theme,
  ) {
    return Card(
      color: theme.cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: AppTheme.secondaryColor),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}