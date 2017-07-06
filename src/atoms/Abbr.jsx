import React, {Component} from 'react'
import styled from 'styled-components'
import {Title, CompItem, CompRow, CompSection} from 'Views'

export class Abbr extends Component {
  render() {
    const StockAbbr = styled.abbr``
    return(
      <CompSection>
        <Title>
          {'The HTML <abbr> element represents an abbreviation and optionally provides a full description for it. If present, the title attribute must contain this full description and nothing else'}
        </Title>
        <CompSection>
          <CompRow>
            <CompItem>
              <StockAbbr title="Internationalization">I18N</StockAbbr>
            </CompItem>
          </CompRow>
        </CompSection>
      </CompSection>
    )
  }
}

export default Abbr;
