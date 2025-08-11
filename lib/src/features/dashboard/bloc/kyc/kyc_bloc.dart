// bloc/kyc/kyc_bloc.dart
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:suncore_mobile/src/core/models/kyc_status.dart';
import 'package:suncore_mobile/src/core/repositories/dashboard_repository.dart';
import 'package:suncore_mobile/src/features/dashboard/bloc/kyc/kyc_event.dart';
import 'package:suncore_mobile/src/features/dashboard/bloc/kyc/kyc_state.dart';

class KycBloc extends Bloc<KycEvent, KycState> {
  final DashboardRepository dashboardRepository;

  KycBloc({required this.dashboardRepository}) : super(KycInitial()) {
    on<LoadKycStatus>((event, emit) async {
      emit(KycLoading());
      try {
        debugPrint('this is messaging. before... ');
        final data = await dashboardRepository.checkKycStatus();
        debugPrint('this is message, ${data.toString()}');
        final status = KycStatus.fromJson(data);
        emit(KycLoaded(status));
      } catch (e) {
        emit(KycError(e.toString()));
      }
    });
  }
}
