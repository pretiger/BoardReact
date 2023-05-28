import { createSlice } from '@reduxjs/toolkit';

const initVal = {
  id: 0,
  username: '',
  password: '',
  role: '',
  token: '',
  createDate: '',
};
const loginSlice = createSlice({
  name: 'login',
  initialState: { value: initVal },
  reducers: {
    login: (state, action) => {
      state.value = action.payload;
    },
    logout: (state, action) => {
      state.value = initVal;
    },
  },
});

export { loginSlice };
