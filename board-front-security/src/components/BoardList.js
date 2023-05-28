import dayjs from 'dayjs';
import { Link } from 'react-router-dom';

export default function BoardList({ board }) {
  const userFor = (num) => {
    const result = [];
    for (let i = 0; i < num; ++i) {
      result.push(<span key={i}>&nbsp;&nbsp;</span>);
    }
    return result;
  };
  return (
    <tr>
      <td>{board.num}</td>
      <td>{board.writer}</td>
      <td>
        {board.sublevel > 0 ? userFor(board.sublevel) : ''}
        <Link to={`/detail/${board.num}`}>{board.subject}</Link>
        {board.count > 0 && (
          <span style={{ color: 'red' }}>[{board.count}]</span>
        )}
      </td>
      <td>{board.count}</td>
      <td>{dayjs(board.regdate).format('YYYY-MM-DD HH:mm:ss')}</td>
    </tr>
  );
}
