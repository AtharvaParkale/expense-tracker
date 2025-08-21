import 'package:flutter/material.dart';

class DashboardFloatingCard extends StatelessWidget {
  const DashboardFloatingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -75, // always relative to sheet's top
      left: 24,
      right: 24,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          padding: const EdgeInsets.all(16),
          child: const Center(
            child: Text(
              "Floating card above Section 1",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
