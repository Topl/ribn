// Package imports:

import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'middleware_test.dart' as middleware_test;
import 'reducer_test.dart' as reducer_test;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  middleware_test.main();
  reducer_test.main();
}
