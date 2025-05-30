import 'package:flutter/material.dart';
import '../main.dart';
import '../screens/DashBoardScreen.dart';
import '../screens/SignInScreen.dart';
import '../utils/AppColors.dart';
import '../utils/AppCommon.dart';
import '../utils/AppConstants.dart';
import '../utils/AppImages.dart';
import '../utils/AppLocalizations.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashScreen extends StatefulWidget {
  static String tag = '/SplashScreen';

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    setStatusBarColor(primaryColor);
    init();
  }

  Future<void> init() async {
    appStore.setLoggedIn(getBoolAsync(IS_LOGGED_IN));
    checkFirstSeen();
  }

  Future<void> checkFirstSeen() async {
    await Future.delayed(Duration(seconds: 2));
    appLocalizations = AppLocalizations.of(context);

    await Future.delayed(Duration(seconds: 2));

    if (appStore.isLoggedIn) {
      currentUrl = isVendor ? vendorUrl : adminUrl;
      if (!getBoolAsync(REMEMBER_PASSWORD, defaultValue: true)) {
        appStore.setLoggedIn(false);
        DashBoardScreen().launch(context, isNewTask: true);
      } else {
        DashBoardScreen().launch(context, isNewTask: true);
      }
    } else {
      SignInScreen().launch(context, isNewTask: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(app_logo, width: context.width() * 0.5, height: context.width() * 0.5, fit: BoxFit.contain),
      ),
    );
  }
}
