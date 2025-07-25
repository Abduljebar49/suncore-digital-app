import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Wallet Address'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'WARNING: Changing your wallet address will affect all future payouts. '
              'Ensure the address is 100% correct as transactions cannot be reversed.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _walletAddressController,
              decoration: const InputDecoration(
                labelText: 'New Bitcoin Wallet Address',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a wallet address';
                }
                // Add more validation logic for BTC addresses
                return null;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
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
                  const SnackBar(content: Text('Wallet address updated')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(!isDarkMode),
          ),
        ],
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Account'),
            tiles: [
              SettingsTile(
                title: const Text('Wallet Address'),
                description: Text(
                  _showWalletField ? 'Editing address' : '••••${_currentWalletAddress.substring(_currentWalletAddress.length - 4)}',
                  style: const TextStyle(fontFamily: 'Monospace'),
                ),
                trailing: _showWalletField
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check),
                            onPressed: () => _showWalletChangeDialog(context),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => setState(() => _showWalletField = false),
                          ),
                        ],
                      )
                    : IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => setState(() => _showWalletField = true),
                      ),
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Appearance'),
            tiles: [
              SettingsTile.switchTile(
                title: const Text('Dark Mode'),
                leading: const Icon(Icons.dark_mode),
                initialValue: isDarkMode,
                onToggle: (value) => themeProvider.toggleTheme(value),
              ),
            ],
          ),
          // SettingsSection(
          //   title: const Text('Security'),
          //   tiles: [
          //     SettingsTile(
          //       title: const Text('Change Password'),
          //       leading: const Icon(Icons.lock),
          //       onPressed: (context) {
          //         // Navigate to password change screen
          //       },
          //     ),
          //     SettingsTile(
          //       title: const Text('Two-Factor Authentication'),
          //       leading: const Icon(Icons.security),
          //       trailing: Switch(
          //         value: false,
          //         onChanged: (value) {
          //           // Implement 2FA toggle
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          SettingsSection(
            title: const Text('About'),
            tiles: [
              SettingsTile(
                title: const Text('Version'),
                description: const Text('1.0.0'),
                leading: const Icon(Icons.info),
              ),
              SettingsTile(
                title: const Text('Terms of Service'),
                leading: const Icon(Icons.description),
                onPressed: (context) {
                  // Show terms
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _walletAddressController.dispose();
    super.dispose();
  }
}