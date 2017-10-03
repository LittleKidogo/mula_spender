import React from 'react';
import ReactDOM from 'react-dom';
import {BrowserRouter} from 'react-router-dom';
import Async from 'react-code-splitting';
import {App} from 'Views';
ReactDOM.render(
  <BrowserRouter>
    <App>
      <p> Budget App </p>
    </App>
  </BrowserRouter>,
  document.getElementById('lib'),
);
