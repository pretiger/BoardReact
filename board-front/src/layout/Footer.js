import { Container, Nav, Navbar } from 'react-bootstrap';

export default function Footer() {
  return (
    <div style={{ backgroundColor: 'lightgray' }}>
      <Container>
        <Nav>
          <Navbar.Brand>Created by Tiger</Navbar.Brand>
        </Nav>
        <Nav>
          <Navbar.Brand>📞010-8888-9999</Navbar.Brand>
        </Nav>
        <Nav>
          <Navbar.Brand>
            🏳‍🌈Junggon-dong, Kwangjin-gu, Seoul, Korea
          </Navbar.Brand>
        </Nav>
      </Container>
    </div>
  );
}
