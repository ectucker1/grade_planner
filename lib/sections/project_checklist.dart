// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
@HtmlImport('project_checklist.html')

import 'package:polymer_elements/paper_input.dart';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'package:yaml/yaml.dart';
import 'dart:html';
import 'package:grade_planner/data/config.dart';
import 'package:grade_planner/main_app.dart';


/// Uses [PaperInput]
@PolymerRegister('project-checklist')
class Checklist extends PolymerElement {
  @property List<Project> projects = [];

  /// Constructor used to create instance of MainApp.
  Checklist.created() : super.created();

  // Optional lifecycle methods - uncomment if needed.

//  /// Called when an instance of main-app is inserted into the DOM.
attached() async {
  print("Called");
  YamlMap config = loadYaml(await HttpRequest.getString('config.yaml'));
  YamlList list = config["required"];

  for (var item in list) {
    Project project = new Project(item["name"], item["strand"], item["points"], item["color"]);
    add('projects', project);
  }

  MainApp.checklist = this;
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
