import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final PageController _ribbonPageController = PageController();
  Timer? _ribbonTimer;
  int _currentRibbonPage = 0;

  bool _showDataBanner = true;
  final Set<String> _vibedCreators = {};

  // Dynamic Ribbon Items: Add as many ads, offers, or data notices as you want!
  final List<Map<String, dynamic>> _ribbonAds = [
    {
      'icon': Icons.cloud_done_rounded,
      'color': Color(0xFF00E5FF),
      'text': 'Free 1 GB Cloud Space Active • Auto-Saves to Vault',
      'tag': 'SYSTEM',
    },
    {
      'icon': Icons.monetization_on_rounded,
      'color': Colors.amberAccent,
      'text': 'Angel One Task: Open Demat & Get ₹400 Instant UPI Cash',
      'tag': 'SPONSORED',
    },
    {
      'icon': Icons.stars_rounded,
      'color': Color(0xFF8A2BE2),
      'text': '👑 100 Vibes Club: Unlock 70% Revenue Share on Your Videos',
      'tag': 'BONUS',
    },
    {
      'icon': Icons.local_fire_department_rounded,
      'color': Colors.redAccent,
      'text': 'Watch 5 Videos Daily to keep your 7-Day Cash Streak alive!',
      'tag': 'REWARD',
    },
  ];

  // Long Videos Data
  final List<Map<String, dynamic>> _longVideos = [
    {
      'id': 'lv_1',
      'title': 'Road Trip to Ladakh | Complete Survival Guide (4K)',
      'channel': 'Travel With Aryan',
      'views': '2.4M views',
      'time': '3 days ago',
      'duration': '18:45',
      'avatar': 'A',
    },
    {
      'id': 'lv_2',
      'title': 'Grandmaster 1v4 Final Circle Clutch & Highlights 🔥',
      'channel': 'Rider Gaming OP',
      'views': '856K views',
      'time': '1 day ago',
      'duration': '12:32',
      'avatar': 'R',
    },
    {
      'id': 'lv_3',
      'title': 'Top 10 AI Tools That Can Replace Coders in 2026',
      'channel': 'Tech Guru India',
      'views': '410K views',
      'time': '5 days ago',
      'duration': '22:10',
      'avatar': 'T',
    },
  ];

  // ZingReels Data (2x2 YouTube style shelf)
  final List<Map<String, dynamic>> _reelsList = [
    {
      'id': 'r_1',
      'title': 'Rimjhim and Sameer New Look...',
      'tag': '#vibes',
      'views': '1.2M',
    },
    {
      'id': 'r_2',
      'title': 'Tu to gaya bete 😂 #comedy',
      'tag': '#fun',
      'views': '850K',
    },
    {
      'id': 'r_3',
      'title': 'Bhai Behen hai ya couple? 💀',
      'tag': '#interview',
      'views': '2.8M',
    },
    {
      'id': 'r_4',
      'title': 'Dance moves on point 🔥 #teamcrazyy',
      'tag': '#dance',
      'views': '642K',
    },
  ];

  @override
  void initState() {
    super.initState();

    // Auto-scroll listener to hide ribbon banner on scrolling
    _scrollController.addListener(() {
      if (_scrollController.offset > 35 && _showDataBanner) {
        setState(() => _showDataBanner = false);
      } else if (_scrollController.offset <= 10 && !_showDataBanner) {
        setState(() => _showDataBanner = true);
      }
    });

    // Auto-play ribbon slider every 4 seconds
    _ribbonTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_ribbonPageController.hasClients) {
        _currentRibbonPage = (_currentRibbonPage + 1) % _ribbonAds.length;
        _ribbonPageController.animateToPage(
          _currentRibbonPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _ribbonPageController.dispose();
    _ribbonTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090714),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopAppBar(),
            Expanded(
              child: ListView(
                controller: _scrollController,
                padding: EdgeInsets.zero,
                children: [
                  // 1. Dynamic Auto-Slide Ribbon (1GB / Ads / Tasks)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: _showDataBanner ? 46 : 0,
                    margin: _showDataBanner
                        ? const EdgeInsets.symmetric(horizontal: 12, vertical: 6)
                        : EdgeInsets.zero,
                    child: _showDataBanner
                        ? _buildDynamicRibbonSlider()
                        : const SizedBox.shrink(),
                  ),

                  // 2. Video 1
                  _buildLongVideoCard(_longVideos[0]),

                  const SizedBox(height: 10),

                  // 3. 2x2 YouTube Style ZingReels Shelf
                  _buildReelsShelfSection(),

                  const SizedBox(height: 14),

                  // 4. Video 2 & 3
                  _buildLongVideoCard(_longVideos[1]),
                  const SizedBox(height: 10),
                  _buildLongVideoCard(_longVideos[2]),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // TOP BAR (Search + Live Coin Box)
  // -------------------------------------------------------------
  Widget _buildTopAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      color: const Color(0xFF140F26),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8A2BE2), Color(0xFF00E5FF)],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'ZING',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.black,
                fontSize: 11,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'ZingZone',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1738),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.amber.withOpacity(0.4)),
            ),
            child: const Row(
              children: [
                Icon(Icons.monetization_on, color: Colors.amber, size: 14),
                SizedBox(width: 4),
                Text(
                  '1,450',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.search, color: Colors.white70, size: 22),
          const SizedBox(width: 10),
          const Icon(Icons.notifications_none, color: Colors.white70, size: 22),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // DYNAMIC SLIDING RIBBON BANNER (Multi-Ad Carousel)
  // -------------------------------------------------------------
  Widget _buildDynamicRibbonSlider() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF18122B),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF8A2BE2).withOpacity(0.35)),
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          PageView.builder(
            controller: _ribbonPageController,
            itemCount: _ribbonAds.length,
            onPageChanged: (idx) => _currentRibbonPage = idx,
            itemBuilder: (ctx, i) {
              final ad = _ribbonAds[i];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Icon(ad['icon'] as IconData, color: ad['color'] as Color, size: 18),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                      decoration: BoxDecoration(
                        color: (ad['color'] as Color).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        ad['tag'] as String,
                        style: TextStyle(
                          color: ad['color'] as Color,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        ad['text'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                  ],
                ),
              );
            },
          ),
          Positioned(
            right: 8,
            child: InkWell(
              onTap: () => setState(() => _showDataBanner = false),
              child: const Icon(Icons.close_rounded, color: Colors.white38, size: 16),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // REELS SHELF (2x2 YouTube Grid in Feed)
  // -------------------------------------------------------------
  Widget _buildReelsShelfSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          child: Row(
            children: [
              const Icon(Icons.bolt_rounded, color: Color(0xFF00E5FF), size: 20),
              const SizedBox(width: 6),
              const Text(
                'ZingReels',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                'See All',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.64,
          ),
          itemCount: _reelsList.length,
          itemBuilder: (ctx, i) {
            final r = _reelsList[i];
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF19122C),
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.purple.withOpacity(0.25),
                            const Color(0xFF090714).withOpacity(0.95),
                          ],
                        ),
                      ),
                    ),
                    const Center(
                      child: Icon(Icons.play_arrow_rounded, color: Colors.white24, size: 40),
                    ),
                    Positioned(
                      left: 8,
                      right: 8,
                      bottom: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            r['title'] as String,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.5,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${r['views']} views',
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // -------------------------------------------------------------
  // LONG VIDEO CARD (⚡ Vibe -> Vibing 🔥)
  // -------------------------------------------------------------
  Widget _buildLongVideoCard(Map<String, dynamic> video) {
    final bool isVibed = _vibedCreators.contains(video['id']);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 195,
          width: double.infinity,
          color: const Color(0xFF1B1430),
          child: Stack(
            children: [
              const Center(
                child: Icon(Icons.play_circle_fill_rounded, color: Color(0xFF8A2BE2), size: 58),
              ),
              Positioned(
                bottom: 8,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    video['duration'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 17,
                backgroundColor: const Color(0xFF8A2BE2),
                child: Text(
                  video['avatar'] as String,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video['title'] as String,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${video['channel']} • ${video['views']} • ${video['time']}',
                      style: const TextStyle(color: Colors.white54, fontSize: 11),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Original Action Button: ⚡ Vibe -> Vibing 🔥
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
                  backgroundColor: isVibed ? const Color(0xFF1D1733) : const Color(0xFF8A2BE2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: isVibed ? const Color(0xFF8A2BE2) : Colors.transparent,
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    if (isVibed) {
                      _vibedCreators.remove(video['id']);
                    } else {
                      _vibedCreators.add(video['id'] as String);
                    }
                  });
                },
                child: Text(
                  isVibed ? 'Vibing 🔥' : '⚡ Vibe',
                  style: TextStyle(
                    color: isVibed ? Colors.white70 : Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
