import { Link } from 'react-router-dom';

export default function EmptyForm() {
  return (
    <>
      <h2>로그인후 다시 시도하세요.</h2>
      <Link to='/'>Main Page</Link>
    </>
  );
}
