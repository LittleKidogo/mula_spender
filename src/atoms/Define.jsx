import React, {Component} from 'react'
import styled from 'styled-components'
import {Title, CompRow, CompSection, CompItem} from 'Views'

export class Define extends Component {
  render() {
    const StockDefine = styled.dfn``
    return(
      <CompSection>
        <Title>
          {'The HTML <dfn> element represents the defining instance of a term.'}
        </Title>
        <CompRow>
          <CompItem>
            <p><StockDefine id="def-internet">The Internet</StockDefine> is a global
              system of interconnected networks that use the Internet
              Protocol Suite (TCP/IP) to serve billions of users
              worldwide.</p>
          </CompItem>
        </CompRow>
      </CompSection>
    )
  }
}

export default Define
