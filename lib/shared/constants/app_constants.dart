import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class TextConstant {
  static const String appName = "eBike Student Mobility Solutions";
  static const String greet = "Welcome to Unibike";
  static const String description =
      "located any bike nearby and scan the qr code.Enjoy your ride!";
  static const String description2 =
      "This is a tutorial on how to use the e-bike. Enjoy learning!";
  static const String priceRateLabel = "RM1/15 minutes";
  static const String minTopUpLabel = "RM10";
  static const String appVersion = "ver 1.0.0";
}

class PricingConstant {
  static const int minTopUpAmt = 10;
  static const double priceRate = 1 / 15;
  static const int rideTimeLimit = 1800; // 30 Hours (1800 minutes)
}

class ColorConstant {
  static const Color darkBlue = Color(0xFF003399); // #003399
  static const Color shadowdarkBlue = Color.fromARGB(255, 0, 37, 112); // #003399
  static const Color lightBlue = Color(0xFFDBE6FF); // #DBE6FF
    static const Color lightBlue2 = Color.fromARGB(255, 207, 220, 252); // #DBE6FF

   static const Color shadowlightBlue = Color.fromARGB(255, 194, 204, 228); // #DBE6FF
  static const Color hintBlue = Color(0xFFF2F6FF); // #F2F6FF
  static const Color grey = Color(0xFF4F4F4F); // #4F4F4F
  static const Color lightGrey = Color(0xFFD9D9D9); // #4F4F4F
  static const Color black = Color(0xFF1E1E1E); // #1E1E1E
  static const Color white = Color(0xFFFFFFFF); // #FFFFFF
  static const Color whitesmoke = Color(0xFF636363); // #636363
  static const Color red = Color(0xFFFF0400); // #FF0400
  static const Color yellow = Color(0xFFEED202); // #eed202
  static const Color shadow = Color(0x41000000); // #eed202
}

enum MarkerCardContent {
  loading,
  scanBike,
  confirmBike,
  ridingBike,
  warningBike,
  landmark
}

class MapConstant{
  // Map camera zoom
  static const double focusZoomLevel = 16.5;
  static const double initZoomLevel = 16;

