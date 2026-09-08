import 'package:flutter/material.dart';

class UploadBottomSheet extends StatelessWidget {
  const UploadBottomSheet({super.key});

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
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Create on Zing',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          _actionTile(
            context,
            icon: Icons.bolt_rounded,
            color: const Color(0xFF00E5FF),
            title: 'Drop a Reel (15s - 60s)',
            subtitle: 'Quick vertical content • Fast engagement',
          ),
          const SizedBox(height: 10),
          _actionTile(
            context,
            icon: Icons.video_library_rounded,
            color: const Color(0xFF8A2BE2),
            title: 'Upload Full Video',
            subtitle: 'Unlimited free cloud hosting (4K MP4/MOV)',
          ),
          const SizedBox(height: 10),
          _actionTile(
            context,
            icon: Icons.cell_tower_rounded,
            color: Colors.redAccent,
            title: 'Go Live',
            subtitle: 'Stream to squad and receive live gifts',
          ),
          const SizedBox(height: 10),
          _actionTile(
            context,
            icon: Icons.poll_outlined,
            color: Colors.amberAccent,
            title: 'Community Post / Poll',
            subtitle: 'Ask questions or post status updates',
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _actionTile(
    BuildContext ctx, {
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(ctx);
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(content: Text('Selected: $title 🚀'), duration: const Duration(seconds: 1)),
        );
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1B1430),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.5),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                  ),
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

