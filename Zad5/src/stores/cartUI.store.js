import { observable } from 'mobx';
import productsStore from './products.store';

export class UI {
  @observable isCartOpen = false;

  openCart() {
    this.isCartOpen = true
  }

  toggleCart() {
    this.isCartOpen = !this.isCartOpen;
  }

  get items() {
    return Object.keys(productsStore.items)
      .map((productId) => productsStore.getProductById(productId));
  }
}

export default new UI();
