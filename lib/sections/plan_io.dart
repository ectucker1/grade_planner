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
import 'package:yaml/yaml.dart';

/// Uses [PaperInput]
@PolymerRegister('plan-io')
class PlanIO extends PolymerElement {

  /// Constructor used to create instance of MainApp.
  PlanIO.created() : super.created();

  @reflectable
  printPlan(event, [_]) async
  {
    var pdf = context['pdfMake'];

    YamlMap config = loadYaml(await HttpRequest.getString('config.yaml'));

    String title = "Grade Plan for " + config["class"].toString();

    List<List<String>> requiredBody = [];
    requiredBody.add(["Project", "Points", "Strand", ""]);
    for(Project project in MainApp.checklist.projects)
    {
      requiredBody.add(project.toList());
    }
    if(requiredBody.length <= 1)
    {
      requiredBody.add(["None", "0", "", ""]);
    }

    List<List<String>> optionalBody = [];
    optionalBody.add(["Project", "Points", "Strand", ""]);
    for(Project project in MainApp.plan.projects)
    {
      optionalBody.add(project.toList());
    }
    if(optionalBody.length <= 1)
    {
      optionalBody.add(["None", "0", "", ""]);
    }

    String conclusion = "That's " + MainApp.plan.points.toString() + "/" + MainApp.plan.needed.toString() + " points";
    String grade;
    if(MainApp.plan.points >= MainApp.plan.needed)
    {
      grade = "This plan is an A in the class.";
    }
    else
    {
      grade = "This plan still needs " + (MainApp.plan.needed - MainApp.plan.points).toString() + " point(s) for an A.";
    }

    JsObject dd = new JsObject.jsify({'content':[
      { 'text': title, 'fontSize': 22, 'bold': true },
      { 'text': 'Projects Required for B', 'fontSize': 16, 'bold': true },
      {
        'table': {
          'headerRows': 1,
          'widths': [ '*', 'auto', 'auto', 10 ],
          'body': requiredBody
        }
      },
      { 'text': 'Your A-Strand Projects', 'fontSize': 16, 'bold': true },
      {
        'table': {
          'headerRows': 1,
          'widths': [ '*', 'auto', 'auto', 10 ],
          'body': optionalBody
        }
      },
      { 'text': conclusion, 'fontSize': 14 },
      { 'text': grade, 'fontSize': 14 },
    ]});

    pdf.callMethod('createPdf', [dd]).callMethod('open');
  }

// Optional lifecycle methods - uncomment if needed.

 attached() async {
    super.attached();
    YamlMap config = loadYaml(await HttpRequest.getString('config.yaml'));
    var elem = document.query("#email");
    elem.attributes['href'] = config['email'];
    elem = document.query("#schedule");
    elem.attributes['href'] = config['schedule'];
 }

  @reflectable
  schedule(event, [_]) async {
    YamlMap config = loadYaml(await HttpRequest.getString('config.yaml'));
    window.location.assign(config['schedule']);
  }

  @reflectable
  email(event, [_]) async {
    YamlMap config = loadYaml(await HttpRequest.getString('config.yaml'));
    window.location.assign('mailto:' + config['email'].toString());
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
