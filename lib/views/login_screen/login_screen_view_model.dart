import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:master_price_picker/core/locator.dart';
import 'package:master_price_picker/core/router_constants.dart';
import 'package:master_price_picker/views/favorite_screen/favorite_screen_view.dart';
import 'package:master_price_picker/views/favourite_ads/favourite_ads_view.dart';
import 'package:master_price_picker/views/register_screen/register_screen_view.dart';
import 'package:stacked/stacked.dart';
import 'package:master_price_picker/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginScreenViewModel extends BaseViewModel {
  Logger log;
  var args;
  var email;
  var password;
  final _navService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();
  bool isLoading = false;

  turnOnLoader() {
    isLoading = true;
    notifyListeners();
  }

  turnOffLoader() {
    isLoading = false;
    notifyListeners();
  }

  LoginScreenViewModel(context) {
    args = ModalRoute.of(context).settings.arguments;
    this.log = getLogger(this.runtimeType.toString());
  }

  resetPassword() {
    _snackbarService.showSnackbar(
      title: "Feature not implemented",
      message: "This feature will be added soon.",
    );
  }

  Future provideEmailSign() async {
    if (email != null && password != null) {
      try {
        var users = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        try {
          var user = await FirebaseFirestore.instance
              .collection('users')
              .doc(users.uid)
              .get();
          print(user.data());
          if (user.exists) {
            if (args != null)
              FirebaseFirestore.instance
                  .collection("favorite")
                  .doc()
                  .set({
                    "uid": users.uid,
                    "product": args['data'],
                    "DateTime": DateTime.now().toString(),
                  })
                  .then((result) => {
                        _navService.navigateToView(FavouriteAdsView()),
                      })
                  .catchError((err) {
                    notifyListeners();
                    _snackbarService.showSnackbar(
                      message: err.message.toString(),
                      title: "Error",
                    );
                  });
            else {
              _navService.clearStackAndShow(masterPricePickerViewRoute);
            }
            notifyListeners();
          } else {
            turnOffLoader();
            _snackbarService.showSnackbar(
                title: "Account do not exist.",
                message: "kindly register before logging in");
          }
        } on Exception catch (_) {
          turnOffLoader();
          _snackbarService.showSnackbar(
              title: "Something went wrong.", message: _.toString());
        }
      } on Exception catch (_) {
        turnOffLoader();

        _snackbarService.showSnackbar(
            title: "Something went wrong.", message: _.toString());
      }
    }
  }

  navigateToRegisterScreen() {
    _navService.navigateToView(RegisterScreenView());
  }
}
