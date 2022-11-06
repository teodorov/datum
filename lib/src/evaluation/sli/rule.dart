class Rule {
  Rule(this.guard, this.action);

  factory Rule.eval(name, guard, action) =>
      Rule(Guard(name, guard), Action(name, action));

  factory Rule.kontinuation(name, frameType, guard, action) =>
      KontinuationRule(frameType, Guard(name, guard), Action(name, action));

  final Guard guard;
  final Action action;
}

class KontinuationRule extends Rule {
  KontinuationRule(this.frameType, super.guard, super.action);
  var frameType;
}

class Guard {
  Guard(this.name, this.code);
  String name;
  Function code;
}

class Action {
  Action(this.name, this.code);
  String name;
  Function code;
}
