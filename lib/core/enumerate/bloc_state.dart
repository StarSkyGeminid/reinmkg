enum BlocState {
  initial,
  loading,
  success,
  failure,
  ;

  bool get isInitial => this == BlocState.initial;
  bool get isLoading => this == BlocState.loading;
  bool get isSuccess => this == BlocState.success;
  bool get isFailure => this == BlocState.failure;
}
