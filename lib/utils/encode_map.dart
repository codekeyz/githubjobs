String encodeMap(Map data) {
  return data.keys.map((key) => "${Uri.encodeComponent(key)}=${Uri.encodeComponent(data[key].toString())}").join("&");
}
