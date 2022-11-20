import 'package:datum/src/model/datum_model.dart' as datum;
import 'configuration.dart';

class Klosure extends datum.Applicable {
  Klosure(this.code, this.formals, this.numberOfMandatoryArguments,
      this.environment, this.isVariadic);

  final Environment environment;
  final datum.Datum code;
  final List<datum.Datum>
      formals; //Datum can be only Symbol and (optional argument) Pair where car is Symbol and cdr is initial expression
  final bool isVariadic;
  final int numberOfMandatoryArguments;

  @override
  accept(visitor) {
    return visitor.visitKlosure(this);
  }
}
