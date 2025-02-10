enum NavigationRoute {
  mainRoute("/"),
  homeRoute("/home"),
  detailRoute("/detail"),
  ratingRoute("/rating");

  const NavigationRoute(this.path);
  final String path;
}
