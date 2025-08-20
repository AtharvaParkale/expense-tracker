import 'package:expense_tracker_app/core/common/widgets/app_button_widget.dart';
import 'package:expense_tracker_app/core/common/widgets/text_form_fieldWidget.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:expense_tracker_app/core/utils/show_snackbar.dart';
import 'package:expense_tracker_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:expense_tracker_app/features/auth/presentation/pages/login_page.dart';
import 'package:expense_tracker_app/features/auth/presentation/widgets/switch_auth_text.dart';
import 'package:expense_tracker_app/features/auth/presentation/widgets/title_widget.dart';
import 'package:expense_tracker_app/features/stack_home/presentation/pages/stack_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpPage());

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(35),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  showSnackBar(context, state.message);
                } else if (state is AuthSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StackHomeScreen(),
                    ),
                  );
                }
              },
              buildWhen: (previous, current) => _buildWhen(current),
              builder: (context, state) {
                return _buildForm(context, state is AuthLoading);
              },
            ),
          ),
        ),
      ),
    );
  }

  bool _buildWhen(AuthState current) => current is AuthLoading;

  Form _buildForm(BuildContext context, bool isLoading) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TitleWidget(textOne: 'Get started with ', textTwo: 'BulkBuddy'),
          const SizedBox(height: 40),
          TextFormFieldWidget(
            controller: nameController,
            labelText: 'Name',
            hintText: 'Please enter your name here',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Name field cannot be empty";
              }
              return null;
            },
          ),
          const SizedBox(height: 40),
          TextFormFieldWidget(
            controller: emailController,
            labelText: 'Email',
            hintText: 'Please enter your email here',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email field cannot be empty";
              }
              return null;
            },
          ),
          const SizedBox(height: 40),
          TextFormFieldWidget(
            controller: passwordController,
            labelText: 'Password',
            hintText: 'Please enter your email here',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password field cannot be empty";
              }
              return null;
            },
          ),
          const SizedBox(height: 35),
          _buildButton(context, isLoading),

          const SizedBox(height: 30),
          SwitchAuthText(
            prefixText: 'Already have an account? ',
            postFixText: 'Log In',
            onPress: () {
              Navigator.pushReplacement(context, LoginPage.route());
            },
          ),
        ],
      ),
    );
  }

  Row _buildButton(BuildContext context, bool isLoading) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: AppButtonWidget(
            text: isLoading ? 'Please wait...' : 'Signup',
            bgColor: AppPallete.secondaryColor,
            fontColor: AppPallete.primaryColor,
            fontWeight: FontWeight.w700,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<AuthBloc>().add(
                  AuthSignUp(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                    name: nameController.text.trim(),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
