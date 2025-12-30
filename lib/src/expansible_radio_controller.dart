// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Modifications Copyright 2025 itulau. All rights reserved.
// This file has been modified from the original Flutter source.

library;

import 'package:flutter/material.dart';

import 'expansion_panel2.dart';

/// A controller for managing the expansion state of an [ExpansionPanelList.radio].
///
/// This class is a [ChangeNotifier] that notifies its listeners if the value of
/// [isExpanded] changes.
///
/// This controller provides methods to programmatically expand or collapse the
/// widget, and it allows external components to query the current expansion
/// state.
///
/// The controller's [expand] and [collapse] methods cause the
/// [Expansible] to rebuild, so they may not be called from
/// a build method.
///
/// Remember to [dispose] of the [ExpansibleRadioController] when it is no longer
/// needed. This will ensure all resources used by the object are discarded.
class ExpansibleRadioController<T> extends ChangeNotifier {
  /// Creates a controller to be used with [ExpansionPanelList2.ExpansibleRadioController].
  ExpansibleRadioController();

  T? _value;

  void _setExpansionState(T? newValue) {
    if (newValue != _value) {
      _value = newValue;
      notifyListeners();
    }
  }

  /// Whether the expansible widget built with this controller is in expanded
  /// state.
  ///
  /// This property doesn't take the animation into account. It reports `true`
  /// even if the expansion animation is not completed.
  ///
  /// To be notified when this property changes, add a listener to the
  /// controller using [ExpansibleController.addListener].
  ///
  /// See also:
  ///
  ///  * [expand], which expands the expansible widget.
  ///  * [collapse], which collapses the expansible widget.
  T? get value => _value;

  /// Expands the [Expansible] that was built with this controller.
  ///
  /// If the widget is already in the expanded state (see [isExpanded]), calling
  /// this method has no effect.
  ///
  /// Calling this method may cause the [Expansible] to rebuild, so it may
  /// not be called from a build method.
  ///
  /// Calling this method will notify registered listeners of this controller
  /// that the expansion state has changed.
  ///
  /// See also:
  ///
  ///  * [collapse], which collapses the expansible widget.
  ///  * [isExpanded] to check whether the expansible widget is expanded.
  void expand(T value) {
    _setExpansionState(value);
  }

  /// Collapses the [Expansible] that was built with this controller.
  ///
  /// If the widget is already in the collapsed state (see [isExpanded]),
  /// calling this method has no effect.
  ///
  /// Calling this method may cause the [Expansible] to rebuild, so it may not
  /// be called from a build method.
  ///
  /// Calling this method will notify registered listeners of this controller
  /// that the expansion state has changed.
  ///
  /// See also:
  ///
  ///  * [expand], which expands the [Expansible].
  ///  * [isExpanded] to check whether the [Expansible] is expanded.
  void collapse(T? value) {
    _setExpansionState(value);
  }

  /// Finds the [ExpansibleController] for the closest [Expansible] instance
  /// that encloses the given context.
  ///
  /// If no [Expansible] encloses the given context, calling this
  /// method will cause an assert in debug mode, and throw an
  /// exception in release mode.
  ///
  /// To return null if there is no [Expansible] use [maybeOf] instead.
  ///
  /// Typical usage of the [ExpansibleController.of] function is to call it from
  /// within the `build` method of a descendant of an [Expansible].
  static ExpansibleRadioController<Object>? of(BuildContext context) {
    final ExpansionPanelList2State? result =
    context.findAncestorStateOfType<ExpansionPanelList2State>();
    assert(() {
      if (result == null) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary(
            'ExpansibleController.of() called with a context that does not contain a Expansible.',
          ),
          ErrorDescription(
            'No Expansible ancestor could be found starting from the context that was passed to ExpansibleController.of(). '
                'This usually happens when the context provided is from the same StatefulWidget as that '
                'whose build function actually creates the Expansible widget being sought.',
          ),
          ErrorHint(
            'There are several ways to avoid this problem. The simplest is to use a Builder to get a '
                'context that is "under" the Expansible. ',
          ),
          ErrorHint(
            'A more efficient solution is to split your build function into several widgets. This '
                'introduces a new context from which you can obtain the Expansible. In this solution, '
                'you would have an outer widget that creates the Expansible populated by instances of '
                'your new inner widgets, and then in these inner widgets you would use ExpansibleController.of().\n'
                'An other solution is assign a GlobalKey to the Expansible, '
                'then use the key.currentState property to obtain the Expansible rather than '
                'using the ExpansibleController.of() function.',
          ),
          context.describeElement('The context used was'),
        ]);
      }
      return true;
    }());
    return result!.widget.controller;
  }

  /// Finds the [ExpanionPanelList2] from the closest instance of this class that
  /// encloses the given context and returns its [ExpansibleRadioController].
  ///
  /// If no [Expansible] encloses the given context then return null.
  /// To throw an exception instead, use [of] instead of this function.
  ///
  /// See also:
  ///
  ///  * [of], a similar function to this one that throws if no [ExpanionPanelList2]
  ///    encloses the given context.
  static ExpansibleRadioController<Object>? maybeOf(BuildContext context) {
    return context
        .findAncestorStateOfType<ExpansionPanelList2State>()
        ?.widget
        .controller;
  }
}