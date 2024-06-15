bool isPriceWithinTolerance(double? targetPrice, double? currentPrice) {
  if (targetPrice == null ||
      targetPrice == 0 ||
      currentPrice == null ||
      currentPrice == 0) {
    return false;
  }

  final absoluteDifference = currentPrice - targetPrice;
  final percentageDifference = (absoluteDifference / targetPrice) * 100;

  return percentageDifference.abs() <= 5;
}
