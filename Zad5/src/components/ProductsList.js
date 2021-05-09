import React, { Component } from 'react';
import { inject, observer } from 'mobx-react';

@inject('uiStore', 'cartStore')
@observer
class ProductsList extends Component {

  addToCart = (productId) => {
    this.props.cartStore.addItem(productId, 1)
    this.props.uiStore.openCart();
  }

  renderProduct = (product) => {
    return (
      <div className="product" key={ product.id }>
        <div>
          <h1 style={{color: "#03191E"}}>{ product.title }</h1>
          <img src={ product.image } width={ 200 } alt={ product.title }/>
        </div>
        <button onClick={ () => this.addToCart(product.id) }>Dodaj do koszyka: { product.price } PLN</button>
      </div>
    )
  }

  render() {
    return (
      <div style={{flexGrow:"1", display: "flex", flexDirection : "column"}}>
        <div>
          { this.props.uiStore.items.map(this.renderProduct) }
        </div>
      </div>
    );
  }
}

export default ProductsList;
