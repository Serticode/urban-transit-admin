import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:urban_transit_admin/screens/dashboard/map/widgets/user_address_widget.dart";
import "package:urban_transit_admin/services/controllers/map_controller.dart";
import "package:urban_transit_admin/shared/utils/app_extensions.dart";
import "package:urban_transit_admin/shared/utils/app_screen_utils.dart";

class DashboardMap extends ConsumerStatefulWidget {
  const DashboardMap({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardMapState();
}

class _DashboardMapState extends ConsumerState<DashboardMap>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final mapController = ref.watch(mapControllerProvider);

    return mapController.when(
      data: (controllerData) {
        return Scaffold(
          body: GoogleMap(
            mapType: MapType.normal,
            trafficEnabled: true,
            onMapCreated: (controller) async => await ref
                .read(mapControllerProvider.notifier)
                .init(controller: controller),
            initialCameraPosition: controllerData.cameraPosition!,
            myLocationEnabled: true,

            //!
            markers: {
              Marker(
                markerId: const MarkerId("userMarker"),
                position: controllerData.userLocation!,
                onTap: () {
                  AppScreenUtils.showAppDialogBox(
                      theBuildContext: context,
                      width: 600,
                      height: 200,
                      child: const UserAddressWidget());
                },
              ),

              //!
              if (controllerData.markers != null) ...controllerData.markers!
            },

            //!
            polylines: controllerData.polylines != null
                ? controllerData.polylines!
                : {},

            //!
            circles:
                controllerData.circles != null ? controllerData.circles! : {},
          ),

          //!
          floatingActionButton: FloatingActionButton(
            onPressed: () async =>
                await ref.read(mapControllerProvider.notifier).updateDrivers(),
            child: const Icon(Icons.refresh),
          ),
        );
      },

      //!
      error: (error, stackTrace) => "Error: $error \nS.T: $stackTrace".txt16(),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
