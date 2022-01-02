import 'package:flutter/material.dart';
import 'package:master_price_picker/views/master_price_picker/master_price_picker_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stacked/stacked.dart';
import 'splash_screen_view_model.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashScreenViewModel>.reactive(
      builder:
          (BuildContext context, SplashScreenViewModel viewModel, Widget _) {
        return AnimatedSplashScreen(
          animationDuration: Duration(milliseconds: 800),
          nextScreen: MasterPricePickerView(),
          splash: 'assets/logo_2.png',
          splashIconSize: 350,
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
        );
      },
      viewModelBuilder: () => SplashScreenViewModel(),
    );
  }
}
