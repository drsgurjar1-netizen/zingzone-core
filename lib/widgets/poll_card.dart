import 'package:flutter/material.dart';

class ResearchPollCard extends StatefulWidget {
  final String question;
  final List<String> options;
  final double rewardAmount;
  final VoidCallback onVoted;

  const ResearchPollCard({
    super.key,
    required this.question,
    required this.options,
    this.rewardAmount = 1.0,
    required this.onVoted,
  });

  @override
  State<ResearchPollCard> createState() => _ResearchPollCardState();
}

class _ResearchPollCardState extends State<ResearchPollCard> {
  int? _selectedOption;
  bool _hasVoted = false;

  void _vote(int index) {
    if (_hasVoted) return;
    setState(() {
      _selectedOption = index;
      _hasVoted = true;
    });
    widget.onVoted();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF140F26),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: _hasVoted ? const Color(0xFF00FFCC) : const Color(0xFF8A2BE2).withOpacity(0.5),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.bolt, color: Color(0xFF00FFCC), size: 18),
                  const SizedBox(width: 4),
                  Text(
                    'SPONSORED RESEARCH POLL',
                    style: TextStyle(
                      color: const Color(0xFF00FFCC).withOpacity(0.9),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF00FFCC).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _hasVoted ? '✓ +₹${widget.rewardAmount.toInt()} EARNED' : 'GET ₹${widget.rewardAmount.toInt()}',
                  style: const TextStyle(
                    color: Color(0xFF00FFCC),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.question,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 14),
          ...List.generate(widget.options.length, (i) {
            final isSelected = _selectedOption == i;
            return GestureDetector(
              onTap: () => _vote(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF8A2BE2).withOpacity(0.4)
                      : const Color(0xFF1B1633),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF00FFCC) : Colors.white10,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.options[i],
                      style: TextStyle(
                        color: isSelected ? const Color(0xFF00FFCC) : Colors.white70,
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_circle, color: Color(0xFF00FFCC), size: 16),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

