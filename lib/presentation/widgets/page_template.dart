import 'package:flutter/material.dart';
import 'package:storia/presentation/widgets/loading_view.dart';

class PageTemplate extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final bool extendBodyBehindAppBar;
  final Widget child;
  final bool loading;
  final Widget? bottomSheet;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  const PageTemplate(
      {super.key,
      this.appBar,
      this.backgroundColor,
      this.extendBodyBehindAppBar = false,
      required this.child,
      this.loading = false,
      this.bottomSheet,
      this.bottomNavigationBar,
      this.floatingActionButton});

  @override
  State<StatefulWidget> createState() => _PageTemplateState();
}

class _PageTemplateState extends State<PageTemplate> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Scaffold(
            appBar: widget.appBar,
            backgroundColor: widget.backgroundColor,
            extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
            body: Stack(
              fit: StackFit.expand,
              children: [
                widget.child,
                Align(
                    alignment: Alignment.bottomCenter,
                    child: widget.bottomSheet ?? const SizedBox()),
              ],
            ),
            bottomNavigationBar: widget.bottomNavigationBar,
            floatingActionButton: widget.floatingActionButton,
          ),
          if (widget.loading) const LoadingView(),
        ],
      ),
    );
  }
}
