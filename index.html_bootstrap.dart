library app_bootstrap;

import 'package:polymer/polymer.dart';

import 'package:scalable_element/scalable_element.dart' as i0;
import 'index.html.0.dart' as i1;
import 'package:smoke/smoke.dart' show Declaration, PROPERTY, METHOD;
import 'package:smoke/static.dart' show useGeneratedCode, StaticConfiguration;
import 'package:scalable_element/scalable_element.dart' as smoke_0;
import 'package:polymer/polymer.dart' as smoke_1;
import 'package:observe/src/metadata.dart' as smoke_2;
abstract class _M0 {} // PolymerElement & ChangeNotifier

void main() {
  useGeneratedCode(new StaticConfiguration(
      checkedMode: false,
      getters: {
        #canTranslate: (o) => o.canTranslate,
        #maxHeight: (o) => o.maxHeight,
        #maxWidth: (o) => o.maxWidth,
        #minHeight: (o) => o.minHeight,
        #minWidth: (o) => o.minWidth,
        #preserveAspectRatio: (o) => o.preserveAspectRatio,
        #selected: (o) => o.selected,
        #toggleSelect: (o) => o.toggleSelect,
      },
      setters: {
        #canTranslate: (o, v) { o.canTranslate = v; },
        #maxHeight: (o, v) { o.maxHeight = v; },
        #maxWidth: (o, v) { o.maxWidth = v; },
        #minHeight: (o, v) { o.minHeight = v; },
        #minWidth: (o, v) { o.minWidth = v; },
        #preserveAspectRatio: (o, v) { o.preserveAspectRatio = v; },
        #selected: (o, v) { o.selected = v; },
      },
      parents: {
        smoke_0.ScalableElement: _M0,
        _M0: smoke_1.PolymerElement,
      },
      declarations: {
        smoke_0.ScalableElement: {
          #canTranslate: const Declaration(#canTranslate, bool, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #maxHeight: const Declaration(#maxHeight, int, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #maxWidth: const Declaration(#maxWidth, int, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #minHeight: const Declaration(#minHeight, int, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #minWidth: const Declaration(#minWidth, int, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #preserveAspectRatio: const Declaration(#preserveAspectRatio, bool, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #selected: const Declaration(#selected, bool, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
        },
      },
      names: {
        #canTranslate: r'canTranslate',
        #maxHeight: r'maxHeight',
        #maxWidth: r'maxWidth',
        #minHeight: r'minHeight',
        #minWidth: r'minWidth',
        #preserveAspectRatio: r'preserveAspectRatio',
        #selected: r'selected',
        #toggleSelect: r'toggleSelect',
      }));
  configureForDeployment([
      () => Polymer.register('scalable-element', i0.ScalableElement),
    ]);
  i1.main();
}
