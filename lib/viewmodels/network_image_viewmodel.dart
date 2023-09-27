import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_panning_assignment/viewmodels/constants.dart';

import '../models/card_api_response_model.dart';
import '../models/image_model.dart';

class NetworkImageViewModel extends ChangeNotifier {
  ImageModel? _image;

  ImageModel? get image => _image;

  void setImage(ImageModel image) {
    _image = image;
    notifyListeners();
  }

  Future<void> fetchImage() async {
    try {
      final response = await http.post(
        Uri.parse(fetchUrl),
        headers: <String, String>{
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'cardImageId': cardImageId,
        }),
      );

      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        final Result? res = cardApiResponseFromJson(response.body).result?[0];
        String? imgURL = res?.customImageCardDesignInfo?.profileBannerImageUrl;
        setImage(ImageModel(imgURL!));
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<bool> uploadImage(String filePath) async {
    final Uri uri = Uri.parse(uploadUrl);

    try {
      final request = http.MultipartRequest('POST', uri);
      print(filePath);

      final multipartFile = await http.MultipartFile.fromPath(
        'profileBannerImageURL',
        filePath,
        contentType: MediaType('image', 'jpg'),
      );
      request.headers['Authorization'] = 'Bearer $authToken';
      request.files.add(multipartFile);

      final response = await request.send();

      final responseBody = await response.stream.bytesToString();
      log('Response: $responseBody');

      if (response.statusCode == 200) {
        print('Image uploaded successfully!');
        return true;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Network Error: $error');
    }

    return false;
  }
}
