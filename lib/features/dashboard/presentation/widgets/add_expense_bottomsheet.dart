import 'package:expense_tracker_app/core/common/widgets/app_button_group_widget.dart';
import 'package:expense_tracker_app/core/common/widgets/custom_dropdown_widget.dart';
import 'package:expense_tracker_app/core/common/widgets/text_form_fieldWidget.dart';
import 'package:expense_tracker_app/core/constants/app_font_weigth.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:expense_tracker_app/core/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

class AddExpenseBottomSheet extends StatefulWidget {
  const AddExpenseBottomSheet({super.key, required this.onSubmit});

  final Function(String, String, double) onSubmit;

  @override
  State<AddExpenseBottomSheet> createState() => _AddExpenseBottomSheetState();
}

class _AddExpenseBottomSheetState extends State<AddExpenseBottomSheet> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  String selectedCategory = "Other";
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(),
          _buildSubTitle(),
          const SizedBox(height: 30),
          TextFormFieldWidget(
            controller: titleController,
            labelText: 'Title',
            hintText: 'Enter your title',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This is a required field";
              }
              return null;
            },
            textInputType: TextInputType.name,
          ),
          const SizedBox(height: 25),
          TextFormFieldWidget(
            controller: amountController,
            labelText: 'Amount (Rs)',
            hintText: 'Enter expense amount',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This is a required field";
              }
              return null;
            },
            textInputType: TextInputType.number,
          ),
          const SizedBox(height: 25),
          CustomDropdown(
            labelText: "Category",
            items: const [
              'Food',
              'Transport',
              'Shopping',
              'Bills',
              'Entertainment',
              'Health',
              'Other',
            ],
            value: selectedCategory,
            onChanged: (val) {
              setState(() {
                selectedCategory = val ?? "Other";
              });
            },
            validator: (val) => val == null ? "Please select a category" : null,
          ),
          const SizedBox(height: 30),
          AppButtonGroupWidget(
            buttonOneText: 'Cancel',
            buttonTwoText: 'Confirm',

            handleButtonOneTap: () {
              Navigator.of(context).pop();
            },
            handleButtonTwoTap: () {
              if (formKey.currentState!.validate()) {
                final String title = titleController.text.trim();
                final String category = selectedCategory;
                final double? amount = double.tryParse(
                  amountController.text.trim(),
                );

                print(title);
                print(category);
                print(amount);
                widget.onSubmit(title, category, amount ?? 0.0);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  Text _buildSubTitle() {
    return Text(
      "Quickly log your spending to stay on top of your budget",
      style: appTextTheme.bodySmall?.copyWith(
        color: AppPallete.descriptionColor,
        fontWeight: AppFontWeight.regular,
      ),
    );
  }

  Text _buildTitle() {
    return Text(
      'Add a New Expense',
      style: appTextTheme.titleMedium?.copyWith(
        color: AppPallete.bgBlack,
        fontWeight: AppFontWeight.semiBold,
      ),
    );
  }
}
