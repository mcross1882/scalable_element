/**
 * <scalable-element> Web Component
 *
 * @author  Matthew Cross <blacklightgfx@gmail.com>
 * @license Apache V2
 * @package scalable_element
 */
import 'dart:html';
import 'package:polymer/polymer.dart';

@CustomTag('scalable-element')
class ScalableElement extends PolymerElement with ChangeNotifier  {

  @reflectable @published int get minWidth => __$minWidth; int __$minWidth; @reflectable set minWidth(int value) { __$minWidth = notifyPropertyChange(#minWidth, __$minWidth, value); } @reflectable @published int get maxWidth => __$maxWidth; int __$maxWidth; @reflectable set maxWidth(int value) { __$maxWidth = notifyPropertyChange(#maxWidth, __$maxWidth, value); }
  @reflectable @published int get minHeight => __$minHeight; int __$minHeight; @reflectable set minHeight(int value) { __$minHeight = notifyPropertyChange(#minHeight, __$minHeight, value); } @reflectable @published int get maxHeight => __$maxHeight; int __$maxHeight; @reflectable set maxHeight(int value) { __$maxHeight = notifyPropertyChange(#maxHeight, __$maxHeight, value); }
  @reflectable @published bool get preserveAspectRatio => __$preserveAspectRatio; bool __$preserveAspectRatio = false; @reflectable set preserveAspectRatio(bool value) { __$preserveAspectRatio = notifyPropertyChange(#preserveAspectRatio, __$preserveAspectRatio, value); }
  @reflectable @published bool get canTranslate => __$canTranslate; bool __$canTranslate = false; @reflectable set canTranslate(bool value) { __$canTranslate = notifyPropertyChange(#canTranslate, __$canTranslate, value); }
  @reflectable @published bool get selected => __$selected; bool __$selected = false; @reflectable set selected(bool value) { __$selected = notifyPropertyChange(#selected, __$selected, value); }

  bool _lockX = false, _lockY = false;

  ScalableElement.created() : super.created() {
    //noop
  }

  @override
  void attached() {
    super.attached();

    var controls = this.shadowRoot.querySelectorAll('#tab-controls .control');

    controls.forEach((Element control) {
      control
        ..onDragStart.listen(startDragEvent)
        ..onDrag.listen(resizeDragEvent)
        ..onDragEnd.listen(finishDragEvent)
        ..onClick.listen((Event event) {
          event.stopPropagation();
        });
    });

    forceBoundrySize();
  }

  void toggleSelect(event, detail, target) {
    if (this.attributes.containsKey('selected')) {
      this.attributes.remove('selected');
    } else {
      this.attributes.putIfAbsent('selected', () => 'true');
    }
  }

  void startDragEvent(MouseEvent event) {
    var sender = event.toElement;

    _lockY = false;
    if (sender.classes.contains('middle')) {
      _lockY = true;
    }

    _lockX = false;
    if (sender.classes.contains('center')) {
      _lockX = true;
    }
  }

  void resizeDragEvent(MouseEvent event) {
    scaleView(event);
    forceBoundrySize();
  }

  void finishDragEvent(MouseEvent event) {
    scaleView(event);
    forceBoundrySize();
  }

  void scaleView(MouseEvent event) {
    if (!_lockY) {
      resizeHeight(event);
    }

    if (!_lockX) {
      resizeWidth(event);
    }
  }

  void resizeHeight(MouseEvent event) {
    var element = event.toElement;
    if (element.classes.contains('top')) {
      shiftTop(event);
    } else if (element.classes.contains('right')) {
      shiftBottom(event);
    }
  }

  void resizeWidth(MouseEvent event) {
    var element = event.toElement;
    if (element.classes.contains('left')) {
      shiftLeft(event);
    } else if (element.classes.contains('right')) {
      shiftRight(event);
    }
  }

  void shiftTop(MouseEvent event) {
    if (event.offset.y <= 0) {
      return;
    }

    this.style.marginTop = "${event.offset.y}px";
    this.style.height = "${this.borderEdge.height - (event.offset.y/2)}px";
  }

  void shiftBottom(MouseEvent event) {
    this.style.height = "${event.client.y - this.borderEdge.top}px";
  }

  void shiftLeft(MouseEvent event) {
    if (event.offset.x <= 0) {
      return;
    }

    this.style.marginLeft = "${event.offset.x}px";
    this.style.width = "${this.borderEdge.width - (event.offset.x/2)}px";
  }

  void shiftRight(MouseEvent event) {
    this.style.width = "${event.client.x - this.borderEdge.left}px";
  }

  void forceBoundrySize() {
    this.style.height = validateRange(this.borderEdge.height, minHeight, maxHeight);
    this.style.width = validateRange(this.borderEdge.width, minWidth, maxWidth);
  }

  String validateRange(int value, int min, int max) {
    if (null != max && value > max) {
      return "${max}px";
    }

    if (null != min && value < min) {
      return "${min}px";
    }

    return "${value}px";
  }
}
