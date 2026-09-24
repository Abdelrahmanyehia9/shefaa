import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shefaa/core/components/app_chip.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/shared/presentation/view/widgets/circle_icon_button.dart';

class MapControls extends StatefulWidget {
  const MapControls({
    super.key,
    this.enabled = true,
    this.showZoom = true,
    this.showMyLocation = true,
    this.onZoomIn,
    this.onZoomOut,
    this.onMyLocation,
  });

  final bool enabled;
  final bool showZoom;
  final bool showMyLocation;
  final VoidCallback? onZoomIn;
  final VoidCallback? onZoomOut;
  final VoidCallback? onMyLocation;

  @override
  State<MapControls> createState() => _MapControlsState();
}

class _MapControlsState extends State<MapControls> {
  bool _open = false;

  void _toggle() => setState(() => _open = !_open);

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled || (!widget.showZoom && !widget.showMyLocation)) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: UISizes.h8,
      children: [
        _menu(),
        _btn(_open ? Icons.close : Icons.menu, _toggle),
      ],
    );
  }

  Widget _menu() {
    final buttons = <Widget>[
      if (widget.showZoom) ...[
        _btn(Icons.add, widget.onZoomIn),
        _btn(Icons.remove, widget.onZoomOut),
      ],
      if (widget.showMyLocation)
        _btn(Icons.my_location, () {
          widget.onMyLocation?.call();
          _toggle();
        }),
    ];

    return IgnorePointer(
      ignoring: !_open,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: UISizes.h8,
        children: [
          for (int i = 0; i < buttons.length; i++)
            buttons[i]
                .animate(target: _open ? 1 : 0)
                .fade(duration: 180.ms, delay: (i * 50).ms)
                .scale(
              begin: const Offset(0.7, 0.7),
              end: const Offset(1, 1),
              duration: 220.ms,
              delay: (i * 50).ms,
              curve: Curves.easeOutBack,
            )
                .slideY(
              begin: 0.3,
              end: 0,
              duration: 220.ms,
              delay: (i * 50).ms,
              curve: Curves.easeOut,
            ),
        ],
      ),
    );
  }

  Widget _btn(IconData icon, VoidCallback? onTap) {
    return AppChip(
      onTap: onTap,
      radius: UISizes.r14,
      paddingHr: UISizes.sp8,paddingVr: UISizes.sp8,
      child:  Icon(icon, size: UISizes.sp32,color: Colors.white,),
    );
  }
}