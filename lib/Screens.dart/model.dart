List<Map> ShoppingCartItems = [];

List<String>productName = [];


  bool checkItemAvailability(String id) {
    bool itemfind = false;
    for (int i = 0; i < ShoppingCartItems.length; i++) {
      if (ShoppingCartItems[i]['id'] == id) {
        itemfind = true;
        ShoppingCartItems[i]['count']++;
      }
    }
    return itemfind;
  }