import React,{Component} from 'react'
import styled from 'styled-components'
import {CompSection, CompRow, CompItem, Title} from 'Views'

export class Data extends Component {
  render() {
    const StockData = styled.data``
    return(
      <CompSection>
        <Title>
          {'The HTML <data> element links a given content with a machine-readable translation. If the content is time- or date-related, the <time> element must be used.'}
        </Title>
        <CompRow>
          <CompItem>
            <StockData value="398">Mini Ketchup</StockData>
          </CompItem>
        </CompRow>
      </CompSection>
    )
  }
}

export default Data;
