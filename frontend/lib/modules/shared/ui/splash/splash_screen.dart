import 'dart:async';

import 'package:frontend/modules/nimble/resources/colors.dart';
import 'package:frontend/modules/nimble/resources/images.dart';
import 'package:frontend/modules/nimble/resources/strings.dart';
import 'package:frontend/modules/nimble/ui/sign_in/screens/sign_in_screen.dart';
import 'package:frontend/modules/shared/components/image/image_component.dart';
import 'package:frontend/modules/shared/helpers/settings_helper.dart';
import 'package:frontend/modules/shared/resources/themes.dart';
import 'package:frontend/modules/shared/ui/walk_through/walk_through_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? showWalkThrough = false;

  @override
  void initState() {
    super.initState();
    init();
    SettingsHelper.getInstance()
        .then((prefs) => showWalkThrough = prefs.walkThrough);
  }

  init() async {
    Timer(
      const Duration(seconds: 3),
      () {
        if (Navigator.canPop(context)) Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => showWalkThrough!
                ? const WalkThroughScreen()
                : const SignInScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Center(
                  child: ImageComponent(
                      url: logo,
                      placeHolder: logo,
                      height: 150,
                      width: 150,
                      fit: BoxFit.fill),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Text(
                    appNameLowercase,
                    style:
                        secondaryTextStyle(size: 25, color: primaryBrandColor),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(from, style: secondaryTextStyle()),
                  Text(companyName, style: boldTextStyle(size: 25)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
