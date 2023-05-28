import { Pagination, Table } from 'react-bootstrap';
import BoardList from '../components/BoardList';
import { useEffect, useState } from 'react';

export default function BoardForm() {
  const [boards, setBoards] = useState([]);
  const [page, setPage] = useState([]);
  const list = (num) => {
    fetch('http://localhost/?curPage=' + num)
      .then((res) => res.json())
      .then((data) => {
        setBoards(data.dto);
        setPage(data.page);
      });
  };
  useEffect(() => {
    list(1);
  }, []);
  const arrLoop = () => {
    const newArr = [];
    for (let i = page.blockStart; i <= page.blockEnd; i++) {
      newArr.push(
        <Pagination.Item
          key={i}
          onClick={() => {
            list(i);
          }}
        >
          {i}
        </Pagination.Item>
      );
    }
    return newArr;
  };

  return (
    <>
      <h3>Board List</h3>
      <Table striped bordered hover>
        <thead>
          <tr>
            <th>No</th>
            <th>Writer</th>
            <th>Title</th>
            <th>Viewcount</th>
            <th>Date</th>
          </tr>
        </thead>
        <tbody>
          {boards.map((board) => (
            <BoardList board={board} key={board.num} />
          ))}
        </tbody>
      </Table>
      <Pagination>
        {1 < page.curPage && (
          <Pagination.First
            onClick={() => {
              list(1);
            }}
          />
        )}
        {1 < page.curBlock && (
          <Pagination.Prev
            onClick={() => {
              list(page.prePage);
            }}
          />
        )}
        {arrLoop()}
        {page.curBlock < page.totalBlock && (
          <Pagination.Next
            onClick={() => {
              list(page.nextPage);
            }}
          />
        )}
        {page.curPage < page.totalPage && (
          <Pagination.Last
            onClick={() => {
              list(page.totalPage);
            }}
          />
        )}
      </Pagination>
    </>
  );
}
