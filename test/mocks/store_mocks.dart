import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:ribn/models/app_state.dart';
import 'package:mockito/mockito.dart' as _i1;

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
    print('QQQQ dispatch $action');
    return '';
  }
}
