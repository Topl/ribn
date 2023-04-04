// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/providers/analytics/analytics_provider.dart';
// Project imports:
import 'package:ribn/providers/utility_provider.dart';
import 'package:ribn/utils/extensions.dart';
import 'package:ribn/utils/platform_utils.dart';

enum AnalyticsEvents {
  AbandonTransactionEvent("Abandon"), // Abandon Cart
  SessionDurationEvent("Session Duration"),
  TransactionEvent("Transaction"),

  // dApp Events
  BounceEvent("Bounce"),
  DAppAuthenticatedEvent("DApp Authenticated"),
  UserInteractionEvents("User Interaction Event");

  const AnalyticsEvents(this.name);

  final String name;
}

enum UserType { Initial, New, Returning }

/**
 * This class is used to build the parameters for the [AnalyticsEvents]
 * This needs to be in the same file as [AnalyticsEventBuilders] due to the private constructor,
 * This is to ensure that the [AnalyticsEventBuilders] is the only way to create an instance of this class
 */
class AnalyticsEventData {
  final AnalyticsEvents event;
  final Map<String, dynamic> _value;

  // Private constructor
  AnalyticsEventData._(this.event, this._value);

  //to map
  Map<String, dynamic> toMap() => _value;
}

class AnalyticsEventBuilders {
  Ref _ref;
  AnalyticsEvents _event;

  AnalyticsEventBuilders(this._ref, this._event);

  AnalyticsEventData buildDAppAuthenticatedEvent(
          {String dAppName = 'Unknown',
          String dAppUrl = 'Unknown',
          bool authenticatedState = false}) =>
      AnalyticsEventData._(
          _event,
          _optionsBuilder(walletAddress: true, userType: true, parameters: {
            "dAppName": dAppName,
            "dAppUrl": dAppUrl,
            "authenticated": authenticatedState,
          }));

  AnalyticsEventData buildTransactionEvent({
    String dAppName = 'Unknown',
    String dAppUrl = 'Unknown',
    int? authTime,
    String transactionType = 'Unknown',
    String assetType = 'Unknown',
    double transferAmount = 0,
    String destinationAddress = 'Unknown',
    bool transactionSent = false,
    double fee = 0,
    double gasPrice = 0,
  }) =>
      AnalyticsEventData._(
          _event,
          _optionsBuilder(walletAddress: true, userType: true, parameters: {
            "dAppName": dAppName,
            "dAppUrl": dAppUrl,
            "authTime": authTime ?? DateTime.now().millisecondsSinceEpoch,
            "transactionType": transactionType,
            "assetType": assetType,
            "transferAmount": transferAmount,
            "destinationAddress": destinationAddress,
            "transactionSent": transactionSent,
            "fee": fee,
            "gasPrice": gasPrice,
          }));

  AnalyticsEventData buildSessionDurationEvent({
    required int startTime,
    required int endTime,
    String sessionType = "Active",
    int contractInteractions = 0,
    double totalAmountTransferred =
        0, //TODO: consider refactoring to a Map that will hold multiple currencies
  }) =>
      AnalyticsEventData._(
          _event,
          _optionsBuilder(
              walletAddress: true,
              userType: true,
              screens: true,
              parameters: {
                "startTime": startTime,
                "endTime": endTime,
                "duration": endTime - startTime,
                "sessionType": sessionType,
                "totalAmountTransferred": totalAmountTransferred,
                "contractInteractions": contractInteractions,
              }));

  AnalyticsEventData buildBounceRateEvent({
    String sessionType = "Active",
    int contractInteractions = 0,
    double totalAmountTransferred =
        0, //TODO: consider refactoring to a Map that will hold multiple currencies
  }) =>
      AnalyticsEventData._(
          _event,
          _optionsBuilder(
              walletAddress: true,
              userType: true,
              screens: true,
              parameters: {
                "sessionType": sessionType,
                "totalAmountTransferred": totalAmountTransferred,
                "contractInteractions": contractInteractions,
              }));

  AnalyticsEventData buildAbandonTransactionEvent(
          {int contractInteractions = 0,
          assetType = 'Unknown',
          double transferAmount = 0,
          bool transactionSent = false}) =>
      AnalyticsEventData._(
          _event,
          _optionsBuilder(walletAddress: true, userType: true, parameters: {
            "transactionSent": transactionSent,
            "contractInteractions": contractInteractions,
            "assetType": assetType,
            "transferAmount": transferAmount,
          }));

  AnalyticsEventData buildUserInteractionEvent(
      {required int startTime,
      required int endTime,
      int contractInteractions = 0}) {
    return AnalyticsEventData._(
        _event,
        _optionsBuilder(
            walletAddress: true,
            userType: true,
            userInteractions: true,
            parameters: {
              "startTime": startTime,
              "endTime": endTime,
              "duration": endTime - startTime,
              "contractInteractions": contractInteractions,
            }));
  }

  Map<String, dynamic> _optionsBuilder(
          {bool defaultMetrics = true,
          bool eventName = true,
          bool walletAddress = false,
          bool userType = false,
          bool network = false,
          bool screens = false,
          bool userInteractions = false,
          Map<String, dynamic> parameters = const {}}) =>
      parameters
          .addIf(eventName, _addEventName())
          .addIf(defaultMetrics, _addDefaultMetrics())
          .addIf(walletAddress, _addWalletAddress())
          .addIf(userType, _addUserType())
          .addIf(network, _addNetwork());

  static Map<String, dynamic> _addDefaultMetrics(
          {Map<String, dynamic> parameters = const {}}) =>
      {
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'platform': getOperatingSystem(),
        ...parameters,
      };

  Map<String, dynamic> _addWalletAddress(
          {Map<String, dynamic> parameters = const {}}) =>
      {
        'walletAddress': _ref.read(currentWalletAddressProvider).toHashSha256(),
        ...parameters,
      };

  Map<String, dynamic> _addUserType(
          {Map<String, dynamic> parameters = const {}}) =>
      {
        'userType': _ref.read(analyticsProvider).userType.name,
        ...parameters,
      };

  Map<String, dynamic> _addEventName(
          {Map<String, dynamic> parameters = const {}}) =>
      {
        'event': _event.name.toString(),
        ...parameters,
      };

  Map<String, dynamic> _addNetwork(
          {Map<String, dynamic> parameters = const {}}) =>
      {
        'network': _ref.read(currentNetworkProvider),
        ...parameters,
      };
}
