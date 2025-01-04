enum AppRoutes {
  root,
  login,
  home,
  register,
  verify,
  producthomescreen,
  editProfile,
  getcurrentLocation,
  getcurrentLocationMap,
  ParticularHomeScreenProduct
}

extension AppRouteExtension on AppRoutes {
  static const appRoutes = {
    AppRoutes.root: "/",
    AppRoutes.login: "/login",
    AppRoutes.home: "/home",
    AppRoutes.register: "/register",
    AppRoutes.verify: "/verify",
    AppRoutes.producthomescreen: "/productomescreen",
    AppRoutes.editProfile: "/EditProfileScreen",
    AppRoutes.getcurrentLocationMap: "/MapLocation",
    AppRoutes.ParticularHomeScreenProduct: "/particularHomeScreenProduct",
  };

  String get toName => appRoutes[this]!;
}

enum ApiRoutes {
  login,
}

extension ApiRouteExtension on ApiRoutes {
  static const apiRoutes = {
    ApiRoutes.login: "",
  };

  String get toName => apiRoutes[this]!;
}
