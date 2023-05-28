import { useEffect, useRef, useState } from 'react';
import { Button, Card, Form, InputGroup, Table } from 'react-bootstrap';
import { useSelector } from 'react-redux';
import { Link, useHistory, useParams } from 'react-router-dom';
import '../App.css';

export default function BoardDetailForm() {
  const history = useHistory();
  const { num } = useParams();
  const [board, setBoard] = useState({});
  const [files, setFiles] = useState([]);
  const [replys, setReplys] = useState([]);
  const inputRef = useRef(null);
  const user = useSelector((state) => state.login.value);
  const originalName = (filename) =>
    filename.substr(filename.lastIndexOf('_') + 1);
  useEffect(() => {
    fetch('http://localhost/api/detailForm/' + num, {
      headers: {
        'Content-Type': 'application/json',
        Authorization: 'Bearer ' + user.token,
      },
    })
      .then((res) => {
        if (res.status === 401) {
          history.push('/error');
        }
        return res.json();
      })
      .then((data) => {
        setBoard(data);
        fetch('http://localhost/api/board/attachList/' + num, {
          headers: {
            'Content-Type': 'application/json',
            Authorization: 'Bearer ' + user.token,
          },
        })
          .then((res) => res.json())
          .then((data) => setFiles(data));
      });
    fetch('http://localhost/api/commentList/' + num, {
      headers: {
        'Content-Type': 'application/json',
        Authorization: 'Bearer ' + user.token,
      },
    })
      .then((res) => res.json())
      .then((data) => setReplys(data));
  }, [num]);

  const commentAdd = () => {
    fetch('http://localhost/api/board/comment', {
      method: 'post',
      headers: {
        'Content-Type': 'application/json',
        Authorization: 'Bearer ' + user.token,
      },
      body: JSON.stringify({
        bnum: board.num,
        replytext: inputRef.current.value,
        replyer: user.username,
      }),
    }).then((res) => {
      if (res.ok) {
        inputRef.current.value = '';
        fetch('http://localhost/api/commentList/' + num, {
          headers: {
            'Content-Type': 'application/json',
            Authorization: 'Bearer ' + user.token,
          },
        })
          .then((res) => res.json())
          .then((data) => {
            setReplys(data);
          });
      }
    });
  };
  const replyDel = (reply) => {
    fetch('http://localhost/api/deleteComment/' + reply.rnum, {
      method: 'delete',
      headers: {
        'Content-Type': 'application/json',
        Authorization: 'Bearer ' + user.token,
      },
    }).then((res) => {
      if (res.ok) {
        fetch('http://localhost/api/commentList/' + num, {
          headers: {
            'Content-Type': 'application/json',
            Authorization: 'Bearer ' + user.token,
          },
        })
          .then((res) => res.json())
          .then((data) => setReplys(data));
      }
    });
  };
  const download = (filename) => {
    fetch('http://localhost/api/board/downloadFile/?filename=' + filename, {
      headers: {
        'Content-Type': 'application/json',
        Authorization: 'Bearer ' + user.token,
      },
    })
      .then((res) => res.blob())
      .then((data) => {
        let a = document.createElement('a');
        a.href = window.URL.createObjectURL(data);
        a.download = originalName(filename);
        a.click();
      });
  };
  const boardDel = () => {
    if (window.confirm('삭제하시겠습니까?')) {
      fetch('http://localhost/api/board/delete/', {
        method: 'delete',
        headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer ' + user.token,
        },
        Authorization: 'Bearer ' + user.token,
        body: JSON.stringify({
          num: board.num,
          count: board.count,
        }),
      }).then((res) => {
        if (res.ok) {
          alert('삭제완료');
          history.push('/');
        }
      });
    }
  };

  return (
    <>
      <Card>
        <Card.Body>
          <Button className='btn btn-dark' onClick={() => history.go(-1)}>
            Back
          </Button>
          {user.username === board.writer && (
            <>
              <Link className='btn btn-primary' to={`/boardUpdate/${num}`}>
                Upate
              </Link>
              <Button className='btn btn-danger' onClick={boardDel}>
                Delete
              </Button>
            </>
          )}
          {user.id !== 0 && (
            <Link className='btn btn-success' to={`/boardReply/${num}`}>
              Reply
            </Link>
          )}
          <Table striped bordered hover>
            <thead>
              <tr>
                <th width='10%'>Number</th>
                <td width='40%'>{board.num}</td>
                <th width='10%'>Writer</th>
                <td width='40%'>{board.writer}</td>
              </tr>
            </thead>
            <tbody>
              <tr>
                <th>Subject</th>
                <td colSpan='3'>{board.subject}</td>
              </tr>
              <tr>
                <th>Content</th>
                <td colSpan='3'>
                  <Form.Control
                    as='textarea'
                    style={{ height: '150px' }}
                    value={board.content}
                    readOnly
                  />
                </td>
              </tr>
              <tr>
                <th>AttachFile</th>
                <td colSpan='3'>
                  {files.map((file) => {
                    return (
                      <a
                        key={file}
                        href='#'
                        style={{ textDecorationLine: 'none' }}
                        onClick={() => download(file)}
                      >
                        {originalName(file)}&nbsp;&nbsp;
                      </a>
                    );
                  })}
                </td>
              </tr>
            </tbody>
          </Table>
        </Card.Body>
      </Card>
      {user.username !== '' && (
        <InputGroup className='mb-3'>
          <Form.Control
            placeholder='Could you write a comment!'
            ref={inputRef}
          />
          <Button variant='secondary' onClick={commentAdd}>
            Save
          </Button>
        </InputGroup>
      )}
      <ul>
        {replys.map((reply) => (
          <li key={reply.rnum}>
            <span>{reply.replytext} &nbsp;&nbsp;&nbsp;&nbsp;</span>
            <span>
              writer:{reply.replyer}&nbsp;&nbsp;
              {user.username === reply.replyer && (
                <Button
                  variant='outline-danger'
                  size='sm'
                  onClick={() => replyDel(reply)}
                >
                  Delete
                </Button>
              )}
            </span>
          </li>
        ))}
      </ul>
    </>
  );
}
