import { useEffect, useRef } from 'react';
import { Button, Form } from 'react-bootstrap';
import { useDispatch } from 'react-redux';
import { useHistory } from 'react-router-dom';
import { loginSlice } from '../login/userSlice';

export default function JoinForm() {
  const formRef = useRef([]);
  const history = useHistory();
  const dispatch = useDispatch();
  useEffect(() => {
    formRef.current[0].focus();
  }, []);
  const save = (e) => {
    e.preventDefault();
    console.log(0, formRef.current[0].value);
    console.log(1, formRef.current[1].value);
    console.log(2, formRef.current[2].value);
    console.log(3, formRef.current[3].value);
    fetch('http://localhost/auth/insert', {
      method: 'post',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        username: formRef.current[0].value,
        password: formRef.current[1].value,
        email: formRef.current[2].value,
        role: formRef.current[3].value,
      }),
    }).then((res) => {
      if (res.ok) {
        dispatch(
          loginSlice.actions.login({
            username: formRef.current[0].value,
            password: formRef.current[1].value,
            email: formRef.current[1].value,
            role: formRef.current[2].value,
          })
        );
        history.push('/');
      } else {
        alert('username or password create fail');
      }
    });
  };
  return (
    <>
      <Form onSubmit={save}>
        <Form.Group className='mb-3'>
          <Form.Label>Username</Form.Label>
          <Form.Control type='text' ref={(e) => (formRef.current[0] = e)} />
        </Form.Group>
        <Form.Group className='mb-3'>
          <Form.Label>Password</Form.Label>
          <Form.Control type='password' ref={(e) => (formRef.current[1] = e)} />
        </Form.Group>
        <Form.Group className='mb-3'>
          <Form.Label>Email</Form.Label>
          <Form.Control type='email' ref={(e) => (formRef.current[2] = e)} />
        </Form.Group>
        <Form.Group className='mb-3'>
          <Form.Label>Role</Form.Label>
          <Form.Select ref={(e) => (formRef.current[3] = e)}>
            <option value='ROLE_USER'>ROLE_USER</option>
            <option value='ROLE_ADMIN'>ROLE_ADMIN</option>
            <option value='ROLE_GUEST'>ROLE_GUEST</option>
          </Form.Select>
        </Form.Group>
        <Button variant='primary' type='submit'>
          Save
        </Button>
      </Form>
    </>
  );
}
