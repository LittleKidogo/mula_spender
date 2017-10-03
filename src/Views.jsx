import React from 'react';
import styled, {css} from 'styled-components';

export const App = styled.div`
  display: flex;
  flex-direction: row;
`;
export const CompList = styled.div`
  display: block;
  background: #ff057e;
  margin-right: 1rem;
  padding: 0.5em;
  height: 95vh;
  color: white;
  width: 30%;
`;
export const CompPane = styled.div`
  display: flex;
  flex-direction: column;
  width: 70%;
  background: #32d6da;
  height: 95vh;
  color: white;
  padding: 0.5em;
`;

export const CompSection = styled.section``;

export const CompRow = styled.div`
  display: flex;
  flex-direction: row;
`;

export const CompItem = styled.div`
  background: #4a4a4a;
  width: 30%;
  padding: 0.3em;
  margin: 0.3em;
`;

export const Title = styled.h1`
  font-size: 1.2rem;
  font-weight: bold;
`;

export const List = styled.ul``;

export const ListItem = styled.li`list-style: none;`;
