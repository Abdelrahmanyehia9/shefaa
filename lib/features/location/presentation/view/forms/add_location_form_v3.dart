import 'package:flutter/material.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/extensions/sizes.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/models/latlang.dart';
import 'package:shefaa/features/location/data/models/user_location.dart';
import 'package:shefaa/features/location/domain/entity/user_location_entity.dart';
import 'package:shefaa/features/location/presentation/view/forms/location_form.dart';
import 'package:shefaa/features/location/presentation/view/mixin/geo_coding_mixin.dart';
import 'package:shefaa/features/location/presentation/view/widget/static_map_view.dart';

class AddLocationFormV3 extends StatefulWidget {
  final LatLong coordinates;
  final void Function(UserLocation loc) onSubmit;
  final UserLocationEntity? initial ;
  final VoidCallback? onSuccess ;

  const AddLocationFormV3({
    super.key,
    required this.coordinates,
    required this.onSubmit,
    this.onSuccess,
    this.initial
  });

  @override
  State<AddLocationFormV3> createState() => _AddLocationFormV3State();
}

class _AddLocationFormV3State extends State<AddLocationFormV3>
    with GeoCodingMixin {
  final TextEditingController _governorateController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  final TextEditingController _addressNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _initLocation() async {
    if (widget.initial != null) {
      _governorateController.text = widget.initial!.government;
      _areaController.text = widget.initial!.area;
      _streetController.text = widget.initial!.street;
      _addressNameController.text = widget.initial!.name??"";
      _buildingController.text = widget.initial!.build;
      _apartmentController.text = widget.initial!.flatNo;
      _floorController.text = widget.initial!.floor;
      return;
    }

    await getLocationFromCoordinates();

    if (!mounted || placemark == null) return;

    _governorateController.text = placemark!.administrativeArea ?? '';
    _areaController.text = placemark!.subAdministrativeArea ?? '';
    _streetController.text = placemark!.locality ?? '';
  }

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: UISizes.h24,
        children: [
          StaticMapView(
            lat: widget.coordinates.lat,
            lon: widget.coordinates.long,
            width: context.width,
            height: context.height * .25,
          ),
          LocationForm(
            formKey: _formKey,
            governorateController: _governorateController,
            areaController: _areaController,
            streetController: _streetController,
            buildingController: _buildingController,
            floorController: _floorController,
            apartmentController: _apartmentController,
            addressNameController: _addressNameController,
          ),
          AppButton.filled("تاكيد", onTap: onLocationSubmit,),
        ],
      ),
    );
  }

  Future<void> onLocationSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final location = UserLocation(
        id: widget.initial?.id,
        name: _addressNameController.text.trim(),
        coordinates: coordinates,
        government: _governorateController.text.trim(),
        area: _areaController.text.trim(),
        street: _streetController.text.trim(),
        build: _buildingController.text.trim(),
        flatNo: _apartmentController.text.trim(),
        floor: _floorController.text.trim(),
      );
      widget.onSubmit.call(location);
    }
  }

  @override
  // TODO: implement coordinates
  LatLong get coordinates => widget.coordinates;

  @override
  void dispose() {
    _governorateController.dispose();
    _areaController.dispose();
    _streetController.dispose();
    _buildingController.dispose();
    _floorController.dispose();
    _apartmentController.dispose();
    _addressNameController.dispose();

    super.dispose();
  }
}
