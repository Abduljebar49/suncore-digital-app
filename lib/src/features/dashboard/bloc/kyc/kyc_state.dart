// bloc/kyc/kyc_state.dart
import 'package:suncore_mobile/src/core/models/kyc_status.dart';

abstract class KycState {}

class KycInitial extends KycState {}

class KycLoading extends KycState {}

class KycLoaded extends KycState {
  final KycStatus status;

  KycLoaded(this.status);
}

class KycError extends KycState {
  final String message;

  KycError(this.message);
}