import React,{Component} from 'react'
import styled from 'styled-components'
import {CompSection, CompRow, CompItem, Title} from 'Views'

export class Bold extends Component {
  render(){
    const StockBold = styled.b``
    return(
      <CompSection>
        <Title>
          {'The HTML <b> element represents a span of text stylistically different from normal text, without conveying any special importance or relevance, and that is typically rendered in boldface.'}
        </Title>
        <CompRow>
          <CompItem>
            <StockBold>{'Boldface Text'}</StockBold>
          </CompItem>
        </CompRow>
      </CompSection>
    )
  }
}

export default Bold
