import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Main Menu
int selectedIndex = 0;

// Tabbar
TabController? globalStatsTabController;
int selectedStatsTabIndex = 0;

// Content - Pagination
int pageMyInventory = 1;
int pageAllHistory = 1;

// Content - Select
String statsType = 'item';
XFile? capturedImage;

// Firebase
String? token;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);

bool isOffline = false;

// Camera
FlashMode flashMode = FlashMode.off;

// API Fetch rest time
int dctFetchRestTime = 300; // in second
int historyFetchRestTime = 60; // in second
int profileFetchRestTime = 60; // in second
int statsFetchRestTime = 120; // in second
