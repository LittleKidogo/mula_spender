import React from 'react'
import ReactDOM from 'react-dom'
import { BrowserRouter, Link, Route} from 'react-router-dom'
import styled from 'styled-components'
import Anchor from 'Anchor'
import Abbr from 'Abbr'
import {App, CompList, Title, List, ListItem, CompPane, CompRow} from 'Views'
import Paragraph from 'Paragraph'
ReactDOM.render((
  <BrowserRouter>
    <App>
      <CompList>
        <Title>List of components</Title>
        <List>
          <Link to={'/a'}>
            <ListItem>{'<a>'}</ListItem>
          </Link>
          <Link to={'/p'}>
            <ListItem>{'<p>'}</ListItem>
          </Link>
          <Link to={'/abbr'}>
            <ListItem>{'abbr'}</ListItem>
          </Link>
        </List>
      </CompList>
      <CompPane>
        <CompRow>
          <Title>Selected Component</Title>
        </CompRow>
        <CompRow>
            <Route exact={true} path="/a" component={Anchor}/>
            <Route exact={true} path="/p" component={Paragraph}/>
            <Route exact={true} path="/abbr" component={Abbr}/>
        </CompRow>
      </CompPane>
    </App>
  </BrowserRouter>
  ),document.getElementById('lib')
);
