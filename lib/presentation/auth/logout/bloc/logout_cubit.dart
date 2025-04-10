import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_lisa_it/data/repositories/auth/auth_repository.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final AuthRepository authRepository;

  LogoutCubit({required this.authRepository}) : super(LogoutState());

  Future<void> logout() async {
    try {
      emit(LogoutState(status: LogoutStatus.loading));
      await authRepository.logout();
      emit(LogoutState(status: LogoutStatus.success));
    } catch (e) {
      emit(
        LogoutState(
          status: LogoutStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
