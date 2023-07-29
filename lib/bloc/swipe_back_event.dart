part of 'swipe_back_bloc.dart';

class SwipeBackEvent {
  const SwipeBackEvent();
}

class RegisterDragStart extends SwipeBackEvent {
  const RegisterDragStart({required this.val});
  final double val;
}

class RegisterDragUpdate extends SwipeBackEvent {
  const RegisterDragUpdate({required this.val});
  final double val;
}

class ResetValues extends SwipeBackEvent {}
