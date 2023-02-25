// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '../../../size_config.dart';

Container UploadCard(imageName) {
  return Container(
      margin: const EdgeInsets.all(10),
      height: getProportionateScreenHeight(70),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
        borderRadius: BorderRadius.circular(15),
        color: Colors.black.withOpacity(0.4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: getProportionateScreenHeight(40),
                width: getProportionateScreenWidth(40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.image_rounded,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: SizeConfig.screenHeight * 0.01),
              Container(
                width: SizeConfig.screenHeight * 0.14,
                height: SizeConfig.screenHeight * 0.03,
                child: Text(
                  imageName,
                  style: TextStyle(
                      fontFamily: 'muli',
                      color: Colors.white.withOpacity(0.7),
                      fontSize: getProportionateScreenWidth(15),
                      fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
          Text(
            "123kb",
            style: TextStyle(
                fontFamily: 'muli',
                color: Colors.white.withOpacity(0.7),
                fontSize: getProportionateScreenWidth(15),
                fontWeight: FontWeight.w300),
          )
        ],
      ));
}
