// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
@HtmlImport('plan_io.html')
import 'dart:html';
import 'dart:js';

import 'package:polymer_elements/paper_input.dart';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'package:grade_planner/main_app.dart';
import 'package:grade_planner/data/config.dart';

/// Uses [PaperInput]
@PolymerRegister('custom-project')
class ProjectCustom extends PolymerElement {
  @property String name;
  @property String points;
  @property String strand;

  /// Constructor used to create instance of MainApp.
  ProjectCustom.created() : super.created();

  @reflectable
  addProject(event, [_])
  {
    MainApp.plan.addProject(new Project(name, strand, num.parse(points), "white"));
  }

}