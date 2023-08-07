const double tabletBreak = 1024;
const double mobileBreak = 550;
const double barrierOpacity = 0.64;

double calculateRatio({
  required double screenWidth,
  required double width1,
  required double ratio1,
  required double width2,
  required double ratio2,
}) {
  // Calculate the slope and y-intercept
  double slope = (ratio2 - ratio1) / (width2 - width1);
  double yIntercept = ratio1 - (slope * width1);

  // Calculate the ratio for the given screenWidth
  double ratio = (slope * screenWidth) + yIntercept;

  return ratio;
}
