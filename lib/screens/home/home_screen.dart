import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              // 1. Top Bar: [Z] ZingZone + Coins Badge + Notification/Support
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF8A2BE2), Color(0xFF4B0082)],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Z',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'ZingZone',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF161822),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withOpacity(0.08)),
                        ),
                        child: const Row(
                          children: [
                            Text('🪙 ', style: TextStyle(fontSize: 12)),
                            Text(
                              '1,450',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.headset_mic_outlined, color: Colors.white.withOpacity(0.8), size: 22),
                      const SizedBox(width: 8),
                      Icon(Icons.notifications_none_rounded, color: Colors.white.withOpacity(0.8), size: 24),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // 2. Hero Banner: 1GB Data / Game
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1D1E30), Color(0xFF0F101A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: const Color(0xFF8A2BE2).withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'PLAY 1 GAME\nGET 1GB DATA',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8A2BE2),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                              minimumSize: const Size(0, 30),
                            ),
                            child: const Text('Claim Now', style: TextStyle(fontSize: 11, color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(
                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          'Jio',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // 3. Four Quick Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickAction(Icons.sports_esports_rounded, 'Esports', const Color(0xFF6A11CB)),
                  _buildQuickAction(Icons.movie_creation_outlined, 'Cinema', const Color(0xFFFF416C)),
                  _buildQuickAction(Icons.local_offer_outlined, 'Loot99', const Color(0xFFFF8C00)),
                  _buildQuickAction(Icons.mic_none_rounded, 'Tasks', const Color(0xFF00C9FF)),
                ],
              ),
              const SizedBox(height: 20),

              // 4. Trending Videos Section
              _buildSectionHeader('Trending Videos'),
              const SizedBox(height: 10),
              SizedBox(
                height: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildVideoCard('Free Fire Squad', '2.4M'),
                    _buildVideoCard('Desi Vibes Status', '1.8M'),
                    _buildVideoCard('Gaming Setup Tour', '1.2M'),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // 5. 4 Squads Video + Chat (Live Strip)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.flash_on_rounded, color: Colors.white, size: 18),
                      SizedBox(width: 4),
                      Text(
                        '4 Squads Video + Chat',
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'LIVE',
                        style: TextStyle(color: Colors.redAccent, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text('See All', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildSquadLiveCard('Free Fire Squad', '4.2k'),
                    _buildSquadLiveCard('BGMI Squad', '2.1k'),
                    _buildSquadLiveCard('Minecraft Squad', '2.1k'),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // 6. Local Deals Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF141622),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white.withOpacity(0.06)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Local Deals', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                        Text('City Gym 50% Off', style: TextStyle(color: Colors.grey, fontSize: 11)),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6A11CB),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                        minimumSize: const Size(0, 26),
                      ),
                      child: const Text('View', style: TextStyle(fontSize: 10, color: Colors.white)),
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

  Widget _buildQuickAction(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFF161824),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.4)),
            boxShadow: [
              BoxShadow(color: color.withOpacity(0.2), blurRadius: 8, spreadRadius: 1),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
        Text('See All', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)),
      ],
    );
  }

  Widget _buildVideoCard(String title, String views) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF161824),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Center(
                child: Icon(Icons.play_circle_fill_rounded, color: Colors.white.withOpacity(0.7), size: 28),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold), maxLines: 1),
                Text('▶ $views', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 9)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSquadLiveCard(String title, String count) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF161824),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold), maxLines: 1),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
              const SizedBox(width: 4),
              Text(count, style: const TextStyle(color: Colors.redAccent, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}

