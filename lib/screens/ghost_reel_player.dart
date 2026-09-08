import 'dart:async';
import 'package:flutter/material.dart';

class GhostReelPlayer extends StatefulWidget {
  const GhostReelPlayer({super.key});

  @override
  State<GhostReelPlayer> createState() => _GhostReelPlayerState();
}

class _GhostReelPlayerState extends State<GhostReelPlayer> {
  final PageController _pageCtrl = PageController();
  bool _showHud = false;
  Timer? _hudTimer;
  bool _isLiked = false;
  bool _isMuted = false;
  bool _is2x = false;

  // 120 सेकंड रील सिम्युलेटर डेटा
  final List<Map<String, dynamic>> _reels = [
    {
      'creator': '@neon_coder',
      'caption': 'Zero cost edge streaming engine in action 🔥 #ZingZone #Flutter',
      'duration': '1:54',
      'likes': '12.4K',
      'comments': '342',
    },
    {
      'creator': '@vibe_dangal',
      'caption': 'Round 4 Battle: Vote your favorite edit below! 🎬⚡',
      'duration': '1:20',
      'likes': '8.9K',
      'comments': '180',
    },
  ];

  void _triggerHud() {
    _hudTimer?.cancel();
    setState(() => _showHud = true);
    _hudTimer = Timer(const Duration(milliseconds: 3500), () {
      if (mounted) setState(() => _showHud = false);
    });
  }

  @override
  void dispose() {
    _hudTimer?.cancel();
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageCtrl,
        scrollDirection: Axis.vertical,
        itemCount: _reels.length,
        itemBuilder: (ctx, i) {
          final reel = _reels[i];
          return GestureDetector(
            onTap: _triggerHud,
            onDoubleTap: () {
              setState(() => _isLiked = !_isLiked);
              _triggerHud();
            },
            onLongPressStart: (_) => setState(() => _is2x = true),
            onLongPressEnd: (_) => setState(() => _is2x = false),
            child: Stack(
              children: [
                // 1. रील्स बैकग्राउंड (वीडियो प्लेयर बॉक्स)
                Container(
                  color: const Color(0xFF090714),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.movie_filter_outlined, size: 80, color: Colors.white12),
                        const SizedBox(height: 12),
                        Text(
                          'Reel ${i + 1} (${reel['duration']})',
                          style: const TextStyle(color: Colors.white38, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),

                // 2. 2X स्पीड इंडिकेटर
                if (_is2x)
                  Positioned(
                    top: 40,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFF00FFCC), width: 0.8),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.fast_forward, color: Color(0xFF00FFCC), size: 14),
                            SizedBox(width: 4),
                            Text('2X SPEED', style: TextStyle(color: Color(0xFF00FFCC), fontSize: 11, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),

                // 3. GHOST HUD OVERLAY (केवल टैप करने पर 3.5s के लिए दिखता है)
                AnimatedOpacity(
                  opacity: _showHud ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 250),
                  child: IgnorePointer(
                    ignoring: !_showHud,
                    child: Stack(
                      children: [
                        // निचला ग्रेडिएंट ताकि टेक्स्ट साफ़ दिखे
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          height: 200,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black87],
                              ),
                            ),
                          ),
                        ),

                        // दायाँ एक्शन बार (Like, Comment, Share, Mute)
                        Positioned(
                          right: 12,
                          bottom: 30,
                          child: Column(
                            children: [
                              _sideAction(
                                _isLiked ? Icons.favorite : Icons.favorite_border,
                                reel['likes'],
                                _isLiked ? Colors.redAccent : Colors.white,
                                () => setState(() => _isLiked = !_isLiked),
                              ),
                              const SizedBox(height: 18),
                              _sideAction(Icons.chat_bubble_outline, reel['comments'], Colors.white, () {}),
                              const SizedBox(height: 18),
                              _sideAction(Icons.share_outlined, 'Share', Colors.white, () {}),
                              const SizedBox(height: 18),
                              _sideAction(
                                _isMuted ? Icons.volume_off : Icons.volume_up,
                                _isMuted ? 'Muted' : 'Audio',
                                _isMuted ? Colors.orangeAccent : const Color(0xFF00FFCC),
                                () => setState(() => _isMuted = !_isMuted),
                              ),
                            ],
                          ),
                        ),

                        // निचला क्रिएटर इंफो और 120s टैग
                        Positioned(
                          left: 14,
                          bottom: 24,
                          right: 80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    reel['creator'],
                                    style: const TextStyle(color: Color(0xFF00FFCC), fontWeight: FontWeight.bold, fontSize: 14),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF8A2BE2).withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Text('120s Reel', style: TextStyle(color: Colors.white70, fontSize: 9)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                reel['caption'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _sideAction(IconData icon, String label, Color col, VoidCallback tap) {
    return GestureDetector(
      onTap: tap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.black45,
            child: Icon(icon, color: col, size: 22),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

