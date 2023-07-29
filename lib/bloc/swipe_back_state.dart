part of 'swipe_back_bloc.dart';

class SwipeBackState {
  const SwipeBackState({
    required this.start,
    required this.position,
    required this.executeCallBack,
  });

  final double start;
  final double position;
  final bool executeCallBack;
}
