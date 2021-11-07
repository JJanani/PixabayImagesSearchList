import 'package:flutter/material.dart';
import 'package:pixabay_project/common_classes/base_viewmodel.dart';
import 'package:pixabay_project/common_classes/utils.dart';
import 'package:provider/provider.dart';

import 'locator.dart';

class BaseWidget<T extends BaseViewModel> extends StatefulWidget {
  final Function(BuildContext context, T model, Widget child) builder;
  final Function(T) onModelReady;

  BaseWidget({
    this.builder,
    this.onModelReady,
  });

  @override
  State<StatefulWidget> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends BaseViewModel> extends State<BaseWidget<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (isNotNull(widget.onModelReady)) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
        create: (context) => model,
        child: Consumer<T>(builder: widget.builder));
  }
}
