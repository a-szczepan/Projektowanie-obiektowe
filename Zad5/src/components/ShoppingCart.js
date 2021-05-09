import React, {Component} from 'react';
import {inject, observer} from 'mobx-react';

@inject('uiStore', 'cartStore')
@observer
class ShoppingCart extends Component {

    renderItem = (item) => (
        <div style={{borderBottom: "1px solid darkgrey", padding: "20px 0"}} key={item.productId}>
            <div style={{display: "flex"}}>
                <span> Cena: {item.totalPrice} PLN</span>
                <div style={{display: "flex"}}>
                    <h3>{item.product.title}</h3>
                </div>
            </div>
            <div>
                <span> Ilość: {item.count}</span>
            </div>
            <button onClick={() => this.props.cartStore.removeItem(item.productId)}>X</button>
        </div>
    );

    render() {
        const {isCartOpen} = this.props.uiStore;
        const {itemsArray, totalPrice} = this.props.cartStore;

        return (
            <div className={`shopping-cart ${isCartOpen ? 'shopping-cart-open' : ''}`}>
                {itemsArray.map(this.renderItem)}
                <div className="cart-total">Podsumowanie: {totalPrice} PLN</div>
            </div>
        );
    }
}

export default ShoppingCart;
