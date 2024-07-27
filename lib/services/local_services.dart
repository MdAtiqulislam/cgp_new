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


 /* static IOSOptions _getIOSOptions() => const IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
  );
  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
*/
}
