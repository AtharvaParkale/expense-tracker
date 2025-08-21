import 'package:expense_tracker_app/features/dashboard/presentation/widgets/dashboard_transaction_list_widget.dart';
import 'package:flutter/material.dart';

class DashboardBaseBottomSheetWidget extends StatelessWidget {
  const DashboardBaseBottomSheetWidget({super.key, required this.childWidget});

  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.15,
        left: 16,
        right: 16,
        bottom: 17,
      ),
      child: childWidget,
    );
  }
}
