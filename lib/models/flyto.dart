class FlyToView {
  double longitude;
  double latitude;
  double range;
  double tilt;
  double heading;

  FlyToView({
    required this.longitude,
    required this.latitude,
    required this.range,
    required this.tilt,
    required this.heading,
  });

  String getCommand() {
    return 'echo "flytoview=<LookAt><longitude>${longitude}</longitude><latitude>${latitude}</latitude><range>${range}</range><tilt>${tilt}</tilt><heading>${heading}</heading><gx:altitudeMode>relativeToGround</gx:altitudeMode></LookAt>" > /tmp/query.txt';
  }
}

String generateQueryString(FlyToView flyToView) {
  return flyToView.getCommand();
}
