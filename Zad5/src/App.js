import React, { Component } from 'react';
import { Provider } from 'mobx-react';
import ShoppingCartBtn from './components/ShoppingCartBtn';
import ProductsList from './components/ProductsList';
import ShoppingCart from './components/ShoppingCart';
import uiStore from './stores/cartUI.store';
import cartStore from './stores/cart.store';
import productsStore from './stores/products.store';
import './App.css';

class App extends Component {
  render() {
    return (
      <Provider { ...{ uiStore, cartStore, productsStore } }>
        <div className="App">
          <div style={{padding: "50px", backgroundColor:"black"}}>
            <ShoppingCartBtn/>
          </div>
          <div className="main-page">
            <ProductsList/>
            <ShoppingCart/>
          </div>
        </div>
      </Provider>
    );
  }
}

export default App;
