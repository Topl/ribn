// Package imports:
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:ribn/v1/models/app_state.dart';

MockStore getStoreMocks({
  bool isNewUser = false,
}) {
  final _mockStore = MockStore(isNewUser);
  return _mockStore;
}

class MockStore extends Mock implements Store<AppState> {
  final bool isNewUser;
  MockStore(this.isNewUser) {
    _i1.throwOnMissingStub(this);
  }

  @override
  AppState get state => AppState.test(isNewUser: isNewUser);

  @override
  Stream<AppState> get onChange => Stream.value(AppState.test());

  @override
  dispatch(action) {
    return '';
  }
}
