import styled from 'styled-components'
import React, {Component} from 'react'
import Paragraph from 'Paragraph'
import {Title, CompItem, CompRow, CompSection} from 'Views'

export class Anchor extends Component {
  render() {
    const Anchor = styled.a``
    return(
      <CompSection>
        <Title>
          {'The HTML <a> element (or anchor element) creates a hyperlink to other web pages, files, locations within the same page, email addresses, or any other URL.'}
        </Title>
        <CompSection>
          <CompRow>
            <CompItem>
              <Anchor href="https://google.com">Google</Anchor>
            </CompItem>
            <CompItem >
              <Anchor href="https://github.com/zacck"> Zacck's Github</Anchor>
            </CompItem>
          </CompRow>
        </CompSection>
      </CompSection>
    )
  }
}

export default Anchor;
