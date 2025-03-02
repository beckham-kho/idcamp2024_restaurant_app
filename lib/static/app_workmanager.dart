enum AppWorkmanager {
  periodic("com.example.restaurant_app", "com.example.restaurant_app"),
  oneOff("com.example.restaurant_app", "com.example.restaurant_app");

  final String uniqueName;
  final String taskName;

  const AppWorkmanager(this.uniqueName, this.taskName);
}