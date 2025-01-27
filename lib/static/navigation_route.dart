enum NavigationRoute {
  mainRoute("/"),
  detailRoute("/detail");

  const NavigationRoute(this.path);
  final String path;
}