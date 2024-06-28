import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    required this.onChange,
    required this.children,
    super.key,
  });

  final Function(int) onChange;
  final List<NavigationOption> children;

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int initial = 0;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: SizedBox(
        height: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: widget.children.asMap().entries.map((e) {
            return InkWell(
              onTap: () {
                widget.onChange(e.key);
                setState(() => initial = e.key);
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      e.value.icon,
                      color: initial == e.key
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                    Text(
                      e.value.title,
                      style: TextStyle(
                        // fontSize: 13.sp,
                        color: initial == e.key
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class NavigationOption {
  final IconData icon;
  final String title;

  const NavigationOption({
    required this.icon,
    required this.title,
  });
}
