import { observable, autorun, toJS} from 'mobx';
import { values, forEach } from 'lodash/fp';
import productsStore from './products.store';

export class CartProduct {
  @observable productId;
  @observable count;

  constructor(data) {
    Object.assign(this, data);
  }

  counterUpdate(count) {
    this.count = Math.max(1, count);
  }

  get totalPrice() {
    return this.product.price * this.count;
  }

  get product() {
    return productsStore.getProductById(this.productId);
  }
}

export class Cart {
  @observable items = new Map();

  constructor() {
    if (localStorage.cart) {
      const savedItems = JSON.parse(localStorage.cart);
      forEach((item) => {
        this.items.set(item.productId, new CartProduct(item))
      }, savedItems);
    }
    autorun(() => {
      localStorage.cart = JSON.stringify(toJS(this.items));
    });
  }

  addItem(productId, count) {
    if (this.items.get(productId)) {
      this.items.get(productId).counterUpdate(this.items.get(productId).count + 1);
    } else {
      this.items.set(productId, new CartProduct({productId, count}));
    }
  }


  removeItem(productId) {
    this.items.delete(productId);
  }

  get itemsArray() {
    return values(this.items.toJSON());
  }

  get totalPrice() {
    return this.itemsArray.reduce(
      (prev, item) => prev + item.totalPrice,
      0
    );
  }

  get count() {
    return this.itemsArray.length;
  }
}

export default new Cart();
