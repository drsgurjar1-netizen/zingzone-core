import 'package:flutter/material.dart';

class ToolsScreen extends StatefulWidget {
  const ToolsScreen({super.key});

  @override
  State<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090714),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Container(
          color: const Color(0xFF140F26),
          child: TabBar(
            controller: _tabCtrl,
            indicatorColor: const Color(0xFF00FFCC),
            labelColor: const Color(0xFF00FFCC),
            unselectedLabelColor: Colors.white54,
            labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: '🎮 Free Fire Hub'),
              Tab(text: '⚔️ Reel Dangal'),
              Tab(text: '🧰 150+ Tools'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _freeFireTab(),
          _reelDangalTab(),
          _utilityKitTab(),
        ],
      ),
    );
  }

  // 1. FREE FIRE / BGMI TOURNAMENT HUB
  Widget _freeFireTab() {
    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        _matchCard(
          title: 'Free Fire Clash Squad: 50 Slots',
          entryFee: '₹10',
          pool: '₹500',
          time: 'Starts Today at 8:00 PM',
          slotsLeft: '14 / 50 Left',
          isLocked: true,
        ),
        _matchCard(
          title: 'BGMI Erangel Mega Rush',
          entryFee: '₹20',
          pool: '₹1,000',
          time: 'Starts Today at 9:30 PM',
          slotsLeft: '6 / 50 Left',
          isLocked: true,
        ),
      ],
    );
  }

  Widget _matchCard({
    required String title,
    required String entryFee,
    required String pool,
    required String time,
    required String slotsLeft,
    required bool isLocked,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF140F26),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF8A2BE2).withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('Pool: $pool', style: const TextStyle(color: Colors.amber, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('$time • $slotsLeft', style: const TextStyle(color: Colors.white54, fontSize: 11)),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(isLocked ? Icons.lock : Icons.lock_open, color: const Color(0xFF00FFCC), size: 16),
                  const SizedBox(width: 4),
                  const Text('Room ID unlocks 15m prior', style: TextStyle(color: Colors.white38, fontSize: 10)),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00FFCC),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {},
                child: Text('Join for $entryFee', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 2. REEL DANGAL (VOTING POOL)
  Widget _reelDangalTab() {
    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF2E1256), Color(0xFF140F26)]),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFF00FFCC).withOpacity(0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('⚡ Active Dangal: Round 12', style: TextStyle(color: Color(0xFF00FFCC), fontSize: 15, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('50 Creators Slot • ₹5 Entry • ₹200 Winner Prize', style: TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 14),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8A2BE2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {},
                icon: const Icon(Icons.upload, color: Colors.white, size: 16),
                label: const Text('Enter Reel (₹5 Slot)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 3. 150+ CREATOR UTILITY KIT
  Widget _utilityKitTab() {
    final tools = [
      {'title': 'AI Auto Subtitles', 'desc': 'Generate subtitles in Hindi/English', 'icon': Icons.subtitles},
      {'title': 'Audio Denoiser', 'desc': 'Remove background noise from voice', 'icon': Icons.graphic_eq},
      {'title': 'Vocal Extractor', 'desc': 'Separate vocals and beat', 'icon': Icons.music_note},
      {'title': 'Thumbnail Maker', 'desc': 'Generate 4K YouTube/Reel covers', 'icon': Icons.photo_size_select_actual},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(14),
      itemCount: tools.length,
      itemBuilder: (ctx, i) {
        final t = tools[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF140F26),
            borderRadius: BorderRadius.circular(14),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFF1B1633),
              child: Icon(t['icon'] as IconData, color: const Color(0xFF00FFCC), size: 20),
            ),
            title: Text(t['title'] as String, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
            subtitle: Text(t['desc'] as String, style: const TextStyle(color: Colors.white38, fontSize: 11)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 12),
          ),
        );
      },
    );
  }
}