  // This is UTeM's center
  static const LatLng initCenterPoint = LatLng(2.31125, 102.32025);
  // This is UTeM's center
  static const List<LatLng> theWholeWorld = [
    LatLng(-90, -180), // Bottom-left of the world
    LatLng(-90, 180),  // Bottom-right
    LatLng(90, 180),   // Top-right
    LatLng(90, -180),  // Top-left
    LatLng(-90, -180), // Close the loop
  ];
  // These are polylines, wrapped around UTeM
  static const List<LatLng> geoFencePoints = [
    LatLng(2.3042661008596967, 102.31728475417593),
    LatLng(2.305601193676538, 102.3179337529114),
    LatLng(2.3050137529913943, 102.31849876357523),
    LatLng(2.305250255114574, 102.3194608087596),
    LatLng(2.3054419568590085, 102.32035635007237),
    LatLng(2.3071889909341987, 102.32206954310655),
    LatLng(2.3064207180766556, 102.32286092140144),
    LatLng(2.307476531545828, 102.32392658423134),
    LatLng(2.308262775120037, 102.32428180517265),
    LatLng(2.308909740939457, 102.32453360735818),
    LatLng(2.3096375771331714, 102.32303178718138),
    LatLng(2.3102521562817073, 102.32310019419747),
    LatLng(2.3105299347901105, 102.32284114455175),
    LatLng(2.310689657419824, 102.32301193697978),
    LatLng(2.3109410128579033, 102.32312580098112),
    LatLng(2.311202951633783, 102.32316022498178),
    LatLng(2.3114701820540287, 102.32314168898029),
    LatLng(2.3117612250270554, 102.32307548897941),
    LatLng(2.31194378831364, 102.32295632897876),
    LatLng(2.3122136644445197, 102.32319994498246),
    LatLng(2.3123618317060863, 102.32318670498495),
    LatLng(2.3124729571435436, 102.32346474499039),
    LatLng(2.3127983958766354, 102.32360508899141),
    LatLng(2.3137270864637864, 102.32331910498704),
    LatLng(2.313756190721517, 102.32374808099433),
    LatLng(2.314274775510883, 102.32395462500183),
    LatLng(2.314682234852003, 102.32391225700079),
    LatLng(2.314938881255845, 102.32363951299932),
    LatLng(2.315214048491261, 102.32369776899885),
    LatLng(2.315005027237408, 102.32399434500043),
    LatLng(2.315251571507213, 102.324108622993),
    LatLng(2.3147695397168593, 102.32537122104321),
    LatLng(2.3147431785988424, 102.32580465022036),
    LatLng(2.3144704165587093, 102.32595722731331),
    LatLng(2.314339366869683, 102.32570930301034),
    LatLng(2.3115708764943794, 102.32622682730815),
    LatLng(2.3117269813555685, 102.32718805132968),
    LatLng(2.3143343067605513, 102.32659651588213),
    LatLng(2.3151556968174565, 102.32606379098846),
    LatLng(2.3164953166910904, 102.32557217644023),
    LatLng(2.3169334329349587, 102.32654270137986),
    LatLng(2.3168404869793524, 102.32661711897897),
    LatLng(2.3168386280562188, 102.32661339810066),
    LatLng(2.3166267112543526, 102.32663200250046),
    LatLng(2.3163274251906856, 102.32661525854064),
    LatLng(2.3163199895097537, 102.32739478289812),
    LatLng(2.317000354013716, 102.32739106201817),
    LatLng(2.317026166307723, 102.3268863682639),
    LatLng(2.317158149545564, 102.32679334626502),
    LatLng(2.3174537176007046, 102.32706869138686),
    LatLng(2.3176712110407673, 102.32719520130888),
    LatLng(2.317959343314229, 102.32730496726758),
    LatLng(2.320832265139565, 102.32712456639786),
    LatLng(2.3204962970058807, 102.32774802789879),
    LatLng(2.320476807038825, 102.328661922145),
    LatLng(2.319780436629629, 102.32849545517003),
    LatLng(2.3198669285138442, 102.32908585803978),
    LatLng(2.320988238378079, 102.3290441748879),
    LatLng(2.3210591306354034, 102.32955899538997),
    LatLng(2.3221430065926754, 102.3295149768787),
    LatLng(2.3218293373985217, 102.3264287053726),
    LatLng(2.32136400800942, 102.32639442817576),
    LatLng(2.321354659137942, 102.32673438283459),
    LatLng(2.3192533662480406, 102.32679458915253),
    LatLng(2.319561777376675, 102.3257191465255),
    LatLng(2.319651735606526, 102.32482941850137),
    LatLng(2.3193659859156974, 102.32456461848935),
    LatLng(2.319612048153675, 102.32396352247689),
    LatLng(2.3199560060474935, 102.32351071446804),
    LatLng(2.319820180571854, 102.31798997453616),
    LatLng(2.317106470021216, 102.31828281590163),
    LatLng(2.31701413814179, 102.31510715212815),
    LatLng(2.3127713938169157, 102.31427979203413),
    LatLng(2.312979480602913, 102.31485679127985),
    LatLng(2.313470242842731, 102.31552349335821),
    LatLng(2.313559194916933, 102.31612008410079),
    LatLng(2.3132211014472492, 102.3169422549037),
    LatLng(2.3120146640728674, 102.31709267264746),
    LatLng(2.3112588512911176, 102.31670792666597),
    LatLng(2.310489890755351, 102.3164302348094),
    LatLng(2.310127550891627, 102.31571866652115),
    LatLng(2.311776169016351, 102.31481316118803),
    LatLng(2.311675844599505, 102.3126783025902),
    LatLng(2.3094230964870035, 102.3135053511001),
    LatLng(2.307881460999966, 102.31346457762072),
    LatLng(2.30786558588769, 102.3142986976347),
    LatLng(2.308238651003592, 102.31434106564063),
    LatLng(2.308234779233376, 102.31558210690072),
    LatLng(2.3091079099685916, 102.31554768290363),
    LatLng(2.308922700466072, 102.31604815491269),
    LatLng(2.3090047218199916, 102.31659629093025),
    LatLng(2.3091767020670226, 102.31683725893474),
    LatLng(2.309372494932711, 102.31692729093521),
    LatLng(2.309687350976899, 102.31804474696476),
    LatLng(2.3092587234119093, 102.31830954696619),
    LatLng(2.3085291378910973, 102.31801313440646),
    LatLng(2.307955896860584, 102.31786349817625),
    LatLng(2.3075134712549725, 102.31768489593469),
    LatLng(2.307083591007212, 102.3172307126342),
    LatLng(2.3065575131608784, 102.31755815007196),
    LatLng(2.30611395189397, 102.3167054328831),
    LatLng(2.3049040406342947, 102.3160116602744),
    LatLng(2.3042583414438567, 102.31731402272145),
  ];
}