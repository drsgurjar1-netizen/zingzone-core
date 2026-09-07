import 'dart:async';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Regular', 'Secret', 'Groups', 'Bots'];

  final List<Map<String, dynamic>> _chats = [
    {
      'name': 'Rohan',
      'msg': 'Bhai kal milte hai 👍',
      'time': '12:18 PM',
      'unread': 2,
      'type': 'Regular',
      'avatar': 'R',
      'online': true,
    },
    {
      'name': 'Neha',
      'msg': '📷 Photo',
      'time': '11:45 AM',
      'unread': 1,
      'type': 'Regular',
      'avatar': 'N',
      'online': false,
    },
    {
      'name': 'Family Group',
      'msg': 'Mummy: Khana kha liya?',
      'time': '10:30 AM',
      'unread': 5,
      'type': 'Groups',
      'avatar': 'FG',
      'online': false,
    },
    {
      'name': 'Study Partner',
      'msg': 'Tum kaha ho abhi?',
      'time': 'Yesterday',
      'unread': 3,
      'type': 'Regular',
      'avatar': 'SP',
      'online': false,
    },
    {
      'name': 'Friends Forever',
      'msg': '😂 Mast wali pic bhej na',
      'time': 'Yesterday',
      'unread': 0,
      'type': 'Groups',
      'avatar': 'FF',
      'online': false,
    },
    {
      'name': 'Secret Contact 🔒',
      'msg': '⏱ This chat self-destructs',
      'time': 'Yesterday',
      'unread': 1,
      'type': 'Secret',
      'avatar': '🔒',
      'online': true,
    },
    {
      'name': 'Tech World Bot',
      'msg': 'New AI tool aaya hai...',
      'time': 'Yesterday',
      'unread': 7,
      'type': 'Bots',
      'avatar': '🤖',
      'online': true,
    },
    {
      'name': 'Official Updates',
      'msg': 'App v2.0 Released',
      'time': '2 days ago',
      'unread': 0,
      'type': 'Bots',
      'avatar': '📢',
      'online': false,
    },
    {
      'name': 'Riya',
      'msg': '🎙 Voice Message (0:12)',
      'time': '2 days ago',
      'unread': 0,
      'type': 'Regular',
      'avatar': 'R',
      'online': false,
    },
    {
      'name': 'Crush 😍',
      'msg': 'Typing...',
      'time': '2 days ago',
      'unread': 0,
      'type': 'Secret',
      'avatar': 'C',
      'online': true,
    },
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
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF8A2BE2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 18),
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Chat', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
            Text('Connect • Talk • Share', style: TextStyle(fontSize: 11, color: Colors.white54)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            color: const Color(0xFF1B1633),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onSelected: (val) {
              if (val == 'Privacy') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrivacyScreen()),
                );
              }
            },
            itemBuilder: (ctx) => [
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
          // Filter Pills
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
                    decoration: BoxDecoration(
                      color: isSel ? const Color(0xFF8A2BE2) : const Color(0xFF1B1633),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        f,
                        style: TextStyle(
                          color: isSel ? Colors.white : Colors.white70,
                          fontSize: 12,
                          fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Chat List
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (ctx, i) {
                final c = filtered[i];
                return ListTile(
                  onTap: () {
                    if (c['type'] == 'Secret') {
                      Navigator.push(ctx, MaterialPageRoute(builder: (_) => SecretChatRoom(name: c['name'])));
                    } else if (c['type'] == 'Groups') {
                      Navigator.push(ctx, MaterialPageRoute(builder: (_) => GroupChatRoom(name: c['name'])));
                    } else {
                      Navigator.push(ctx, MaterialPageRoute(builder: (_) => RegularChatRoom(name: c['name'])));
                    }
                  },
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: c['type'] == 'Secret'
                            ? const Color(0xFF8A2BE2)
                            : const Color(0xFF262042),
                        child: Text(
                          c['avatar'],
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      if (c['online'] == true)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: const Color(0xFF00FF7F),
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFF090714), width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  title: Text(
                    c['name'],
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  subtitle: Text(
                    c['msg'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: c['msg'] == 'Typing...' ? const Color(0xFF00FF7F) : Colors.white54,
                      fontSize: 13,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(c['time'], style: const TextStyle(color: Colors.white38, fontSize: 11)),
                      const SizedBox(height: 4),
                      if (c['unread'] > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: const BoxDecoration(
                            color: Color(0xFF8A2BE2),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${c['unread']}',
                            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        )
                      else
                        const SizedBox(height: 16),
                    ],
                  ),
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
          Text(
            label,
            style: TextStyle(
              color: highlight ? const Color(0xFFB388FF) : Colors.white,
              fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// PRIVACY SCREEN
// -------------------------------------------------------------
class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090714),
      appBar: AppBar(
        backgroundColor: const Color(0xFF090714),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Privacy', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _tile(Icons.visibility_off, 'Hide Chats', 'Your hidden chats are safe'),
          _tile(Icons.lock, 'Secret Chat', 'End-to-end encrypted'),
          _tile(Icons.timer, 'Disappearing Messages', 'Auto delete after time'),
          _tile(Icons.fingerprint, 'App Lock', 'Fingerprint / PIN'),
          _tile(Icons.cloud_upload, 'Chat Backup', 'Backup your chats'),
          _tile(Icons.block, 'Blocked Contacts', 'View blocked users'),
          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFF2E1256), Color(0xFF140D2E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: const Color(0xFF8A2BE2).withOpacity(0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Hidden Chat Access', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('Only you can see these chats', style: TextStyle(color: Colors.white54, fontSize: 12)),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8A2BE2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const HiddenPinScreen()));
                    },
                    icon: const Icon(Icons.visibility_off, color: Colors.white, size: 18),
                    label: const Text('Enter Hidden Section', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(IconData icon, String title, String sub) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1633),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF2E2452),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFFB388FF), size: 22),
        ),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        subtitle: Text(sub, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 14),
      ),
    );
  }
}

// -------------------------------------------------------------
// PIN & BIOMETRIC SCREEN
// -------------------------------------------------------------
class HiddenPinScreen extends StatefulWidget {
  const HiddenPinScreen({super.key});

  @override
  State<HiddenPinScreen> createState() => _HiddenPinScreenState();
}

class _HiddenPinScreenState extends State<HiddenPinScreen> {
  String _pin = '';

  void _press(String digit) {
    if (_pin.length < 4) {
      setState(() => _pin += digit);
      if (_pin.length == 4) {
        if (_pin == '7788') {
          _unlockSuccess();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Wrong PIN! Try 7788 or tap Fingerprint'), backgroundColor: Colors.red),
          );
          setState(() => _pin = '');
        }
      }
    }
  }

  void _unlockSuccess() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HiddenChatRoom()),
    );
  }

  void _biometricAuth() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Biometric Verified! 🛡️'), backgroundColor: Colors.green),
    );
    _unlockSuccess();
  }

  void _backspace() {
    if (_pin.isNotEmpty) {
      setState(() => _pin = _pin.substring(0, _pin.length - 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090714),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.security, color: Color(0xFF8A2BE2), size: 60),
          const SizedBox(height: 12),
          const Text('Hidden Section', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          const Text('Enter secret PIN or touch fingerprint', style: TextStyle(color: Colors.white54, fontSize: 13)),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (i) {
              final filled = i < _pin.length;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: filled ? const Color(0xFF8A2BE2) : Colors.transparent,
                  border: Border.all(color: const Color(0xFF8A2BE2), width: 2),
                ),
              );
            }),
          ),
          const SizedBox(height: 36),

          for (var r = 0; r < 3; r++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var c = 1; c <= 3; c++)
                    _keyBtn('${r * 3 + c}'),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _iconBtn(Icons.fingerprint, _biometricAuth),
                _keyBtn('0'),
                _iconBtn(Icons.backspace_outlined, _backspace),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _keyBtn(String txt) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () => _press(txt),
      child: Container(
        width: 65,
        height: 65,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFF1B1633),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white10),
        ),
        child: Text(txt, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _iconBtn(IconData icon, VoidCallback tap) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: tap,
      child: Container(
        width: 65,
        height: 65,
        alignment: Alignment.center,
        child: Icon(icon, color: const Color(0xFF00FF7F), size: 30),
      ),
    );
  }
}

// -------------------------------------------------------------
// CHAT ROOMS
// -------------------------------------------------------------
class RegularChatRoom extends StatelessWidget {
  final String name;
  const RegularChatRoom({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return _InteractiveChatRoom(
      name: name,
      status: 'online',
      themeColor: const Color(0xFF1E88E5),
      initialMessages: [
        {'text': 'Bhai kal milte hai 👍', 'me': false, 'time': '12:16'},
        {'text': 'Haan bro pakka', 'me': true, 'time': '12:20'},
        {'text': 'Kaha?', 'me': false, 'time': '12:21'},
        {'text': 'College ke paas', 'me': true, 'time': '12:22'},
      ],
    );
  }
}

class SecretChatRoom extends StatelessWidget {
  final String name;
  const SecretChatRoom({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return _InteractiveChatRoom(
      name: name,
      status: 'Online 🔒',
      themeColor: const Color(0xFF8A2BE2),
      isSecret: true,
      banner: '🔒 End-to-end encrypted. Messages auto-destruct in 30s.',
      initialMessages: [
        {'text': 'Tu free hai?', 'me': false, 'time': '12
