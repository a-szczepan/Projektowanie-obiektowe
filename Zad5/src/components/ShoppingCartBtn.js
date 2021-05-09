import React, { Component } from 'react';
import { inject, observer } from 'mobx-react';
import cart from '../shopping-cart.png'

@inject('uiStore')
@observer
class ShoppingCartBtn extends Component {
  handleClick = () => this.props.uiStore.toggleCart();
  render() {
    return (
      <div className="shopping-bag" onClick={ this.handleClick }>
        <img style={{width:"40px", filter:"invert(100%)"}} src={cart} alt="cart"/>
      </div>
    );
  }
}
export default ShoppingCartBtn;
