import 'package:mockito/annotations.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/repositories/keychain_repository.dart';
import 'package:ribn/repositories/login_repository.dart';
import 'package:ribn/repositories/misc_repository.dart';
import 'package:ribn/repositories/onboarding_repository.dart';
import 'package:ribn/repositories/transaction_repository.dart';

@GenerateMocks([
  OnboardingRespository,
  LoginRepository,
  MiscRepository,
  KeychainRepository,
  TransactionRepository,
  RibnAddress,
])
void main() {}
