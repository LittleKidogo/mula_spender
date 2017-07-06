import React from 'react'
import ReactDOM from 'react-dom'
import { BrowserRouter, Link, Route} from 'react-router-dom'
import styled from 'styled-components'
import Anchor from 'Anchor'
import Abbr from 'Abbr'
import Bold from 'Bold'
import Bdi from 'Bdi'
import Break from 'Break'
import Cite from 'Cite'
import Code from 'Code'
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
          <Link to={'/b'}>
            <ListItem>{'b'}</ListItem>
          </Link>
          <Link to={'/bdi'}>
            <ListItem>{'bdi'}</ListItem>
          </Link>
          <Link to={'/br'}>
            <ListItem>{'br'}</ListItem>
          </Link>
          <Link to={'/cite'}>
            <ListItem>{'cite'}</ListItem>
          </Link>
          <Link to={'/code'}>
            <ListItem>{'code'}</ListItem>
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
            <Route exact={true} path="/b" component={Bold}/>
            <Route exact={true} path="/bdi" component={Bdi}/>
            <Route exact={true} path="/br" component={Break}/>
            <Route exact={true} path="/cite" component={Cite}/>
            <Route exact={true} path="/code" component={Code}/>
        </CompRow>
      </CompPane>
    </App>
  </BrowserRouter>
  ),document.getElementById('lib')
);
