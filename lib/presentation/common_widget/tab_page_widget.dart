import 'package:flutter/material.dart';

import '../../common/utils.dart';

class TabBox extends StatelessWidget {
  final Widget? child;
  const TabBox({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [0.04, 0.04],
          colors: [Colors.black12, Colors.white],
        ),
      ),
      child: child,
    );
  }
}

class TabPageWidget extends StatefulWidget {
  final Tab Function(BuildContext context, int index) tabBuilder;
  final Widget Function(BuildContext context, int index) pageBuilder;
  final int length;
  final void Function(
    TabController tabController,
    PageController pageController,
  )? onViewCreated;
  final ScrollPhysics? physics;
  final bool isTabScrollable;
  final Color? pageBackground;
  final bool allowImplicitScrolling;
  final PageController? pageController;
  final void Function(int)? onPageChanged;

  const TabPageWidget({
    Key? key,
    required this.tabBuilder,
    required this.pageBuilder,
    required this.length,
    this.onViewCreated,
    this.isTabScrollable = false,
    this.allowImplicitScrolling = false,
    this.physics,
    this.pageBackground,
    this.pageController,
    this.onPageChanged,
  }) : super(key: key);

  @override
  State<TabPageWidget> createState() => _TabPageWidgetState();
}

class _TabPageWidgetState extends State<TabPageWidget> {
  PageController? _pageController;
  TabController? tabController;

  @override
  void initState() {
    _setupPageController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TabPageWidget oldWidget) {
    _setupPageController();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    _setupPageController();
    super.didChangeDependencies();
  }

  void _setupPageController() {
    if (widget.pageController != _pageController ||
        widget.pageController == null) {
      _pageController?.dispose();
    }
    _pageController = widget.pageController ?? PageController();
  }

  void onDefaultTabCreated(BuildContext context) {
    if (tabController == null) {
      DefaultTabController.of(context).let((that) {
        tabController = that;
        widget.onViewCreated?.call(
          tabController!,
          _pageController!,
        );
      });
    }
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.length,
      child: Builder(builder: (defaultTabContext) {
        onDefaultTabCreated(defaultTabContext);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TabBox(
              child: TabBar(
                onTap: (index) => _pageController!.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                ),
                isScrollable: widget.isTabScrollable,
                tabs: [
                  ...List.generate(
                    widget.length,
                    (index) => widget.tabBuilder(context, index),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: widget.pageBackground,
                child: PageView.builder(
                  controller: _pageController,
                  physics: widget.physics ?? const ClampingScrollPhysics(),
                  allowImplicitScrolling: widget.allowImplicitScrolling,
                  onPageChanged: (value) {
                    tabController?.animateTo(value);
                    widget.onPageChanged?.call(value);
                  },
                  itemBuilder: widget.pageBuilder,
                  itemCount: widget.length,
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
