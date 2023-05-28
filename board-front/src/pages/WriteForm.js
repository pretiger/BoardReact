import { useRef } from 'react';
import { Button, Form } from 'react-bootstrap';
import { useSelector } from 'react-redux';
import { useHistory } from 'react-router-dom';

export default function WriteForm() {
  const history = useHistory();
  const inRef = useRef([]);
  const user = useSelector((state) => state.login.value);
  let files = [];
  const handleChange = (e) => {
    for (let i = 0; i < e.target.files.length; i++) {
      files[i] = e.target.files[i];
    }
  };
  const handleInsert = (e) => {
    e.preventDefault();
    const formData = new FormData();
    formData.append('subject', inRef.current[0].value);
    formData.append('content', inRef.current[1].value);
    formData.append('writer', user.username);
    files.map((file) => formData.append('files', file));

    fetch('http://localhost/api/board/insert', {
      method: 'post',
      headers: {
        // Authorization: 'Bearer ' + user.token,
      },
      body: formData,
    }).then((res) => {
      if (res.ok) {
        alert('insert success!');
        history.push('/');
      }
    });
  };
  return (
    <Form onSubmit={handleInsert}>
      <Form.Group className='mb-3'>
        <Form.Label>Subject</Form.Label>
        <Form.Control type='text' ref={(e) => (inRef.current[0] = e)} />
      </Form.Group>
      <Form.Group className='mb-3'>
        <Form.Label>Content</Form.Label>
        <Form.Control
          as='textarea'
          rows={5}
          ref={(e) => (inRef.current[1] = e)}
        />
      </Form.Group>
      <Form.Group className='mb-3'>
        <Form.Label>File Attatch</Form.Label>
        <Form.Control type='file' multiple onChange={handleChange} />
      </Form.Group>
      <Button variant='primary' type='submit'>
        Save
      </Button>
    </Form>
  );
}
