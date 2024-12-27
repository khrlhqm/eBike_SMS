import 'package:ebikesms/modules/global_import.dart';

class PopupMessage extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final Color backgroundColor;

  const PopupMessage({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  State<PopupMessage> createState() => _PopupMessageState();
}

class _PopupMessageState extends State<PopupMessage> {
  bool _expanded = false; // Track whether popup is expanded

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _expanded = !_expanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: _expanded
            ? Row(
                children: [
                  Icon(widget.icon, color: widget.iconColor, size: 30),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.message,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the popup
                    },
                  ),
                ],
              )
            : Center(
                // Show only the icon initially
                child: Icon(widget.icon, color: widget.iconColor, size: 40),
              ),
      ),
    );
  }
}

// If you want to use it use this
void _showPopup(BuildContext context, bool isWarning) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent, // Transparent background
      elevation: 0,
      child: PopupMessage(
        icon: isWarning ? Icons.warning_amber_rounded : Icons.error_outline,
        iconColor: isWarning ? Colors.yellow : Colors.red,
        title: isWarning ? "You entering the border." : "BORDER CROSSED",
        message: isWarning
            ? "Do not cross the marked borders. Violations will be reported."
            : "Please return the bike to safe zone immediately.",
        backgroundColor: isWarning ? Colors.black87 : Colors.red,
      ),
    ),
  );
}
