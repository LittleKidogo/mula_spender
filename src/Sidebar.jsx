import React, {Component} from 'react'
import {Link} from 'react-router-dom'
import {CompList, Title, List, ListItem} from 'Views'

export class SideBar extends Component{
  render(){
    return(
      <CompList>
        <Title>List of components</Title>
        <List>
          <Link to={'/a'}>
            <ListItem>{'<a>'}</ListItem>
          </Link>
          <Link to={'/p'}>
            <ListItem>{'<p>'}</ListItem>
          </Link>
          <Link to={'/abbr'}>
            <ListItem>{'abbr'}</ListItem>
          </Link>
          <Link to={'/b'}>
            <ListItem>{'b'}</ListItem>
          </Link>
          <Link to={'/bdi'}>
            <ListItem>{'bdi'}</ListItem>
          </Link>
          <Link to={'/br'}>
            <ListItem>{'br'}</ListItem>
          </Link>
          <Link to={'/cite'}>
            <ListItem>{'cite'}</ListItem>
          </Link>
          <Link to={'/code'}>
            <ListItem>{'code'}</ListItem>
          </Link>
          <Link to={'/data'}>
            <ListItem>{'data'}</ListItem>
          </Link>
          <Link to={'/dfn'}>
            <ListItem>{'dfn'}</ListItem>
          </Link>
        </List>
      </CompList>
    )
  }
}
export default SideBar
