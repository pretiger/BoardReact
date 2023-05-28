import { configureStore } from '@reduxjs/toolkit';
import { loginSlice } from './userSlice';

const store = configureStore({
  reducer: {
    login: loginSlice.reducer,
  },
});

export { store };
