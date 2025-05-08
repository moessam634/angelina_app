sealed class PayMobState {}

final class PayMobInitial extends PayMobState {}

final class PayMobLoading extends PayMobState {}

final class PayMobSuccess extends PayMobState {}

final class PayMobFailure extends PayMobState {
  final String errorMessage;

  PayMobFailure({required this.errorMessage});
}
