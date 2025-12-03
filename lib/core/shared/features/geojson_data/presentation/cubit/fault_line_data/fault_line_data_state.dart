part of 'fault_line_data_cubit.dart';

abstract class FaultLineDataState {
  const FaultLineDataState();
}

class FaultLineDataInitial extends FaultLineDataState {
  const FaultLineDataInitial();
}

class FaultLineDataLoading extends FaultLineDataState {
  const FaultLineDataLoading();
}

class FaultLineDataLoaded extends FaultLineDataState {
  final String faultLine;
  const FaultLineDataLoaded(this.faultLine);
}

class FaultLineDataFailure extends FaultLineDataState {
  final String message;
  const FaultLineDataFailure(this.message);
}
