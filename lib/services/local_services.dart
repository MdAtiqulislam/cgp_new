
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

import '../app/modules/cart/models/my_cart_model.dart';
import '../app/modules/wishList/models/wish_list_model.dart';
import '../models/customer_model.dart';

class LocalServices {
  static const _keyToken = 'token';
  static const _keyUser = 'user';
  static const _keyWishListItem = 'wishList';
  static const _keyMyCart = 'myCart';
  static const _keyOnGoingTripId = 'keyOnGoingTripId';

  static Future<SharedPreferences> get _prefs async => await SharedPreferences.getInstance();

  static Future<void> storeOnGoingTrip(String? tripId) async {
    try {
      final prefs = await _prefs;
      final existingTripId = prefs.getString(_keyOnGoingTripId);
      if (existingTripId != tripId) {
        await prefs.setString(_keyOnGoingTripId, tripId ?? '');
      } else {
        if (kDebugMode) {
          print('Trip Id already exists and is the same.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error storing onGoingTripId: $e');
      }
    }
  }

  static Future<String?> getOnGoingTrip() async {
    try {
      final prefs = await _prefs;
      return prefs.getString(_keyOnGoingTripId);
    } catch (e) {
      if (kDebugMode) {
        print('Error reading onGoingTripId: $e');
      }
      return null;
    }
  }

  static Future<void> storeToken(String token) async {
    try {
      final prefs = await _prefs;
      String? existingToken = prefs.getString(_keyToken);
      if (existingToken != token) {
        await prefs.setString(_keyToken, token);
      } else {
        if (kDebugMode) {
          print('Token already exists and is the same.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error storing token: $e');
      }
    }
  }

  static Future<String?> getToken() async {
    try {
      final prefs = await _prefs;
      return prefs.getString(_keyToken);
    } catch (e) {
      if (kDebugMode) {
        print('Error reading token: $e');
      }
      return null;
    }
  }

  Future<void> storeUser(CustomerModel user) async {
    try {
      final prefs = await _prefs;
      final value = json.encode(user);
      await prefs.setString(_keyUser, value);
    } catch (e) {
      if (kDebugMode) {
        print('Error storing user: $e');
      }
    }
  }

  static Future<CustomerModel?> getUser() async {
    try {
      final prefs = await _prefs;
      final value = prefs.getString(_keyUser);
      return value == null ? null : CustomerModel.fromJson(json.decode(value));
    } catch (e) {
      if (kDebugMode) {
        print('Error reading user: $e');
      }
      return null;
    }
  }

  Future<void> storeWishList(WishListModel wishList) async {
    try {
      final prefs = await _prefs;
      final value = json.encode(wishList);
      await prefs.setString(_keyWishListItem, value);
    } catch (e) {
      if (kDebugMode) {
        print('Error storing wishList: $e');
      }
    }
  }

  static Future<WishListModel?> getWishList() async {
    try {
      final prefs = await _prefs;
      final value = prefs.getString(_keyWishListItem);
      return value == null ? null : WishListModel.fromJson(json.decode(value));
    } catch (e) {
      if (kDebugMode) {
        print('Error reading wishList: $e');
      }
      return null;
    }
  }

  Future<void> storeMyCart(MyCartModel myCart) async {
    try {
      final prefs = await _prefs;
      final value = json.encode(myCart);
      await prefs.setString(_keyMyCart, value);
    } catch (e) {
      if (kDebugMode) {
        print('Error storing myCart: $e');
      }
    }
  }

  static Future<MyCartModel?> getMyCart() async {
    try {
      final prefs = await _prefs;
      final value = prefs.getString(_keyMyCart);
      return value == null ? null : MyCartModel.fromJson(json.decode(value));
    } catch (e) {
      if (kDebugMode) {
        print('Error reading myCart: $e');
      }
      return null;
    }
  }

  static Future<void> deleteData() async {
    try {
      final prefs = await _prefs;
      await prefs.clear();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting data: $e');
      }
    }
  }
}
