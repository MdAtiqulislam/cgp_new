
/*
import 'dart:convert';

import 'package:cgp/app/modules/cart/models/my_cart_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../app/modules/wishList/models/wish_list_model.dart';
import '../models/customer_model.dart';

class LocalServices {
  static const _localStorage = FlutterSecureStorage();
  static const _keyToken = 'token';
  static const _keyUser = 'user';
  static const _keyWishListItem = 'wishList';
  static const _keyMyCart = 'myCart';
  static const _keyOnGoingTripId = 'keyOnGoingTripId';




  //write onGoingTripId
  static Future storeOnGoingTrip(String? tripId) async =>
      await _localStorage.write(key: _keyOnGoingTripId, value: tripId);

//read onGoingTripId
  static Future<String?> getOnGoingTrip() async =>
      await _localStorage.read(key: _keyOnGoingTripId);

  //write token
  static Future storeToken(String token) async =>
      await _localStorage.write(key: _keyToken, value: token);

//read token
  static Future<String?> getToken() async =>
      await _localStorage.read(key: _keyToken);


  //store user
  Future storeUser(CustomerModel user) async {
    final value = json.encode(user);
    await _localStorage.write(key: _keyUser, value: value);
  }

  //read user
  static Future<CustomerModel?> getUser() async {
    final value = await _localStorage.read(key: _keyUser);
    return value == null ? null : CustomerModel.fromJson(json.decode(value));
  }
//store wishlist
  Future storeWishList(WishListModel wishList) async {
    final value = json.encode(wishList);
    await _localStorage.write(key: _keyWishListItem, value: value,);
  }

  //read wishlist
  static Future<WishListModel?> getWishList() async {
    final value = await _localStorage.read(key: _keyWishListItem,);
    return value == null ? null : WishListModel.fromJson(json.decode(value));
  }

  //store myCart
  Future storeMyCart(MyCartModel myCart) async {
    final value = json.encode(myCart);
    await _localStorage.write(key: _keyMyCart, value: value,);
  }

  //read myCart
  static Future<MyCartModel?> getMyCart() async {
    final value = await _localStorage.read(key: _keyMyCart,);
    return value == null ? null : MyCartModel.fromJson(json.decode(value));
  }


  static Future deleteData() async => await _localStorage.deleteAll();


}

 */


/*
import 'dart:convert';
import 'package:cgp/app/modules/cart/models/my_cart_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../app/modules/wishList/models/wish_list_model.dart';
import '../models/customer_model.dart';

class LocalServices {
  static const _localStorage = FlutterSecureStorage();
  static const _keyToken = 'token';
  static const _keyUser = 'user';
  static const _keyWishListItem = 'wishList';
  static const _keyMyCart = 'myCart';
  static const _keyOnGoingTripId = 'keyOnGoingTripId';

  // Write onGoingTripId with error handling
  static Future<void> storeOnGoingTrip(String? tripId) async {
    try {
      final existingTripId = await getOnGoingTrip();
      if (existingTripId != tripId) {
        await _localStorage.write(key: _keyOnGoingTripId, value: tripId, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
        // await _localStorage.delete(key: _keyOnGoingTripId, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
      }else {
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

  // Read onGoingTripId with error handling
  static Future<String?> getOnGoingTrip() async {
    try {
      return await _localStorage.read(key: _keyOnGoingTripId, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
    } catch (e) {
      if (kDebugMode) {
        print('Error reading onGoingTripId: $e');
      }
      return null;
    }
  }

  // Write token with duplicate check and error handling
  static Future<void> storeToken(String token) async {
    try {
      // Check if token already exists
      String? existingToken = await getToken();
      if (existingToken != token) {
        await _localStorage.write(key: _keyToken, value: token, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
        if (kDebugMode) {
          print('Token stored successfully');
        }
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

  // Read token with error handling
  static Future<String?> getToken() async {
    try {
      return await _localStorage.read(key: _keyToken, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
    } catch (e) {
      if (kDebugMode) {
        print('Error reading token: $e');
      }
      return null;
    }
  }

  // Store user with error handling
  Future<void> storeUser(CustomerModel user) async {
    try {
      final value = json.encode(user);
      await _localStorage.write(key: _keyUser, value: value, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
    } catch (e) {
      if (kDebugMode) {
        print('Error storing user: $e');
      }
    }
  }

  // Read user with error handling
  static Future<CustomerModel?> getUser() async {
    try {
      final value = await _localStorage.read(key: _keyUser, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
      return value == null ? null : CustomerModel.fromJson(json.decode(value));
    } catch (e) {
      if (kDebugMode) {
        print('Error reading user: $e');
      }
      return null;
    }
  }

  // Store wishlist with error handling
  Future<void> storeWishList(WishListModel wishList) async {
    try {
      final value = json.encode(wishList);
      await _localStorage.write(key: _keyWishListItem, value: value, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
    } catch (e) {
      if (kDebugMode) {
        print('Error storing wishList: $e');
      }
    }
  }

  // Read wishlist with error handling
  static Future<WishListModel?> getWishList() async {
    try {
      final value = await _localStorage.read(key: _keyWishListItem, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
      return value == null ? null : WishListModel.fromJson(json.decode(value));
    } catch (e) {
      if (kDebugMode) {
        print('Error reading wishList: $e');
      }
      return null;
    }
  }

  // Store myCart with error handling
  Future<void> storeMyCart(MyCartModel myCart) async {
    try {
      final value = json.encode(myCart);
      await _localStorage.write(key: _keyMyCart, value: value, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
    } catch (e) {
      if (kDebugMode) {
        print('Error storing myCart: $e');
      }
    }
  }

  // Read myCart with error handling
  static Future<MyCartModel?> getMyCart() async {
    try {
      final value = await _localStorage.read(key: _keyMyCart, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
      return value == null ? null : MyCartModel.fromJson(json.decode(value));
    } catch (e) {
      if (kDebugMode) {
        print('Error reading myCart: $e');
      }
      return null;
    }
  }

  // Delete all stored data with error handling
  static Future<void> deleteData() async {
    try {
      await _localStorage.deleteAll(iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting data: $e');
      }
    }
  }

  // iOS-specific secure storage options
  static IOSOptions _getIOSOptions() => const IOSOptions(
    accessibility: KeychainAccessibility.unlocked,
    synchronizable: true
  );

  // Android-specific secure storage options
  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
}

 */


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
