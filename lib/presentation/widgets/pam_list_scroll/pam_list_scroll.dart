// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

/// A widget that displays a scrollable list with optional pull-to-refresh feature.
class PAMListScroll<T> extends StatefulWidget {
  /// Callback function triggered when the user pulls down to refresh the list.
  final RefreshCallback onRefresh;

  /// A function that generates a widget for each item in the list.
  final IndexedWidgetBuilder itemBuilder;

  /// The total number of items in the list.
  final int itemCount;

  /// Whether to show a loading indicator at the end for more items.
  final RefreshCallback? scrollToRefresh;

  /// The padding to set in scroll view
  final EdgeInsetsGeometry? padding;

  /// Creates a new [PAMListScroll] widget.
  ///
  /// The [onRefresh], [itemBuilder], [itemCount], [padding], and [scrollToRefresh] parameters are required.
  const PAMListScroll({
    Key? key,
    required this.itemBuilder,
    required this.onRefresh,
    required this.itemCount,
    required this.scrollToRefresh,
    this.padding
  }) : super(key: key);

  @override
  State<PAMListScroll<T>> createState() => _PAMListScrollState<T>();
}

class _PAMListScrollState<T> extends State<PAMListScroll<T>> {
  /// A controller that is used to handle pagination
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (widget.scrollToRefresh == null) return;
      if (_controller.position.maxScrollExtent == _controller.offset) {
        widget.scrollToRefresh!();
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(() { });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _controller,
        padding: widget.padding,
        itemCount: widget.scrollToRefresh != null ? widget.itemCount + 1 : widget.itemCount,
        itemBuilder: (context, index) {
          if (widget.scrollToRefresh != null && index == widget.itemCount) {
            if (widget.itemCount < 25) {
              return Container();
            }

            return const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return widget.itemBuilder(context, index);
          }
        },
      ),
    );
  }
}