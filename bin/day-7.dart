import 'dart:io';

RegExp parser = new RegExp(r'^([\w\d\s]+) -> (\w+)$', caseSensitive: false);
RegExp simpleInput = new RegExp(r'^([\w\d]+)$', caseSensitive: false);
RegExp unaryInput = new RegExp(r'^(\w+) ([\w\d]+)$', caseSensitive: false);
RegExp binaryInput = new RegExp(r'^([\w\d]+) (\w+) ([\w\d]+)$', caseSensitive: false);


Map<String, Function> ops = {
  'NOT': (List<int> inp) => ~inp[0],
  'AND': (List<int> inp) => inp[0] & inp[1],
  'OR': (List<int> inp) => inp[0] | inp[1],
  'RSHIFT': (List<int> inp) => inp[0] >> inp[1],
  'LSHIFT': (List<int> inp) => inp[0] << inp[1],
};


bool log = false;

class Graph {
  Map<String, int> wires = new Map<String, int>();
  List<Gate> gates = new List<Gate>();

  void addGate(String operator, List inputs, String output) {
    Gate gate = new Gate();
    gate.graph = this;
    gate.output = output;
    gate.inputs = new List.from(inputs);
    gate.operator = operator;

    for (var i in inputs) {
      if (i.runtimeType == String) {
        if (!wires.containsKey(i)) {
          wires[i] =  null;
        }
      }
    }

    if (!wires.containsKey(output)) {
      wires[output] = null;
    }

    gates.add(gate);
    resolveFrom(gate);
  }

  void resolveFrom(Gate gate) {
    if (gate.hasAllInputs()) {
      if (log) print("resolving from $gate");
      wires[gate.output] = gate.getValue();
      for (Gate affected in gates.where((Gate g) => g.inputs.contains(gate.output))) {
        resolveFrom(affected);
      }
    }
  }
}

class Gate {

  Graph graph;
  List inputs = [];
  String output = null;
  String operator;

  @override
  String toString() {
    return "$operator(${inputs.join(',')}) -> $output";
  }

  bool hasAllInputs() {
    for (var i in inputs) {
      if (i.runtimeType == String) {
        if (graph.wires[i] == null) {
          return false;
        }
      }
    }
    return true;
  }

  int _getInputValue(var input) {
    if (input.runtimeType == String) {
      return graph.wires[input];
    } else if (input.runtimeType == int) {
      return input;
    } else {
      throw new TypeError();
    }
  }
  int getValue() {
    if (operator == null) {
      return _getInputValue(inputs[0]);
    } else {
      return ops[operator](inputs.map(_getInputValue).toList());
    }
  }
}

dynamic tryParse(String input) {
  try {
    return int.parse(input);
  } on Exception {
    return input;
  }
}

main() {
  Graph graph = new Graph();
  Match m;
  String lhs, rhs;
  List inputs;
  Gate gate;
  List<String> lines = new File("../inputs/day-7.txt").readAsLinesSync();
  Stopwatch watch = new Stopwatch();
  watch.start();
  for (String line in lines) {
    m = parser.matchAsPrefix(line);
    lhs = m.group(1);
    rhs = m.group(2);
    inputs = [];
    // Handle a simple numeric input;
    m = simpleInput.firstMatch(lhs);
    if (m != null) {
      inputs.add(tryParse(m.group(1)));
      graph.addGate(null, inputs, rhs);
      continue;
    }
    // handle a unary operator
    m = unaryInput.firstMatch(lhs);
    if (m != null) {
      inputs.add(tryParse(m.group(2)));
      graph.addGate(m.group(1), inputs, rhs);
      continue;
    }

    // handle a binary operator
    m = binaryInput.firstMatch(lhs);
    if (m != null) {
      inputs.add(tryParse(m.group(1)));
      inputs.add(tryParse(m.group(3)));
      graph.addGate(m.group(2), inputs, rhs);
      continue;
    }
  }
  int answer = graph.wires['a'];
  watch.stop();
  print("a = $answer (${watch.elapsedMilliseconds}ms)");

}
