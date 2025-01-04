class ApiUrl {
  static const bool isProductionUrl = false;
  static const String appVersion = "0.0.1";
  static const int maxAuthRetry = 3;
  static const String baseUrl =
      isProductionUrl ? "https://mdqualityapps.in/API/gross_shop/uat/" : "https://mdqualityapps.in/API/gross_shop/development/";
  static String login_token = "";
  static String login = "customer/signin";
  static String register = "customer/signup";
  static String editProfile = "update-customerprofile";
  static String favoriteScreen = "filter_nearby_products";
  static String homeScreen = "filter_nearby_products";
  static String addWishList = "add-wishlist";
  static String deleteWishList = "delete-wishlist";
  static String SelectProductScreen = "get_related_product"; 
  static String addcart = "customer/cart/add-to-cart";
  static String getcart = "customer/cart/get-products";
  static String deletecart = "customer/cart/remove";
  static String SearchProduct = "filter_nearby_products";  
  static String forgotPassword = "customer/forgot-password";
  static String getParticularCustomer = "customer/order/get"; 
  static String getOfferslist = "get-offers";
  static String getCustomerOrderlist = "customer/order/get-all";
  static String deleteCart = "delete-cart";

  ///
  static String getWishList = "get-wishlist";
  static String getParticularProduct = "get_particular_product";
  static String deleteCustomerAddress = "customer/address/delete";
  static String getCustomerAddress = "customer/address/get-all";
  static String addCustomerAddress = "customer/address/add";
  static String getCartInformation = "customer/cart/billing-info";
  static String updateCartQuantities = "update_cart_quantities";
  static String getCustomerPlaceOrderList = "customer/order/place_order";
  static String getParticularMyOrder = "customer/order/get";
  static String applyCouponCode = "customer/order/promocode-info";

  static String getItemcountUrl = "https://mdqualityapps.in/API/gross_shop/development/customer/cart/item-count";

  //offers
  static String getoffersSliderlist = "https://mdqualityapps.in/API/gross_shop/development/ad/carousel/get_all";
  static String clickoffersproductUrl = "https://mdqualityapps.in/API/gross_shop/development/ad/clicked/products";
  static String getrowaddsoffersUrl = "https://mdqualityapps.in/API/gross_shop/development/ad/row/get_all";

  
  //setting 

  static String getprofileUrl = "https://mdqualityapps.in/API/gross_shop/development/customer/get";
  static String getupdateprofileUrl = "https://mdqualityapps.in/API/gross_shop/development/customer/update";
  static String getquerysoptionUrl = "https://mdqualityapps.in/API/gross_shop/development/customer/queries/get-options";
  static String addquerysUrl = "https://mdqualityapps.in/API/gross_shop/development/customer/queries/add";
  static String addfeedbackUrl = "https://mdqualityapps.in/API/gross_shop/development/customer/feedback/add";
  static String getfeedbackUrl = "https://mdqualityapps.in/API/gross_shop/development/customer/feedback/get";

  //orderexpected

  static String orderexpectedUrl = "https://mdqualityapps.in/API/gross_shop/development/customer/cart/expected-delivery-time";

  //currencyrupee symbol

  static String  rupeessymbolUrl = "https://mdqualityapps.in/API/gross_shop/development/get_site_currency";
}
