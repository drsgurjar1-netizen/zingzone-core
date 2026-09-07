import 'package:flutter/material.dart';
import 'chat_room_screen.dart';
import 'privacy_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Regular', 'Secret', 'Groups', 'Bots'];

  final List<Map<String, dynamic>> _chats = [
    {'name': 'Rohan', 'msg': 'Bhai kal milte hai 👍', 'time': '12:18 PM', 'unread': 2, 'type': 'Regular', 'avatar': 'R', 'online': true},
    {'name': 'Neha', 'msg': '📷 Photo', 'time': '11:45 AM', 'unread': 1, 'type': 'Regular', 'avatar': 'N', 'online': false},
    {'name': 'Family Group', 'msg': 'Mummy: Khana kha liya?', 'time': '10:30 AM', 'unread': 5, 'type': 'Groups', 'avatar': 'FG', 'online': false},
    {'name': 'Study Partner', 'msg': 'Tum kaha ho abhi?', 'time': 'Yesterday', 'unread': 3, 'type': 'Regular', 'avatar': 'SP', 'online': false},
    {'name': 'Friends Forever', 'msg': '😂 Mast wali pic bhej na', 'time': 'Yesterday', 'unread': 0, 'type': 'Groups', 'avatar': 'FF', 'online': false},
    {'name': 'Secret Contact 🔒', 'msg': '⏱ This chat self-destructs', 'time': 'Yesterday', 'unread': 1, 'type': 'Secret', 'avatar': '🔒', 'online': true},
    {'name': 'Tech World Bot', 'msg': 'New AI tool aaya hai...', 'time': 'Yesterday', 'unread': 7, 'type': 'Bots', 'avatar': '🤖', 'online': true},
    {'name': 'Official Updates', 'msg': 'App v2.0 Released', 'time': '2 days ago', 'unread': 0, 'type': 'Bots', 'avatar': '📢', 'online': false},
    {'name': 'Riya', 'msg': '🎙 Voice Message (0:12)', 'time': '2 days ago', 'unread': 0, 'type': 'Regular', 'avatar': 'R', 'online': false},
    {'name': 'Crush 😍', 'msg': 'Typing...', 'time': '2 days ago', 'unread': 0, 'type': 'Secret', 'avatar': 'C', 'online': true},
    {'name': 'Business', 'msg': 'Payment received ✅', 'time': '3 days ago', 'unread': 0, 'type': 'Regular', 'avatar': 'B', 'online': false},
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _selectedFilter == 'All'
        ? _chats
        : _chats.where((c) => c['type'] == _selectedFilter).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF090714),
      appBar: AppBar(
        backgroundColor: const Color(0xFF090714),
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(10.0),
          child: CircleAvatar(backgroundColor: Color(0xFF8A2BE2), child: Icon(Icons.chat_bubble_outline, color: Colors.white, size: 18)),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Chat', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
            Text('Connect • Talk • Share', style: TextStyle(fontSize: 11, color: Colors.white54)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            color: const Color(0xFF1B1633),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onSelected: (val) {
              if (val == 'Privacy') Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyScreen()));
            },
            itemBuilder: (_) => [
              _menuItem(Icons.group_add_outlined, 'New Group'),
              _menuItem(Icons.campaign_outlined, 'Broadcast'),
              _menuItem(Icons.devices, 'Linked Devices'),
              _menuItem(Icons.star_border, 'Starred Messages'),
              _menuItem(Icons.lock_outline, 'Privacy', highlight: true),
              _menuItem(Icons.settings_outlined, 'Settings'),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 48,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              itemCount: _filters.length,
              itemBuilder: (ctx, i) {
                final f = _filters[i];
                final isSel = f == _selectedFilter;
                return GestureDetector(
                  onTap: () => setState(() => _selectedFilter = f),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(color: isSel ? const Color(0xFF8A2BE2) : const Color(0xFF1B1633), borderRadius: BorderRadius.circular(20)),
                    child: Center(child: Text(f, style: TextStyle(color: isSel ? Colors.white : Colors.white70, fontSize: 12, fontWeight: isSel ? FontWeight.bold : FontWeight.normal))),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (ctx, i) {
                final c = filtered[i];
                return ListTile(
                  onTap: () {
                    Color col = const Color(0xFF1E88E5);
                    bool secret = false;
                    String? banner;
                    List<Map<String, dynamic>> msgs = [
                      {'text': 'Bhai kal milte hai 👍', 'me': false, 'time': '12:16 PM'},
                      {'text': 'Haan bro pakka', 'me': true, 'time': '12:20 PM'},
                      {'text': 'Kaha?', 'me': false, 'time': '12:21 PM'},
                      {'text': 'College ke paas', 'me': true, 'time': '12:22 PM'},
                    ];

                    if (c['type'] == 'Secret') {
                      col = const Color(0xFF8A2BE2);
                      secret = true;
                      banner = '🔒 This chat is end-to-end encrypted.\nMessages will self-destruct after 24 hours';
                      msgs = [
                        {'text': 'Tu free hai?', 'me': false, 'time': '12:05 PM', 'ttl': 30},
                        {'text': 'Haan, bol', 'me': true, 'time': '12:06 PM', 'ttl': 28},
                        {'text': 'Kisi ko batana mat', 'me': false, 'time': '12:07 PM', 'ttl': 25},
                        {'text': 'Sure', 'me': true, 'time': '12:08 PM', 'ttl': 22},
                      ];
                    } else if (c['type'] == 'Groups') {
                      col = const Color(0xFFE91E63);
                      msgs = [
                        {'sender': 'Ravi', 'text': 'Mast wali pic bhej na', 'me': false, 'time': '9:12 AM'},
                        {'sender': 'Sonia', 'text': 'Ye le 😂', 'me': false, 'time': '9:13 AM'},
                        {'sender': 'Aman', 'text': 'Bhai ye jagah kaha hai?', 'me': false, 'time': '9:15 AM'},
                        {'text': 'Manali trip ki hai bhai!', 'me': true, 'time': '9:16 AM'},
                      ];
                    }

                    Navigator.push(
                      ctx,
                      MaterialPageRoute(
                        builder: (_) => InteractiveChatRoom(
                          name: c['name'],
                          status: c['online'] == true ? 'Online' : 'Offline',
                          themeColor: col,
                          banner: banner,
                          isSecret: secret,
                          initialMessages: msgs,
                        ),
                      ),
                    );
                  },
                  leading: Stack(
                    children: [
                      CircleAvatar(radius: 24, backgroundColor: c['type'] == 'Secret' ? const Color(0xFF8A2BE2) : const Color(0xFF262042), child: Text(c['avatar'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                      if (c['online'] == true)
                        Positioned(bottom: 0, right: 0, child: Container(width: 12, height: 12, decoration: BoxDecoration(color: const Color(0xFF00FF7F), shape: BoxShape.circle, border: Border.all(color: const Color(0xFF090714), width: 2)))),
                    ],
                  ),
                  title: Text(c['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
                  subtitle: Text(c['msg'], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: c['msg'] == 'Typing...' ? const Color(0xFF00FF7F) : Colors.white54, fontSize: 13)),
                  trailing: Text(c['time'], style: const TextStyle(color: Colors.white38, fontSize: 11)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _menuItem(IconData icon, String label, {bool highlight = false}) {
    return PopupMenuItem<String>(
      value: label,
      child: Row(
        children: [
          Icon(icon, color: highlight ? const Color(0xFFB388FF) : Colors.white70, size: 20),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(color: highlight ? const Color(0xFFB388FF) : Colors.white, fontWeight: highlight ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
