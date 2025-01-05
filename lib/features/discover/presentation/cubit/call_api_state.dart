part of 'call_api_cubit.dart';

abstract class CallApiState extends Equatable {
  const CallApiState();

  @override
  List<Object> get props => [];
}

class InitialStateData extends CallApiState {}

class LoadingInitial extends CallApiState {}

class LoadedStateApi extends CallApiState {
  final ModelMovies modelMovies;
  const LoadedStateApi(
    this.modelMovies,
  );
}

class ErrorStateApi extends CallApiState {
  final String mess;

  const ErrorStateApi({
    required this.mess,
  });
}
