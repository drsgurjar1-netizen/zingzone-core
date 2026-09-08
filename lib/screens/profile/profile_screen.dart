import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _activeGridTab = 0; // 0: All Drops, 1: Reels, 2: Vault, 3: Creator Analytics
  final int _vibeCount = 82; // Real-time vibes out of 100

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090714),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  const Text('Aryan_OP', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 6),
                  const Icon(Icons.verified, color: Color(0xFF00E5FF), size: 16),
                  const Spacer(),
                  const Icon(Icons.share_outlined, color: Colors.white70),
                  const SizedBox(width: 14),
                  const Icon(Icons.settings, color: Colors.white70),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 36,
                    backgroundColor: Color(0xFF8A2BE2),
                    child: Text('A', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _statBox('24', 'Drops'),
                        _statBox('$_vibeCount', 'Vibes'),
                        _statBox('180', 'Vibing'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 100 Vibes Club Cashout Meter
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF26103D), Color(0xFF140F26)]),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.amberAccent.withOpacity(0.6)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.stars, color: Colors.amber, size: 14),
                                SizedBox(width: 4),
                                Text('👑 100 Vibe Club (₹100 Bonus)', style: TextStyle(color: Colors.amber, fontSize: 11, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Text('$_vibeCount/100', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(value: _vibeCount / 100, color: const Color(0xFF00E5FF), backgroundColor: Colors.white12, minHeight: 6),
                        const SizedBox(height: 4),
                        Text('Only ${100 - _vibeCount} more vibes to unlock instant ₹100 cash & 70% share!', style: const TextStyle(color: Colors.white54, fontSize: 10)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('Dream | Create | Earn | Grow\nGaming • Travel • Tech Creator 🔥', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(height: 6),
                  // Social Link Chips
                  Row(
                    children: [
                      _socialChip('📸 Insta', '@aryan_live'),
                      const SizedBox(width: 8),
                      _socialChip('✈️ Telegram', 'AryanVibeRoom'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8A2BE2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {},
                      child: const Text('Vibing 🔥', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white24),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {},
                      child: const Text('Message', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white12))),
              child: Row(
                children: [
                  _gridTab(0, 'All Drops'),
                  _gridTab(1, 'Reels'),
                  _gridTab(2, 'Vault 💾'),
                  _gridTab(3, 'Analytics 📊'),
                ],
              ),
            ),
            if (_activeGridTab == 3)
              _buildAnalyticsView()
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(4),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  childAspectRatio: 0.8,
                ),
                itemCount: 9,
                itemBuilder: (ctx, i) {
                  return Container(
                    decoration: BoxDecoration(color: const Color(0xFF1B1430), borderRadius: BorderRadius.circular(6)),
                    child: Stack(
                      children: [
                        const Center(child: Icon(Icons.play_arrow_rounded, color: Colors.white30, size: 30)),
                        Positioned(
                          bottom: 4,
                          left: 4,
                          child: Row(
                            children: [
                              const Icon(Icons.play_arrow, color: Colors.white70, size: 12),
                              Text(' ${(i + 1) * 24}K', style: const TextStyle(color: Colors.white70, fontSize: 10)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsView() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Live Performance (Last 28 Days)', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              _metricTile('Estimated Rev.', '₹2,450', '+24%', Colors.greenAccent),
              const SizedBox(width: 10),
              _metricTile('Total Plays', '142.5K', '+12%', const Color(0xFF00E5FF)),
              const SizedBox(width: 10),
              _metricTile('Watch Hours', '840 hrs', '+8%', Colors.purpleAccent),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: const Color(0xFF140F26), borderRadius: BorderRadius.circular(12)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Audience Retention Rate: 72%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                SizedBox(height: 4),
                Text('Your Ladakh vlog is ranking #1 on ZingZone recommendations.', style: TextStyle(color: Colors.white54, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _metricTile(String label, String val, String grow, Color col) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: const Color(0xFF140F26), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white54, fontSize: 9)),
            const SizedBox(height: 4),
            Text(val, style: TextStyle(color: col, fontSize: 14, fontWeight: FontWeight.bold)),
            Text(grow, style: const TextStyle(color: Colors.greenAccent, fontSize: 9, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _socialChip(String title, String handle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: const Color(0xFF1B1430), borderRadius: BorderRadius.circular(12)),
      child: Text('$title: $handle', style: const TextStyle(color: Colors.white70, fontSize: 10)),
    );
  }

  Widget _statBox(String val, String title) {
    return Column(
      children: [
        Text(val, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(title, style: const TextStyle(color: Colors.white54, fontSize: 11)),
      ],
    );
  }

  Widget _gridTab(int idx, String title) {
    final bool isSel = _activeGridTab == idx;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _activeGridTab = idx),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: isSel ? const Color(0xFF00E5FF) : Colors.transparent, width: 2)),
          ),
          child: Center(
            child: Text(title, style: TextStyle(color: isSel ? const Color(0xFF00E5FF) : Colors.white54, fontSize: 11, fontWeight: isSel ? FontWeight.bold : FontWeight.normal)),
          ),
        ),
      ),
    );
  }
}
