// ignore_for_file: file_names

import 'dart:collection';

import 'package:datum_cli/src/model/datum_ast.dart' as datum;

class Environment extends datum.Datum {
  // ignore: prefer_collection_literals
  Environment([this._parent]) : _bindings = LinkedHashMap();

  final Environment? _parent;
  final Map<datum.Symbol, datum.Datum> _bindings;

  Environment create() => Environment(this);

  //lookup
  datum.Datum? operator [](datum.Symbol symbol) {
    if (_bindings.containsKey(symbol)) {
      return _bindings[symbol]!;
    }
    if (_parent != null) {
      return _parent![symbol];
    }
    throw ArgumentError('$symbol is not defined in the lexical scope');
  }

  //update existing binding
  void operator []=(datum.Symbol symbol, datum.Datum value) {
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
  datum.Datum define(datum.Symbol symbol, datum.Datum value) =>
      _bindings[symbol] = value;

  datum.Datum definePrimitive(datum.Primitive primitive) =>
      _bindings[primitive.name] = primitive;

  Iterable<MapEntry<datum.Symbol, datum.Datum>> get entries =>
      _bindings.entries;
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
}
