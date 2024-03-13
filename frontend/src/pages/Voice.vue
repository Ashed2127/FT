<template>
    <div class="container mt-5">
      <div class="row justify-content-center">
        <div class="col-md-6">
          <h2>Chapa Payment</h2>
          <form @submit.prevent="submitPayment" class="form-group">
            <div class="mb-3">
              <label for="amount" class="form-label">Amount:</label>
              <input
                type="number"
                id="amount"
                v-model="amount"
                class="form-control"
                required
              />
            </div>
            <div class="mb-3">
              <label for="currency" class="form-label">Currency:</label>
              <select id="currency" v-model="currency" class="form-control" required>
                <option value="ETB">ETB</option>
                </select>
            </div>
            <div class="mb-3">
              <label for="email" class="form-label">Email (Optional):</label>
              <input
                type="email"
                id="email"
                v-model="email"
                class="form-control"
              />
            </div>
            <button type="submit" class="btn btn-primary">Pay with Chapa</button>
          </form>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import axios from 'axios';
  // import router from '../router';
  // import VueBasicAlert from '../vue-basic-alert';
  
  // import axios from 'axios';

export default {
  data() {
    return {
      amount: '',
      currency: '',
      email: '',
    };
  },
  methods: {
    async submitPayment() {
      try {
        const response =  {
          amount: this.amount,
          currency: this.currency,
          email: this.email,
        };
        await axios.post('/payment/',  response);
      } catch (error) {
        console.error('Error initiating payment:', error);
      }
    },
  },
};
  
  </script>
  
  <style scoped>
  /* Add additional styling if needed (optional) */
  </style>
  