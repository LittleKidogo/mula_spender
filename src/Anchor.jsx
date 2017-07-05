import styled from 'styled-components'
import React, {Component} from 'react'
import Paragraph from 'Paragraph'

export class Anchor extends Component {
  render() {
    const Wrapper = styled.section``
    const Description = styled.p``
    const Anchor = styled.a``
    return(
      <Wrapper>
        <Description>
          {'The HTML <a> element (or anchor element) creates a hyperlink to other web pages, files, locations within the same page, email addresses, or any other URL.'}
        </Description>
        <Anchor href="https://google.com">Google</Anchor>
        <Description>
          More Examples
        </Description>
      </Wrapper>
    )
  }
}

export default Anchor;
