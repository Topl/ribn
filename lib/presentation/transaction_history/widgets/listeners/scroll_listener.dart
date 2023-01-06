// Flutter imports:
import 'package:flutter/cupertino.dart';

class ScrollListener extends StatefulWidget {
  final Widget Function(BuildContext, ScrollController) builder;
  final VoidCallback loadNext;
  final double threshold;
  const ScrollListener({
    Key? key,
    required this.threshold,
    required this.builder,
    required this.loadNext,
  }) : super(key: key);

  @override
  _ScrollListener createState() => _ScrollListener();
}

class _ScrollListener extends State<ScrollListener> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final rate = _controller.offset / _controller.position.maxScrollExtent;
      if (widget.threshold <= rate) {
        widget.loadNext();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _controller);
  }
}
