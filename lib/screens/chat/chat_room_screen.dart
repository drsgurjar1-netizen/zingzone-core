import 'dart:async';
import 'package:flutter/material.dart';

class InteractiveChatRoom extends StatefulWidget {
  final String name;
  final String status;
  final Color themeColor;
  final String? banner;
  final bool isSecret;
  final List<Map<String, dynamic>> initialMessages;

  const InteractiveChatRoom({
    super.key,
    required this.name,
    required this.status,
    required this.themeColor,
    required this.initialMessages,
    this.banner,
    this.isSecret = false,
  });

  @override
  State<InteractiveChatRoom> createState() => _InteractiveChatRoomState();
}

class _InteractiveChatRoomState extends State<InteractiveChatRoom> {
  late List<Map<String, dynamic>> _messages;
  final TextEditingController _ctrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  Timer? _destructTimer;

  @override
  void initState() {
    super.initState();
    _messages = widget.initialMessages.map((e) => Map<String, dynamic>.from(e)).toList();

    if (widget.isSecret) {
      _destructTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        setState(() {
          for (var i = _messages.length - 1; i >= 0; i--) {
            if (_messages[i].containsKey('ttl')) {
              int val = _messages[i]['ttl'];
              if (val > 1) {
                _messages[i]['ttl'] = val - 1;
              } else {
                _messages.removeAt(i);
              }
            }
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _destructTimer?.cancel();
    _ctrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _send([String? customText]) {
    final text = customText ?? _ctrl.text.trim();
    if (text.isEmpty) return;

    final now = TimeOfDay.now();
    final timeStr = '${now.hourOfPeriod}:${now.minute.toString().padLeft(2, '0')} ${now.period == DayPeriod.am ? 'AM' : 'PM'}';

    setState(() {
      _messages.add({
        'text': text,
        'me': true,
        'time': timeStr,
        if (widget.isSecret) 'ttl': 30,
      });
    });

    if (customText == null) _ctrl.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _openAttachmentSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF140F26),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _actionOption(Icons.image, 'Gallery', const Color(0xFF7C4DFF), () {
                    Navigator.pop(ctx);
                    _send('📷 Photo shared');
                  }),
                  _actionOption(Icons.camera_alt, 'Camera', const Color(0xFFFF5252), () {
                    Navigator.pop(ctx);
                    _send('📸 Snapshot');
                  }),
                  _actionOption(Icons.mic, 'Audio Note', const Color(0xFF00E676), () {
                    Navigator.pop(ctx);
                    _send('🎙 Voice Note (0:08)');
                  }),
                  _actionOption(Icons.visibility_off, 'View Once', const Color(0xFFFFD700), () {
                    Navigator.pop(ctx);
                    _send('🔒 View-Once Photo');
                  }),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _actionOption(IconData icon, String label, Color col, VoidCallback tap) {
    return GestureDetector(
      onTap: tap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: col.withOpacity(0.2),
            child: Icon(icon, color: col, size: 24),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090714),
      appBar: AppBar(
        backgroundColor: const Color(0xFF140F26),
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.name, style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
            Text(widget.status, style: const TextStyle(fontSize: 11, color: Colors.white54)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.call, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.videocam, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          if (widget.banner != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: widget.themeColor.withOpacity(0.15),
              child: Text(
                widget.banner!,
                textAlign: TextAlign.center,
                style: TextStyle(color: widget.themeColor, fontSize: 11, fontWeight: FontWeight.w600),
              ),
            ),
          Expanded(
            child: ListView.builder(
              controller: _scrollCtrl,
              padding: const EdgeInsets.all(14),
              itemCount: _messages.length,
              itemBuilder: (ctx, i) {
                final m = _messages[i];
                final isMe = m['me'] == true;
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: isMe ? widget.themeColor : const Color(0xFF1F1A3A),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (m['sender'] != null)
                          Text(
                            m['sender'],
                            style: const TextStyle(color: Colors.amberAccent, fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        Text(m['text'], style: const TextStyle(color: Colors.white, fontSize: 14)),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (m.containsKey('ttl')) ...[
                              const Icon(Icons.timer_outlined, size: 12, color: Colors.orangeAccent),
                              const SizedBox(width: 3),
                              Text('${m['ttl']}s', style: const TextStyle(color: Colors.orangeAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 6),
                            ],
                            Text(m['time'], style: const TextStyle(color: Colors.white38, fontSize: 10)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            color: const Color(0xFF140F26),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Color(0xFF8A2BE2), size: 26),
                  onPressed: _openAttachmentSheet,
                ),
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    style: const TextStyle(color: Colors.white),
                    onSubmitted: (_) => _send(),
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(color: Colors.white38),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.mic, color: Colors.white54),
                  onPressed: () => _send('🎙 Voice Note (0:05)'),
                ),
                Container(
                  decoration: BoxDecoration(color: widget.themeColor, shape: BoxShape.circle),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 18),
                    onPressed: () => _send(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
