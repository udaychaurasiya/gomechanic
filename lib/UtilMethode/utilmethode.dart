import 'package:gomechanic/UtilMethode/appexpenstion.dart';
import 'package:gomechanic/UtilMethode/dailoghelper.dart';
import 'package:gomechanic/utils/custom_snackbar.dart';

class BaseController {
  void handleError(error) {
    // Get.context!.loaderOverlay.hide();
    if (error is BadRequestException) {
      var message = error.message;
      errorSnack(message.toString());
    } else if (error is FetchDataException) {
      var message = error.message;
      errorSnack(message.toString());
    } else if (error is ApiNotRespondingException) {
      errorSnack("Oops! It took longer to respond.");
    } else {
      errorSnack("Something went wrong");
    }
  }

  showLoading(String? message) {
    DialogHelper.showLoading(message);
  }

  hideLoading() {
    DialogHelper.hideLoading();
  }

  errorSnack(String message) {
    CustomAnimation().showCustomSnackBar(message, isError: true);
  }

  successSnack(String message) {
    CustomAnimation().showCustomSnackBar(message, isError: false);
  }

  warningSnack(String message) {
    CustomAnimation().showCustomSnackBar(message, isError: true);
  }
}
