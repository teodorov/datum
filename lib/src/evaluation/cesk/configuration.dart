import 'dart:collection';

import 'package:datum/src/evaluation/cesk/closure.dart';
import 'package:datum/src/model/datum_model.dart' as datum;

class Configuration {
  Configuration(this.control, this.environment, this.store, this.kontinuation);
  final datum.Datum control; //C : the program counter, an expression for us
  /// E : a map from symbols to addresses in store
  /// ρ ∈ Env = Symbol → N
  final Environment environment;

  /// S : a map from addresses to values
  /// σ ∈ store = N → Values
  /// val ∈ Values = null | number | boolean | closure(λ, ρ) | continuation(κ)
  final List<datum.Datum> store;
  final Frame kontinuation; //K : a representation of the program stack

  copy() => Configuration(control, environment, store, kontinuation);

  @override
  bool operator ==(Object other) =>
      other is Configuration &&
      other.control == control &&
      other.environment == environment &&
      other.store == store &&
      other.kontinuation == kontinuation;

  @override
  int get hashCode => Object.hash(control, environment, store, kontinuation);

  @override
  String toString() {
    return '{C: $control, E: $environment, S: $store, K: $kontinuation}';
  }

  Map<String, dynamic> toJson() => {
        'C': control.toString(),
        'E': environment.toJson(),
        'S': store.map((e) => e.toString()).toList(),
        'K': kontinuation.toString(),
      };
}

class Environment extends datum.Datum {
  // ignore: prefer_collection_literals
  Environment([this._parent]) : _bindings = LinkedHashMap();

  final Environment? _parent;
  final Map<datum.Symbol, int> _bindings;

  Environment create() => Environment(this);

  //lookup
  int? operator [](datum.Symbol symbol) {
    if (_bindings.containsKey(symbol)) {
      return _bindings[symbol]!;
    }
    if (_parent != null) {
      return _parent![symbol];
    }
    throw ArgumentError('$symbol is not defined in the lexical scope');
  }

  //update existing binding ; I think we don't need this for CESK
  void operator []=(datum.Symbol symbol, int value) {
    if (_bindings.containsKey(symbol)) {
      _bindings[symbol] = value;
      return;
    }
    if (_parent != null) {
      _parent![symbol] = value;
    }
    throw ArgumentError('$symbol is not defined in the lexical scope');
  }

  //define a new binding
  void define(datum.Symbol symbol, int value) => _bindings[symbol] = value;

  Iterable<MapEntry<datum.Symbol, int>> get entries => _bindings.entries;
  Iterable<datum.Symbol> get symbols => _bindings.keys;
  Environment? get parent => _parent;

  clone() {
    Environment env = Environment(parent);
    for (var element in entries) {
      env.define(element.key, element.value);
    }
    return env;
  }

  @override
  accept(visitor) {
    return visitor.visitEnvironment(this);
  }

  @override
  String toString() {
    return 'environment ${_bindings.toString()}';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> dd =
        _bindings.map((key, value) => MapEntry(key.literal, value));
    if (parent == null) return dd;
    dd['parent'] = parent!.toJson();
    return dd;
  }
}

class Frame {}

class EndFrame extends Frame {
  EndFrame();
  @override
  String toString() {
    return 'EndFrame';
  }
}

class DoneFrame extends Frame {
  DoneFrame();
}

abstract class AbstractFrame extends Frame {
  AbstractFrame(this.parent);
  final Frame parent;
}

class ApplicationFrame extends AbstractFrame {
  ApplicationFrame(this.closure, this.values, this.expressions,
      this.environment, this.isDone, super.parent);
  final Klosure? closure;
  final List<datum.Datum> values;
  final datum.Datum expressions;
  final Environment environment;
  final bool isDone;

  @override
  String toString() {
    return 'AppFrame, $parent';
  }
}

class IfFrame extends AbstractFrame {
  IfFrame(this.trueBranch, this.falseBranch, super.parent);
  final datum.Datum trueBranch;
  final datum.Datum falseBranch;

  @override
  String toString() {
    return 'IfFrame, $parent';
  }
}

class SetFrame extends AbstractFrame {
  SetFrame(this.address, super.parent);
  final int address;

  @override
  String toString() {
    return 'SetFrame, $parent';
  }
}

class SequenceFrame extends AbstractFrame {
  SequenceFrame(this.rest, super.parent);
  final datum.Datum rest;

  @override
  String toString() {
    return 'SequenceFrame, $parent';
  }
}

class DefFrame extends AbstractFrame {
  DefFrame(this.symbol, super.parent);
  final datum.Symbol symbol;

  @override
  String toString() {
    return 'DefFrame, $parent';
  }
}
