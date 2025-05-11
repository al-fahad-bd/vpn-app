class IpInfo {
  late final String countryName;
  late final String regionName;
  late final String cityName;
  late final String zipCode;
  late final String timeZone;
  late final String internetServiceProvider;
  late final String query;

  IpInfo({
    required this.countryName,
    required this.regionName,
    required this.cityName,
    required this.zipCode,
    required this.timeZone,
    required this.internetServiceProvider,
    required this.query,
  });

  IpInfo.fromJson(Map<String, dynamic> jsonData) {
    countryName = jsonData["country"];
    regionName = jsonData["regionName"] ?? "";
    cityName = jsonData["city"] ?? "";
    zipCode = jsonData["zip"] ?? "";
    timeZone = jsonData["timeZone"] ?? "Unknown";
    internetServiceProvider = jsonData["isp"] ?? "Unknown";
    query = jsonData["qurey"] ?? "Not available";
  }
}
