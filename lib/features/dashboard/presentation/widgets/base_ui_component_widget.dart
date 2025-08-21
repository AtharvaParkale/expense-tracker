import 'package:expense_tracker_app/features/dashboard/presentation/widgets/dashboard_base_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';

import 'dashboard_floating_card.dart';

class BaseUIComponentWidget extends StatelessWidget {
  const BaseUIComponentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(color: Colors.transparent),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // This
              DashboardBaseBottomSheetWidget(),
              DashboardFloatingCard(),
            ],
          ),
        ),
      ],
    );
  }
}
