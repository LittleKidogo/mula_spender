import React, {Component} from 'react'
import styled from 'styled-components'
import {CompSection, CompRow, CompItem, Title} from 'Views'

export class Code extends Component {
  render() {
    const StockCode = styled.code`
      background: black;
      padding: .1em;
    `
    return(
      <CompSection>
        <Title>
          {"The HTML <code> element represents a fragment of computer code. By default, it is displayed in the browser's default monospace font."}
        </Title>
        <CompRow>
          <CompItem>
            <Title>some javascript</Title>
            <StockCode>
              var p = 0;
              <br></br>
              const q = p++;
            </StockCode>
          </CompItem>
        </CompRow>
      </CompSection>
    )
  }
}
export default Code
