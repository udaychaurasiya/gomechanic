// ignore_for_file: non_constant_identifier_names, avoid_print, deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gomechanic/AppConstent/AppConstant.dart';
import 'package:gomechanic/UtilMethode/BaseClient.dart';
import 'package:gomechanic/UtilMethode/utilmethode.dart';
import 'package:gomechanic/models/booking_status_model.dart';
import 'package:gomechanic/models/category_model.dart';
import 'package:gomechanic/models/service_model.dart';
import 'package:gomechanic/utils/app_constants.dart';
import 'package:gomechanic/utils/custom_snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

class DetailsController extends GetxController {
  var serviceModel = ServiceDetailsModel(data: []).obs;
  var searchServiceModel = ServiceDetailsModel(data: []).obs;
  GetStorage storage = GetStorage();
  final ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  RxBool isLoadingPage = false.obs;
  RxBool simmerValue = false.obs;
  RxInt currentPage = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isExpansionTileOpen1 = false.obs;
  RxBool isExpansionTileOpen2 = false.obs;
  RxBool isExpansionTileOpen3 = false.obs;
  RxBool isExpansionTileOpen4 = false.obs;
  RxInt detailsIndex = 0.obs;
  RxString bookingId = "".obs;
  RxString bookingNo = "".obs;
  RxString booking_date = "".obs;
  RxString user_id = "".obs;
  RxString user_name = "".obs;
  RxString user_num = "".obs;
  RxString userProfile = "".obs;
  RxString ownerName = "".obs;
  RxString serviceType = "".obs;
  RxString service_date = "".obs;
  RxString bike_cc = "".obs;
  RxString status = "".obs;
  RxString brandName = "".obs;
  RxString vin_image = "".obs;
  RxString prove_image = "".obs;
  RxString slot_id = "".obs;
  RxString pImage1 = "".obs;
  RxString pImage2 = "".obs;
  RxString pImage3 = "".obs;
  RxString pImage4 = "".obs;
  RxString dImage1 = "".obs;
  RxString dImage2 = "".obs;
  RxString dImage3 = "".obs;
  RxString dImage4 = "".obs;
  RxString rImage1 = "".obs;
  RxString rImage2 = "".obs;
  RxString rImage3 = "".obs;
  RxString rImage4 = "".obs;
  RxString uImage1 = "".obs;

  final List<String> serviceStatus = [
    'Pending',
    'Receive',
    'Pickup',
    'Complete',
  ];

  @override
  void onInit() {
    super.onInit();
    addItems();
  }

  saveDataRegistration() async {
    user_id.value = storage.read(AppConstant.id) ?? "";
    user_num.value = storage.read(AppConstant.mobile_no) ?? "";
    userProfile.value = storage.read(AppConstant.userProfile) ?? "";
    bookingNo.value = storage.read(AppConstant.booking_no) ?? "";
    booking_date.value = storage.read(AppConstant.booking_date) ?? "";
    user_name.value = storage.read(AppConstant.userName) ?? "";
    ownerName.value = storage.read(AppConstant.ownerName) ?? "";
    serviceType.value = storage.read(AppConstant.serviceType) ?? "";
    service_date.value = storage.read(AppConstant.service_date) ?? "";
    bike_cc.value = storage.read(AppConstant.bike_cc) ?? "";
    status.value = storage.read(AppConstant.status) ?? "";
    brandName.value = storage.read(AppConstant.brandName) ?? "";
    slot_id.value = storage.read(AppConstant.slot_id) ?? "";
    prove_image.value = storage.read(AppConstant.id_prove) ?? "";
    vin_image.value = storage.read(AppConstant.vin_no_pic) ?? "";
    storage.read(AppConstant.latitude) ?? "";
    storage.read(AppConstant.longitude) ?? "";
  }

