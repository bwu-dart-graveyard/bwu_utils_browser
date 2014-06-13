library bwu_utils_browser.html;

import 'dart:html' as dom;

dom.HtmlElement getParentElement(dom.Node element) {
  if(element.parentNode == null) {
    return null;
  }
  if(element.parentNode is dom.ShadowRoot) {
    return (element.parentNode as dom.ShadowRoot).host;
  } else {
    return element.parentNode as dom.HtmlElement;
  }
}

int innerWidth(dom.HtmlElement e) {
  var cs = e.getComputedStyle();
   return parseInt(cs.width) + parseInt(cs.paddingLeft) + parseInt(cs.paddingRight);
}

int outerWidth(dom.HtmlElement e) {
  var cs = e.getComputedStyle();
   return parseInt(cs.width) + parseInt(cs.paddingLeft) + parseInt(cs.paddingRight) + parseInt(cs.borderLeftWidth) + parseInt(cs.borderRightWidth);
}

int outerHeight(dom.HtmlElement e) {
  var cs = e.getComputedStyle();
   return parseInt(cs.height) + parseInt(cs.paddingTop) + parseInt(cs.paddingBottom) + parseInt(cs.borderTopWidth) + parseInt(cs.borderBottomWidth);
}

dom.HtmlElement closest(dom.HtmlElement e, String selector, {dom.HtmlElement context, bool goThroughShadowBoundaries: false}) {
  dom.HtmlElement curr = e;

  if(context != null) {
    //print('tools.closest: context not yet supported: ${context}');
  }

  dom.Node p = curr.parentNode;
  if(p is dom.ShadowRoot) {
    p = (p as dom.ShadowRoot).host;
  }

  dom.HtmlElement parent = (p as dom.HtmlElement);

  var prevParent = e;
  var found;
  while(parent != null && found == null) {
    found = parent.querySelector(selector);
    if(found != null) {
      if(parent.querySelectorAll(selector).contains(prevParent)) {
        return prevParent;
      } else {
        return found;
      }
    } else {
      if(parent.querySelectorAll(selector).contains(prevParent)) {
        return prevParent;
      }
    }
    prevParent = parent;

    if(parent is dom.ShadowRoot) {
      if(goThroughShadowBoundaries) {
        parent = (parent as dom.ShadowRoot).host;
      }
    } else {
      parent = parent.parent;
    }
  }

  return found;
}

int parseInt(String s) {
  if(s == null || s.trim() == '') {
    return 0;
  }
  if(s.endsWith('%')) {
    return int.parse(s.substring(0, s.length-1));
  } else if (s.endsWith('px')) {
//      print(s);
//      print(s.substring(0,s.length-2));
    return int.parse(s.substring(0, s.length-2));
  }
  try {
    return int.parse(s);
  } on FormatException catch (e) {
    print('message: ${e.message}; value: "${s}"');
    rethrow;
  }
}