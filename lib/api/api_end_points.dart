import 'package:travel_hour/pages/change_password.dart';

class ApiEndPoints {
  // static const products = "products";
  // static const popularMovies = "movie/popular";
  // static const upcomingMovies = "movie/upcoming";
  // static const getGenreList = "genre/movie/list";
  static const login = "/auths/login-firebase";
  static const customer = "/customers/";
  static const loginFacebook = "/auths/login-facebook";
  static const getQuestByCustomerID = "/customer-quests/get-by-customer-id?id=";
  static const checkUserLocationQuestItem =
      "/customer-tasks/check-location-with-quest-item/";
  static const checkUserLocationQuest =
      "/customer-tasks/check-location-with-quest/";
  static const getSuggestion = "/customer-tasks/show-suggestion/";
  static const decreasePointSuggestion =
      "/customer-tasks/decrease-point-suggestion/";
  static const moveNextTask = "/customer-tasks/move-next-task/";
  static const addCustomerTask = "/customer-tasks/";
  static const checkAnswer = "/customer-tasks/check-answer/";
  static const getQuestItemByQuestId = "/quest-items/get-by-quest-id/";
  static const buyQuest = "/payments/";
  static const getQuestById = "/quests/";
  static const getCustomerQuestByCustomerId =
      "/customer-quests/get-by-customer-id?id=";
  static const customerStartQuest = "/customer-tasks/";
  static const checkPaymentStatus = "/payments/";
  static const checkImage = "/weather-forecast/demo2?api-version=1";
  static const getRewardByCustomerId =
      "/rewards/get-by-customer-id?customerId=";
  static const loginUsenamePassword = "/auths/login";
  static const register = "/auths/register-account";
  static const forgotPassword = "/auths/forgot-password";
  static const ChangePassword = "/customers/update-password";
  static const checkCoupon = "/payments/check-coupon";
  static const skipCustomerTask = "/customer-tasks/skip/";
}
