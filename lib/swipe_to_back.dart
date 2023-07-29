library swipe_to_back;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipe_to_back/bloc/swipe_back_bloc.dart';

class VerticalSwipeBackPage extends StatefulWidget {
  const VerticalSwipeBackPage({
    super.key,
    required this.showInfoIcon,
    this.infoIconCallback,
    this.backgroundColor,
    this.fixedWidget,
    this.bottomActions,
    required this.child,
  });

  ///A [bool] flag to set whether the info button on the top right should be rendered or not
  final bool showInfoIcon;

  ///A callback to be executed when the info button is clicked
  final FutureOr<void> Function()? infoIconCallback;

  ///Background [Color] applied to the page scaffold
  final Color? backgroundColor;

  ///Fixed Widget that does not move as page is dragged vertically
  final Widget? fixedWidget;

  ///A list of bottom action [Widget] (s)
  final List<Widget>? bottomActions;

  ///The main [Widget] child of the page that needs to be dragged
  final Widget child;

  @override
  State<VerticalSwipeBackPage> createState() => _VerticalSwipeBackPageState();
}

class _VerticalSwipeBackPageState extends State<VerticalSwipeBackPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SwipeBackBloc(),
      child: Builder(builder: (context) {
        return BlocConsumer<SwipeBackBloc, SwipeBackState>(
          listener: (context, state) {
            if (state.executeCallBack) {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: widget.backgroundColor ?? Colors.black,
              body: Stack(
                children: [
                  Column(
                    children: [
                      Transform.translate(
                        offset: Offset(
                          0,
                          state.position > 0 ? -state.position : state.position,
                        ),
                        child: SizedBox(
                          height: 110,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                                if (widget.showInfoIcon)
                                  IconButton(
                                    onPressed: () {
                                      widget.infoIconCallback!();
                                    },
                                    icon: const Icon(
                                      Icons.info_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Transform.translate(
                          offset: Offset(0, state.position),
                          child: GestureDetector(
                            onVerticalDragStart: (details) =>
                                context.read<SwipeBackBloc>().add(
                                      RegisterDragStart(
                                          val: details.globalPosition.dy),
                                    ),
                            onVerticalDragUpdate: (details) =>
                                context.read<SwipeBackBloc>().add(
                                      RegisterDragUpdate(val: details.delta.dy),
                                    ),
                            onVerticalDragEnd: (details) =>
                                context.read<SwipeBackBloc>().add(
                                      ResetValues(),
                                    ),
                            child: widget.child,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(
                          0,
                          state.position < 0 ? -state.position : state.position,
                        ),
                        child: SizedBox(
                          height: 110,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: widget.bottomActions
                                      ?.asMap()
                                      .values
                                      .toList() ??
                                  [],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  if (widget.fixedWidget != null)
                    Positioned(
                      top: 100,
                      left: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(16),
                        color: Colors.black54,
                        child: widget.fixedWidget,
                      ),
                    )
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
