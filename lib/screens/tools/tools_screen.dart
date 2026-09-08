import 'package:flutter/material.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090714),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          children: [
            // Top Bar
            Row(
              children: [
                const Icon(Icons.stars_rounded, color: Color(0xFF00E5FF), size: 24),
                const SizedBox(width: 8),
                const Text(
                  'ZingRewards & Tools',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
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
            const SizedBox(height: 14),

            // Wallet Box
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
                      const SizedBox(height: 2),
                      Text('(1,450 Coins • 100 Coins = ₹1)', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10)),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8A2BE2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Minimum withdrawal is ₹50 (5,000 Coins) 💳')),
                      );
                    },
                    child: const Text('Withdraw UPI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // 7-Day Watch Streak
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF140F26),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('🔥 Daily Watch Streak', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                      Text('Day 3/7', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: 3 / 7, color: const Color(0xFF00E5FF), backgroundColor: Colors.white12, minHeight: 6),
                  const SizedBox(height: 6),
                  const Text('Watch 2 more videos today to get +100 Coins bonus!', style: TextStyle(color: Colors.white54, fontSize: 11)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Quick Earn Grid
            const Text('⚡ Quick Earn', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                _quickTile('Watch Videos', '+100-500', Icons.play_circle_filled_rounded, Colors.blueAccent),
                const SizedBox(width: 8),
                _quickTile('Spin & Win', '+50-200', Icons.casino_rounded, Colors.purpleAccent),
                const SizedBox(width: 8),
                _quickTile('Mystery Chest', '+200-1K', Icons.card_giftcard_rounded, Colors.amberAccent),
              ],
            ),
            const SizedBox(height: 18),

            // High Ticket Tasks
            const Text('💰 High Value CPA Tasks', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _taskRow('Angel One Demat', 'Open Account & Trade', '₹400 / Task', Icons.trending_up_rounded, Colors.redAccent),
            const SizedBox(height: 8),
            _taskRow('Kotak 811 Savings', 'Zero balance online bank', '₹250 / Task', Icons.account_balance_rounded, Colors.blueAccent),
            const SizedBox(height: 8),
            _taskRow('Survey Rewards', '3-min feedback poll', '₹100 / Task', Icons.assignment_turned_in_rounded, Colors.greenAccent),
            const SizedBox(height: 18),

            // Creator Tools
            const Text('🛠️ Creator Studio & AI Tools', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                _creatorCard('AI Tags', 'Viral Tags', Icons.smart_toy_rounded),
                const SizedBox(width: 8),
                _creatorCard('100 Vibe Club', '70% Revenue', Icons.stars_rounded),
                const SizedBox(width: 8),
                _creatorCard('Affiliate', 'Link Products', Icons.shopping_bag_rounded),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  static Widget _quickTile(String title, String reward, IconData icon, Color col) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF140F26),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          children: [
            Icon(icon, color: col, size: 26),
            const SizedBox(height: 5),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
              decoration: BoxDecoration(color: Colors.amber.withOpacity(0.2), borderRadius: BorderRadius.circular(6)),
              child: Text(reward, style: const TextStyle(color: Colors.amber, fontSize: 9, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _taskRow(String title, String sub, String cash, IconData icon, Color col) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF140F26), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: col.withOpacity(0.2), child: Icon(icon, color: col, size: 20)),
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
            child: Text(cash, style: const TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold, fontSize: 11)),
          ),
        ],
      ),
    );
  }

  static Widget _creatorCard(String title, String sub, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: const Color(0xFF140F26), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF8A2BE2), size: 20),
            const SizedBox(height: 5),
            Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
            Text(sub, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white38, fontSize: 9)),
          ],
        ),
      ),
    );
  }
}

