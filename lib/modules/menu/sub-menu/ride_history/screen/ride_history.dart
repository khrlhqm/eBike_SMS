import 'package:ebikesms/modules/global_import.dart';
import 'package:ebikesms/modules/menu/sub-menu/ride_history/widget/history_strip_item.dart';
import 'package:ebikesms/modules/menu/screen/menu.dart';

class RideHistoryScreen extends StatelessWidget {
  const RideHistoryScreen({super.key});
  final String totalTrips = '5 trips completed';
  final String totalRideTime = '2 hours 32 minutes';
  final String totalDistance = '2.3 km';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.darkBlue,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: CustomIcon.back(30),
        ),
        title: const Text(
          'Ride History',
          style: TextStyle(color: ColorConstant.white),
        ),
      ),
      body: Column(
        children: [
          // Summary section
          Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: ColorConstant.shadow,
                    blurRadius: 10,
                    offset: Offset(0, 5))
              ],
              color: ColorConstant.lightBlue,
            ),
            child: Column(
              children: [
                const Text(
                  'Your journey with us',
                  style: TextStyle(color: ColorConstant.grey, fontSize: 14),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 1, 0, 10),
                  child: Text(
                    totalTrips,
                    style: const TextStyle(
                        color: ColorConstant.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIcon.clock(16, color: ColorConstant.black),
                    const SizedBox(width: 6),
                    Text(
                      totalDistance,
                      style: const TextStyle(color: ColorConstant.black),
                    ),
                    const SizedBox(width: 20),
                    CustomIcon.distance(16, color: ColorConstant.black),
                    const SizedBox(width: 6),
                    Text(
                      totalRideTime,
                      style: const TextStyle(color: ColorConstant.black),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // History strip items
          Expanded(
            child: ListView.builder(
              itemCount: 10, // number of trips
              itemBuilder: (context, index) {
                return HistoryStripItem(
                  bikeId: '#8323',
                  distance: index == 0
                      ? '0 m'
                      : index == 1
                          ? '2.5 km'
                          : '605 m',
                  duration: index == 0
                      ? '1 min'
                      : index == 1
                          ? '1 hour 54 mins'
                          : '33 mins',
                  date: '30 Nov 2024',
                  time: '15:12',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
