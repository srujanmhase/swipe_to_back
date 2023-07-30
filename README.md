# Swipe to go back

A simple to use flutter package that helps you to implement swipe up or down to go back like twitter.

## Demo

[![Video](https://img.youtube.com/vi/p29qyEA3b7U/maxresdefault.jpg)](https://www.youtube.com/watch?v=p29qyEA3b7U)

## Getting Started

Just navigate to the vertical swipe page provided by the package like in the example below:

```
onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => const VerticalSwipeBackPage(
                ...[params]
        ),
    ),
),
```

The parameters are:

```
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
```