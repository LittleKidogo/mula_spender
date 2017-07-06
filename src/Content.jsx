import React, {Component} from 'react'
import {Title, CompPane, CompRow} from 'Views'
import Async from 'react-code-splitting'

import {Route} from 'react-router-dom'
const Anchor = () => <Async load={import('Anchor')} />
const Abbr = () => <Async load={import('Abbr')} />
const Bold = () => <Async load={import('Bold')} />
const Bdi = () => <Async load={import('Bdi')} />
const Break = () => <Async load={import('Break')} />
const Cite = () => <Async load={import('Cite')} />
const Code = () => <Async load={import('Code')} />
const Data = () => <Async load={import('Data')} />
const Define = () => <Async load={import('Define')} />
const Paragraph = () => <Async load={import('Paragraph')}/>
export class Content extends  Component {
  render() {
    return(
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
            <Route exact={true} path="/data" component={Data}/>
            <Route exact={true} path="/dfn" component={Define}/>
        </CompRow>
      </CompPane>
    )
  }
}

export default Content
