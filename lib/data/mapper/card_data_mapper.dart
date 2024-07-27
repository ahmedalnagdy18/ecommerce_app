import 'package:flutter_application_test/data/model/api_model.dart';
import 'package:flutter_application_test/domain/entities/card_info_entity.dart';

extension ConvertCardInfoEntityToApiModel on ProductApiModel {
  CardInfoEntity cardMap() {
    return CardInfoEntity(
      id: id,
      title: title,
      description: description,
      category: category,
      price: price,
      discountPercentage: discountPercentage,
      rating: rating,
      stock: stock,
      tags: tags,
      brand: brand,
      sku: sku,
      weight: weight,
      warrantyInformation: warrantyInformation,
      shippingInformation: shippingInformation,
      availabilityStatus: availabilityStatus,
      returnPolicy: returnPolicy,
      minimumOrderQuantity: minimumOrderQuantity,
      images: images,
      thumbnail: thumbnail,
    );
  }
}
