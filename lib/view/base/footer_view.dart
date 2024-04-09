import 'package:flutter/material.dart';

class FooterView extends StatefulWidget {
  final Widget child;
  final double minHeight;
  final bool visibility;
  const FooterView(
      {Key? key,
      required this.child,
      this.minHeight = 0.65,
      this.visibility = true})
      : super(key: key);

  @override
  State<FooterView> createState() => _FooterViewState();
}

class _FooterViewState extends State<FooterView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: (widget.visibility
                ? MediaQuery.of(context).size.height * widget.minHeight
                : MediaQuery.of(context).size.height * 0.7),
          ),
        ),
      ],
    );
  }
}
