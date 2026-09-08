import 'dart:async';
import 'package:flutter/material.dart';

class ChatHubScreen extends StatefulWidget {
  const ChatHubScreen({super.key});

  @override
  State<ChatHubScreen> createState() => _ChatHubScreenState();
}

class _ChatHubScreenState extends State<ChatHubScreen> {
  int _activeTab = 0; // 0: Chats, 1: Groups, 2: Requests
  bool _isSecretMode = false;
  Map<String, dynamic>? _openedChat;

  // Mock Chats Data with Online/Typing/Read status
  final List<Map<String, dynamic>> _chats = [
    {
      'id': 'c1',
      'name': 'Aman Sharma',
      'lastMsg': 'typing...',
      'time': 'Just now',
      'avatar': 'A',
      'isOnline': true,
      'isTyping': true,
      'unreadCount': 2,
      'isSecret': false,
      'tickStatus': 'sent',
    },
    {
      'id': 'c2',
      'name': 'Priya Patel',
      'lastMsg': 'Reel edit ho gayi bhai 🔥',
      'time': '5:46 PM',
      'avatar': 'P',
      'isOnline': true,
      'isTyping': false,
      'unreadCount': 0,
      'isSecret': false,
      'tickStatus': 'seen',
    },
    {
      'id': 'c3',
      'name': 'Squad Room #4',
      'lastMsg': '🎙️ Rohit sent voice message (0:18)',
      'time': '4:12 PM',
      'avatar': 'S',
      'isOnline': false,
      'lastSeen': 'Active 15m ago',
      'isTyping': false,
      'unreadCount': 5,
      'isSecret': false,
      'tickStatus': 'delivered',
    },
    {
      'id': 'c4',
      'name': 'Ghost_9921',
      'lastMsg': '🔒 Auto Delete in 10m (View Once)',
      'time': '2:37 PM',
      'avatar': 'G',
      'isOnline': true,
      'isTyping': false,
      'unreadCount': 1,
      'isSecret': true,
      'tickStatus': 'seen',
    },
    {
      'id': 'c5',
      'name': 'Rohit Raj',
      'lastMsg': 'Next stream kab shuru karega?',
      'time': 'Yesterday',
      'avatar': 'R',
      'isOnline': false,
      'lastSeen': 'Active 2h ago',
      'isTyping': false,
      'unreadCount': 0,
      'isSecret': false,
      'tickStatus': 'delivered',
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (_openedChat != null) {
      return _buildActiveChatConversation(_openedChat!);
    }

    return Scaffold(
      backgroundColor: const Color(0xFF090714),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildActiveStoryRow(),
            _buildTabsBar(),
            Expanded(child: _buildChatList()),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // TOP BAR
  // -------------------------------------------------------------
  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: const Color(0xFF140F26),
      child: Row(
        children: [
          const Text(
            'Chat Hub',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF00E5FF).withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text('3 Online', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.lock_outline_rounded, color: Color(0xFF00E5FF)),
            tooltip: 'Secret Ghost Chat',
            onPressed: () {
              setState(() {
                _openedChat = _chats.firstWhere((c) => c['isSecret'] == true);
              });
            },
          ),
          const Icon(Icons.search_rounded, color: Colors.white70),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // ACTIVE NOW STORIES WITH LIVE ONLINE RING
  // -------------------------------------------------------------
  Widget _buildActiveStoryRow() {
    return SizedBox(
      height: 90,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        children: [
          _buildStoryAvatar('Your Vibe', 'You', isMe: true, isOnline: true),
          _buildStoryAvatar('Aman', 'A', isMe: false, isOnline: true),
          _buildStoryAvatar('Priya', 'P', isMe: false, isOnline: true),
          _buildStoryAvatar('Ghost', 'G', isMe: false, isOnline: true),
          _buildStoryAvatar('Rohit', 'R', isMe: false, isOnline: false),
        ],
      ),
    );
  }

  Widget _buildStoryAvatar(String name, String initial, {required bool isMe, required bool isOnline}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: isMe ? Colors.white24 : const Color(0xFF8A2BE2),
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: const Color(0xFF1B1430),
                  child: isMe
                      ? const Icon(Icons.add, color: Colors.white, size: 18)
                      : Text(initial, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              if (isOnline)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E676),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF090714), width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(name, style: const TextStyle(color: Colors.white70, fontSize: 10)),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // TABS: CHATS | GROUPS | REQUESTS
  // -------------------------------------------------------------
  Widget _buildTabsBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: const Color(0xFF140F26), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          _tabBtn(0, 'Chats'),
          _tabBtn(1, 'Groups (Voice)'),
          _tabBtn(2, 'Requests (2)'),
        ],
      ),
    );
  }

  Widget _tabBtn(int idx, String label) {
    final bool isSel = _activeTab == idx;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeTab = idx),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSel ? const Color(0xFF8A2BE2) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(label, style: TextStyle(color: isSel ? Colors.white : Colors.white60, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // CHAT LIST (Typing, Online Dots, Unread Badges, Seen Ticks)
  // -------------------------------------------------------------
  Widget _buildChatList() {
    return ListView.builder(
      itemCount: _chats.length,
      itemBuilder: (ctx, i) {
        final c = _chats[i];
        final bool isTyping = c['isTyping'] as bool;
        final bool isOnline = c['isOnline'] as bool;
        final int unread = c['unreadCount'] as int;

        return InkWell(
          onTap: () => setState(() => _openedChat = c),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white10)),
            ),
            child: Row(
              children: [
                // Avatar + Online Green Dot
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: c['isSecret'] as bool ? Colors.redAccent : const Color(0xFF8A2BE2),
                      child: Text(c['avatar'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    if (isOnline)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00E676),
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFF090714), width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 14),

                // Name & Typing / Last Msg
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(c['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                          if (c['isSecret'] as bool) ...[
                            const SizedBox(width: 6),
                            const Icon(Icons.lock, color: Colors.amberAccent, size: 12),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      if (isTyping)
                        const Row(
                          children: [
                            Text(
                              'typing',
                              style: TextStyle(color: Color(0xFF00E5FF), fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 2),
                            Text('...', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        )
                      else
                        Row(
                          children: [
                            if (!c['isSecret']) _buildTickIcon(c['tickStatus'] as String),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                c['lastMsg'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: unread > 0 ? Colors.white : Colors.white54,
                                  fontWeight: unread > 0 ? FontWeight.w600 : FontWeight.normal,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                // Time + Unread Count Badge
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      c['time'] as String,
                      style: TextStyle(color: unread > 0 ? const Color(0xFF00E5FF) : Colors.white38, fontSize: 11),
                    ),
                    const SizedBox(height: 6),
                    if (unread > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8A2BE2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '$unread',
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      )
                    else if (!isOnline && c.containsKey('lastSeen'))
                      Text(c['lastSeen'] as String, style: const TextStyle(color: Colors.white24, fontSize: 9)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTickIcon(String status) {
    if (status == 'seen') {
      return const Icon(Icons.done_all_rounded, color: Color(0xFF00E5FF), size: 15);
    } else if (status == 'delivered') {
      return const Icon(Icons.done_all_rounded, color: Colors.white38, size: 15);
    } else {
      return const Icon(Icons.done_rounded, color: Colors.white38, size: 15);
    }
  }

  // -------------------------------------------------------------
  // ACTIVE 1-ON-1 CONVERSATION ROOM (With Typing & Online Status Header)
  // -------------------------------------------------------------
  Widget _buildActiveChatConversation(Map<String, dynamic> chat) {
    final bool isSecret = chat['isSecret'] as bool;
    final bool isTyping = chat['isTyping'] as bool;
    final bool isOnline = chat['isOnline'] as bool;

    return Scaffold(
      backgroundColor: const Color(0xFF090714),
      appBar: AppBar(
        backgroundColor: const Color(0xFF140F26),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => setState(() => _openedChat = null),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: isSecret ? Colors.redAccent : const Color(0xFF8A2BE2),
              child: Text(chat['avatar'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(chat['name'] as String, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                if (isTyping)
                  const Text('typing...', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 11, fontWeight: FontWeight.bold))
                else if (isOnline)
                  const Text('Online', style: TextStyle(color: Color(0xFF00E676), fontSize: 11, fontWeight: FontWeight.w500))
                else
                  Text(chat['lastSeen'] ?? 'Offline', style: const TextStyle(color: Colors.white38, fontSize: 10)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.call_outlined, color: Colors.white70), onPressed: () {}),
          IconButton(icon: const Icon(Icons.videocam_outlined, color: Colors.white70), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(14),
              children: [
                _bubble('Bhai kal live stream kab aayega?', isMe: false, time: '8:40 PM', tick: 'seen'),
                _bubble('Bas 9 PM sharp start karenge, setup ready hai! 🔥', isMe: true, time: '8:41 PM', tick: 'seen'),
                if (isSecret) ...[
                  _bubble('🔒 View-Once Image Shared', isMe: false, time: '8:42 PM', isViewOnce: true),
                ],
              ],
            ),
          ),
          // Typing Input Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            color: const Color(0xFF140F26),
            child: Row(
              children: [
                IconButton(icon: const Icon(Icons.camera_alt_outlined, color: Colors.white70), onPressed: () {}),
                IconButton(icon: const Icon(Icons.mic_none_rounded, color: Colors.white70), onPressed: () {}),
                const Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Type message...',
                      hintStyle: TextStyle(color: Colors.white38, fontSize: 13),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send_rounded, color: Color(0xFF00E5FF)),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bubble(String msg, {required bool isMe, required String time, String? tick, bool isViewOnce = false}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF8A2BE2) : const Color(0xFF1B1430),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (isViewOnce)
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.looks_one, color: Colors.amberAccent, size: 18),
                  SizedBox(width: 6),
                  Text('Photo (Tap to view once)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              )
            else
              Text(msg, style: const TextStyle(color: Colors.white, fontSize: 13)),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(time, style: const TextStyle(color: Colors.white38, fontSize: 9)),
                if (isMe && tick != null) ...[
                  const SizedBox(width: 4),
                  _buildTickIcon(tick),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

