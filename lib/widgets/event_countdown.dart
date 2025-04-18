import 'package:axios/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class EventCountdown extends StatefulWidget {
  final String eventName;
  final DateTime eventDate;

  const EventCountdown({
    super.key,
    required this.eventName,
    required this.eventDate,
  });

  @override
  State<EventCountdown> createState() => _EventCountdownState();
}

class _EventCountdownState extends State<EventCountdown>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  late Duration _timeRemaining;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _timeRemaining = widget.eventDate.difference(DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      _calculateTimeRemaining();
    });

    _pulseController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  void _calculateTimeRemaining() {
    final now = DateTime.now();
    final difference = widget.eventDate.difference(now);
    setState(() {
      _timeRemaining = difference.isNegative ? Duration.zero : difference;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF8A6BF6).withValues(alpha: .2),
            Color(0xFF6B8AF6).withValues(alpha: .2),
          ],
        ),
        border: Border.all(
          color: Color(0xFF8A6BF6).withValues(alpha: .3),
          width: 2,
        ),
      ),
      child: SizedBox(
        child: Column(
          children: [
            SizedBox(height: 12),
            Text(
              "Upcoming Event",
              style: TextStyle(
                fontSize: isMobile ? 16 : 18,
                color: Colors.white60,
              ),
            ),
            SizedBox(height: 10),
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: Text(
                    widget.eventName,
                    style: TextStyle(
                      fontSize: isMobile ? 28 : 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
            SizedBox(height: 30),
            isMobile
                ? Column(
                  children: [
                    _buildTimeUnit(_timeRemaining.inDays, "Days"),
                    SizedBox(height: 20),
                    _buildTimeUnit(_timeRemaining.inHours % 24, "Hours"),
                    SizedBox(height: 20),
                    _buildTimeUnit(_timeRemaining.inMinutes % 60, "Minutes"),
                    SizedBox(height: 20),
                    _buildTimeUnit(_timeRemaining.inSeconds % 60, "Seconds"),
                  ],
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTimeUnit(_timeRemaining.inDays, "Days"),
                    _buildTimeUnit(_timeRemaining.inHours % 24, "Hours"),
                    _buildTimeUnit(_timeRemaining.inMinutes % 60, "Minutes"),
                    _buildTimeUnit(_timeRemaining.inSeconds % 60, "Seconds"),
                  ],
                ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8A6BF6),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : 30,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "Register Now",
                style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (!isMobile) SizedBox(height: 12),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeUnit(int value, String label) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Color(0xFF8A6BF6).withValues(alpha: .2),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Color(0xFF8A6BF6).withValues(alpha: .5),
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              value.toString().padLeft(2, '0'),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.white60)),
      ],
    );
  }
}
