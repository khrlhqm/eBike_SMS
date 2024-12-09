import 'package:ebikesms/shared/widget/rectangle_button.dart';

import '../../global_import.dart';
import '../sub-screen/navigation/screen/nav_destination.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MarkerCard extends StatefulWidget {
  final MarkerCardState markerCardState;
  final bool navigationButtonEnable;
  final String bikeStatus;
  final String bikeId;
  final String currentTotalDistance;
  final String currentRideTime;
  final String locationNameMalay;
  final String locationNameEnglish;
  final String locationType;
  final String address;

  const MarkerCard({
    super.key,
    required this.markerCardState,
    required this.navigationButtonEnable,
    // For bike marker cards:
    this.bikeStatus = "",
    this.bikeId = "",
    this.currentTotalDistance = "",
    this.currentRideTime = "",
    // For location marker cards:
    this.locationNameMalay = "",
    this.locationNameEnglish = "",
    this.locationType = "",
    this.address = "",
  });

  @override
  State<MarkerCard> createState() => _MarkerCardState();
}

class _MarkerCardState extends State<MarkerCard> {
  late double cardWidth;
  late double cardHeight;

  @override
  Widget build(BuildContext context) {
    cardWidth = MediaQuery.of(context).size.width * 0.9;
    cardHeight = 245;
    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: const EdgeInsets.only(bottom: 50),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
        color: ColorConstant.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(color: ColorConstant.shadow, blurRadius: 4.0, offset: Offset(0, 2)),
        ],
      ),
      child: Builder(
        builder: (context) {
          switch (widget.markerCardState) {
            case MarkerCardState.loading:
              return _displayLoadingContent();
            case MarkerCardState.scanBike:
              return _displayScanBikeContent();
            case MarkerCardState.confirmBike:
              return _displayConfirmBikeContent();
            case MarkerCardState.ridingBike:
              return _displayRidingBikeContent();
            case MarkerCardState.warningBike:
              return _displayWarningBikeContent();
            case MarkerCardState.location:
              return _displayLocationContent();
            default:
              return const SizedBox.shrink();
          }
        }
      )
    );
  }

  Widget _displayLoadingContent (){
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoadingAnimation(dimension: 45),
        SizedBox(height: 30)
      ],
    );
  }

  Widget _displayScanBikeContent() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 20, 0),
              child: CustomIcon.bicycle(70, color: ColorConstant.black),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Bike ID ",
                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15, color: ColorConstant.black),
                      ),
                      Text(
                        widget.bikeId,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: ColorConstant.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CustomIcon.bikeStatus(14, widget.bikeStatus),
                      const SizedBox(width: 5),
                      AutoSizeText(
                        widget.bikeStatus,
                        maxFontSize: 12,
                        minFontSize: 11,
                        style: const TextStyle(color: ColorConstant.black),

                      ),
                      const Spacer(),
                      const AutoSizeText(
                        TextConstant.priceRateLabel,
                        maxFontSize: 12,
                        minFontSize: 11,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: RectangleButton(
                          height: 35,
                          label: "Ring",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          backgroundColor: ColorConstant.white,
                          foregroundColor: ColorConstant.darkBlue,
                          borderSide: const BorderSide(width: 2, color: ColorConstant.darkBlue),
                          onPressed: () {
                            // TODO: Ring the bike (make buzzer sound)
                          }
                        )
                      ),
                    ],
                  )
                ],
              )
            ),
          ],
        ),
        const Spacer(flex: 1),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Get near the bike",
              style: TextStyle(
                  fontSize: 12
              ),
            ),
            Text(
              "Scan to start",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorConstant.darkBlue,
              ),
            ),
          ],
        ),
        const Spacer(flex: 3),
      ],
    );
  }

  Widget _displayConfirmBikeContent() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 20, 0),
              child: CustomIcon.bicycle(70, color: ColorConstant.black),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Bike ID ",
                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15, color: ColorConstant.black),
                      ),
                      Text(
                        widget.bikeId,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: ColorConstant.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CustomIcon.bikeStatus(14, widget.bikeStatus),
                      const SizedBox(width: 3),
                      AutoSizeText(
                        widget.bikeStatus,
                        maxFontSize: 12,
                        minFontSize: 11,
                        style: const TextStyle(color: ColorConstant.black),
                      ),
                      const Spacer(),
                      const Text(
                        TextConstant.priceRateLabel,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                ],
              )
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RichText(
                textAlign: TextAlign.center,
                maxLines: 1,
                text: TextSpan(
                  style: const TextStyle(fontSize: 16, color: ColorConstant.black),
                  children: [
                    const TextSpan(text: "Start riding with "),
                    TextSpan(
                      text: widget.bikeId,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: "?"),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: RectangleButton(
                          height: 45,
                          label: "Cancel",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          backgroundColor: ColorConstant.white,
                          foregroundColor: ColorConstant.darkBlue,
                          borderSide: const BorderSide(width: 2, color: ColorConstant.darkBlue),
                          onPressed: () {
                            // TODO: Disconfirm the ride session, removing the scanned QR code
                          }
                      )
                  ),
                  const SizedBox(width: 15), // The gap between buttons
                  Expanded(
                    child: RectangleButton(
                        height: 45,
                        label: "Confirm",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        backgroundColor: ColorConstant.darkBlue,
                        foregroundColor: ColorConstant.white,
                        onPressed: () {
                          // TODO: Start ride session
                        }
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _displayRidingBikeContent() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 20, 0),
              child: CustomIcon.bicycle(70, color: ColorConstant.black),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Bike ID ",
                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: ColorConstant.black),
                      ),
                      Text(
                        widget.bikeId,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: ColorConstant.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CustomIcon.bikeStatus(14, widget.bikeStatus),
                      const SizedBox(width: 3),
                      AutoSizeText(
                        widget.bikeStatus,
                        maxFontSize: 12,
                        minFontSize: 11,
                        style: const TextStyle(color: ColorConstant.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  RectangleButton(
                    height: 35,
                    label: (widget.navigationButtonEnable) ? "End Navigation" : "Start Navigation",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    backgroundColor: (widget.navigationButtonEnable) ? ColorConstant.white : ColorConstant.darkBlue,
                    foregroundColor: (widget.navigationButtonEnable) ? ColorConstant.darkBlue : ColorConstant.white,
                    borderSide: (widget.navigationButtonEnable)
                        ? const BorderSide(width: 3, color: ColorConstant.darkBlue)
                        : BorderSide.none,
                    onPressed: () {
                      if(widget.navigationButtonEnable){
                        // TODO: End the navigation
                      }
                      else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=> const NavDestinationScreen())
                        );
                      }
                    }
                  ),
                ],
              )
            ),
          ],
        ),
        const Spacer(flex: 1),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  CustomIcon.distance(40, color: ColorConstant.black),
                  const SizedBox(height: 5),
                  Text(
                    widget.currentTotalDistance,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 2,
              height: 50,
              color: ColorConstant.shadow,
              margin: const EdgeInsets.symmetric(horizontal: 10),
            ),
            const AutoSizeText.rich(
              textAlign: TextAlign.center,
              maxFontSize: 13,
              minFontSize: 11,
              TextSpan(
                style: TextStyle(
                    color: ColorConstant.darkBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 13
                ),
                children: [
                  TextSpan(text: "Your current\n"),
                  TextSpan(
                    text: "   session",
                  ),
                ],
              ),
            ),
            Container(
              width: 2,
              height: 50,
              color: ColorConstant.shadow,
              margin: const EdgeInsets.symmetric(horizontal: 10),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  CustomIcon.clock(35, color: ColorConstant.black),
                  const SizedBox(height: 5),
                  Text(
                    widget.currentRideTime,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        const Spacer(flex: 5),
      ],
    );
  }

  Widget _displayWarningBikeContent() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 20, 0),
              child: CustomIcon.bicycle(70, color: ColorConstant.black),
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Bike ID ",
                          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: ColorConstant.black),
                        ),
                        Text(
                          widget.bikeId,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: ColorConstant.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomIcon.bikeStatus(14, widget.bikeStatus),
                        const SizedBox(width: 3),
                        AutoSizeText(
                          widget.bikeStatus,
                          maxFontSize: 12,
                          minFontSize: 11,
                          style: const TextStyle(color: ColorConstant.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    RectangleButton(
                        height: 35,
                        label: (widget.navigationButtonEnable) ? "End Navigation" : "Start Navigation",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        backgroundColor: (widget.navigationButtonEnable) ? ColorConstant.white : ColorConstant.darkBlue,
                        foregroundColor: (widget.navigationButtonEnable) ? ColorConstant.darkBlue : ColorConstant.white,
                        borderSide: (widget.navigationButtonEnable)
                            ? const BorderSide(width: 3, color: ColorConstant.darkBlue)
                            : BorderSide.none,
                        onPressed: () {
                          if(widget.navigationButtonEnable){
                            // TODO: End the navigation
                          }
                          else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context)=> const NavDestinationScreen())
                            );
                          }
                        }
                    ),
                  ],
                )
            ),
          ],
        ),
        const Spacer(flex: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  CustomIcon.distance(40, color: ColorConstant.black),
                  const SizedBox(height: 5),
                  Text(
                    widget.currentTotalDistance,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.red
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 2,
              height: 50,
              color: ColorConstant.shadow,
              margin: const EdgeInsets.symmetric(horizontal: 10),
            ),
            const AutoSizeText.rich(
              textAlign: TextAlign.center,
              maxFontSize: 13,
              minFontSize: 11,
              TextSpan(
                style: TextStyle(
                  color: ColorConstant.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 13
                ),
                children: [
                  TextSpan(text: "Please return\n"), // First line
                  TextSpan(
                    text: "  to safe zone", // Indented second line
                  ),
                ],
              ),
            ),
            Container(
              width: 2,
              height: 50,
              color: ColorConstant.shadow,
              margin: const EdgeInsets.symmetric(horizontal: 10),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  CustomIcon.clock(35, color: ColorConstant.black),
                  const SizedBox(height: 5),
                  Text(
                    widget.currentRideTime,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.red
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        const Spacer(flex: 6),
      ],
    );
  }

  final _scrollControllerMalay = ScrollController();
  final _scrollControllerEnglish = ScrollController();
  Widget _displayLocationContent() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 25, 0),
              child: CustomIcon.locationMarker(60, widget.locationType),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    child: SingleChildScrollView(
                      controller: _scrollControllerMalay,
                      scrollDirection: Axis.vertical,
                      child: AutoSizeText(
                        widget.locationNameMalay,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: ColorConstant.black),
                        minFontSize: 14,
                      ),
                    ),
                  ),
                  Scrollbar(
                    thickness: 1,
                    radius: const Radius.circular(50),
                    thumbVisibility: true,
                    trackVisibility: true,
                    controller: _scrollControllerEnglish,
                    child: SingleChildScrollView(
                      controller: _scrollControllerEnglish,
                      scrollDirection: Axis.horizontal,
                      child: AutoSizeText(
                        widget.locationNameEnglish,
                        style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: ColorConstant.black),
                      ),
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
        const Spacer(flex: 1),
        Container(
          padding: const EdgeInsets.fromLTRB(4, 13, 4, 5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 70,
                child: AutoSizeText(
                  widget.locationType,
                  minFontSize: 13,
                  maxFontSize: 14,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                width: 2,
                height: 70,
                padding: const EdgeInsets.only(right: 5),
                margin: const EdgeInsets.fromLTRB(10, 0, 15, 0),
                color: ColorConstant.shadow,
              ),
              Expanded(
                child: SizedBox(
                  height: 55,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      widget.address,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
        const Spacer(flex: 8),
      ],
    );
  }
}