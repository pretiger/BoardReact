import { Button, Container, Nav, Navbar } from 'react-bootstrap';
import { useDispatch, useSelector } from 'react-redux';
import { Link, useHistory } from 'react-router-dom';
import { loginSlice } from '../login/userSlice';

export default function Header() {
  const history = useHistory();
  const dispatch = useDispatch();
  const user = useSelector((state) => state.login.value);
  return (
    <Navbar bg='dark' variant='dark'>
      <Container>
        <Link className='navbar-brand' to='/'>
          Tiger
        </Link>
        <Nav className='me-auto'>
          <Link className='nav-link' to='/login'>
            Login
          </Link>
          <Link className='nav-link' to='/join'>
            Join
          </Link>
          {user.id !== 0 && (
            <>
              <Link className='nav-link' to='/boardInsert'>
                Writing
              </Link>
              <Button
                size='sm'
                variant='outline-danger'
                onClick={() => {
                  dispatch(loginSlice.actions.logout());
                  history.push('/');
                }}
              >
                Logout
              </Button>
              <span className='nav-link' style={{ color: 'white' }}>
                {user.username} logging
              </span>
            </>
          )}
        </Nav>
      </Container>
    </Navbar>
  );
}
