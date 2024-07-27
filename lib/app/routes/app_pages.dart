import 'package:get/get.dart';

import 'package:cgp/app/modules/addOrUpdateAddress/bindings/add_or_update_address_binding.dart';
import 'package:cgp/app/modules/addOrUpdateAddress/views/add_or_update_address_view.dart';
import 'package:cgp/app/modules/categorySearch/bindings/category_search_binding.dart';
import 'package:cgp/app/modules/categorySearch/views/category_search_view.dart';
import 'package:cgp/app/modules/chatHistory/bindings/chat_history_binding.dart';
import 'package:cgp/app/modules/chatHistory/views/chat_history_view.dart';
import 'package:cgp/app/modules/completeRegistration/bindings/complete_registration_binding.dart';
import 'package:cgp/app/modules/completeRegistration/views/complete_registration_view.dart';
import 'package:cgp/app/modules/editProfile/bindings/edit_profile_binding.dart';
import 'package:cgp/app/modules/editProfile/views/edit_profile_view.dart';
import 'package:cgp/app/modules/home/bindings/home_binding.dart';
import 'package:cgp/app/modules/home/views/home_view.dart';
import 'package:cgp/app/modules/locationSearch/bindings/location_search_binding.dart';
import 'package:cgp/app/modules/locationSearch/views/location_search_view.dart';
import 'package:cgp/app/modules/login/bindings/login_binding.dart';
import 'package:cgp/app/modules/login/views/login_view.dart';
import 'package:cgp/app/modules/messaging/bindings/messaging_binding.dart';
import 'package:cgp/app/modules/messaging/views/messaging_view.dart';
import 'package:cgp/app/modules/notifications/bindings/notifications_binding.dart';
import 'package:cgp/app/modules/notifications/views/notifications_view.dart';
import 'package:cgp/app/modules/orderDetails/bindings/order_details_binding.dart';
import 'package:cgp/app/modules/orderDetails/views/order_details_view.dart';
import 'package:cgp/app/modules/orderHistory/bindings/order_history_binding.dart';
import 'package:cgp/app/modules/orderHistory/views/order_history_view.dart';
import 'package:cgp/app/modules/password/bindings/password_binding.dart';
import 'package:cgp/app/modules/password/views/password_view.dart';
import 'package:cgp/app/modules/paymentMethods/bindings/payment_methods_binding.dart';
import 'package:cgp/app/modules/paymentMethods/views/payment_methods_view.dart';
import 'package:cgp/app/modules/paymentPage/bindings/payment_page_binding.dart';
import 'package:cgp/app/modules/paymentPage/views/payment_page_view.dart';
import 'package:cgp/app/modules/productDetails/bindings/product_details_binding.dart';
import 'package:cgp/app/modules/productDetails/views/product_details_view.dart';
import 'package:cgp/app/modules/profile/bindings/profile_binding.dart';
import 'package:cgp/app/modules/profile/views/profile_view.dart';
import 'package:cgp/app/modules/registration/bindings/registration_binding.dart';
import 'package:cgp/app/modules/registration/views/registration_view.dart';
import 'package:cgp/app/modules/resetPassword/bindings/reset_password_binding.dart';
import 'package:cgp/app/modules/resetPassword/views/reset_password_view.dart';
import 'package:cgp/app/modules/reviewAndRatings/bindings/review_and_ratings_binding.dart';
import 'package:cgp/app/modules/reviewAndRatings/views/review_and_ratings_view.dart';
import 'package:cgp/app/modules/searchPage/bindings/search_page_binding.dart';
import 'package:cgp/app/modules/searchPage/views/search_page_view.dart';
import 'package:cgp/app/modules/setLocation/bindings/set_location_binding.dart';
import 'package:cgp/app/modules/setLocation/views/set_location_view.dart';
import 'package:cgp/app/modules/shopDetails/bindings/shop_details_binding.dart';
import 'package:cgp/app/modules/shopDetails/views/shop_details_view.dart';
import 'package:cgp/app/modules/splashScreen/bindings/splash_screen_binding.dart';
import 'package:cgp/app/modules/splashScreen/views/splash_screen_view.dart';
import 'package:cgp/app/modules/support/bindings/support_binding.dart';
import 'package:cgp/app/modules/support/views/support_view.dart';
import 'package:cgp/app/modules/trackOrder/bindings/track_order_binding.dart';
import 'package:cgp/app/modules/trackOrder/views/track_order_view.dart';
import 'package:cgp/app/modules/transportation/bindings/transportation_binding.dart';
import 'package:cgp/app/modules/transportation/views/transportation_view.dart';
import 'package:cgp/app/modules/verifyOTP/bindings/verify_o_t_p_binding.dart';
import 'package:cgp/app/modules/verifyOTP/views/verify_o_t_p_view.dart';
import 'package:cgp/app/modules/wareHouses/bindings/ware_houses_binding.dart';
import 'package:cgp/app/modules/wareHouses/views/ware_houses_view.dart';
import 'package:cgp/app/modules/wishList/bindings/wish_list_binding.dart';
import 'package:cgp/app/modules/wishList/views/wish_list_view.dart';

