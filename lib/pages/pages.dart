import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:outfilt/widgets/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../constants/constant.dart';
import '../data/data.dart';
import '../provider/providers.dart';
import '../services/services.dart';

part 'model_view_page.dart';
part 'home_page.dart';
part 'welcome_page.dart';
part 'pick_outfit_page.dart';
part 'makeup_creator.dart';

/* Bottoms naviations items */
part 'bottom_navigation/makeup_page.dart';
part 'bottom_navigation/find_in_map.dart';
