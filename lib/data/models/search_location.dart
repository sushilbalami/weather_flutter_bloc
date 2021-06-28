class SearchLocation {
  String city;
  String country;
  SearchLocation({
    required this.city,
    required this.country,
  });
  SearchLocation.fromJson(Map json)
      : city = json['name'],
        country = json['country'];
}
