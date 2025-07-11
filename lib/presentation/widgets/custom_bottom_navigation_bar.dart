import 'dart:ui';

import 'package:eventrecs/presentation/widgets/animated_scale_wrapper.dart';
import 'package:eventrecs/presentation/widgets/glossy_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glossy/glossy.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar(
      {super.key,
      this.selectedIndex = 0,
      required this.items,
      required this.onTap});

  final int selectedIndex;
  final List<CustomBottomNavigationBarItem> items;
  final void Function(int, {bool notify}) onTap;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  List<_CustomBottomNavigationBarItem> _items = [];

  @override
  void initState() {
    super.initState();
    processItems();
  }

  void processItems() {
    _items = List.empty(growable: true);
    for (int i = 0; i < widget.items.length; i++) {
      _items.add(_CustomBottomNavigationBarItem(
          selectedIcon: widget.items[i].selectedIcon,
          label: widget.items[i].label,
          defaultIcon: widget.items[i].defaultIcon,
          position: i));
    }
  }

  @override
  void didUpdateWidget(covariant CustomBottomNavigationBar oldWidget) {
    processItems();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, 1),
      child: SizedBox(
        height: kBottomNavigationBarHeight + kToolbarHeight,
          width: double.infinity,
        child: GlossyCard(
          strokeAlign: BorderSide.strokeAlignInside,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ..._items.map((item) {
                return Expanded(
                  child: AnimatedScaleWrapper(
                    onTap: () => widget.onTap(item.position),
                    child: Container(
                      padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight/2),
                      color: Colors.transparent,
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 4,
                        children: [
                          Icon(
                            item.position == widget.selectedIndex
                                ? item.selectedIcon
                                : item.defaultIcon,
                            size: 32,
                            color: item.position == widget.selectedIndex
                                ? Colors.white
                                : Colors.white60,
                          ),
                          // Text(item.label)
                        ],
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomBottomNavigationBarItem {
  final IconData selectedIcon;
  final IconData defaultIcon;
  final String label;
  final int position;

  _CustomBottomNavigationBarItem(
      {required this.selectedIcon,
      required this.label,
      required this.defaultIcon,
      required this.position});
}

class CustomBottomNavigationBarItem {
  final IconData selectedIcon;
  final IconData defaultIcon;
  final String label;

  CustomBottomNavigationBarItem(
      {required this.selectedIcon,
      required this.label,
      required this.defaultIcon});
}
