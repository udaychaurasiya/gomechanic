// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, non_constant_identifier_names, deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gomechanic/AppConstent/AppConstant.dart';
import 'package:gomechanic/Dashbord/dashboard.dart';
import 'package:gomechanic/SplashScreens/OtpVerify.dart';
import 'package:gomechanic/SplashScreens/Registration.dart';
import 'package:gomechanic/SplashScreens/SplashPage.dart';
import 'package:gomechanic/UtilMethode/utilmethode.dart';
import 'package:gomechanic/UtilMethode/BaseClient.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/Widget/shop_details.dart';
import 'package:gomechanic/models/banner_model.dart';
import 'package:gomechanic/models/contact_us_model.dart';
import 'package:gomechanic/models/feq_model.dart';
import 'package:gomechanic/models/item_model.dart';
import 'package:gomechanic/models/notification_model.dart';
import 'package:gomechanic/models/shop_details_model.dart';
import 'package:gomechanic/models/shop_open_close_model.dart';
import 'package:gomechanic/utils/app_constants.dart';
import 'package:gomechanic/utils/custom_snackbar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginController extends GetxController {
  GetStorage storage = GetStorage();
  RxString selectTtlValue = "".obs;
  RxString current_address = "".obs;
  RxString selectvehicle = "Select Vehicle".obs;
  var showOtherTextField = false.obs;
  var otherValueController = TextEditingController();
  RxString Address = "".obs;
  RxInt idProveType = 0.obs;
  RxString rxPath = "".obs;
  RxInt otpValidation = 0.obs;
  RxString images = "".obs;
  RxString shopImage = "".obs;
  RxString shopPath = "".obs;
  RxString urlValue = "".obs;
  RxString FCM_TOKEN = "".obs;
  RxString profile = "".obs;
  RxDouble longitude = 0.0.obs;
  RxDouble latitude = 0.0.obs;
  RxDouble long = 0.0.obs;
  RxDouble lat = 0.0.obs;
  DateTime? currentBackPressTime;
  RxInt minutes = 1.obs;
  RxInt seconds = 0.obs;
  RxInt normalCc = 0.obs;
  RxInt highPickup = 0.obs;
  RxInt roadService = 0.obs;
  Timer? timer;
  RxBool simmer = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingPage = false.obs;
  RxInt currentPage = 0.obs;
  var selectedTime = TimeOfDay.now().obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  RxBool isValueBtn = false.obs;
  final RoundedLoadingButtonController googleController = RoundedLoadingButtonController();
  // final ScrollController scrollNotificationsController = ScrollController();

  OtpFieldController otpController = OtpFieldController();
  TextEditingController etMobile = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController etName = TextEditingController();
  TextEditingController etEmail = TextEditingController();
  TextEditingController etAadhar = TextEditingController();
  TextEditingController etAddress = TextEditingController();
  TextEditingController mapAddress = TextEditingController();

  TextEditingController shopName = TextEditingController();
  TextEditingController VehicleName = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController serviceCapacity = TextEditingController();

  late ScrollController scrollNotificationsController;


  // @override
  // void onInit() {
  //   super.onInit();
  //   scrollNotificationsController = ScrollController();
  //   addItems();
  // }

  /// login api integrate




  loginNetworkApi() async {
    final fcmTokan=await FirebaseMessaging.instance.getToken();
    var bodyRequest = {
      "lng": AppConstants.LANGUAGE,
      "mobile": etMobile.text.toString(),
      "device_id": "",
      "fcm_id": fcmTokan.toString(),
    };
    print("request >>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .post(AppConstants.LOGIN_URL, bodyRequest)
        .catchError(BaseController().handleError);
    print("Mobile No : ${etMobile.text}");
    print(response);
    Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"] == 1) {
      // isLoading.value = true;
      number.text = etMobile.text;
      BaseController().successSnack(jsonDecode(response)["message"]+ " " + jsonDecode(response)["Data"]["otp"]);
      Get.to(() => OtpVerify(id: jsonDecode(response)["Data"]["id"] ?? "",otp: jsonDecode(response)["Data"]["otp"] ?? "",));
      return;
    }
    storage.write(AppConstant.fcm_token, jsonDecode(response)["Data"]["fcm_id"] ?? "");
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  /// otp verify api integrate
  Future<bool> verifyNetworkApi(String id, String otp) async {
      var bodyRequest = {
        "lng": AppConstants.LANGUAGE,
        "id": id.toString(),
        "otp": otp.toString(),
      };
      print("body ==>>>>> $bodyRequest");
      Get.context!.loaderOverlay.show();
      var response = await BaseClient()
          .post(AppConstants.VERIFY_URL, bodyRequest)
          .catchError(BaseController().handleError);
      Get.context!.loaderOverlay.hide();
      print("response ===>>>>>> $response");
      if (jsonDecode(response)["status"] == 1) {
        if (jsonDecode(response)["Data"].isNotEmpty) {
          if (jsonDecode(response)["Data"]["id"].toString().isNotEmpty
              && jsonDecode(response)["Data"]["email"].toString().isNotEmpty) {
            storage.write(AppConstant.id, jsonDecode(response)["Data"]["id"] ?? "");
            storage.write(AppConstant.name, jsonDecode(response)["Data"]["name"] ?? "");
            storage.write(AppConstant.address, jsonDecode(response)["Data"]["address"] ?? "");
            storage.write(AppConstant.profile, jsonDecode(response)["Data"]["profile"] ?? "");
            storage.write(AppConstant.email, jsonDecode(response)["Data"]["email"] ?? "");
            storage.write(AppConstant.phone, jsonDecode(response)["Data"]["mobile"] ?? "");
            storage.write(AppConstant.fcm_token, jsonDecode(response)["Data"]["fcm_id"] ?? "");
            storage.write(AppConstant.idProvePhoto,jsonDecode(response)["Data"]["id_prove_photo"] ?? "");
            storage.write(AppConstant.aadhar, jsonDecode(response)["Data"]["id_prove_no"] ?? "");
            storage.write(AppConstant.idProveType, jsonDecode(response)["Data"]["id_prove_type"] ?? "");
            storage.write(AppConstant.normalCcByck, jsonDecode(response)["Data"]["normal_cc_byck"] ?? "");
            storage.write(AppConstant.heigh_pickup, jsonDecode(response)["Data"]["heigh_pickup"] ?? "");
            storage.write(AppConstant.is_on_road_service, jsonDecode(response)["Data"]["is_on_road_service"] ?? "");
            storage.write(AppConstant.byck_service_capicity, jsonDecode(response)["Data"]["byck_service_capicity"] ?? "");
            storage.write(AppConstant.description, jsonDecode(response)["Data"]["description"] ?? "");
            storage.write(AppConstant.shopName, jsonDecode(response)["Data"]["shop_name"] ?? "");
            storage.write(AppConstant.shopPhoto,jsonDecode(response)["Data"]["shop_photo"] ?? "");
            storage.write(AppConstant.store_time, jsonDecode(response)["Data"]["store_time"] ?? "");
            storage.write(AppConstant.shop_open, jsonDecode(response)["Data"]["shop_open"].toString());
            storage.write(AppConstant.latitude, jsonDecode(response)["Data"]["latitude"] ?? "");
            storage.write(AppConstant.longitude, jsonDecode(response)["Data"]["longitude"] ?? "");
            saveDataRegistration();
            Get.offAll(()=> const DashboardScreen());
            BaseController().successSnack(jsonDecode(response)["message"]);
          } else {
            removeData();
            storage.write(AppConstant.phone, jsonDecode(response)["Data"]["mobile"] ?? "");
            storage.write(AppConstant.id, jsonDecode(response)["Data"]["id"] ?? "");
            Get.to(()=>const RegistrationScreen());
        }
      } else {
      }
        return true;
    }
      BaseController().errorSnack(jsonDecode(response)["message"]);
     return false;
  }

  /// registration api integrate
  Future<bool> registrationNetworkApi(value) async {
    var bodyRequest = {
      "lng": AppConstants.LANGUAGE,
      "id": GetStorage().read(AppConstant.id).toString().trim(),
      "mobile": number.text.toString(),
      "state_id": '1',
      "zip_code": "",
      "city_id": "",
      "id_prove_type": idProveType.value.toString() ?? "", // ignore: dead_null_aware_expression
      "id_prove_no": etAadhar.value.text.toString(), // ignore: dead_null_aware_expression
      "address": etAddress.text.toString(), // ignore: dead_null_aware_expression
      "map_address": mapAddress.text.toString(), // ignore: dead_null_aware_expression
      "name": etName.text.toString(), // ignore: dead_null_aware_expression
      "email": etEmail.text.toString(), // ignore: dead_null_aware_expression
    };
    print("bjs ${rxPath.value}");
    print("body request =========>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .profileUpdate(
            AppConstants.PROFILE_UPDATE, bodyRequest, rxPath.value)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("data response =====>>>> $response");
    if (jsonDecode(response)["status"] == 1) {
      storage.write(AppConstant.id, jsonDecode(response)["Data"]["id"] ?? "");
      storage.write(AppConstant.name, jsonDecode(response)["Data"]["name"] ?? "");
      storage.write(AppConstant.address, jsonDecode(response)["Data"]["address"] ?? "");
      storage.write(AppConstant.profile, jsonDecode(response)["Data"]["profile"] ?? "");
      storage.write(AppConstant.email, jsonDecode(response)["Data"]["email"] ?? "");
      storage.write(AppConstant.phone, jsonDecode(response)["Data"]["mobile"] ?? "");
      storage.write(AppConstant.userlogin, jsonDecode(response)["Data"]["user_login"] ?? "");
      storage.write(AppConstant.idProvePhoto, jsonDecode(response)["Data"]["id_prove_photo"] ?? "");
      storage.write(AppConstant.aadhar, jsonDecode(response)["Data"]["id_prove_no"] ?? "");
      storage.write(AppConstant.idProveType, jsonDecode(response)["Data"]["id_prove_type"] ?? "");
      storage.write(AppConstant.latitude, jsonDecode(response)["Data"]["latitude"] ?? "");
      storage.write(AppConstant.longitude, jsonDecode(response)["Data"]["longitude"] ?? "");
      storage.write(AppConstant.shopName, jsonDecode(response)["Data"]["shop_name"] ?? "");
      storage.write(AppConstant.shopPhoto,jsonDecode(response)["Data"]["shop_photo"] ?? "");
      BaseController().successSnack(value?"":"Profile update successfully");
      value ?  Get.offAll(()=>const ShopDetails()) : Get.offAll(() => const DashboardScreen());
      return true;
    }
      BaseController().errorSnack(jsonDecode(response)["message"]);
      return false;
  }

  saveDataRegistration() async {
    number.text = storage.read(AppConstant.phone) ?? "";
    etName.text = storage.read(AppConstant.name) ?? "";
    etEmail.text = storage.read(AppConstant.email) ?? "";
    etAddress.text = storage.read(AppConstant.address) ?? "";
    String idType = storage.read(AppConstant.idProveType) ?? "";
    idProveType.value = idType.isNotEmpty?int.parse(idType.toString()):0;
    etAadhar.text = storage.read(AppConstant.aadhar);
  }

  removeData() async {
    GetStorage().erase();
    storage.remove(AppConstant.phone);
    storage.remove(AppConstant.name);
    storage.remove(AppConstant.email);
    storage.remove(AppConstant.shopName);
    storage.remove(AppConstant.address);
    storage.remove(AppConstant.profile);
    storage.remove(AppConstant.idProveType);
    storage.remove(AppConstant.aadhar);
    storage.remove(AppConstant.store_time);
    storage.remove(AppConstant.description);
    storage.remove(AppConstant.byck_service_capicity);
    storage.remove(AppConstant.normalCcByck);
    storage.remove(AppConstant.heigh_pickup);
    storage.remove(AppConstant.is_on_road_service);
    storage.remove(AppConstant.shopPhoto);
    etMobile.clear();
    etName.clear();
    etEmail.clear();
    etAddress.clear();
    etAadhar.clear();
    shopName.clear();
    startTime.clear();
    endTime.clear();
    description.clear();
    serviceCapacity.clear();
  }

  logout() async {
    removeData();
    Get.delete<LoginController>();
    Get.offAll(()=>const SpalshScreen());
  }

  /// update profile api integrate
  Future<bool> updateShopProfile(String message) async {
    var text;
    var bodyRequest = {
      "lng": AppConstants.LANGUAGE,
      "id": storage.read(AppConstant.id).toString().trim(),
      "normal_cc_byck": normalCc.value.toString(),
      "heigh_pickup": highPickup.value.toString(),
      "is_on_road_service": roadService.value.toString(),
      "byck_service_capicity": serviceCapacity.text.toString(),
      "description": description.text.toString(),
      "shop_name": shopName.text.toString(),
      "store_time": "${startTime.text.toString()} to ${endTime.text.toString()}",
      "select_vehicle":"${selectvehicle.value} ${otherValueController.text}",
    };
    Get.context!.loaderOverlay.show();
    print("data body request =========>>>>>>>>  $bodyRequest");
    var response = await BaseClient()
        .shopUpdate(AppConstants.SHOP_PROFILE_UPDATE, bodyRequest,
            shopPath.value)
        .catchError(BaseController().handleError);
    print("==========>>>> status ${jsonDecode(response)["status"]}");
    print("data response =====>>>> $response");
    Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"] == 1) {
      storage.write(AppConstant.id, jsonDecode(response)["Data"]["id"] ?? "");
      storage.write(AppConstant.normalCcByck, jsonDecode(response)["Data"]["normal_cc_byck"] ?? "");
      storage.write(AppConstant.heigh_pickup, jsonDecode(response)["Data"]["heigh_pickup"] ?? "");
      storage.write(AppConstant.userlogin, jsonDecode(response)["Data"]["user_login"] ?? "");
      storage.write(AppConstant.is_on_road_service, jsonDecode(response)["Data"]["is_on_road_service"] ?? "");
      storage.write(AppConstant.byck_service_capicity, jsonDecode(response)["Data"]["byck_service_capicity"] ?? "");
      storage.write(AppConstant.description, jsonDecode(response)["Data"]["description"] ?? "");
      storage.write(AppConstant.profile, jsonDecode(response)["Data"]["profile"] ?? "");
      storage.write(AppConstant.shopName, jsonDecode(response)["Data"]["shop_name"] ?? "");
      storage.write(AppConstant.shopPhoto, jsonDecode(response)["Data"]["shop_photo"] ?? "");
      storage.write(AppConstant.idProvePhoto, jsonDecode(response)["Data"]["id_prove_photo"] ?? "");
      storage.write(AppConstant.store_time, jsonDecode(response)["Data"]["store_time"] ?? "");
      BaseController().successSnack(message);
      // CustomAnimation().showCustomSnackBar(value ? "Login Successfully!" : jsonDecode(response)["message"], isError: false);
      return true;
    }
    CustomAnimation().showCustomSnackBar(jsonDecode(response)["message"], isError: true);
    return false;
  }

  /// timer otp verify
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value > 0.0) {
        seconds.value--;
      } else {
        if (minutes.value > 0.0) {
          minutes.value--;
          seconds.value = 30;
        } else {
          timer.cancel();
        }
      }
    });
  }
  void resetTimer() {
    timer?.cancel();
    minutes.value = 1;
    seconds.value = 0;
    startTimer();
    Future.delayed(const Duration(milliseconds: 500));
  }

  void setSelectedValue(int value) {
    idProveType.value = value;
  }

  /// crop profile image code
  Future chooseImage(bool isCamera) async {
    final ImagePicker picker = ImagePicker();
    try {
      /*final XFile? image =*/ await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 60,
      ).then((value) {
        if(value != null){
          _cropImage(File(value.path));
        }
        return null;
      });
      // if (image != null) {
      //   isLoading.value = true;
      //   rxPath.value = image.path;
      //   isLoading.value = false;
      //   print("photo ${rxPath.value}");
      // }
    } on Exception catch (e) {
      print("image response $e");
    }
  }
  _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ] : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [AndroidUiSettings(
            toolbarTitle: "Image",
            toolbarColor: TColor.themecolor,
            toolbarWidgetColor: Colors.white,
            statusBarColor: TColor.themecolor,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
          IOSUiSettings(
            title: "Image",
          ),
        ]);
    if (croppedFile != null) {
      imageCache.clear();
      isLoading.value = true;
      rxPath.value = File(croppedFile.path).path;
      isLoading.value = false;
    }
  }

  /// chooseShopImage choose
  chooseShopImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );
    if (image != null) {
      shopPath.value = image.path.toString();
      print("shop photo ${shopPath.value}");
    }
  }

  void chooseTime(bool timeValue) async {
    var currentTime;
    var selectedTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      currentTime = selectedTime.format(Get.context!);
      print(currentTime);
    }
    if (currentTime != null) {
      timeValue ? (endTime.text = currentTime) : (startTime.text = currentTime);
      CustomAnimation()
          .showCustomToast("Set time $currentTime", isError: false);
    } else {
      Fluttertoast.showToast(msg: "Please select time ! ");
      CustomAnimation().showCustomToast("Please select time ! ", isError: true);
    }
  }

  /// app exit function
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      urlValue.value = "";
      currentBackPressTime = now;
      CustomAnimation().showCustomToast('Press again to exit GoMechanic', isError: false);
      // ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
      return Future.value(false);
    }
    return Future.value(true);
  }

  /// get current location address
  Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  /// get current address api integrate
  Future<void> getAddressFromLatLong() async {
    Position position = await getLocation();
    List<Placemark> placemarks=await placemarkFromCoordinates(position.latitude, position.longitude);
    latitude.value = position.latitude;
    longitude.value = position.longitude;
    print("lat ${position.latitude}");
    print("long ${position.longitude}");
    Placemark place = placemarks[0];
    current_address.value = "${place.street}, ${place.subLocality}, ${place.locality.toString()}, ${place.country}";
    etAddress.text = current_address.value;
  }

  /// banner api integrate
  var bannerData = BannerData(data: []).obs;
  RxInt currentIndex = 0.obs;
  getBannerNetworkApi() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get(AppConstants.getBannerApi)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ===================>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"].toString() == "1") {
      bannerData.value = bannerDataFromJson(response);
      refresh();
      update();
      return;
    }
    // BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  void setCurrentIndex(int index, bool notify) {
    currentIndex.value = index;
    update();
  }

  /// get vendor item data count api integrate
  var itemData = ItemModel(data: []).obs;
  Future<bool> getVendorItemDataCountNetworkApi() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get("${AppConstants.getVendorDashboardCount}?mechanic_id=${GetStorage().read(AppConstant.id).toString().trim()}")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ===================>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"].toString() == "1") {
      itemData.value = itemModelFromJson(response);
      refresh();
      update();
      return true;
    }
    // BaseController().errorSnack(jsonDecode(response)["message"]);
      return false;
  }

  /// get list item data count api integrate
  var listItemData = ItemModel(data: []).obs;
  Future<bool> getListItemDataCountNetworkApi() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get("${AppConstants.getVendorDashboardCount}?mechanic_id=${GetStorage().read(AppConstant.id).toString().trim()}")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("list response ===================>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"].toString() == "1") {
      listItemData.value = itemModelFromJson(response);
      listItemData.value.data.removeRange(0,3);
      refresh();
      update();
      return true;
    }
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// get shop details api integrate
  var shopDetails = ShopDetailsModel(data: ShopData()).obs;
  Future<bool> getShopDetailsNetworkApi() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get("${AppConstants.getShopDetails}?shop_id=${GetStorage().read(AppConstant.id).toString().trim()}")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("list response ===================>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"].toString() == "1") {
      shopDetails.value = shopDetailsModelFromJson(response);
      refresh();
      update();
      return true;
    }
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// shop open close api integrate
  var shopOpenClose = ShopOpenCloseModel(data: ShopOpenCloseData()).obs;
  Future<bool> shopOpenCloseNetworkApi() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get("${AppConstants.vendorShop_openClose}?mechanic_id=${GetStorage().read(AppConstant.id).toString().trim()}")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("list response ===================>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"].toString() == "1") {
      shopOpenClose.value = shopOpenCloseModelFromJson(response);
      storage.write(AppConstant.shop_open, jsonDecode(response)["Data"]["shop_open"].toString());
      storage.write(AppConstant.profile, jsonDecode(response)["Data"]["profile"] ?? "");
      storage.write(AppConstant.id, jsonDecode(response)["Data"]["id"] ?? "");
      storage.write(AppConstant.phone, jsonDecode(response)["Data"]["mobile"] ?? "");
      return true;
    }
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// get notification api integrate
  var allNotification = NotificationModel(data: []).obs;
  Future<bool> getNotificationNetworkApi() async {
    allNotification.value.data.clear();
    // Get.context!.loaderOverlay.show();
        simmer.value = true;
    var response = await BaseClient()
        .get("${AppConstants.getNotifications}?limit=${10}&page=0&id=${GetStorage().read(AppConstant.id).toString().trim()}&type=2")
        .catchError(BaseController().handleError);
    // Get.context!.loaderOverlay.hide();
        simmer.value = false;
    print("notification response ===================>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"].toString() == "1") {
      isLoadingPage.value = true;
      allNotification.value = notificationModelFromJson(response);
      update();
      refresh();
      return true;
    }
    // BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  addItems() async {
    scrollNotificationsController.addListener(() {
      // print("pagination data");
      if (scrollNotificationsController.position.pixels == scrollNotificationsController.position.maxScrollExtent) {
        if (isLoadingPage.value == true) {
          currentPage.value = currentPage.value + int.parse(allNotification.value.page.toString());
          notificationLoadingPageNetworkApi(currentPage.value);
        }
      }
    });
  }

  /// get notification pagination api integrate
  void notificationLoadingPageNetworkApi(int end) async {
    var response = await BaseClient()
        .get("${AppConstants.getNotifications}?limit=${10}&page=$end&id=${GetStorage().read(AppConstant.id).toString().trim()}&type=2")
        .catchError(BaseController().handleError);
    print("response =============>>>>>>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == 1) {
      if (isLoadingPage.value == true) {
        allNotification.value.data.addAll(notificationModelFromJson(response).data);
        refresh();
        update();
      }
    } else {
      isLoadingPage.value = false;
      CustomAnimation().showCustomToast("No more data available !", isError: false);
    }
  }

  /// google signing get value
  var googleValue;
  Future<bool> socialGoogleLogin()async{
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      googleValue = await googleSignIn.signIn();
      print("result $googleValue");
      return true;
    } catch (error) {
      print(error);
    }
    return false;
  }

  /// social signIn login api integrate
  Future<bool> socialSignInUpNetworkApi(String deviceId)async
  {
    final FcmTokan=await FirebaseMessaging.instance.getToken();
    var bodyRequest={
      "lng": AppConstants.LANGUAGE,
      "name": googleValue.displayName.toString(),
      "email": googleValue.email.toString(),
      "mobile": "",
      "device_id": googleValue.id.toString(),
      "fcm_id": FcmTokan.toString(),
    };
    print("body request ========>>>>>>>>>>>>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response=await BaseClient().post(AppConstants.vendorSocialSignInUp, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("body response ==============>>>>>>>>>>>>>>>>>>>> $response");
    if(jsonDecode(response)["status"] == 1)
    {
        if ( googleValue.displayName.toString().isNotEmpty
            &&  googleValue.email.toString().isNotEmpty) {
          storage.write(AppConstant.id, jsonDecode(response)["Data"]["id"] ?? "");
          storage.write(AppConstant.name, jsonDecode(response)["Data"]["name"] ?? "");
          storage.write(AppConstant.address, jsonDecode(response)["Data"]["address"] ?? "");
          storage.write(AppConstant.profile, jsonDecode(response)["Data"]["profile"] ?? "");
          storage.write(AppConstant.email, jsonDecode(response)["Data"]["email"] ?? "");
          storage.write(AppConstant.phone, jsonDecode(response)["Data"]["mobile"] ?? "");
          storage.write(AppConstant.fcm_token, jsonDecode(response)["Data"]["fcm_id"] ?? "");
          storage.write(AppConstant.idProvePhoto,jsonDecode(response)["Data"]["id_prove_photo"] ?? "");
          storage.write(AppConstant.aadhar, jsonDecode(response)["Data"]["id_prove_no"] ?? "");
          storage.write(AppConstant.idProveType, jsonDecode(response)["Data"]["id_prove_type"] ?? "");
          storage.write(AppConstant.normalCcByck, jsonDecode(response)["Data"]["normal_cc_byck"] ?? "");
          storage.write(AppConstant.heigh_pickup, jsonDecode(response)["Data"]["heigh_pickup"] ?? "");
          storage.write(AppConstant.is_on_road_service, jsonDecode(response)["Data"]["is_on_road_service"] ?? "");
          storage.write(AppConstant.byck_service_capicity, jsonDecode(response)["Data"]["byck_service_capicity"] ?? "");
          storage.write(AppConstant.description, jsonDecode(response)["Data"]["description"] ?? "");
          storage.write(AppConstant.shopName, jsonDecode(response)["Data"]["shop_name"] ?? "");
          storage.write(AppConstant.shopPhoto,jsonDecode(response)["Data"]["shop_photo"] ?? "");
          storage.write(AppConstant.store_time, jsonDecode(response)["Data"]["store_time"] ?? "");
          storage.write(AppConstant.shop_open, jsonDecode(response)["Data"]["shop_open"].toString());
          storage.write(AppConstant.latitude, jsonDecode(response)["Data"]["latitude"] ?? "");
          storage.write(AppConstant.longitude, jsonDecode(response)["Data"]["longitude"] ?? "");
          saveDataRegistration();
          Get.offAll(()=> const DashboardScreen());
          BaseController().successSnack(jsonDecode(response)["message"]);
        } else {
          removeData();
          storage.write(AppConstant.phone, jsonDecode(response)["Data"]["mobile"] ?? "");
          storage.write(AppConstant.id, jsonDecode(response)["Data"]["id"] ?? "");
          Get.to(()=>const ShopDetails());
        }
    }
    else {
      final auth = FirebaseAuth.instance;
      final googleSignIn = GoogleSignIn();
      await auth.signOut();
      await googleSignIn.signOut();
      BaseController().errorSnack(jsonDecode(response)["message"]);
    }
    return false;
  }


  /// get Faq api integrate
  var faqModel = FaqModel(data: []).obs;
  getFaqNetworkApi() async {
    var response = await BaseClient()
        .get("${AppConstants.getFaq}?lng=eng&limit=10&page=0&mechanic_id=${GetStorage().read(AppConstant.id).toString().trim()}")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1) {
      faqModel.value = faqModelFromJson(response);
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  /// get contact us api integrate
  var contactUs = ContactUsModel(data: ContactData()).obs;
  Future<bool> getContactUsNetworkApi() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get("${AppConstants.getContactDetails}?lng=eng")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"] == 1) {
      contactUs.value = contactUsModelFromJson(response);
      // BaseController().successSnack(jsonDecode(response)["message"]);
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  /// instagram send url
  instagramUrlApp() async {
    const url = "https://www.instagram.com/_akshayarya_bst/";
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// facebook send url
  facebookUrlApp() async {
    const url = "https://www.facebook.com/profile.php?id=100081886102066";
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// twitter send url
  twitterUrlApp() async {
    const url = "https://twitter.com/akshay515690";
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// weblink send url
  websiteLink() async {
    final url = contactUs.value.data.websiteLink.toString();
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// contact number send dial keyboard
  launchCaller() async {
    final url = "tel: ${contactUs.value.data.mobile.toString()}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// mail send url
  luncherMail() async {
    final url = "mailto: ${contactUs.value.data.email.toString()}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// open google map send url
  void openGoogleMaps(double lat, double long) async {
    final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not open Google Maps';
    }
  }


}
