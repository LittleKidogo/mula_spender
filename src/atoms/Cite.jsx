import React, {Component} from 'react'
import styled from 'styled-components'
import {Title, CompRow, CompItem, CompSection} from 'Views'

export class Cite extends Component {
  render() {
    const StockCite = styled.cite``
    return(
      <CompSection>
        <Title>
          {'The HTML <cite> element represents a reference to a creative work. It must include the title of a work or a URL reference, which may be in an abbreviated form according to the conventions used for the addition of citation metadata.'}
        </Title>
        <CompSection>
          <CompRow>
            <CompItem>
              <p>More information about this can be found at <StockCite>[https://zacck.com]</StockCite></p>
            </CompItem>
          </CompRow>
        </CompSection>
      </CompSection>
    )
  }
}

export default Cite;
