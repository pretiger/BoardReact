import { useEffect, useState, useRef } from 'react';
import { Button, Form } from 'react-bootstrap';
import { useSelector } from 'react-redux';
import { useHistory, useParams } from 'react-router-dom';

export default function ReplyForm() {
  const { num } = useParams();
  const history = useHistory();
  const user = useSelector((state) => state.login.value);
  const [board, setBoard] = useState();
  const [files, setFiles] = useState([]);
  const inRef = useRef([]);
  let files2 = [];
  const handleChange = (e) => {
    for (let i = 0; i < e.target.files.length; i++) {
      files2[i] = e.target.files[i];
    }
  };
  const originalName = (filename) =>
    filename.substr(filename.lastIndexOf('_') + 1);
  useEffect(() => {
    fetch('http://localhost/api/board/' + num + '/replyForm/', {
      headers: {
        'Content-Type': 'application/json',
        Authorization: 'Bearer ' + user.token,
      },
    })
      .then((res) => res.json())
      .then((data) => {
        console.log('data', data);
        setBoard(data.dto);
        fetch('http://localhost/api/board/attachList/' + num, {
          headers: {
            'Content-Type': 'application/json',
          },
        })
          .then((res) => res.json())
          .then((data) => setFiles(data));
      });
  }, [num]);

  const handleReply = (e) => {
    e.preventDefault();
    const formData = new FormData();
    formData.append('subject', inRef.current[0].value);
    formData.append('content', inRef.current[1].value);
    formData.append('writer', user.username);
    formData.append('subgroup', board.subgroup);
    formData.append('sublevel', board.sublevel);
    formData.append('substep', board.substep);
    files2.map((file) => formData.append('files', file));
    fetch('http://localhost/api/board/reply', {
      method: 'post',
      headers: {
        Authorization: 'Bearer ' + user.token,
      },
      body: formData,
    }).then((res) => {
      if (res.ok) {
        alert('reply success!');
        history.push('/');
      }
    });
  };
  const handleDelete = (filename) => {
    fetch('http://localhost/api/board/deleteFile/?filename=' + filename).then(
      (res) => {
        if (res.ok) {
          fetch('http://localhost/api/board/attachList/' + num, {
            headers: {
              'Content-Type': 'application/json',
            },
          })
            .then((res) => res.json())
            .then((data) => setFiles(data));
        }
      }
    );
  };
  if (board === undefined) return;
  return (
    <Form onSubmit={handleReply}>
      <Form.Group className='mb-3'>
        <Form.Label>Subject</Form.Label>
        <Form.Control
          type='text'
          defaultValue={board.subject}
          ref={(e) => (inRef.current[0] = e)}
        />
      </Form.Group>
      <Form.Group className='mb-3'>
        <Form.Label>Content</Form.Label>
        <Form.Control
          as='textarea'
          rows={5}
          defaultValue={board.content}
          ref={(e) => (inRef.current[1] = e)}
        />
      </Form.Group>
      <Form.Group className='mb-3'>
        <Form.Label>FileAttach</Form.Label>
        <div>
          {files.map((file) => {
            return (
              <span key={file}>
                <span>{originalName(file)}</span>
                <a
                  href='#'
                  style={{ textDecorationLine: 'none' }}
                  onClick={() => handleDelete(file)}
                >
                  [delete]&nbsp;&nbsp;
                </a>
              </span>
            );
          })}
        </div>
        <Form.Control type='file' multiple onChange={handleChange} />
      </Form.Group>
      <Button variant='primary' type='submit'>
        Reply
      </Button>
    </Form>
  );
}
