import React from 'react'
import ReactDOM from 'react-dom'
import { BrowserRouter } from 'react-router-dom'
import styled from 'styled-components'

const App = styled.div`
  display: flex;
  flex-direction: row;
`
const CompList = styled.div`
  display: block;
  background: blue;
  margin-right: 1rem;
  padding: .5em;
  color: papayawhip;
  width: 30%;
`
const CompPane=  styled.div`
  display: block;
  background: palevioletred;
  width: 70%;
  padding: .5em;
`

const Title = styled.h1`
  font-size: 1.2rem;
  font-weight: bold;
`


ReactDOM.render((
  <BrowserRouter>
    <App>
      <CompList>
        <Title>List of components</Title>
      </CompList>
      <CompPane>
        <Title>Selected Component & Code</Title>
      </CompPane>
    </App>
  </BrowserRouter>
  ),document.getElementById('lib')
);
