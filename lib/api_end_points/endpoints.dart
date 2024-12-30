class ApiEndPoints {
  ApiEndPoints._();

  static String fetchListings(int skip) {
    return 'products?limit=10&skip=$skip&select=title,price,thumbnail';
  }
}
