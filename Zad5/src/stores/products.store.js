import { observable } from 'mobx';
import chamaedorea from './img/chamaedorea-elegans.img'
import monstera from './img/monstera-adasonii.img'
import zamioculcas from './img/zamioculcas.img'
import pilea from './img/pilea-peperomioides.jpg'

export class ProductsStore {
  @observable items = {
    '1': {
      id: '1',
      title: 'CHAMAEDOREA ELEGANS',
      image: chamaedorea,
      price: 6
    },
    '2': {
      id: '2',
      title: 'MONSTERA ADASONII',
      image: monstera,
      price: 29
    },
    '3': {
      id: '3',
      title: 'ZAMIOCULCAS',
      image: zamioculcas,
      price: 29
    },
    '4': {
      id: '4',
      title: 'PILEA PEPEROMIOIDES',
      image: pilea,
      price: 30
    }
  }

  getProductById(id) {
    return this.items[id];
  }
}

export default new ProductsStore();
