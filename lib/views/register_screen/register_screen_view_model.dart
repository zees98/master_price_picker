import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:master_price_picker/core/locator.dart';
import 'package:master_price_picker/views/login_screen/login_screen_view.dart';
import 'package:stacked/stacked.dart';
import 'package:master_price_picker/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterScreenViewModel extends BaseViewModel {
  Logger log;
  var email;
  var name;
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

  Future provideEmailSign() async {
    if (email != null && password != null) {
      try {
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((currentUser) async {
          FirebaseFirestore.instance
              .collection("users")
              .doc(currentUser.user.uid)
              .set({
                "uid": currentUser.user.uid,
                'email': email,
                "name": name,
                "DateTime": DateTime.now().toString(),
              })
              .then((result) => {
                    _navService.navigateToView(LoginScreenView()),
                  })
              .catchError((err) {
                notifyListeners();
                _snackbarService.showSnackbar(
                  message: err.message.toString(),
                  title: "Error",
                );
              });
          notifyListeners();
        }).catchError((err) {
          notifyListeners();
          _snackbarService.showSnackbar(
            message: err.message.toString(),
            title: "Error",
          );
        });
      } on Exception catch (_) {
        turnOffLoader();

        _snackbarService.showSnackbar(
            title: "Something went wrong.", message: _.toString());
      }
    }
  }

  navigateToLoginScreen() {
    _navService.navigateToView(LoginScreenView());
  }

  RegisterScreenViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
