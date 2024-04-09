
// ignore_for_file: constant_identifier_names

class AppConstants {
  static const String APP_NAME = 'GoMechanic';
  static const String BASE_URL = "https://www.animationmedia.org/carMechanic/";
  static const String LANGUAGE = "eng";
  static const String LOGIN_URL = "${BASE_URL}api/VendorMaster/vendorSignIn";
  static const String VERIFY_URL = "${BASE_URL}api/VendorMaster/vendorVerifyOTP";
  static const String PROFILE_UPDATE = "${BASE_URL}api/VendorMaster/vendorUpdateProfile";
  static const String SHOP_PROFILE_UPDATE = "${BASE_URL}api/VendorMaster/vendorUpdateShopDetails";
  static const String getVendorOrderList = "${BASE_URL}api/VendorMaster/getVendorOrderList";
  static const String UPDATE_CURRENT_ADDRESS = "${BASE_URL}api/UserMaster/updateCurrentAddress";
  static const String getBannerApi = "${BASE_URL}api/Dashboard/getBanner";
  static const String getCategory = "${BASE_URL}api/Dashboard/getCategory";
  static const String getShopDetails = "${BASE_URL}api/Dashboard/getShopDetails";
  static const String getVendorDashboardCount = "${BASE_URL}api/VendorMaster/getVendorDashboardCount";
  static const String vendorShop_openClose = "${BASE_URL}api/VendorMaster/vendorShop_openClose";
  static const String getNotifications = "${BASE_URL}api/Dashboard/getNotifications";
  static const String vendorUpdate_BookingStatus = "${BASE_URL}api/VendorMaster/vendorUpdate_BookingStatus";
  static const String vendorUpdateServiceStatus = "${BASE_URL}api/VendorMaster/vendorUpdateServiceStatus";
  static const String getBookingDetails = "${BASE_URL}api/Dashboard/getBookingDetails";
  static const String vendorSocialSignInUp = "${BASE_URL}api/VendorMaster/vendorSocialSignInUp";
  static const String vendorAcceptBookService = "${BASE_URL}api/VendorMaster/vendorAcceptBookService";
  static const String getFaq = "${BASE_URL}api/Dashboard/getFaq";
  static const String getContactDetails = "${BASE_URL}api/Dashboard/getContactDetails";
  static const String getRejectedApi = "${BASE_URL}api/VendorMaster/vendorRejectOrderStatus";

}
