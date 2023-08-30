import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_portal/flutter_portal.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Portal(
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: ListTile.divideTiles(
                  context: context,
                  tiles: List.generate(
                    20,
                    (index) => PortalTarget(
                      anchor: const Aligned(
                        target: Alignment.topLeft,
                        follower: Alignment.centerLeft,
                        alignToPortal: AxisFlag(x: true),
                      ),
                      portalFollower: _PositionWidget(
                        key: UniqueKey(),
                        child: Container(
                          height: 100,
                          width: 100,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          color: Colors.green,
                          child: const Text('child'),
                        ),
                      ),
                      child: Container(
                        height: 100,
                        width: 200,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        color: Colors.red,
                        child: const Text('child'),
                      ),
                    ),
                  ),
                ).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PositionWidget extends SingleChildRenderObjectWidget {
  const _PositionWidget({super.child, super.key});

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RednerPositionWidget();
}

class _RednerPositionWidget extends RenderProxyBox {
  bool _firstPaint = true;
  @override
  void paint(PaintingContext context, Offset offset) {
    print(localToGlobal(Offset(size.width, size.height)));
    super.paint(context, offset);

    if (!_firstPaint) return;

    _firstPaint = false;
    scheduleMicrotask(() {
      markNeedsPaint();
      print(
        localToGlobal(Offset(size.width, size.height)),
      );
    });
  }
}
