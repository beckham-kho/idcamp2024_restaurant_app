enum NavigationRoute {
  mainRoute("/"),
  detailRoute("/detail"),
  ratingRoute("/rating");

  const NavigationRoute(this.path);
  final String path;
}