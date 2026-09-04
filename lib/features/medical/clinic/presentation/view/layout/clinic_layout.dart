part of "../clinic_screen.dart";

class _ClinicLayout extends StatefulWidget {
  final Widget Function(bool isColabsed, double height) header;
  final Widget body;
  const _ClinicLayout({required this.header, required this.body});

  @override
  State<_ClinicLayout> createState() => _ClinicLayoutState();
}

class _ClinicLayoutState extends State<_ClinicLayout>
    with ScrollTitleVisibilityMixin {
  @override
  double get titleThreshold => UISizes.h220;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        ValueListenableBuilder(
          valueListenable: showTitle,
          builder: (context, value, child) =>
              widget.header.call(value, titleThreshold),
        ),
        SliverToBoxAdapter(child: widget.body),
      ],
    );
  }
}
