class CommonFunctions {
  static String formatAmount(double amount) {
    if (amount >= 10000000) {
      double croreAmount = amount / 10000000;
      return "\u{20B9} ${croreAmount.toStringAsFixed(1)} Crs";
    } else if (amount >= 100000) {
      double lakhAmount = amount / 100000;
      return "\u{20B9} ${lakhAmount.toStringAsFixed(1)} Lk";
    } else if (amount >= 1000) {
      double thousandAmount = amount / 1000;
      return "\u{20B9} ${thousandAmount.toStringAsFixed(1)} K";
    } else {
      return "\u{20B9} ${amount.toString()}";
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
