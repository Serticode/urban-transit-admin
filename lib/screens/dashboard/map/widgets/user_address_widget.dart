import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:urban_transit_admin/services/controllers/map_controller.dart';
import 'package:urban_transit_admin/shared/constants/env_constants.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';

class UserAddressWidget extends ConsumerWidget {
  const UserAddressWidget({super.key});

  static final TextEditingController _addressController =
      TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerData = ref.watch(mapControllerProvider).value;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: 550.0.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "Enter the address".txt24().alignCenterLeft(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                )
              ],
            ),
          ),
        ),

        //!
        21.0.sizedBoxHeight,

        //!
        GooglePlaceAutoCompleteTextField(
          textEditingController: _addressController,
          googleAPIKey: dotenv.get(ENVConstants.mapsApiKey),
          inputDecoration: const InputDecoration(
            hintText: "Search your location",
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
          debounceTime: 400,
          countries: const ["ng"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (Prediction prediction) async {
            "Place LAT: ${prediction.lat}".log();
            "Place LNG: ${prediction.lng}".log();

            LatLng destinationLatLng = LatLng(
              double.parse(prediction.lat!),
              double.parse(prediction.lng!),
            );

            await ref.read(mapControllerProvider.notifier).updatePolylines(
                  origin: controllerData!.userLocation!,
                  destination: destinationLatLng,
                );
          },
          itemClick: (Prediction prediction) async {
            _addressController.text = prediction.description ?? "";
            _addressController.selection = TextSelection.fromPosition(
              TextPosition(
                offset: prediction.description?.length ?? 0,
              ),
            );

            Navigator.of(context).pop();
          },
          seperatedBuilder: const Divider(),
          containerHorizontalPadding: 10,
          itemBuilder: (context, index, Prediction prediction) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(Icons.location_on),
                  const SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: Text(prediction.description ?? ""),
                  )
                ],
              ),
            );
          },
          isCrossBtnShown: true,
        ),
      ],
    );
  }
}
