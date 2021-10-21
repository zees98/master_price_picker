import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:master_price_picker/core/logger.dart';

class LoginScreenViewModel extends BaseViewModel {
  Logger log;

  LoginScreenViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