  loader() {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
    });
  }
  var address = ''.obs;
  RxDouble latitude =0.0.obs;
  RxDouble longitude =0.0.obs;
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
  Future<void> GetAddressFromLatLong() async {
    Position position = await getLocation();
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    longitude.value=position.longitude;
    latitude.value=position.latitude;
    Placemark place = placemarks[0];
   address.value ="${place.street},${place.subLocality},${place.locality.toString()},${place.country}";

  }







    Future<dynamic> UpdateAddressNetWorkApi() async {
    var bodyRequest = {
      "user_id":GetStorage().read(AppConstant.id).toString(),
      "latitude":latitude.value.toString(),
      "longitude":longitude.value.toString(),
      "address":address.toString(),
    };
    print("fghfhf $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .post(AppConstants.UPDATE_CURRENT_ADDRESS, bodyRequest)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print(response);
    print("kdjkjhiygfvh"+response);
    if (jsonDecode(response)["status"] == 1)
    {
      BaseController().successSnack(jsonDecode(response)["message"]);
      return true;
    }
  }


  Future<bool>? getBookDetailsNetworkApi(var categoryId, type,searchKey) async {
    serviceModel.value.data.clear();
    serviceModel.value.status = 0;
    // Get.context!.loaderOverlay.show();
    simmerValue.value = true;
    var response = await BaseClient()
        .get("${AppConstants.getVendorOrderList}?limit=${100}&page=0&searchkey=$searchKey&category_id=$categoryId&mechanic_id=${GetStorage().read(AppConstant.id).toString().trim()}&type=$type")
        .catchError(BaseController().handleError);
    simmerValue.value = false;
    // Get.context!.loaderOverlay.hide();
    print("response gh ========>>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == 1) {
      isLoadingPage.value = false;
      serviceModel.value = serviceDetailsModelFromJson(response);
      refresh();
      update();
      return true;
    }
      return false;
  }

  Future<bool>? searchBookingOrderNetworkApi(var categoryId, type,searchKey) async {
    serviceModel.value.data.clear();
    serviceModel.value.status = 0;
    // Get.context!.loaderOverlay.show();
    simmerValue.value = true;
    var response = await BaseClient()
        .get("${AppConstants.getVendorOrderList}?limit=${100}&page=0&searchkey=$searchKey&category_id=$categoryId&mechanic_id=${GetStorage().read(AppConstant.id).toString().trim()}&type=$type")
        .catchError(BaseController().handleError);
    // Get.context!.loaderOverlay.hide();
    simmerValue.value = false;
    print("response gh ========>>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == 1) {
      serviceModel.value = serviceDetailsModelFromJson(response);
      isLoadingPage.value = false;
      refresh();
      update();
      return true;
    }
    CustomAnimation().showCustomToast("No data found !", isError: true);
    return false;
  }

  addItems() async {
    scrollController.addListener(() {
      // print("pagination data");
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (isLoadingPage.value == true) {
          currentPage.value = currentPage.value + int.parse(serviceModel.value.page.toString());
          getBookingLoadingPageNetworkApi(currentPage.value);
        }
      }
    });
  }

  getBookingLoadingPageNetworkApi(int end) async {
    var response = await BaseClient()
        .get("${AppConstants.getVendorOrderList}?lng=eng?limit=${100}&page=$end&searchkey=&category_id=&mechanic_id=${GetStorage().read(AppConstant.id).toString().trim()}&type=")
        .catchError(BaseController().handleError);
    print("response ======>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == 1) {
      if (isLoadingPage.value == true) {
        serviceModel.value.data.addAll(serviceDetailsModelFromJson(response).data);
        refresh();
        update();
      }
    } else {
      isLoadingPage.value = false;
      CustomAnimation().showCustomToast("No more data available !", isError: false);
    }
  }

  var getCategoryData = CategoryModel(data: []).obs;
  Future<bool> getCategoryNetworkApi() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get(AppConstants.getCategory)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ========>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == 1) {
      getCategoryData.value = categoryModelFromJson(response);
      refresh();
      update();
      return true;
    }
      return false;
  }

  // booking status api integration
  Future<bool> bookingStatusNetworkApi(String bookingId, String status) async {
    var bodyRequest = {
      "booking_id": bookingId,
      "mechanic_id": GetStorage().read(AppConstant.id).toString().trim(),
      "booking_status": status,
    };
    print("body request ====>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .bookingStatus(bodyRequest, AppConstants.vendorUpdate_BookingStatus,
        status == "2" ? pImage1.value : status == "4" ? rImage1.value : dImage1.value,
        status == "2" ? pImage2.value : status == "4" ? rImage2.value : dImage2.value ,
        status == "2" ? pImage3.value : status == "4" ? rImage3.value : dImage3.value,
        status == "2" ? pImage4.value : status == "4" ? rImage4.value : dImage4.value)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ============>>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == 1) {
      BaseController().successSnack(jsonDecode(response)["message"]);
      refresh();
      update();
      return true;
    }
    return false;
  }

  Future<bool> bookingUnderServiceNetworkApi(String bookingId, String status) async {
    var bodyRequest = {
      "booking_id": bookingId,
      "mechanic_id": GetStorage().read(AppConstant.id).toString().trim(),
      "booking_status": status,
    };
    print("body request ====>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .underDeliverImage(bodyRequest, AppConstants.vendorUpdate_BookingStatus, uImage1.value)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ============>>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == 1) {
      refresh();
      update();
      return true;
    }
    return false;
  }



  Future<bool> reachBtnNetworkApi(String bookingId, String bookingStatus) async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get("${AppConstants.vendorUpdateServiceStatus}?booking_id=$bookingId&mechanic_id=${GetStorage().read(AppConstant.id).toString().trim()}&booking_status=$bookingStatus")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("====== $response");
    if (jsonDecode(response)["status"] == 1) {
      refresh();
      update();
      return true;
    }
    return false;
  }


  Future<bool> getRejectedNetworkApi(String bookingId,String bookingStatus) async {
    Get.context!.loaderOverlay.show();
    // var response = await BaseClient().get("${AppConstants.getRejectedApi}?booking_id=$bookingId&mechanic_id=${GetStorage().read(AppConstant.id).toString()}&status=$bookingStatus")
    //     .catchError(BaseController().handleError);
    var response = await BaseClient().get("https://www.animationmedia.org/carMechanic/api/VendorMaster/vendorRejectOrderStatus?booking_id=$bookingId&mechanic_id=${GetStorage().read(AppConstant.id)}&status=0")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("==kjkjkkjk==== $response");
    if (jsonDecode(response)["status"] == 1) {
      BaseController().successSnack(jsonDecode(response)["message"]);
      refresh();
      update();
      return true;
    }
    return false;
  }

  // booking status details api integration
  var getBookingDetails = BookingStatusModel(data: DetailsData(pickedupImage: [], underServiceImage: [], readyDeliverImage: [], deliveredImage: [], transectionList: [])).obs;
  Future<bool> getBookingDetailsNetworkApi(String bookingId) async {
    getBookingDetails.value.data.pickedupImage.clear();
    getBookingDetails.value.data.underServiceImage.clear();
    getBookingDetails.value.data.readyDeliverImage.clear();
    getBookingDetails.value.data.deliveredImage.clear();
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get("${AppConstants.getBookingDetails}?booking_id=$bookingId")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ===========>>>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == 1) {
      getBookingDetails.value = bookingStatusModelFromJson(response);
      getBookingDetails.refresh();
      refresh();
      update();
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  // booking accepted api integration
  Future<bool> BookingAcceptNetworkApi(String bookingId)async
  {
    var bodyRequest = {
      "lng": AppConstants.LANGUAGE,
      "booking_id": bookingId.toString(),
      "mechanic_id": GetStorage().read(AppConstant.id).toString().trim(),
    };
    print("body request ========>>>>>>>>>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().post(
        AppConstants.vendorAcceptBookService, bodyRequest).catchError(
        BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("body response =============>>>>>>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == 1) {
      BaseController().successSnack("Booking ${jsonDecode(response)["message"]}");
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  // deliver image choose image code
  final picker = ImagePicker();
  var deliverImage1 = Rx<File?>(null);
  var deliverImage2 = Rx<File?>(null);
  var deliverImage3 = Rx<File?>(null);
  var deliverImage4 = Rx<File?>(null);

  Future deliverPhoto1(context, ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
        deliverImage1.value = File(pickedFile.path);
        rImage1.value = deliverImage1.value!.path;
        print(deliverImage1.value!.path);
    }
  }

  Future deliverPhoto2(context, ImageSource source) async {
    final pickedFile1 = await picker.pickImage(source: source);
    if (pickedFile1 != null) {
      deliverImage2.value = File(pickedFile1.path);
      rImage2.value = deliverImage2.value!.path;
      print(deliverImage2.value!.path);
    }
  }

  Future deliverPhoto3(context, ImageSource source) async {
    final pickedFile2 = await picker.pickImage(source: source);
    if (pickedFile2 != null) {
      deliverImage3.value = File(pickedFile2.path);
      rImage3.value = deliverImage3.value!.path;
      print(deliverImage3.value!.path);
    }
  }

  Future deliverPhoto4(context, ImageSource source) async {
    final pickedFile3 = await picker.pickImage(source: source);
    if (pickedFile3 != null) {
      deliverImage4.value = File(pickedFile3.path);
      rImage4.value = deliverImage4.value!.path;
      print(deliverImage4.value!.path);
    }
  }

  // Under Service Image widget
  var serviceImage = Rx<File?>(null);
  Future servicePhoto(context, ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      serviceImage.value = File(pickedFile.path);
      uImage1.value = serviceImage.value!.path;
      print(serviceImage.value!.path);
    }
  }

  // pickup Image code
  var pickImage1 = Rx<File?>(null);
  var pickImage2 = Rx<File?>(null);
  var pickImage3 = Rx<File?>(null);
  var pickImage4 = Rx<File?>(null);
  Future pickPhoto1(context, ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
        pickImage1.value = File(pickedFile.path);
        pImage1.value = pickImage1.value!.path;
        print(pickImage1.value!.path);
    }
  }

  Future pickPhoto2(context, ImageSource source) async {
    final pickedFile1 = await picker.pickImage(source: source);
    if (pickedFile1 != null) {
        pickImage2.value = File(pickedFile1.path);
        pImage2.value = pickImage2.value!.path;
        print(pickImage2.value!.path);
    }
  }

  Future pickPhoto3(context, ImageSource source) async {
    final pickedFile2 = await picker.pickImage(source: source);
    if (pickedFile2 != null) {
        pickImage3.value = File(pickedFile2.path);
        pImage3.value = pickImage3.value!.path;
        print(pickImage3.value!.path);
    }
  }

  Future pickPhoto4(context, ImageSource source) async {
    final pickedFile3 = await picker.pickImage(source: source);
    if (pickedFile3 != null) {
        pickImage4.value = File(pickedFile3.path);
        pImage4.value = pickImage4.value!.path;
        print(pickImage4.value!.path);
    }
  }

  // delivered Image code
  var deliveredImage1 = Rx<File?>(null);
  var deliveredImage2 = Rx<File?>(null);
  var deliveredImage3 = Rx<File?>(null);
  var deliveredImage4 = Rx<File?>(null);
  Future deliveredPhoto1(context, ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      deliveredImage1.value = File(pickedFile.path);
      dImage1.value = deliveredImage1.value!.path;
      print(deliveredImage1.value!.path);
    }
  }

  Future deliveredPhoto2(context, ImageSource source) async {
    final pickedFile1 = await picker.pickImage(source: source);
    if (pickedFile1 != null) {
      deliveredImage2.value = File(pickedFile1.path);
      dImage2.value = deliveredImage2.value!.path;
      print(deliveredImage2.value!.path);
    }
  }

  Future deliveredPhoto3(context, ImageSource source) async {
    final pickedFile2 = await picker.pickImage(source: source);
    if (pickedFile2 != null) {
      deliveredImage3.value = File(pickedFile2.path);
      dImage3.value = deliveredImage3.value!.path;
      print(deliveredImage3.value!.path);
    }
  }

  Future deliveredPhoto4(context, ImageSource source) async {
    final pickedFile3 = await picker.pickImage(source: source);
    if (pickedFile3 != null) {
      deliveredImage4.value = File(pickedFile3.path);
      dImage4.value = deliveredImage4.value!.path;
      print(deliveredImage4.value!.path);
    }
  }



}
