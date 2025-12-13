class AppConstants {
  static const String appName = "DiLaundry";

  static const _host = "http://127.0.0.1:8000";

  /// Base URL for API endpoints ("http://127.0.0.1:8000/api/")
  static const String baseUrl = "$_host/api/";

  /// Base URL for accessing stored images ("http://127.0.0.1:8000/storage/")
  static const String baseImageUrl = "$_host/storage/";

  static const laundryStatusCategory = [
    'All',
    'Picked Up',
    'Queued',
    'Processing',
    'Washing',
    'Drying',
    'Ironing',
    'Done',
    'Delivered',
  ];
}
