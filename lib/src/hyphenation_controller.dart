import 'package:flutter/material.dart';
import 'package:hyphenator_impure/hyphenator.dart';

class HyphenationController extends ChangeNotifier {
  HyphenationController({
    required this.loader,
    required this.hyphenator,
  });

  final ResourceLoader loader;
  final Hyphenator hyphenator;

  static HyphenationController of(BuildContext context) {
    final _HyphenationControllerScope? scope = context.dependOnInheritedWidgetOfExactType<_HyphenationControllerScope>();
    return scope?.controller ?? DefaultHyphenationController.of(context);
  }
}

class _HyphenationControllerScope extends InheritedWidget {
  const _HyphenationControllerScope({
    Key? key,
    required this.controller,
    required Widget child,
  }) : super(key: key, child: child);

  final HyphenationController controller;

  @override
  bool updateShouldNotify(_HyphenationControllerScope old) => controller != old.controller;
}

class DefaultHyphenationController extends StatefulWidget {
  const DefaultHyphenationController({
    Key? key,
    required this.child,
    this.language = DefaultResourceLoaderLanguage.enUs,
  }) : super(key: key);

  final Widget child;
  final DefaultResourceLoaderLanguage language;

  static HyphenationController of(BuildContext context) {
    final _DefaultHyphenationControllerScope? scope = context.dependOnInheritedWidgetOfExactType<_DefaultHyphenationControllerScope>();
    assert(scope != null, 'DefaultHyphenationController.of() called with a context that does not contain a DefaultHyphenationController.');
    return scope!.controller;
  }

  @override
  State<DefaultHyphenationController> createState() => _DefaultHyphenationControllerState();
}

class _DefaultHyphenationControllerState extends State<DefaultHyphenationController> {
  late HyphenationController _controller;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  Future<void> _initController() async {
    final loader = await DefaultResourceLoader.load(widget.language);
    final hyphenator = Hyphenator(
      resource: loader,
      hyphenateSymbol: '_',
    );
    _controller = HyphenationController(loader: loader, hyphenator: hyphenator);
    setState(() {
      isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isInitialized ?  _DefaultHyphenationControllerScope(
      controller: _controller,
      child: widget.child,
    ) : const SizedBox.shrink();
  }
}

class _DefaultHyphenationControllerScope extends InheritedWidget {
  const _DefaultHyphenationControllerScope({
    Key? key,
    required this.controller,
    required Widget child,
  }) : super(key: key, child: child);

  final HyphenationController controller;

  @override
  bool updateShouldNotify(_DefaultHyphenationControllerScope old) => controller != old.controller;
}