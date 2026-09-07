import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _secretTapCounter = 0;

  void _handleAdminDoor() {
    _secretTapCounter++;
    if (_secretTapCounter >= 5) {
      _secretTapCounter = 0;
      _showAdminPinDialog();
    }
  }

  void _showAdminPinDialog() {
    final TextEditingController pinController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF131522),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.admin_panel_settings_rounded, color: Color(0xFF00F0FF)),
            SizedBox(width: 8),
            Text('Admin Gateway', style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
        content: TextField(
          controller: pinController,
          keyboardType: TextInputType.number,
          obscureText: true,
          maxLength: 4,
          style: const TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 8),
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            hintText: 'PIN',
            hintStyle: TextStyle(color: Colors.white38, letterSpacing: 0),
            counterText: '',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7B2CBF)),
            onPressed: () {
              Navigator.pop(context);
              if (pinController.text == '7788') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Access Granted: Admin Control Center Unlocked!'),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text('Invalid Security PIN! Access Denied.'),
                  ),
                );
              }
            },
            child: const Text('Unlock', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060709),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header
              const Row(
                children: [
                  Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                  SizedBox(width: 10),
                  Text(
                    'My Profile',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // 2. User Info Card
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF8A2BE2), width: 2),
                      color: const Color(0xFF1E2235),
                    ),
                    child: const Center(
                      child: Icon(Icons.person_rounded, color: Colors.white, size: 32),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Laxman Gurjar',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '@laxman123',
                          style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFF7B2CBF).withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: const Color(0xFF7B2CBF)),
                              ),
                              child: const Text(
                                'Level 12',
                                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 3. Balance Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF191B2E), Color(0xFF0E101C)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Wallet Balance', style: TextStyle(color: Colors.white60, fontSize: 11)),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '₹14.50 (1,450 Coins)',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7B2CBF),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                            minimumSize: const Size(0, 26),
                          ),
                          child: const Text('Withdraw UPI', style: TextStyle(color: Colors.white, fontSize: 11)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // 4. Creator Studio Banner Card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2A103D), Color(0xFF150A22)],
                  ),
                  border: Border.all(color: const Color(0xFF9D4EDD).withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF7B2CBF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.video_library_rounded, color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Grow Your Channel',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          Text(
                            'Get 1,000 Real Subscribers',
                            style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9D4EDD),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        minimumSize: const Size(0, 24),
                      ),
                      child: const Text('Buy Now', style: TextStyle(color: Colors.white, fontSize: 10)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // 5. Menu List Items
              _buildMenuItem(Icons.campaign_outlined, 'Promote YouTube / Instagram', 'Boost Your Social Media'),
              _buildMenuItem(Icons.bar_chart_rounded, 'Analytics', 'View Performance'),
              _buildMenuItem(Icons.account_balance_wallet_outlined, 'Earnings History', 'View All Transactions'),
              _buildMenuItem(Icons.cloud_upload_outlined, 'My Uploads', 'Manage Uploads'),
              _buildMenuItem(Icons.bookmark_outline_rounded, 'Saved Videos', 'Your Saved Content'),
              _buildMenuItem(Icons.privacy_tip_outlined, 'Privacy & Secret Chat', 'Auto Delete (10m) Active'),
              const SizedBox(height: 24),

              // 6. Hidden Admin Door: App Version
              Center(
                child: GestureDetector(
                  onTap: _handleAdminDoor,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    child: Column(
                      children: [
                        Text(
                          'App Version 1.0.0',
                          style: TextStyle(color: Colors.white.withOpacity(0.35), fontSize: 11),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Tap 5x for PIN 7788',
                          style: TextStyle(color: Colors.white.withOpacity(0.18), fontSize: 9),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF131522),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF9D4EDD), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10)),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded, color: Colors.white.withOpacity(0.3), size: 12),
        ],
      ),
    );
  }
}

