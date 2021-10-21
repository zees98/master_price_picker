import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:master_price_picker/core/logger.dart';

class SplashScreenViewModel extends BaseViewModel {
  Logger log;

  SplashScreenViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
