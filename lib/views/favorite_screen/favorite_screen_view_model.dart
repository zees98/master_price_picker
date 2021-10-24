import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:master_price_picker/core/logger.dart';

class FavoriteScreenViewModel extends BaseViewModel {
  Logger log;

  FavoriteScreenViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
