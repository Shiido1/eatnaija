import 'package:eatnaija/presentation/screens/restaurant_foods/model/get_all_restaurant_food_response.dart';

class CartItemsModel{
  List<Map<String,dynamic>> items = [];
  int itemNum = 0;
  List<Map<String,dynamic>> getCartItems(){
    return items;
  }
  void updateCartItems(Map<String,dynamic> item){
    var target = items.firstWhere((e)=>e['item'].id==item['item'].id, orElse:()=>null);
    if(target != null){
      if(item['quantity'] > 0){
        items[items.indexWhere((itm)=>itm['item'].id==item['item'].id)]['quantity'] = item['quantity'];
      }else{
        items.remove(target);
      }
    }else{
      items.add(item);
    }
  }
  void removeCartItem(Menu item){
    var target = items.firstWhere((e)=>e['item']==item, orElse:()=>null);
    if(target != null){
      items.remove(target);
    }
  }
  int getCartItemsNumber(){
    int iNum = 0;
    items.forEach((it)=> iNum +=it['quantity']);
    return iNum;
  }
  double getTotalPrice(){
    double totalPrice = 0;
    items.forEach((element) => totalPrice +=(element['quantity']*element['price']));
    return totalPrice;
  }
}