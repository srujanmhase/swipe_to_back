import 'package:flutter_bloc/flutter_bloc.dart';

part 'swipe_back_event.dart';
part 'swipe_back_state.dart';

class SwipeBackBloc extends Bloc<SwipeBackEvent, SwipeBackState> {
  SwipeBackBloc()
      : super(
          const SwipeBackState(start: 0, position: 0, executeCallBack: false),
        ) {
    on<RegisterDragStart>((event, emit) {
      return emit(
        SwipeBackState(start: event.val, position: 0, executeCallBack: false),
      );
    });

    on<RegisterDragUpdate>((event, emit) {
      final val = state.position + event.val > 0
          ? state.position + event.val
          : -(state.position + event.val);
      switch (val) {
        case (<= 50):
          return emit(
            SwipeBackState(
                start: state.start,
                position: state.position + event.val,
                executeCallBack: false),
          );
        case (> 50 && <= 100):
          return emit(
            SwipeBackState(
              start: state.start,
              position: state.position + (event.val / 2),
              executeCallBack: false,
            ),
          );
        case (> 100 && <= 200):
          return emit(
            SwipeBackState(
              start: state.start,
              position: state.position + (event.val / 10),
              executeCallBack: false,
            ),
          );
        default:
          return;
      }
    });

    on<ResetValues>((event, emit) {
      return emit(
        SwipeBackState(
          start: 0,
          position: 0,
          executeCallBack: (state.position > 100) || (state.position < -100),
        ),
      );
    });
  }
}
