import { Link } from 'react-router-dom';

export default function EmptyForm() {
  return (
    <>
      <h2>잘못된 경로 입니다.</h2>
      <Link to='/'>Main Page</Link>
    </>
  );
}
