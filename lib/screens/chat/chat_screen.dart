import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _selectedTab = 0; // 0: Public, 1: Friends, 2: Squad
  final TextEditingController _msgController = TextEditingController();

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060709),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top Bar: Header & Controls
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                  const SizedBox(width: 10),
                  const Text(
                    'Chat Hub',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const Icon(Icons.search_rounded, color: Colors.white, size: 22),
                  const SizedBox(width: 12),
                  const Icon(Icons.settings_outlined, color: Colors.white, size: 22),
                ],
              ),
            ),

            // 2. Three Segmented Tabs: Public | Friends | Squad
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                children: [
                  _buildTopTab('Public', 0),
                  const SizedBox(width: 8),
                  _buildTopTab('Friends', 1),
                  const SizedBox(width: 8),
                  _buildTopTab('Squad', 2),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // 3. Chat List & Floating Context Panel Area
            Expanded(
              child: Stack(
                children: [
                  ListView(
                    padding: const EdgeInsets.only(left: 16, right: 120, bottom: 20),
                    children: [
                      _buildChatTile(
                        name: 'Rahul Sharma',
                        message: 'Kal ka match dekha kya?',
                        time: '8:45 PM',
                        unreadCount: 0,
                        avatarColor: Colors.blueAccent,
                      ),
                      _buildChatTile(
                        name: 'Aman King',
                        message: 'Bro id bhej na',
                        time: '8:05 PM',
                        unreadCount: 2,
                        avatarColor: Colors.purpleAccent,
                      ),
                      _buildSquadRoomTile(
                        title: 'Squad Room #4',
                        subtitle: '🎙 Voice Party Active',
                        activeCount: 4,
                      ),
                      _buildChatTile(
                        name: 'Priya',
                        message: 'Kya kar rahe ho?',
                        time: '7:50 PM',
                        unreadCount: 0,
                        avatarColor: Colors.tealAccent,
                        isDoubleTick: true,
                      ),
                      _buildSecretChatTile(
                        name: 'Ghost_9921',
                        subtitle: '⏱ Auto Delete 10m',
                        time: '7:32 PM',
                      ),
                      _buildChatTile(
                        name: 'Gaming Friends',
                        message: 'Video • 4 Members',
                        time: '6:18 PM',
                        unreadCount: 0,
                        avatarColor: Colors.orangeAccent,
                      ),
                      _buildChatTile(
                        name: 'Rohan',
                        message: 'Nice Bro!',
                        time: '5:45 PM',
                        unreadCount: 0,
                        avatarColor: Colors.pinkAccent,
                      ),
                    ],
                  ),

                  // Floating Quick Context Menu (Right Side)
                  Positioned(
                    top: 10,
                    right: 12,
                    child: Container(
                      width: 104,
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF131520).withOpacity(0.92),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white.withOpacity(0.08)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPanelOption(Icons.person_outline_rounded, 'View Profile'),
                          _buildPanelOption(Icons.volume_off_outlined, 'Mute'),
                          _buildPanelOption(Icons.block_flipped, 'Block'),
                          const SizedBox(height: 4),
                          // Highlighted Secret Chat Button
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF7B2CBF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.lock_outline_rounded, color: Colors.white, size: 12),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    'Secret Chat',
                                    style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          _buildPanelOption(Icons.flag_outlined, 'Report'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 4. Bottom Chat Input Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF0D0F18),
                border: Border(top: BorderSide(color: Colors.white.withOpacity(0.06))),
              ),
              child: Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1B1E2E),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 38,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF161826),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: _msgController,
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(color: Colors.white38, fontSize: 12),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(bottom: 10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.mic_none_rounded, color: Colors.white70, size: 22),
                  const SizedBox(width: 8),
                  Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xFF8A2BE2), Color(0xFF5A189A)]),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send_rounded, color: Colors.white, size: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopTab(String title, int index) {
    bool isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7B2CBF) : const Color(0xFF131522),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(isSelected ? 0.0 : 0.06)),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white60,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildChatTile({
    required String name,
    required String message,
    required String time,
    required int unreadCount,
    required Color avatarColor,
    bool isDoubleTick = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: avatarColor.withOpacity(0.3),
            child: Text(name[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 2),
                Text(message, style: const TextStyle(color: Colors.white60, fontSize: 11), maxLines: 1),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(time, style: const TextStyle(color: Colors.white38, fontSize: 9)),
              const SizedBox(height: 4),
              if (unreadCount > 0)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: Color(0xFF7B2CBF), shape: BoxShape.circle),
                  child: Text('$unreadCount', style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                )
              else if (isDoubleTick)
                const Icon(Icons.done_all_rounded, color: Colors.blueAccent, size: 14),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSquadRoomTile({
    required String title,
    required String subtitle,
    required int activeCount,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF141726),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF00F0FF).withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFF00F0FF),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.headset_mic_rounded, color: Colors.black, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                Text(subtitle, style: const TextStyle(color: Color(0xFF00F0FF), fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecretChatTile({
    required String name,
    required String subtitle,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF7B2CBF), width: 1.5),
            ),
            child: const Icon(Icons.lock_rounded, color: Color(0xFF9D4EDD), size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(color: Color(0xFF9D4EDD), fontSize: 10, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Text(time, style: const TextStyle(color: Colors.white38, fontSize: 9)),
        ],
      ),
    );
  }

  Widget _buildPanelOption(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 13),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
        ],
      ),
    );
  }
}

