import 'package:flutter/material.dart';
import '../../../shared/constants/app_constants.dart';

class MenuTile extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color? labelColor;
  final Widget? iconWidget;
  final double? fontSize;
  final bool? enableForwardArrow;

  const MenuTile({
    super.key,
    required this.label,
    required this.onTap,
    this.labelColor,
    this.iconWidget,
    this.fontSize,
    this.enableForwardArrow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      alignment: Alignment.center,
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: iconWidget
        ),
        title: Text(
          label,
          style: TextStyle(
            color: labelColor ?? ColorConstant.black,
            fontSize: fontSize ?? 14
          ),
        ),
        trailing: (enableForwardArrow ?? false) ? const Icon(Icons.arrow_forward_ios) : null,
        onTap: onTap,
      ),
    );
  }
}


class ExpansionMenuTile extends StatefulWidget {
  final String label;
  final List<Widget> children;
  final Color? fontColor;
  final Widget? iconWidget;
  final bool? enableForwardArrow;

  const ExpansionMenuTile({
    super.key,
    required this.label,
    required this.children,
    this.fontColor,
    this.iconWidget,
    this.enableForwardArrow,
  });

  @override
  State<ExpansionMenuTile> createState() => _ExpansionMenuTileState();
}

class _ExpansionMenuTileState extends State<ExpansionMenuTile> {
  bool settingsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: widget.iconWidget,
        ),
        title: Text(
          widget.label,
          style: TextStyle(
              color: widget.fontColor ?? ColorConstant.black,
              fontSize: 14
          ),
        ),
        trailing: (widget.enableForwardArrow ?? true)
            ? Icon(
              settingsExpanded
              ? Icons.expand_more
              : Icons.arrow_forward_ios,
          color: ColorConstant.darkBlue,
          size: 20.0, // Set a consistent size for both icons
        )
            : null,
        onExpansionChanged: (bool expanded) {
          setState(() {
            settingsExpanded = expanded;
          });
        },
        children: widget.children,
      ),
    );
  }
}

