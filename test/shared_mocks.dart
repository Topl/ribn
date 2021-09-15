import 'package:mockito/annotations.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/repositories/keychain_repository.dart';
import 'package:ribn/repositories/login_repository.dart';
import 'package:ribn/repositories/misc_repository.dart';
import 'package:ribn/repositories/onboarding_repository.dart';
import 'package:mubrambl/src/credentials/hd_wallet_helper.dart';

@GenerateMocks([
  OnboardingRespository,
  LoginRepository,
  MiscRepository,
  KeychainRepository,
  RibnAddress,
  HdWallet,
])
void main() {}
