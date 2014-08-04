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
class ScalableElement extends PolymerElement {

  @published int minWidth, maxWidth;
  @published int minHeight, maxHeight;
  @published bool preserveAspectRatio = false;
  @published bool canTranslate = false;
  @published bool selected = false;

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
