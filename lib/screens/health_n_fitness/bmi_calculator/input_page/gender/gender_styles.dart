import 'dart:math' as math;

import 'package:lakhimpur_kheri/screens/health_n_fitness/bmi_calculator/model/gender.dart';
import 'package:lakhimpur_kheri/screens/health_n_fitness/bmi_calculator/widget_utils.dart';
import 'package:flutter/material.dart';

const double defaultGenderAngle = math.pi / 4;
const Map<Gender, double> genderAngles = {
  Gender.female: -defaultGenderAngle,
  Gender.other: 0.0,
  Gender.male: defaultGenderAngle,
};

double circleSize(BuildContext context) => screenAwareSize(80.0, context);
