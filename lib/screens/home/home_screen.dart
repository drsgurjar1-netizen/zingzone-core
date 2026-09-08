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
  bool _dataSaverActive = false;
  String _selectedCategory = 'All';

  final Set<String> _vibedCreators = {};
  final Set<String> _burstVibeIds = {};

  final List<String> _categories = ['All', '🔥 Gaming', '🎬 Cinema', '💡 AI Tech', '😂 Comedy', '🏍️ Travel'];

  final List<Map<String, dynamic>> _ribbonAds = [
    {'icon': Icons.cloud_done_rounded, 'color': Color(0xFF00E5FF), 'text': 'Free 1 GB Cloud Space Active • Auto-Saves to Vault', 'tag': 'SYSTEM'},
    {'icon': Icons.monetization_on_rounded, 'color': Colors.amberAccent, 'text': 'Angel One Task: Open Demat & Get ₹400 Instant UPI Cash', 'tag': 'SPONSORED'},
    {'icon': Icons.stars_rounded, 'color': Color(0xFF8A2BE2), 'text': '👑 100 Vibes Club: Unlock 70% Revenue Share on Your Videos', 'tag': 'BONUS'},
  ];

  final List<Map<String, dynamic>> _longVideos = [
    {
      'id': 'lv_1',
      'title': 'Road Trip to Ladakh | Complete Survival Guide (4K)',
      'channel': 'Travel With Aryan',
      'views': '2.4M plays',
      'time': '3 days ago',
      'duration': '18:45',
      'avatar': 'A',
      'category': '🏍️ Travel',
    },
    {
      'id': 'lv_2',
      'title': 'Grandmaster 1v4 Final Circle Clutch & Highlights 🔥',
      'channel': 'Rider Gaming OP',
      'views': '856K plays',
      'time': '1 day ago',
      'duration': '12:32',
      'avatar': 'R',
      'category': '🔥 Gaming',
    },
    {
      'id': 'lv_3',
      'title': 'Top 10 AI Tools That Can Replace Coders in 2026',
      'channel': 'Tech Guru India',
      'views': '410K plays',
      'time': '5 days ago',
      'duration': '22:10',
      'avatar': 'T',
      'category': '💡 AI Tech',
    },
  ];

  final List<Map<String, dynamic>> _reelsList = [
    {'id': 'r_1', 'title': 'Rimjhim and Sameer New Look...', 'tag': '#vibes', 'views': '1.2M'},
    {'id': 'r_2', 'title': 'Tu to gaya bete 😂 #comedy', 'tag': '#fun', 'views': '850K'},
    {'id': 'r_3', 'title': 'Bhai Behen hai ya couple? 💀', 'tag': '#interview', 'views': '2.8M'},
    {'id': 'r_4', 'title': 'Dance moves on point 🔥 #teamcrazyy', 'tag': '#dance', 'views': '642K'},
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 40 && _showDataBanner) {
        setState(() => _showDataBanner = false);
      } else if (_scrollController.offset <= 10 && !_showDataBanner) {
        setState(() => _showDataBanner = true);
      }
    });

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

  void _triggerDoubleTapBurst(String videoId) {
    setState(() {
      _burstVibeIds.add(videoId);
      _vibedCreators.add(videoId);
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) {
        setState(() => _burstVibeIds.remove(videoId));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredVideos = _selectedCategory == 'All'
        ? _longVideos
        : _longVideos.where((v) => v['category'] == _selectedCategory).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF090714),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopAppBar(),
            _buildCategoryFilterRow(),
            Expanded(
              child: ListView(
                controller: _scrollController,
                padding: EdgeInsets.zero,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: _showDataBanner ? 46 : 0,
                    margin: _showDataBanner ? const EdgeInsets.symmetric(horizontal: 12, vertical: 6) : EdgeInsets.zero,
                    child: _showDataBanner ? _buildDynamicRibbonSlider() : const SizedBox.shrink(),
                  ),
                  if (filteredVideos.isNotEmpty) _buildLongVideoCard(filteredVideos[0]),
                  const SizedBox(height: 10),
                  _buildReelsShelfSection(),
                  const SizedBox(height: 14),
                  for (int i = 1; i < filteredVideos.length; i++) ...[
                    _buildLongVideoCard(filteredVideos[i]),
                    const SizedBox(height: 10),
                  ],
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      color: const Color(0xFF140F26),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF8A2BE2), Color(0xFF00E5FF)]),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('ZING', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black, fontSize: 11, letterSpacing: 1)),
          ),
          const SizedBox(width: 8),
          const Text('ZingZone', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
          const Spacer(),
          // Data Saver Toggle Button
          InkWell(
            onTap: () {
              setState(() => _dataSaverActive = !_dataSaverActive);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_dataSaverActive ? '⚡ Data Saver ON: Saving 50% Mobile Data' : 'Data Saver OFF: High Definition Stream'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _dataSaverActive ? const Color(0xFF00E5FF).withOpacity(0.2) : const Color(0xFF1E1738),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _dataSaverActive ? const Color(0xFF00E5FF) : Colors.white12),
              ),
              child: Row(
                children: [
                  Icon(Icons.bolt, color: _dataSaverActive ? const Color(0xFF00E5FF) : Colors.white60, size: 14),
                  const SizedBox(width: 3),
                  Text(_dataSaverActive ? 'Saver' : 'HD', style: TextStyle(color: _dataSaverActive ? const Color(0xFF00E5FF) : Colors.white60, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
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
                Text('1,450', style: TextStyle(color: Colors.amber, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilterRow() {
    return Container(
      height: 38,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _categories.length,
        itemBuilder: (ctx, i) {
          final cat = _categories[i];
          final isSel = _selectedCategory == cat;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(cat),
              selected: isSel,
              selectedColor: const Color(0xFF8A2BE2),
              backgroundColor: const Color(0xFF140F26),
              labelStyle: TextStyle(color: isSel ? Colors.white : Colors.white70, fontSize: 11, fontWeight: isSel ? FontWeight.bold : FontWeight.normal),
              side: BorderSide(color: isSel ? const Color(0xFF00E5FF) : Colors.white10),
              onSelected: (_) => setState(() => _selectedCategory = cat),
            ),
          );
        },
      ),
    );
  }

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
                      decoration: BoxDecoration(color: (ad['color'] as Color).withOpacity(0.15), borderRadius: BorderRadius.circular(4)),
                      child: Text(ad['tag'] as String, style: TextStyle(color: ad['color'] as Color, fontSize: 9, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(ad['text'] as String, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500)),
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
              const Text('ZingReels', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
              const Spacer(),
              Text('See All', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12)),
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
                decoration: const BoxDecoration(color: Color(0xFF19122C)),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.purple.withOpacity(0.25), const Color(0xFF090714).withOpacity(0.95)],
                        ),
                      ),
                    ),
                    const Center(child: Icon(Icons.play_arrow_rounded, color: Colors.white24, size: 40)),
                    Positioned(
                      left: 8,
                      right: 8,
                      bottom: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r['title'] as String, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11.5)),
                          const SizedBox(height: 3),
                          Text('${r['views']} plays', style: const TextStyle(color: Colors.white54, fontSize: 10)),
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

  Widget _buildLongVideoCard(Map<String, dynamic> video) {
    final String id = video['id'] as String;
    final bool isVibed = _vibedCreators.contains(id);
    final bool isBursting = _burstVibeIds.contains(id);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onDoubleTap: () => _triggerDoubleTapBurst(id),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 195,
                width: double.infinity,
                color: const Color(0xFF1B1430),
                child: Stack(
                  children: [
                    const Center(child: Icon(Icons.play_circle_fill_rounded, color: Color(0xFF8A2BE2), size: 58)),
                    Positioned(
                      bottom: 8,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.85), borderRadius: BorderRadius.circular(4)),
                        child: Text(video['duration'] as String, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
              if (isBursting)
                const Icon(Icons.bolt, color: Color(0xFF00E5FF), size: 90),
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
                child: Text(video['avatar'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(video['title'] as String, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.5)),
                    const SizedBox(height: 3),
                    Text('${video['channel']} • ${video['views']} • ${video['time']}', style: const TextStyle(color: Colors.white54, fontSize: 11)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
                  backgroundColor: isVibed ? const Color(0xFF1D1733) : const Color(0xFF8A2BE2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: isVibed ? const Color(0xFF8A2BE2) : Colors.transparent),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    if (isVibed) {
                      _vibedCreators.remove(id);
                    } else {
                      _vibedCreators.add(id);
                    }
                  });
                },
                child: Text(isVibed ? 'Vibing 🔥' : '⚡ Vibe', style: TextStyle(color: isVibed ? Colors.white70 : Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
