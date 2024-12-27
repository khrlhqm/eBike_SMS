import 'package:ebikesms/modules/global_import.dart';
import 'package:ebikesms/modules/auth/screen/login.dart';

import '../../../shared/utils/calculation.dart';
import '../../../shared/utils/shared_state.dart';

Future<void> EndRideModal(BuildContext context, MapController mapController) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // User must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        alignment: Alignment.center,
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Center(
                    child: Text(
                      'Are you sure of ending the ride session?',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.center,
                  )))
            ],
          ),
        ),
        actions: <Widget>[
          Container(
            decoration: const BoxDecoration(
                border:
                    Border(top: BorderSide(color: ColorConstant.lightGrey))),
            child: ListTile(
              title: const Center(
                  child: Text(
                "End ride",
                style: TextStyle(color: ColorConstant.red),
              )),
              onTap: () async {
                // Set marker card to loading
                Navigator.pop(context);
                SharedState.markerCardContent.value = MarkerCardContent.loading;

                // Prepare posting of data
                SharedState.rideEndDatetime.value = await Calculation.getCurrentDateTime();
                SharedState.currentRideTime.value;
                // TODO: Post ride (start and end datetime) and bike (new current latlong) data to the database

                // Until data is posted, reset map UI
                // TODO: Animate the map, to re-align to initial center
                SharedState.isRiding.value = false;
                SharedState.markerCardVisibility.value = false;
                SharedState.visibleMarkers.value.clear();
                SharedState.visibleMarkers.value.addAll(SharedState.cachedMarkers.value);
                SharedState.timer.value?.cancel();
                SharedState.currentRideTime.value = "< 1 minute";
                SharedState.currentTotalDistance.value = "< 1 meter";
              },
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                border:
                    Border(top: BorderSide(color: ColorConstant.lightGrey))),
            child: ListTile(
              title: const Center(child: Text("Resume")),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    },
  );
}
