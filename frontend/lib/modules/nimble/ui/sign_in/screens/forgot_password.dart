import 'package:frontend/modules/nimble/resources/colors.dart';
import 'package:frontend/modules/nimble/resources/strings.dart';
import 'package:frontend/modules/nimble/ui/sign_in/screens/sign_in_screen.dart';
import 'package:frontend/modules/shared/components/button/primary_button_component.dart';
import 'package:frontend/modules/shared/resources/themes.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 100, left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(resetPassword, style: boldTextStyle(size: 25)),
                const SizedBox(height: 25),
                Text(enterEmail,
                    style: secondaryTextStyle(
                        size: 16,
                        color: secondaryAppTextColor.withOpacity(0.7))),
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
                  decoration: boxDecoration(radius: 5, color: Colors.red),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: emailAddressHint),
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(height: 30),
                PrimaryButtonComponent(
                  textContent: sendButtonLabel,
                  height: 45.0,
                  isStroked: false,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInScreen()));
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
