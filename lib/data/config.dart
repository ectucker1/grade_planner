import 'package:polymer_elements/paper_input.dart';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'package:yaml/yaml.dart';
import 'dart:html';

class Project extends JsProxy {
  @reflectable String name;
  @reflectable String strand;
  @reflectable num points;
  @reflectable String color;

  Project(this.name, this.strand, this.points, this.color);

  List<String> toList()
  {
    if(points != 0) {
      return [name, points.toString(), strand, ""];
    } else {
      return [name, "?", strand, ""];
    }
  }
}

class Config extends JsProxy {
  @reflectable String name;
  @reflectable num extra;
  List<Project> required = [];
  List<Project> optional = [];

  Config(YamlMap config)
  {
    this.name = config["class"];
    this.extra = config["extra"];

    YamlList list = config["optional"];
    for (var item in list) {
      Project project = new Project(item["name"], item["strand"], item["points"], item["color"]);
      optional.add(project);
    }

    list = config["optional"];
    for (var item in list) {
      Project project = new Project(item["name"], item["strand"], item["points"], item["color"]);
      required.add(project);
    }
  }
}
