extension StringExtension on String {
  String toCapitalCase() => toLowerCase().replaceAllMapped(
    RegExp(r'\b\w'),
    (final Match match) => match.group(0)!.toUpperCase(),
  );
}
