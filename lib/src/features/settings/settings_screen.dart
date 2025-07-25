import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suncore_mobile/src/core/theme/app_theme.dart';
import 'package:suncore_mobile/src/core/theme/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _walletAddressController = TextEditingController();
  bool _showWalletField = false;
  String _currentWalletAddress = '3FZbgi29cpjq2GjdwV8eyHuJJnkLtktZc5';

  void _showWalletChangeDialog(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        title: Text(
          'Change Wallet Address',
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'WARNING: Changing your wallet address will affect all future payouts. '
              'Ensure the address is 100% correct as transactions cannot be reversed.',
              style: TextStyle(color: AppTheme.errorColor),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _walletAddressController,
              decoration: InputDecoration(
                labelText: 'New Bitcoin Wallet Address',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.colorScheme.outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                    width: 2,
                  ),
                ),
                labelStyle: TextStyle(color: theme.colorScheme.onSurface),
              ),
              style: TextStyle(color: theme.colorScheme.onSurface),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a wallet address';
                }
                return null;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: theme.colorScheme.primary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_walletAddressController.text.isNotEmpty) {
                setState(() {
                  _currentWalletAddress = _walletAddressController.text;
                  _showWalletField = false;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Wallet address updated'),
                    backgroundColor: AppTheme.successColor,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Settings',
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
        backgroundColor: theme.colorScheme.surface,
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: theme.colorScheme.onSurface,
            ),
            onPressed: () => themeProvider.toggleTheme(!isDarkMode),
          ),
        ],
      ),
      backgroundColor: theme.colorScheme.background,
      body: ListView(
        children: [
          _buildSectionHeader('Account'),
          _buildWalletAddressTile(context),

          _buildSectionHeader('Appearance'),
          _buildDarkModeTile(context, isDarkMode, themeProvider),

          // Uncomment if needed
          // _buildSectionHeader('Security'),
          // _buildSecurityTiles(context),
          _buildSectionHeader('About'),
          _buildAboutTiles(context),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildWalletAddressTile(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text(
        'Wallet Address',
        style: TextStyle(color: theme.colorScheme.onSurface),
      ),
      subtitle: Text(
        _showWalletField
            ? 'Editing address'
            : '••••${_currentWalletAddress.substring(_currentWalletAddress.length - 4)}',
        style: TextStyle(
          fontFamily: 'Monospace',
          color: theme.colorScheme.onSurface.withOpacity(0.7),
        ),
      ),
      trailing: _showWalletField
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.check, color: AppTheme.successColor),
                  onPressed: () => _showWalletChangeDialog(context),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: AppTheme.errorColor),
                  onPressed: () => setState(() => _showWalletField = false),
                ),
              ],
            )
          : IconButton(
              icon: Icon(Icons.edit, color: theme.colorScheme.primary),
              onPressed: () => setState(() => _showWalletField = true),
            ),
    );
  }

  Widget _buildDarkModeTile(
    BuildContext context,
    bool isDarkMode,
    ThemeProvider themeProvider,
  ) {
    final theme = Theme.of(context);
    return SwitchListTile(
      title: Text(
        'Dark Mode',
        style: TextStyle(color: theme.colorScheme.onSurface),
      ),
      secondary: Icon(Icons.dark_mode, color: theme.colorScheme.primary),
      value: isDarkMode,
      activeColor: theme.colorScheme.primary,
      onChanged: (value) => themeProvider.toggleTheme(value),
    );
  }

  Widget _buildSecurityTiles(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        ListTile(
          title: Text(
            'Change Password',
            style: TextStyle(color: theme.colorScheme.onSurface),
          ),
          leading: Icon(Icons.lock, color: theme.colorScheme.primary),
          onTap: () {
            // Navigate to password change screen
          },
        ),
        SwitchListTile(
          title: Text(
            'Two-Factor Authentication',
            style: TextStyle(color: theme.colorScheme.onSurface),
          ),
          secondary: Icon(Icons.security, color: theme.colorScheme.primary),
          value: false,
          activeColor: theme.colorScheme.primary,
          onChanged: (value) {
            // Implement 2FA toggle
          },
        ),
      ],
    );
  }

  Widget _buildAboutTiles(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        ListTile(
          title: Text(
            'Version',
            style: TextStyle(color: theme.colorScheme.onSurface),
          ),
          subtitle: Text(
            '1.0.0',
            style: TextStyle(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          leading: Icon(Icons.info, color: theme.colorScheme.primary),
        ),
        ListTile(
          title: Text(
            'Terms of Service',
            style: TextStyle(color: theme.colorScheme.onSurface),
          ),
          leading: Icon(Icons.description, color: theme.colorScheme.primary),
          onTap: () {
            // Show terms
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _walletAddressController.dispose();
    super.dispose();
  }
}
