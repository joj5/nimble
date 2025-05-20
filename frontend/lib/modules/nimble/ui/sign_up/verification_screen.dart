import 'package:frontend/modules/nimble/resources/colors.dart';
import 'package:frontend/modules/nimble/ui/sign_in/screens/sign_in_screen.dart';
import 'package:frontend/modules/shared/components/button/primary_button_component.dart';
import 'package:frontend/modules/shared/components/text/text_field_component.dart';
import 'package:frontend/modules/shared/resources/dimensions.dart';
import 'package:frontend/modules/shared/resources/themes.dart';
import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController verificationCodeController = TextEditingController();

  FocusNode verificationCodeFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 100, left: 16, right: 16),
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Verify account', style: boldTextStyle(size: 30)),
                const SizedBox(height: spacing24),
                Text(
                    'Please fill in the verification code that has been sent to your email',
                    style: secondaryTextStyle(
                        size: 16,
                        color: secondaryAppTextColor.withOpacity(0.7))),
                const SizedBox(height: spacing24),
                TextFieldComponent(
                  controller: verificationCodeController,
                  hintText: "Verification code",
                  textFieldType: TextInputType.number,
                  focus: verificationCodeFocus,
                ),
                const SizedBox(height: 40),
                PrimaryButtonComponent(
                  textContent: "CONTINUE",
                  height: 45.0,
                  isStroked: false,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInScreen()));
                  },
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Text('Did\'nt Received a code?',
                          style: secondaryTextStyle(size: 16)),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          // make an api call to send a new code to the email
                        },
                        child: Text('RESEND',
                            style: boldTextStyle(color: primaryBrandColor)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