import '../modules/cart/checkOut/bindings/check_out_binding.dart';
import '../modules/cart/checkOut/views/check_out_view.dart';
import '../modules/cart/groupCart/bindings/group_cart_binding.dart';
import '../modules/cart/groupCart/views/group_cart_view.dart';
import '../modules/cart/myCart/bindings/cart_details_binding.dart';
import '../modules/cart/myCart/views/my_cart_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;
  // static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_O_T_P,
      page: () => VerifyOTPView(),
      binding: VerifyOTPBinding(),
    ),
    GetPage(
      name: _Paths.PASSWORD,
      page: () => PasswordView(),
      binding: PasswordBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRATION,
      page: () => RegistrationView(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: _Paths.COMPLETE_REGISTRATION,
      page: () => CompleteRegistrationView(),
      binding: CompleteRegistrationBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_PAGE,
      page: () => SearchPageView(),
      binding: SearchPageBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY_SEARCH,
      page: () => CategorySearchView(),
      binding: CategorySearchBinding(),
    ),
    GetPage(
      name: _Paths.SHOP_DETAILS,
      page: () => ShopDetailsView(),
      binding: ShopDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAILS,
      page: () => ProductDetailsView(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: _Paths.GROUP_CART,
      page: () => GroupCartView(),
      binding: GroupCartBinding(),
    ),
    GetPage(
      name: _Paths.CART_DETAILS,
      page: () => MyCartView(),
      binding: CartDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CHECK_OUT,
      page: () => CheckOutView(),
      binding: CheckOutBinding(),
    ),
    GetPage(
      name: _Paths.WARE_HOUSES,
      page: () => WareHousesView(),
      binding: WareHousesBinding(),
    ),
    GetPage(
      name: _Paths.WISH_LIST,
      page: () => WishListView(),
      binding: WishListBinding(),
    ),
    GetPage(
      name: _Paths.SET_LOCATION,
      page: () => SetLocationView(),
      binding: SetLocationBinding(),
    ),
    GetPage(
      name: _Paths.TRANSPORTATION,
      page: () => TransportationView(),
      binding: TransportationBinding(),
    ),
    GetPage(
      name: _Paths.LOCATION_SEARCH,
      page: () => LocationSearchView(),
      binding: LocationSearchBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_PAGE,
      page: () => PaymentPageView(),
      binding: PaymentPageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.ADD_OR_UPDATE_ADDRESS,
      page: () => AddOrUpdateAddressView(),
      binding: AddOrUpdateAddressBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_HISTORY,
      page: () => OrderHistoryView(),
      binding: OrderHistoryBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAILS,
      page: () => OrderDetailsView(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
      name: _Paths.TRACK_ORDER,
      page: () => TrackOrderView(),
      binding: TrackOrderBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_METHODS,
      page: () => PaymentMethodsView(),
      binding: PaymentMethodsBinding(),
    ),
    GetPage(
      name: _Paths.REVIEW_AND_RATINGS,
      page: () => ReviewAndRatingsView(),
      binding: ReviewAndRatingsBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGING,
      page: () => MessagingView(),
      binding: MessagingBinding(),
    ),
    GetPage(
      name: _Paths.SUPPORT,
      page: () => SupportView(),
      binding: SupportBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_HISTORY,
      page: () => ChatHistoryView(),
      binding: ChatHistoryBinding(),
    ),
  ];
}
