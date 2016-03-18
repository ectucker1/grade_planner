// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
@HtmlImport('project_options.html')

import 'package:polymer_elements/paper_input.dart';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'package:yaml/yaml.dart';
import 'dart:html';
import 'package:grade_planner/data/config.dart';
import 'package:grade_planner/main_app.dart';

/// Uses [PaperInput]
@PolymerRegister('project-plan')
class Plan extends PolymerElement {
  @property List<Project> projects = [];
  @property num points = 0;
  @property num needed = 0;

  /// Constructor used to create instance of MainApp.
  Plan.created() : super.created();

  // Optional lifecycle methods - uncomment if needed.

//  /// Called when an instance of main-app is inserted into the DOM.
  attached() async {
    print("Called");
    YamlMap config = loadYaml(await HttpRequest.getString('config.yaml'));
    needed = config["extra"];

    this.notifyPath('needed', needed);

    MainApp.plan = this;
  }

  addProject(Project project)
  {
    add('projects', project);
    calcPoints();
  }

  calcPoints()
  {
    int total = 0;
    for(Project project in projects)
    {
      total += project.points;
    }
    points = total;
    notifyPath('points', points);
  }

  @reflectable
  deselectItem(event, [_]) {
    var model = new DomRepeatModel.fromEvent(event);
    MainApp.options.addProject(model.item);
    removeItem("projects", model.item);
    calcPoints();
  }

//  /// Called when an instance of main-app is removed from the DOM.
//  detached() {
//    super.detached();
//  }

//  /// Called when an attribute (such as a class) of an instance of
//  /// main-app is added, changed, or removed.
//  attributeChanged(String name, String oldValue, String newValue) {
//    super.attributeChanged(name, oldValue, newValue);
//  }

//  /// Called when main-app has been fully prepared (Shadow DOM created,
//  /// property observers set up, event listeners attached).
//  ready() {
//  }
}
