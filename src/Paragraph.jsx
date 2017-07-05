import React, {Component} from 'react'
import styled from 'styled-components'

export class Paragraph extends Component {
  constructor(props) {
    super(props)
  }
  render() {
    const Par = styled.p``
    const Wrapper = styled.section``
    return(
      <Wrapper>
        <Par>
          This is a block of text in the application
        </Par>
        <Par>
          More Examples
        </Par>
      </Wrapper>
    );
  };
};


export default Paragraph;
