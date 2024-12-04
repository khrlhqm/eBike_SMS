import 'package:ebikesms/modules/global_import.dart';

Widget IconCard({
  required Widget iconWidget,
  required String label,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: ColorConstant.lightBlue,
        borderRadius: BorderRadius.circular(16),
       
      ),
      child: Column(
        children: [
          iconWidget,
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              
            )
          ),
        ],
      ),
    ),
  );
}
