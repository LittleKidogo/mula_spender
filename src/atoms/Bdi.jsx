import React,{Component} from 'react'
import styled from 'styled-components'
import {CompRow, CompSection, CompItem, Title} from 'Views'

export class Bdi extends Component {
  render() {
    return(
      <CompSection>
        <Title>
          {'The HTML <bdi> element (bidirectional isolation) isolates a span of text that might be formatted in a different direction from other text outside it.'}
        </Title>
        <CompRow>
          <CompItem >
            <p dir="ltr"> this is the text <bdi> arabic text</bdi></p>
          </CompItem>
        </CompRow>
      </CompSection>
    )
  }
}

export default Bdi
