// import 'package:hooks_riverpod/hooks_riverpod.dart';

// extension AsyncValueExtensions on AsyncValue {
//   /// Performs an action based on the state of the [AsyncValue].
//   ///
//   /// All cases are required, which allows returning a non-nullable value.
//   ///
//   /// {@template asyncvalue.skip_flags}
//   /// By default, [when] skips "loading" states if triggered by a [Ref.refresh]
//   /// or [Ref.invalidate] (but does not skip loading states if triggered by [Ref.watch]).
//   ///
//   /// In the event that an [AsyncValue] is in multiple states at once (such as
//   /// when reloading a provider or emitting an error after a valid data),
//   /// [when] offers various flags to customize whether it should call
//   /// [loading]/[error]/[data] :
//   ///
//   /// - [skipLoadingOnReload] (false by default) customizes whether [loading]
//   ///   should be invoked if a provider rebuilds because of [Ref.watch].
//   ///   In that situation, [when] will try to invoke either [error]/[data]
//   ///   with the previous state.
//   ///
//   /// - [skipLoadingOnRefresh] (true by default) controls whether [loading]
//   ///   should be invoked if a provider rebuilds because of [Ref.refresh]
//   ///   or [Ref.invalidate].
//   ///   In that situation, [when] will try to invoke either [error]/[data]
//   ///   with the previous state.
//   ///
//   /// - [skipError] (false by default) decides whether to invoke [data] instead
//   ///   of [error] if a previous [value] is available.
//   /// {@endtemplate}
//   R when<R>({
//     bool skipLoadingOnReload = false,
//     bool skipLoadingOnRefresh = true,
//     bool skipError = false,
//     required R Function(dynamic data) data,
//     R Function(Object error, StackTrace stackTrace) error = const (Object error, StackTrace stackTrace) {},
//     R Function() loading,
//   }) {
//     if (isLoading) {
//       bool skip;
//       if (isRefreshing) {
//         skip = skipLoadingOnRefresh;
//       } else if (isReloading) {
//         skip = skipLoadingOnReload;
//       } else {
//         skip = false;
//       }
//       if (!skip) return loading();
//     }

//     if (hasError && (!hasValue || !skipError)) {
//       return error(this.error!, stackTrace!);
//     }

//     return data(requireValue);
//   }
// }
