import 'package:flutter/material.dart';
import 'package:notes_app/core/constant/size_constant.dart';

class ContainerButton extends StatelessWidget {
  final IconData icon;
  final GestureTapCallback? onTap;
  const ContainerButton({Key? key, required this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          minWidth: Theme.of(context).buttonTheme.minWidth,
          minHeight: Theme.of(context).buttonTheme.height,
        ),
        decoration: BoxDecoration(
          borderRadius: SizeConstant.instance.radius,
          color: Theme.of(context).buttonColor,
        ),
        padding: Theme.of(context).buttonTheme.padding,
        child: Icon(
          icon,
        ),
      ),
    );
  }
}
