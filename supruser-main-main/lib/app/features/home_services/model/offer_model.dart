import 'package:flutter/material.dart';

class OfferModel {
  final String id;
  final String title;
  final String subtitle;
  final String code;
  final String discount;
  final Color backgroundColor;
  final DateTime? validTill;
  final String? terms;

  OfferModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.code,
    required this.discount,
    required this.backgroundColor,
    this.validTill,
    this.terms,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      code: json['code'],
      discount: json['discount'],
      backgroundColor: Color(json['backgroundColor']),
      validTill: json['validTill'] != null
          ? DateTime.parse(json['validTill'])
          : null,
      terms: json['terms'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'code': code,
      'discount': discount,
      'backgroundColor': backgroundColor.value,
      'validTill': validTill?.toIso8601String(),
      'terms': terms,
    };
  }
}