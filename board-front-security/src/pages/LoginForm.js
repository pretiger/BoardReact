import { useEffect, useRef } from 'react';
import { Button, Form } from 'react-bootstrap';
import { useDispatch, useSelector } from 'react-redux';
import { loginSlice } from '../login/userSlice';
import { useHistory } from 'react-router-dom';

export default function LoginForm() {
  const formRef = useRef([]);
  const dispatch = useDispatch();
  const history = useHistory();
  const user = useSelector((state) => state.login.value);
  useEffect(() => {
    formRef.current[0].focus();
  }, []);
  const login = (e) => {
    e.preventDefault();
    fetch('http://localhost/auth/login', {
      method: 'post',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        username: formRef.current[0].value,
        password: formRef.current[1].value,
      }),
    })
      .then((res) => res.json())
      .then((data) => {
        if (data.id !== 0) {
          dispatch(loginSlice.actions.login(data));
          history.push('/');
        } else {
          alert('username or password mismatch');
        }
      });
  };
  console.log('user', user);
  return (
    <Form onSubmit={login}>
      <Form.Group className='mb-3'>
        <Form.Label>Username</Form.Label>
        <Form.Control type='text' ref={(e) => (formRef.current[0] = e)} />
      </Form.Group>

      <Form.Group className='mb-3'>
        <Form.Label>Password</Form.Label>
        <Form.Control type='password' ref={(e) => (formRef.current[1] = e)} />
      </Form.Group>
      <Button variant='primary' type='submit'>
        Login
      </Button>
    </Form>
  );
}
