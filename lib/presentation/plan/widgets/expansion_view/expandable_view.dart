import 'package:flutter/material.dart';

class ExpandableView extends StatefulWidget {
  Widget header;
  List<Widget> children;
  ExpandableView({super.key, required this.header, required this.children});

  @override
  State<StatefulWidget> createState() {
    return _ExpandableViewState();
  }
}

class _ExpandableViewState extends State<ExpandableView> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      elevation: 0,
      expandedHeaderPadding: EdgeInsets.all(0),
      expansionCallback: (panelIndex, isExpanded) {
        _toggle();
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return GestureDetector(
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                horizontalTitleGap: 0,
                title: widget.header,
              ),
              onTap: () {
                _toggle();
              },
            );
          },
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.children,
          ),
          isExpanded: expanded,
        ),
      ],
    );
  }

  // Toggle the expand and collapse state of the view.
  void _toggle() {
    setState(() {
      expanded = !expanded;
    });
  }
}
