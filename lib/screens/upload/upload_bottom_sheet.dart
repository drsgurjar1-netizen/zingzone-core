import 'package:flutter/material.dart';

class UploadBottomSheet extends StatefulWidget {
  const UploadBottomSheet({super.key});

  @override
  State<UploadBottomSheet> createState() => _UploadBottomSheetState();
}

class _UploadBottomSheetState extends State<UploadBottomSheet> {
  bool _isUploading = false;
  double _uploadProgress = 0.0;

  void _simulateUpload() {
    setState(() {
      _isUploading = true;
      _uploadProgress = 0.0;
    });

    // Simulated progress tick
    Future.delayed(const Duration(milliseconds: 300), () => setState(() => _uploadProgress = 0.35));
    Future.delayed(const Duration(milliseconds: 700), () => setState(() => _uploadProgress = 0.75));
    Future.delayed(const Duration(milliseconds: 1100), () {
      setState(() => _uploadProgress = 1.0);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Video Dropped to ZingZone Feed Successfully! 🚀🔥')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        color: Color(0xFF140F26),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(top: BorderSide(color: Color(0xFF8A2BE2), width: 1.5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 14),
          const Text('Create on Zing', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 14),

          // Upload Progress Indicator (If uploading)
          if (_isUploading) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: const Color(0xFF1B1430), borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Uploading Video & Generating Cover...', style: TextStyle(color: Colors.white70, fontSize: 11)),
                      Text('${(_uploadProgress * 100).toInt()}%', style: const TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: _uploadProgress, color: const Color(0xFF00E5FF), backgroundColor: Colors.white12, minHeight: 6),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],

          _actionTile(icon: Icons.bolt_rounded, color: const Color(0xFF00E5FF), title: 'Drop a Reel (15s - 60s)', subtitle: 'Quick vertical clip • Auto viral tags', onTap: _simulateUpload),
          const SizedBox(height: 10),
          _actionTile(icon: Icons.video_library_rounded, color: const Color(0xFF8A2BE2), title: 'Upload Full Video + Custom Thumbnail', subtitle: 'Free cloud hosting • Choose 16:9 Cover', onTap: _simulateUpload),
          const SizedBox(height: 10),
          _actionTile(icon: Icons.cell_tower_rounded, color: Colors.redAccent, title: 'Go Live Room', subtitle: 'Squad chat & receive live gift coins', onTap: () => Navigator.pop(context)),
          const SizedBox(height: 10),
          _actionTile(icon: Icons.poll_outlined, color: Colors.amberAccent, title: 'Community Poll / Status', subtitle: 'Engage with your vibers directly', onTap: () => Navigator.pop(context)),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _actionTile({required IconData icon, required Color color, required String title, required String subtitle, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: const Color(0xFF1B1430), borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white10)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.5)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 11)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 14),
          ],
        ),
      ),
    );
  }
}
