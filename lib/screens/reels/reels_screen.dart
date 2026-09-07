import 'dart:async';
import 'package:flutter/material.dart';
import '../../services/admob_service.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  int _currentTabIndex = 0; // 0: Reels, 1: Long Video, 2: Live
  int _secondsLeft = 5;
  Timer? _timer;
  bool _coinEarned = false;

  @override
  void initState() {
    super.initState();
    _startWatchTimer();
  }

  void _startWatchTimer() {
    _secondsLeft = 5;
    _coinEarned = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        setState(() {
          _secondsLeft--;
        });
      } else {
        setState(() {
          _coinEarned = true;
        });
        _timer?.cancel();
        // Trigger coin addition and ad tracker
        AdMobService.checkAndShowReelAd();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060709),
      body: Stack(
        children: [
          // 1. Reel Background Mock Media Area
          PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 20,
            onPageChanged: (index) {
              _startWatchTimer();
            },
            itemBuilder: (context, index) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1F1C2C), Color(0xFF0F0C20)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.movie_filter_rounded, size: 70, color: Colors.white.withOpacity(0.15)),
                      const SizedBox(height: 12),
                      const Text(
                        'Zindagi Ek Safar Hai 🎸',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // 2. Top Header Navigation (Reels | Long Video | Live)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                  const SizedBox(width: 12),
                  const Text(
                    'Video Hub',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const Icon(Icons.search_rounded, color: Colors.white, size: 24),
                ],
              ),
            ),
          ),

          // Tab Bar Strip
          Positioned(
            top: 90,
            left: 16,
            right: 16,
            child: Row(
              children: [
                _buildTabPill('Reels', 0),
                const SizedBox(width: 8),
                _buildTabPill('Long Video', 1),
                const SizedBox(width: 8),
                _buildTabPill('Live', 2),
              ],
            ),
          ),

          // 3. Right Side Action Floating Buttons
          Positioned(
            right: 14,
            bottom: 110,
            child: Column(
              children: [
                _buildActionButton(Icons.favorite_rounded, '12.4K', const Color(0xFFFF2A6D)),
                const SizedBox(height: 16),
                _buildActionButton(Icons.chat_bubble_rounded, '840', Colors.white),
                const SizedBox(height: 16),
                _buildActionButton(Icons.share_rounded, 'Share', Colors.white),
                const SizedBox(height: 18),
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8A2BE2), Color(0xFF00F0FF)],
                    ),
                  ),
                  child: const Icon(Icons.music_note_rounded, color: Colors.white, size: 20),
                ),
              ],
            ),
          ),

          // 4. Bottom Info: Creator Profile + Tag + Countdown Strip
          Positioned(
            left: 16,
            right: 70,
            bottom: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      '@rahul_vlogs',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Follow',
                        style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Desi Gaming Moments #freefire 🔥',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 12),

                // Watch Countdown Progress Strip
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: const Color(0xFF141522).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.12)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _coinEarned ? '✅ +10 Coins Added!' : '🪙 Watch 5s to earn coins',
                        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: _coinEarned ? Colors.green : const Color(0xFF8A2BE2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _coinEarned ? 'Done' : '${_secondsLeft}s',
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabPill(String label, int index) {
    bool isSelected = _currentTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentTabIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF8A2BE2) : const Color(0xFF141522).withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(isSelected ? 0.0 : 0.08)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String count, Color iconColor) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 30),
        const SizedBox(height: 4),
        Text(count, style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
