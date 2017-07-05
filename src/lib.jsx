import React from 'react'
import ReactDOM from 'react-dom'
import { BrowserRouter, Link, Route} from 'react-router-dom'
import styled from 'styled-components'
import Anchor from 'Anchor'
import Paragraph from 'Paragraph'

const App = styled.div`
  display: flex;
  flex-direction: row;
`
const CompList = styled.div`
  display: block;
  margin-right: 1rem;
  padding: .5em;
  color: papayawhip;
  width: 30%;
`
const CompPane =  styled.div`
  display: block;
]  width: 70%;
  padding: .5em;
`

const CompItem = styled.div`
  background: white;
`

const Title = styled.h1`
  font-size: 1.2rem;
  font-weight: bold;
`

const List = styled.ul``

const ListItem = styled.li`
  list-style: none;
`



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
        </List>
      </CompList>
      <CompPane>
        <Title>Selected Component & Code</Title>
        <CompItem>
          <Route exact={true} path="/a" component={Anchor}/>
          <Route exact={true} path="/p" component={Paragraph}/>
        </CompItem>
      </CompPane>
    </App>
  </BrowserRouter>
  ),document.getElementById('lib')
);
