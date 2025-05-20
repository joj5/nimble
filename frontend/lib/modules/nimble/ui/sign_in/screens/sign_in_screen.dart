import 'package:frontend/modules/nimble/resources/colors.dart';
import 'package:frontend/modules/nimble/resources/images.dart';
import 'package:frontend/modules/nimble/resources/strings.dart';
import 'package:frontend/modules/nimble/ui/sign_in/screens/forgot_password.dart';
import 'package:frontend/modules/nimble/ui/sign_up/sign_up.dart';
import 'package:frontend/modules/shared/components/button/custom_button_component.dart';
import 'package:frontend/modules/shared/components/button/primary_button_component.dart';
import 'package:frontend/modules/shared/components/text/text_field_component.dart';
import 'package:frontend/modules/shared/helpers/utils.dart';
import 'package:frontend/modules/shared/resources/dimensions.dart';
import 'package:frontend/modules/shared/resources/themes.dart';
import 'package:flutter/material.dart';
import 'package:frontend/viewmodels/auth_view_model.dart';
import 'package:frontend/views/inventory_view.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();

    changeStatusColor(secondaryBrandColor);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: secondaryBrandColor,
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.only(left: spacing16, right: spacing16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(signInWelcomeText.toLowerCase(),
                            style:
                                boldTextStyle(size: 35, color: Colors.white)),
                      ),
                      const SizedBox(height: 50),
                      Column(
                        children: [
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
                          const SizedBox(height: spacing16),
                          TextFormField(
                            obscureText: true,
                            onChanged: (val) => password = val,
                            validator: (val) =>
                                val!.length < 5 ? 'Password too short' : null,
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
                          const SizedBox(height: spacing16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPasswordScreen()));
                              },
                              child: Text(forgotPassword,
                                  style: boldTextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: spacing16),
                      PrimaryButtonComponent(
                        textContent: signInButtonLabel,
                        height: 45.0,
                        isStroked: false,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final success =
                                await viewModel.login(email, password);
                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Login successful"),
                                ),
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const InventoryView()));
                              // Navigate to home/dashboard
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(viewModel.errorMessage),
                                ),
                              );
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          const Expanded(child: Divider(thickness: 2)),
                          const SizedBox(width: spacing8),
                          Text(signInWith,
                              style: secondaryTextStyle(color: Colors.white)),
                          const SizedBox(width: spacing8),
                          const Expanded(child: Divider(thickness: 2)),
                        ],
                      ),
                      const SizedBox(height: spacing16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButtonComponent(
                            onPressed: () {},
                            minWidth:
                                (MediaQuery.of(context).size.width - (3 * 16)) *
                                    0.5,
                            color: facebookColor,
                            elevation: 0,
                            shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                  width: 1, color: Colors.grey),
                            ),
                            child: Row(
                              children: [
                                Image.asset(facebookWhite,
                                    width: 20, height: 20),
                                const SizedBox(width: spacing8),
                                Text(facebookLabel,
                                    style:
                                        primaryTextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                          const SizedBox(height: spacing16),
                          CustomButtonComponent(
                            onPressed: () {},
                            minWidth:
                                (MediaQuery.of(context).size.width - (3 * 16)) *
                                    0.5,
                            elevation: 0,
                            shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                  width: 1, color: Colors.grey),
                            ),
                            child: Row(
                              children: [
                                Image.asset(google, width: 20, height: 20),
                                const SizedBox(width: spacing8),
                                Text(googleLabel,
                                    style:
                                        primaryTextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: spacing32,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.fingerprint,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
              Text(noAccount, style: secondaryTextStyle(color: Colors.white)),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
                child: Text(signUpInstead,
                    style: boldTextStyle(size: 14, color: Colors.white)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
