formatFileName(String fileName, {charsToDisplay = 6}) {
  const numDots = 3;
  final String dotsString = List<String>.filled(numDots, '.').join();
  final String leftSubstring = fileName.substring(0, charsToDisplay);
  final String rightSubstring = fileName.substring(fileName.length - 3);
  return '$leftSubstring$dotsString$rightSubstring';
}
