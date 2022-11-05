import 'dart:collection';

import 'package:datum/src/cesk/closure.dart';
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
}

class Frame {}

class EndFrame extends Frame {
  EndFrame();
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
      this.environment, super.parent);
  final Klosure? closure;
  final List<datum.Datum> values;
  final datum.Datum expressions;
  final Environment environment;
}

class IfFrame extends AbstractFrame {
  IfFrame(this.trueBranch, this.falseBranch, super.parent);
  final datum.Datum trueBranch;
  final datum.Datum falseBranch;
}

class SetFrame extends AbstractFrame {
  SetFrame(this.address, super.parent);
  final int address;
}
