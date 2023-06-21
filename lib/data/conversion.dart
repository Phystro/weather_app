class Conversion {
  static double ftoc(double f) {
    return (f - 32) * (5 / 9);
  }

  static double ktoc(double k) {
    return (k - 273.15);
  }
}