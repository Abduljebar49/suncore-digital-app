import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Support',
          style: TextStyle(
            fontFamily: 'Noto Sans',
            fontWeight: FontWeight.w400,
            fontSize: 22,
          ),
        ),
        backgroundColor: const Color(0xFF101010),
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: const Color(0xFFf9fafd),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'We go the extra 93 million miles',
                textAlign: TextAlign.center,

                style: TextStyle(
                  fontFamily: 'Libre Caslon Display',
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF856d4a),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 24),

              // Contact Information
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Personal Liaison',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Libre Caslon Display',
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8d8fa7),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildContactCard(
                      'Sarah Johnson',
                      'Senior Client Relations',
                      'sarah.johnson@suncore.com',
                      '(555) 123-4567',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Contact Form
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Direct Support',
                      style: TextStyle(
                        fontFamily: 'Libre Caslon Display',
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8d8fa7),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Subject',
                        labelStyle: const TextStyle(color: Color(0xFF6C6C77)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFD9D9D9),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF4a6cf7),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Message',
                        labelStyle: const TextStyle(color: Color(0xFF6C6C77)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFD9D9D9),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF4a6cf7),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4a6cf7),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Send Message',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // FAQ Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Frequently Asked Questions',
                      style: TextStyle(
                        fontFamily: 'Libre Caslon Display',
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8d8fa7),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFAQItem('How do I add a new ASIC to my account?'),
                    _buildFAQItem('What are the current maintenance fees?'),
                    _buildFAQItem('How often are payouts processed?'),
                    _buildFAQItem('What upgrade options are available?'),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Call to Action
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8e8fa8), Color(0xFF2b292d)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text(
                      'NEED IMMEDIATE ASSISTANCE?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF01c8e1),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Call Support Now',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(
    String name,
    String title,
    String email,
    String phone,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFeffbff),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF01c8e1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF2b292d),
                  ),
                ),
                Text(title, style: const TextStyle(color: Color(0xFF6C6C77))),
                const SizedBox(height: 8),
                Text(email, style: const TextStyle(color: Color(0xFF4a6cf7))),
                Text(phone, style: const TextStyle(color: Color(0xFF2b292d))),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chat, color: Color(0xFF4a6cf7)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD9D9D9)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFF2b292d),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Answer to $question would appear here with detailed information. Our support team is available 24/7 to assist with any additional questions you may have.',
              style: const TextStyle(color: Color(0xFF6C6C77)),
            ),
          ),
        ],
      ),
    );
  }
}
