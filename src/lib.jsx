import React from 'react'
import ReactDOM from 'react-dom'
import { BrowserRouter} from 'react-router-dom'
import Async from 'react-code-splitting'
const SideBar = () => <Async load={import('SideBar')}/>
const Content = () => <Async load={import('Content')}/>
import {App} from 'Views'
ReactDOM.render((
  <BrowserRouter>
    <App>
      <SideBar/>
      <Content/>
    </App>
  </BrowserRouter>
  ),document.getElementById('lib')
);
