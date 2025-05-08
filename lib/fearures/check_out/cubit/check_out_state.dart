abstract class CheckOutState {}

class CheckOutInitial extends CheckOutState {}
class CheckOutLoading extends CheckOutState {}
class CheckOutSuccess extends CheckOutState {
  final dynamic response;
  CheckOutSuccess(this.response);
}
class CheckOutError extends CheckOutState {
  final String message;
  CheckOutError(this.message);
}
