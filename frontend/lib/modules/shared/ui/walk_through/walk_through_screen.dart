import 'package:frontend/modules/nimble/models/walk_through_model.dart';
import 'package:frontend/modules/nimble/resources/colors.dart';
import 'package:frontend/modules/nimble/resources/strings.dart';
import 'package:frontend/modules/nimble/ui/sign_in/screens/sign_in_screen.dart';
import 'package:frontend/modules/shared/components/button/custom_button_component.dart';
import 'package:frontend/modules/shared/components/image/image_component.dart';
import 'package:frontend/modules/shared/components/indicators/position_indicator_component.dart';
import 'package:frontend/modules/shared/helpers/settings_helper.dart';
import 'package:frontend/modules/shared/resources/dimensions.dart';
import 'package:frontend/modules/shared/resources/themes.dart';
import 'package:flutter/material.dart';

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({super.key});

  @override
  State<WalkThroughScreen> createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  int _currentWalkThroughIndex = 0;
  final PageController _walkThroughPageController = PageController();

  init() async {
    _walkThroughPageController.addListener(() {
      _currentWalkThroughIndex = _walkThroughPageController.page!.toInt();
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();

    init();

    SettingsHelper.getInstance().then((prefs) => prefs.walkThrough = false);
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.89,
            child: PageView.builder(
                controller: _walkThroughPageController,
                itemCount: walkThroughModels.length,
                itemBuilder: (_, index) {
                  WalkThroughModel walkThroughModel = walkThroughModels[index];
                  return Stack(
                    children: [
                      ImageComponent(
                        url: walkThroughModel.backgroundImg!,
                        placeHolder: walkThroughModel.backgroundImg!,
                        height: MediaQuery.of(context).size.height * 0.82,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        // color: frontendStore.isDarkModeOn ? Colors.transparent : white.withOpacity(0.5),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.14,
                        right: 0,
                        left: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ImageComponent(
                                  url: walkThroughModel.img!,
                                  placeHolder: walkThroughModel.img!,
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover),
                              const SizedBox(height: spacing24),
                              Text(walkThroughModel.title!,
                                  style: boldTextStyle(size: 24)),
                              const SizedBox(height: spacing16),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(walkSubTitle,
                                    style: secondaryTextStyle(),
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: PositionIndicatorComponent(
                  pageController: _walkThroughPageController,
                  pages: walkThroughModels,
                  indicatorColor: primaryBrandColor),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(spacing16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButtonComponent(
              minWidth: (MediaQuery.of(context).size.width - (3 * 16)) * 0.5,
              height: 60,
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 0,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()));
              },
              color: Colors.grey.withOpacity(0.1),
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              child: Text(
                skipButtonLabel,
                style: boldTextStyle(),
              ),
            ),
            const SizedBox(
              width: spacing16,
            ),
            CustomButtonComponent(
              minWidth: (MediaQuery.of(context).size.width - (3 * 16)) * 0.5,
              height: 60,
              elevation: 0,
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: primaryBrandColor,
              onPressed: () {
                if (_currentWalkThroughIndex == 4) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()));
                }
                _walkThroughPageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
                setState(() {});
              },
              child: _currentWalkThroughIndex == 4
                  ? Text(
                      'Start',
                      style: boldTextStyle(color: Colors.white),
                    )
                  : Text(
                      'Next',
                      style: boldTextStyle(color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
