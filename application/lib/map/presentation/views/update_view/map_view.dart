import 'package:application/map/presentation/cubits/update_form/update_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatefulWidget {
  const MapView({
    super.key,
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final double stepZoom = 1;

  final double initZoom = 18;

  final double minZoomLevel = 2;

  final double maxZoomLevel = 18;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      // padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: BlocBuilder<UpdateFormCubit, UpdateFormState>(
          builder: (context, state) {
            if (state.status == UpdateFormStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            return FlutterMap(
              options: MapOptions(
                center: LatLng(state.latitude, state.longitude),
                zoom: initZoom,
                onTap: (tapPosition, point) {
                  context
                      .read<UpdateFormCubit>()
                      .handleCoordsChange(point.latitude, point.longitude);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.application',
                ),
                CircleLayer(
                  circles: [
                    CircleMarker(
                      point: LatLng(state.latitude, state.longitude),
                      radius: state.radius,
                      useRadiusInMeter: true,
                      color: Colors.red.withAlpha(50)
                    ),

                  ],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(state.latitude, state.longitude),
                      builder: (context) => const Icon(
                        Icons.location_on,
                        size: 30,
                        color: Colors.red,
                      ),
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
