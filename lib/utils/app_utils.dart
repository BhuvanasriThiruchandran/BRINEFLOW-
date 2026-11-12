class AppUtils {
  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  static String formatPercent(double value) {
    return '${value.toStringAsFixed(1)}%';
  }
}
