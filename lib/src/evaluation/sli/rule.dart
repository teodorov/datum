class Rule {
  Rule(this.guard, this.action);

  factory Rule.eval(name, guard, action) =>
      Rule(Guard(name, guard), Action(name, action));

  factory Rule.kontinuation(name, frameType, guard, action) =>
      KontinuationRule(frameType, Guard(name, guard), Action(name, action));

  final Guard guard;
  final Action action;

  @override
  String toString() {
    return 'ERule[${guard.name}]';
  }

  @override
  int get hashCode => Object.hash(guard, action);

  @override
  bool operator ==(Object other) {
    return (other is Rule) && guard == other.guard && action == other.action;
  }
}

class KontinuationRule extends Rule {
  KontinuationRule(this.frameType, super.guard, super.action);
  Type frameType;

  @override
  String toString() {
    return 'KRule[${guard.name}]';
  }

  @override
  int get hashCode => Object.hash(guard, action, frameType);

  @override
  bool operator ==(Object other) {
    return (other is KontinuationRule) &&
        guard == other.guard &&
        action == other.action &&
        frameType == frameType;
  }
}

class Guard {
  Guard(this.name, this.code);
  String name;
  Function code;

  @override
  int get hashCode => Object.hash(name, code);

  @override
  bool operator ==(Object other) {
    return (other is Guard) && name == other.name && code == other.code;
  }
}

class Action {
  Action(this.name, this.code);
  String name;
  Function code;
  @override
  int get hashCode => Object.hash(name, code);

  @override
  bool operator ==(Object other) {
    return (other is Action) && name == other.name && code == other.code;
  }
}
