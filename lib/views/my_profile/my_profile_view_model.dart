import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:master_price_picker/core/locator.dart';
import 'package:master_price_picker/core/router.dart';
import 'package:master_price_picker/core/router_constants.dart';
import 'package:master_price_picker/views/login_screen/login_screen_view.dart';
import 'package:stacked/stacked.dart';
import 'package:master_price_picker/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class MyProfileViewModel extends FutureViewModel {
  Logger log;
  var _navService = locator<NavigationService>();
  var _snackbarSrevice = locator<SnackbarService>();

  MyProfileViewModel() {
    log = getLogger(this.runtimeType.toString());
  }
  logout() {
    FirebaseAuth.instance.signOut().then((value) {
      _navService.clearTillFirstAndShow(masterPricePickerViewRoute);
    }).catchError((onError) => {
          _snackbarSrevice.showSnackbar(
            title: "Error",
            message: "An error occured while signing out",
          )
        });
  }

  navigateToLoginScreen() {
    _navService.navigateToView(LoginScreenView());
  }

  @override
  Future futureToRun() {
    return FirebaseAuth.instance.currentUser();
  }
}
