import React, {Component} from 'react'
import styled, {css} from 'styled-components'

export class Paragraph extends Component {
  constructor(props) {
    super(props)
  }
  render() {
    const Par = styled.p`
      ${props => props.title && css `
          font-weight: bold;
          text-align: center;
        `}
    `
    const Wrapper = styled.section`
      display: flex;
      flex-direction: column;
      ${props => props.horizontal && css `
          flex-direction: row;
        `}
    `
    return(
      <Wrapper>
        <Par>
          This is a block of text in the application
        </Par>
        <Par>
          More Examples
        </Par>
        <Wrapper horizontal>
          <Par>
            Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
          </Par>
        </Wrapper>
      </Wrapper>
    );
  };
};


export default Paragraph;
