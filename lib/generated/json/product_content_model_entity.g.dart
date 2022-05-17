import 'package:jdshop/generated/json/base/json_convert_content.dart';
import 'package:jdshop/model/product_content_model.dart';

ProductContentModelEntity $ProductContentModelEntityFromJson(Map<String, dynamic> json) {
	final ProductContentModelEntity productContentModelEntity = ProductContentModelEntity();
	final ProductContentModelResult? result = jsonConvert.convert<ProductContentModelResult>(json['result']);
	if (result != null) {
		productContentModelEntity.result = result;
	}
	return productContentModelEntity;
}

Map<String, dynamic> $ProductContentModelEntityToJson(ProductContentModelEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['result'] = entity.result.toJson();
	return data;
}

ProductContentModelResult $ProductContentModelResultFromJson(Map<String, dynamic> json) {
	final ProductContentModelResult productContentModelResult = ProductContentModelResult();
	final String? sId = jsonConvert.convert<String>(json['_id']);
	if (sId != null) {
		productContentModelResult.sId = sId;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		productContentModelResult.title = title;
	}
	final String? cid = jsonConvert.convert<String>(json['cid']);
	if (cid != null) {
		productContentModelResult.cid = cid;
	}
	final String? price = jsonConvert.convert<String>(json['price']);
	if (price != null) {
		productContentModelResult.price = price;
	}
	final String? oldPrice = jsonConvert.convert<String>(json['old_price']);
	if (oldPrice != null) {
		productContentModelResult.oldPrice = oldPrice;
	}
	final String? isBest = jsonConvert.convert<String>(json['is_best']);
	if (isBest != null) {
		productContentModelResult.isBest = isBest;
	}
	final String? isHot = jsonConvert.convert<String>(json['is_hot']);
	if (isHot != null) {
		productContentModelResult.isHot = isHot;
	}
	final String? isNew = jsonConvert.convert<String>(json['is_new']);
	if (isNew != null) {
		productContentModelResult.isNew = isNew;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		productContentModelResult.status = status;
	}
	final String? pic = jsonConvert.convert<String>(json['pic']);
	if (pic != null) {
		productContentModelResult.pic = pic;
	}
	final String? content = jsonConvert.convert<String>(json['content']);
	if (content != null) {
		productContentModelResult.content = content;
	}
	final String? cname = jsonConvert.convert<String>(json['cname']);
	if (cname != null) {
		productContentModelResult.cname = cname;
	}
	final List<ProductContentModelResultAttr>? attr = jsonConvert.convertListNotNull<ProductContentModelResultAttr>(json['attr']);
	if (attr != null) {
		productContentModelResult.attr = attr;
	}
	final String? subTitle = jsonConvert.convert<String>(json['sub_title']);
	if (subTitle != null) {
		productContentModelResult.subTitle = subTitle;
	}
	final int? salecount = jsonConvert.convert<int>(json['salecount']);
	if (salecount != null) {
		productContentModelResult.salecount = salecount;
	}
	return productContentModelResult;
}

Map<String, dynamic> $ProductContentModelResultToJson(ProductContentModelResult entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['_id'] = entity.sId;
	data['title'] = entity.title;
	data['cid'] = entity.cid;
	data['price'] = entity.price;
	data['old_price'] = entity.oldPrice;
	data['is_best'] = entity.isBest;
	data['is_hot'] = entity.isHot;
	data['is_new'] = entity.isNew;
	data['status'] = entity.status;
	data['pic'] = entity.pic;
	data['content'] = entity.content;
	data['cname'] = entity.cname;
	data['attr'] =  entity.attr.map((v) => v.toJson()).toList();
	data['sub_title'] = entity.subTitle;
	data['salecount'] = entity.salecount;
	return data;
}

ProductContentModelResultAttr $ProductContentModelResultAttrFromJson(Map<String, dynamic> json) {
	final ProductContentModelResultAttr productContentModelResultAttr = ProductContentModelResultAttr();
	final String? cate = jsonConvert.convert<String>(json['cate']);
	if (cate != null) {
		productContentModelResultAttr.cate = cate;
	}
	final List<String>? list = jsonConvert.convertListNotNull<String>(json['list']);
	if (list != null) {
		productContentModelResultAttr.list = list;
	}
	return productContentModelResultAttr;
}

Map<String, dynamic> $ProductContentModelResultAttrToJson(ProductContentModelResultAttr entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['cate'] = entity.cate;
	data['list'] =  entity.list;
	return data;
}