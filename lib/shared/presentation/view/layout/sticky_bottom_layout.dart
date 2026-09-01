import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/shared/presentation/mixin/scroll_visibility.dart';

class StickyBottomLayout extends StatefulWidget {
  final Widget sticky;
  final Widget content;
  final List<Widget> slivers;
  final ScrollController? controller;

  const StickyBottomLayout({
    super.key,
    required this.content,
    required this.sticky,
    this.slivers = const [],
    this.controller,
  });

  @override
  State<StickyBottomLayout> createState() => _StickyBottomLayoutState();
}

class _StickyBottomLayoutState extends State<StickyBottomLayout>
    with ScrollVisibilityMixin {
  static final double _fixedAreaHeight = UISizes.h72;

  ScrollController get _effectiveController =>
      widget.controller ?? scrollController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: showFixedArea,
      builder: (_, show, _) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          SizedBox.expand(
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: EdgeInsets.only(bottom: show ? _fixedAreaHeight.h : 0),
              child: NotificationListener<ScrollNotification>(
                onNotification: onScrollNotification,
                child: CustomScrollView(
                  controller: _effectiveController,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  slivers: [
                    ...widget.slivers,
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: _fixedAreaHeight + UISizes.h16,
                        ),
                        child: widget.content,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: show ? _fixedAreaHeight.h : 0,
            child: widget.sticky,
          ),
        ],
      ),
    );
  }
}
