import 'package:flutter/material.dart';
import 'chat_room_screen.dart';

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
              gradient: const LinearGradient(colors: [Color(0xFF2E1256), Color(0xFF140D2E)]),
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
                  height: 48,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8A2BE2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HiddenPinScreen())),
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
      decoration: BoxDecoration(color: const Color(0xFF1B1633), borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF2E2452), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: const Color(0xFFB388FF), size: 22)),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        subtitle: Text(sub, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 14),
      ),
    );
  }
}

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
          _unlock();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Wrong PIN! Try 7788 or tap Fingerprint'), backgroundColor: Colors.red));
          setState(() => _pin = '');
        }
      }
    }
  }

  void _unlock() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const InteractiveChatRoom(
          name: 'Hidden Chat)',
          status: 'Only you can see this',
          themeColor: Color(0xFF00B0FF),
          banner: '👁 Secret Ghost Mode Active. Self-destruct enabled.',
          isSecret: true,
          initialMessages: [
            {'text': 'Mera secret plan ready hai 🤫', 'me': false, 'time': '10:45 AM', 'ttl': 30},
            {'text': 'Kya?', 'me': true, 'time': '10:46 AM', 'ttl': 25},
            {'text': 'Sab time pe batayunga...', 'me': false, 'time': '10:47 AM', 'ttl': 20},
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090714),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.security, color: Color(0xFF8A2BE2), size: 60),
          const SizedBox(height: 10),
          const Text('Hidden Section', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          const Text('Enter your secret PIN', style: TextStyle(color: Colors.white54, fontSize: 13)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (i) => Container(margin: const EdgeInsets.symmetric(horizontal: 8), width: 16, height: 16, decoration: BoxDecoration(shape: BoxShape.circle, color: i < _pin.length ? const Color(0xFF8A2BE2) : Colors.transparent, border: Border.all(color: const Color(0xFF8A2BE2), width: 2)))),
          ),
          const SizedBox(height: 36),
          for (var r = 0; r < 3; r++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [for (var c = 1; c <= 3; c++) _btn('${r * 3 + c}')]),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(borderRadius: BorderRadius.circular(40), onTap: _unlock, child: Container(width: 65, height: 65, alignment: Alignment.center, child: const Icon(Icons.fingerprint, color: Color(0xFF00FF7F), size: 32))),
                _btn('0'),
                InkWell(borderRadius: BorderRadius.circular(40), onTap: () { if (_pin.isNotEmpty) setState(() => _pin = _pin.substring(0, _pin.length - 1)); }, child: Container(width: 65, height: 65, alignment: Alignment.center, child: const Icon(Icons.backspace_outlined, color: Colors.white54, size: 24))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _btn(String txt) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () => _press(txt),
      child: Container(width: 65, height: 65, alignment: Alignment.center, decoration: BoxDecoration(color: const Color(0xFF1B1633), shape: BoxShape.circle, border: Border.all(color: Colors.white10)), child: Text(txt, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold))),
    );
  }
}
