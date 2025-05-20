import 'package:frontend/modules/nimble/resources/colors.dart';
import 'package:frontend/modules/nimble/resources/strings.dart';
import 'package:frontend/modules/nimble/ui/sign_in/screens/sign_in_screen.dart';
import 'package:frontend/modules/nimble/ui/sign_up/verification_screen.dart';
import 'package:frontend/modules/shared/components/button/primary_button_component.dart';
import 'package:frontend/modules/shared/components/text/text_field_component.dart';
import 'package:frontend/modules/shared/helpers/utils.dart';
import 'package:frontend/modules/shared/resources/dimensions.dart';
import 'package:frontend/modules/shared/resources/themes.dart';
import 'package:flutter/material.dart';
import 'package:frontend/viewmodels/auth_view_model.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();
  String name = '', email = '', password = '';

  @override
  void initState() {
    changeStatusColor(Colors.white);

    super.initState();
  }

  @override
  void dispose() {
    changeStatusColor(secondaryBrandColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: viewModel.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(2),
              child: Form(
                key: _formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: spacing16, right: spacing16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Text('Create new account',
                                  style: boldTextStyle(size: 30))),
                          const SizedBox(height: 50),
                          TextFormField(
                            onChanged: (val) => name = val,
                            validator: (val) =>
                                val!.isEmpty ? 'Enter name' : null,
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            style: primaryTextStyle(size: 14),
                            focusNode: nameFocus,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 8,
                                bottom: 8,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: nameHint,
                              hintStyle: primaryTextStyle(size: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            onChanged: (val) => email = val,
                            validator: (val) =>
                                val!.isEmpty ? 'Enter email' : null,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: primaryTextStyle(size: 14),
                            focusNode: emailFocus,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 8,
                                bottom: 8,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: emailAddressHint,
                              hintStyle: primaryTextStyle(size: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            obscureText: true,
                            onChanged: (val) => password = val,
                            validator: (val) =>
                                val!.length < 6 ? 'Password too short' : null,
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            style: primaryTextStyle(size: 14),
                            focusNode: passwordFocus,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 8,
                                bottom: 8,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: passwordHint,
                              hintStyle: primaryTextStyle(size: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          PrimaryButtonComponent(
                            textContent: "CONTINUE",
                            height: 45.0,
                            isStroked: false,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final success = await viewModel.register(
                                    name, email, password);
                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Registered successfully")));

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignInScreen()));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text(viewModel.errorMessage)));
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
      persistentFooterButtons: [
        Container(
          height: 40,
          padding: const EdgeInsets.only(left: 15, right: 15),
          width: MediaQuery.of(context).copyWith().size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Already have an account?', style: secondaryTextStyle()),
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final success =
                        await viewModel.register(name, email, password);
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Registered successfully")));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(viewModel.errorMessage)));
                    }
                  }
                },
                child: Text('SIGN IN',
                    style: boldTextStyle(size: 14, color: primaryBrandColor)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
