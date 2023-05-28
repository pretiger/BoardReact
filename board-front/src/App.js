import Header from './layout/Header';
import BoardForm from './pages/BoardForm';
import Footer from './layout/Footer';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import LoginForm from './pages/LoginForm';
import { Provider } from 'react-redux';
import { store } from './login/store';
import JoinForm from './pages/JoinForm';
import BoardDetailForm from './pages/BoardDetailForm';
import EmptyForm from './pages/EmptyForm';
import UpdateForm from './pages/UpdateForm';
import WriteForm from './pages/WriteForm';
import ReplyForm from './pages/ReplyForm';

export default function App() {
  return (
    <>
      <BrowserRouter>
        <Provider store={store}>
          <Header />
          <Switch>
            <Route path='/' exact component={BoardForm} />
            <Route path='/login' component={LoginForm} />
            <Route path='/join' component={JoinForm} />
            <Route path='/detail/:num' component={BoardDetailForm} />
            <Route path='/boardUpdate/:num' component={UpdateForm} />
            <Route path='/boardReply/:num' component={ReplyForm} />
            <Route path='/boardInsert' component={WriteForm} />
            <Route component={EmptyForm} />
          </Switch>
          <Footer />
        </Provider>
      </BrowserRouter>
    </>
  );
}
