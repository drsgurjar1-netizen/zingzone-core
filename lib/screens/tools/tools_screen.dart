import 'package:flutter/material.dart';

class ToolsScreen extends StatefulWidget {
  const ToolsScreen({super.key});

  @override
  State<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> {
  int _activeSubTab = 0; // 0: Rewards & Tasks, 1: Leaderboard, 2: Refer & Earn

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090714),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildSubTabs(),
            Expanded(
              child: _activeSubTab == 0
                  ? _buildRewardsAndTasks()
                  : _activeSubTab == 1
                      ? _buildLeaderboard()
                      : _buildReferAndEarn(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: const Color(0xFF140F26),
      child: Row(
        children: [
          const Icon(Icons.stars_rounded, color: Color(0xFF00E5FF), size: 24),
          const SizedBox(width: 8),
          const Text('ZingRewards & Tools', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF1B1430),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.amber.withOpacity(0.4)),
            ),
            child: const Row(
              children: [
                Icon(Icons.monetization_on, color: Colors.amber, size: 14),
                SizedBox(width: 4),
                Text('1,450', style: TextStyle(color: Colors.amber, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: const Color(0xFF140F26), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          _tabPill(0, '⚡ Tasks'),
          _tabPill(1, '🏆 Leaderboard'),
          _tabPill(2, '👥 Refer & Earn'),
        ],
      ),
    );
  }

  Widget _tabPill(int idx, String label) {
    final bool isSel = _activeSubTab == idx;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeSubTab = idx),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSel ? const Color(0xFF8A2BE2) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(label, style: TextStyle(color: isSel ? Colors.white : Colors.white60, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  // SUB-TAB 1: REWARDS & TASKS
  Widget _buildRewardsAndTasks() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      children: [
        // Wallet Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF3B1259), Color(0xFF140F26)]),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF8A2BE2)),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Wallet Balance', style: TextStyle(color: Colors.white60, fontSize: 12)),
                  const SizedBox(height: 4),
                  const Text('₹14.50', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                  Text('(1,450 Coins • 100 Coins = ₹1)', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10)),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8A2BE2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                ),
                onPressed: () {},
                child: const Text('Withdraw UPI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Scratch Card Feature
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                backgroundColor: const Color(0xFF140F26),
                title: const Text('🎉 Mystery Chest Unlocked!', style: TextStyle(color: Colors.white, fontSize: 16)),
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.stars_rounded, color: Colors.amber, size: 60),
                    SizedBox(height: 10),
                    Text('+250 Coins added to Wallet!', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Claim Cash', style: TextStyle(color: Colors.white))),
                ],
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF1E1535), Color(0xFF2E1C59)]),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.amberAccent.withOpacity(0.5)),
            ),
            child: const Row(
              children: [
                Icon(Icons.card_giftcard, color: Colors.amberAccent, size: 28),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tap to Scratch Mystery Box 🎁', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                      Text('Ready to claim: Earn 50 to 1,000 Coins instantly', style: TextStyle(color: Colors.white54, fontSize: 11)),
                    ],
                  ),
                ),
                Icon(Icons.touch_app, color: Colors.amberAccent, size: 20),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // CPA Tasks
        const Text('💰 Instant Cash Tasks', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _taskCard('Angel One Demat', 'Open account & place trade', '₹400 / Task', Colors.redAccent),
        const SizedBox(height: 8),
        _taskCard('Kotak 811 Savings', 'Zero balance online account', '₹250 / Task', Colors.blueAccent),
      ],
    );
  }

  // SUB-TAB 2: LEADERBOARD
  Widget _buildLeaderboard() {
    final List<Map<String, dynamic>> topRankers = [
      {'rank': 1, 'name': 'Aryan Sharma', 'earned': '₹12,450', 'badge': '🥇'},
      {'rank': 2, 'name': 'Rider Gaming', 'earned': '₹9,820', 'badge': '🥈'},
      {'rank': 3, 'name': 'Priya Tech', 'earned': '₹7,110', 'badge': '🥉'},
      {'rank': 4, 'name': 'Vikas OP', 'earned': '₹5,400', 'badge': '4'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(14),
      itemCount: topRankers.length,
      itemBuilder: (ctx, i) {
        final r = topRankers[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: const Color(0xFF140F26), borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Text(r['badge'].toString(), style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 12),
              Expanded(child: Text(r['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))),
              Text(r['earned'] as String, style: const TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
        );
      },
    );
  }

  // SUB-TAB 3: REFER & EARN
  Widget _buildReferAndEarn() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF140F26),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF00E5FF)),
          ),
          child: Column(
            children: [
              const Icon(Icons.share_rounded, color: Color(0xFF00E5FF), size: 44),
              const SizedBox(height: 10),
              const Text('Invite Friends & Earn ₹20 Each', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text('When your friend downloads ZingZone and watches 3 videos, you both get 2,000 Coins!', textAlign: TextAlign.center, style: TextStyle(color: Colors.white60, fontSize: 11)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(color: const Color(0xFF1B1430), borderRadius: BorderRadius.circular(10)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('CODE: ZING99', style: TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1.5)),
                    Icon(Icons.copy, color: Colors.white70, size: 18),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _taskCard(String title, String sub, String reward, Color col) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF140F26), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: col.withOpacity(0.2), child: Icon(Icons.bolt, color: col, size: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                Text(sub, style: const TextStyle(color: Colors.white54, fontSize: 10.5)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFF00E5FF).withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
            child: Text(reward, style: const TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold, fontSize: 11)),
          ),
        ],
      ),
    );
  }
}
