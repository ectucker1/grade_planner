// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
@HtmlImport('main_app.html')
import 'dart:html';

import 'package:polymer_elements/paper_input.dart';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'package:grade_planner/data/config.dart';
import 'package:yaml/yaml.dart';
import 'package:grade_planner/sections/project_plan.dart';
import 'package:grade_planner/sections/project_options.dart';
import 'package:grade_planner/sections/project_checklist.dart';

/// Uses [PaperInput]
@PolymerRegister('main-app')
class MainApp extends PolymerElement {

  static Config config = null;

  static Plan plan;
  static Options options;
  static Checklist checklist;

  /// Constructor used to create instance of MainApp.
  MainApp.created() : super.created();

  // Optional lifecycle methods - uncomment if needed.

  /// Called when an instance of main-app is inserted into the DOM.

  static getConfig() async {
    return new Config(loadYaml(await HttpRequest.getString('config.yaml')));
  }

//  /// Called when an instance of main-app is inserted into the DOM.
attached() async {
  super.attached();
  config = await getConfig();
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
