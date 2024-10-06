class APIEndPoints {

  //static const baseUrl = "https://raw-bertie-wittyplex.koyeb.app";
  static const baseUrl = "https://cgp-customer-api-dev.onrender.com";
  static const baseUrlMessaging = "https://laravel-api.tradebar.com.au";


  static const login = "/auth/login";
  static const registration="/auth/registration";
  static const emailVerification="/auth/email-verification";
  static const homeData="/home";
  static const getCategory="/categories";
  static const wareHouseDetails="/warehouses/";
  static const getProductByCategory="/categories/{categoryId}/products";
  static const productDetails="/products/";
  static const getWareHouses="/warehouses";
  static const getProductByWareHouse="/warehouses/{warehouseId}/products";
  static const getWareHousesByCategory="/categories/{categoryId}/warehouse";

  static const getSimilarProducts="/products/similar/{productId}";

  static const setPassword="/auth/set-password";
  static const reSetPassword="/auth/reset-password";

  static const searchProduct="/search/products";

  static const loginVerification="/auth/login-verification";

  static const forgotPassword="/auth/forget-password";

  static const reSendOTP="/auth/resent-otp";

  static const getWishList="/wishlist";
  static const addOrRemoveWishList="/wishlist/{productId}";

  static const getAllProducts="/products";
  static const getMyCart="/cart";

  static const addSingleItemToCart="/cart/add-single/{productId}/{quantity}";

  static const updateSingleItemToCart="/cart/update-single/{cartId}/{quantity}";

  static const removeCartItem="/cart/remove-single/{cartId}";

  static const saveAddress="/customers-addresses";
  static const getAddress="/customers-addresses/all";

  static const placeOrder="/orders";

  static const getOrderDetails="/orders/single/{orderId}";

  static const getVehicles="/transportation/vehicles";

  static const calculateTransportSummary="/transportation/calculate";
  static const orderTransport="/transportation/orders";
  static const updateUser="/customers/profile/edit";
  static const updateAddress="/customers-addresses/{id}";
  static const setDefaultAddress="/customers-addresses/set-default/{id}";
  static const orderHistory="/orders/history";
  static const getNotification="/notifications/all";

  static const markNotificationAsRead="/notifications/mark-as-read/{notificationId}";

  static const logOut="/auth/logout";

  static const getCancelReason="/order-cancel-reasons";

  static const cancelOrder="/orders/cancel/{orderId}/{orderCancelReasonId}";

  static const addPaymentMethod="/payment-method";

  static const getPaymentMethods="/payment-method/get-all-by-user";

  static const deletePaymentMethod="/payment-method/{pmID}";

  static const setDefaultPaymentMethod="/payment-method/set-default/{pmID}";

  static const addReview="/reviews";

  static const getOngoingOrder="/orders/ongoing-order/{orderId}";

  static const hasDefaultPaymentMethod="/payment-method/has-default";

  static const getSupportList="/api/v1/messaging/ajax/customer-support-list";

  static const getIssueSubjectList="/api/v1/messaging/ajax/issue-subject-list";

  static const createSupportEndPoint="/api/v1/messaging/ajax/create-support";

  static const faqEndPoint="/api/v1/messaging/ajax/faq-list";

  static const getTermsAndCondition="/api/v1/messaging/ajax/get-terms-condition";

  static const searchWarehouse="/search/warehouses";

  static const wareHouseBranchDetails="/warehouses/branches/";

  static const getProductByWareHouseBranch="/warehouse/branches/{branchId}/products";

  static const getWareHousesBranches="/warehouses/branches/all";

  static const homeDataWithWarehouseBranch="/home/with-branch";

  static const appVersionEndpoint="/app/version";

  static const removeAccount="/customers/remove-account";

  static const loggedInCustomerProfile="/customers/profile";



}
