class CartServices {
  static addCart(item){
    //把对象转换成map类型的数据
    item =  CartServices.formtCartData(item);
    print(item);
    
  }

  static formtCartData(item){
    final Map data = new Map<String, dynamic>();
    data['_id'] = item.sId;
    data['title'] = item.title;
    data['price'] = item.price;
    data['selectedAttr'] = item.selectedAttr;
    data['count'] = item.count;
    data['pic'] = item.pic;
    //是否选中
    data['checked'] = true;    
    return data;
  }
}
