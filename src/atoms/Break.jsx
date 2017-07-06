import React,{Component} from 'react'
import styled from 'styled-components'
import {Title, CompSection, CompRow, CompItem} from 'Views'
export class Break extends Component {
  render(){
    const StockBreak = styled.br`
      color: yellow;
      height: 2em;
    `
    return(
      <CompSection>
        <Title>
          {'The HTML <br> element produces a line break in text (carriage-return). It is useful for writing a poem or an address, where the division of lines is significant.'}
        </Title>
        <CompRow>
          <CompItem>
            <p>49 Chiappini St. <StockBreak></StockBreak>Cape Town, Western Cape, <StockBreak></StockBreak>South Africa</p>
          </CompItem>
        </CompRow>
      </CompSection>
    )
  }
}

export default Break;
