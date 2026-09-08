import 'package:flutter/material.dart';
import '../widgets/poll_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _walletBalance = 0.0;

  void _addReward(double amt) {
    setState(() {
      _walletBalance += amt;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF00FFCC),
        content: Text(
          '₹${amt.toInt()} added to your Zing Wallet!',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090714),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          // 1. TOP CINEMATIC FEATURED POSTER / TRAILER CARD
          Container(
            margin: const EdgeInsets.all(14),
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF2E1256), Color(0xFF140D2E)],
              ),
              border: Border.all(color: const Color(0xFF8A2BE2).withOpacity(0.4)),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black38,
                    ),
                    child: const Center(
                      child: Icon(Icons.play_circle_fill, size: 54, color: Color(0xFF00FFCC)),
                    ),
                  ),
                ),
                Positioned(
                  top: 14,
                  left: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'PREMIERE',
                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 14,
                  left: 14,
                  right: 14,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SHADOW RUNNERS (Season 1)',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Action • 45 min • 4K HDR',
                            style: TextStyle(color: Colors.white54, fontSize: 11),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00FFCC),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {},
                        child: const Text('Watch', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. 16:9 LONG VIDEO CARD 1
          _longVideoCard(
            title: 'How AI is Changing Mobile Coding in 2026',
            channel: 'Zing Tech Labs',
            views: '45K views',
            duration: '18:24',
          ),

          // 3. SPONSORED RESEARCH POLL (REWARD ₹1)
          ResearchPollCard(
            question: 'Which brand are you planning to buy next?',
            options: const ['OnePlus', 'Apple iPhone', 'Samsung Galaxy', 'Nothing Phone'],
            rewardAmount: 1.0,
            onVoted: () => _addReward(1.0),
          ),

          // 4. 16:9 LONG VIDEO CARD 2
          _longVideoCard(
            title: 'Top 5 Unreal Engine Games Coming This Year',
            channel: 'Gaming Arena',
            views: '110K views',
            duration: '26:50',
          ),
        ],
      ),
    );
  }

  Widget _longVideoCard({
    required String title,
    required String channel,
    required String views,
    required String duration,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF140F26),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 16:9 Box
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF1B1633),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Stack(
                children: [
                  const Center(child: Icon(Icons.movie_creation_outlined, color: Colors.white24, size: 40)),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        duration,
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: Color(0xFF2E2452),
                  child: Icon(Icons.person, color: Colors.white70, size: 18),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$channel • $views',
                        style: const TextStyle(color: Colors.white38, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_vert, color: Colors.white38, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

