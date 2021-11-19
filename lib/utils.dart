/// Formats an address string to only dispaly its first and last 10 characters.
String formatAddrString(String addr) {
  const numDots = 3;
  const charsToDisplay = 10;
  final String dotsString = List<String>.filled(numDots, '.').join();
  final String leftSubstring = addr.substring(0, charsToDisplay);
  final String rightSubstring = addr.substring(addr.length - charsToDisplay);
  return '$leftSubstring$dotsString$rightSubstring';
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
