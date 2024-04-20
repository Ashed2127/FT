<template>
  <div class="row r">
    <router-link
      @click="scrollToTop()"
      to="/admin/dashboard"
      class="btn b-r r col-3"
      >Dashboard</router-link
    ><router-link
      @click="scrollToTop()"
      to="/dpRegister"
      class="btn b-r r col-3"
      >add Dp</router-link
    ><router-link
      @click="scrollToTop()"
      to="/dpRegister"
      class="btn b-r r col-3"
      >remove dp</router-link
    >
    <button class="btn b-r r col" @click="handleLogout()">Logout</button>
  </div>
  <div class="register-container">
    <div class="register-form-container">
      <form
        id="registerForm"
        @submit="handleSubmit"
        novalidate
        autocomplete="off"
      >
        <!-- <router-link
          @click="scrollToTop()"
          to="admin/dashboard"
          class="btn b-r col-6 col-md-12 col-sm-12"
          >back to dashboard</router-link -->
        >
        <h3>update price & discount</h3>

        <div class="form-group">
          <input
            type="foodName"
            name="afoodName"
            placeholder="enter food name"
            id="afoodName"
            class="form-control"
            :value="registerObj.foodName"
          />
          <p class="error-mess" v-if="errorObj.foodNameErr.length > 0">
            {{ errorObj.foodNameErr[0] }}
          </p>
        </div>

        <div class="form-group">
          <input
            type="foodPrice"
            name="aPass"
            placeholder="update food price"
            id="aPass"
            class="form-control"
            :value="registerObj.foodPrice"
          />
          <p class="error-mess" v-if="errorObj.foodPriceErr.length > 0">
            {{ errorObj.foodPriceErr[0] }}
          </p>
        </div>

        <div class="form-group">
          <input
            type="foodPrice"
            name="aPassfoodDiscount"
            placeholder="update food discount"
            id="aPassfoodDiscount"
            class="form-control"
            :value="registerObj.foodDiscount"
          />
          <p class="error-mess" v-if="errorObj.foodDiscountErr.length > 0">
            {{ errorObj.foodDiscountErr[0] }}
          </p>
        </div>

        <div class="form-group">
          <input type="submit" value="update" class="btn" />
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "UpdateAmount",

  data() {
    return {
      registerObj: { foodName: "", foodPrice: "", foodDiscount: "" },
      errorObj: { foodNameErr: [], foodPriceErr: [], foodDiscountErr: [] },
      matchUser: undefined,
      foodData: [],
    };
  },

  methods: {
    scrollToTop() {
      window.scrollTo(0, 0);
    },

    resetCheckErr: function () {
      this.errorObj.foodNameErr = [];
      this.errorObj.foodPriceErr = [];
      this.errorObj.foodDiscountErr = [];
    },

    checkEmptyErr: function () {
      for (var typeErr in this.errorObj) {
        if (this.errorObj[typeErr].length != 0) {
          return false;
        }
      }
      return true;
    },

    checkForm: function () {
      this.resetCheckErr();

      // foodName validate
      if (!this.registerObj.foodName) {
        this.errorObj.foodNameErr.push("Food name is required");
      } else if (!/^[a-zA-Z]+$/.test(this.registerObj.foodName)) {
        this.errorObj.foodNameErr.push("Food name must contain only letters");
      } else {
        // Clear the error message if the value is valid
        this.errorObj.foodNameErr = [];
      }

      // Pass validate
      if (!this.registerObj.foodPrice) {
        this.errorObj.foodPriceErr.push("Food price is required");
      } else {
        if (!/^\d+$/.test(this.registerObj.foodPrice)) {
          this.errorObj.foodPriceErr.push(
            "Food price must contain only numbers"
          );
        }
      }

      // foodDiscount Pass validate
      if (!this.registerObj.foodDiscount) {
        this.errorObj.foodDiscountErr.push("Food discount is required");
      } else {
        if (!/^\d+$/.test(this.registerObj.foodDiscount)) {
          this.errorObj.foodDiscountErr.push(
            "Food discount must contain only numbers"
          );
        }
      }
    },

    async handleSubmit(e) {
      this.checkForm();
      if (!this.checkEmptyErr()) {
        e.preventDefault();
      } else {
        e.preventDefault();
        // let user_data = await axios.get('/user/' + data.book_phone);
        // console.log(user_data[1].user_id);
        this.resetCheckErr();
        // console.log(data.book_phone);
        let foodData = {
          food_price: this.registerObj.foodPrice,
          food_name: this.registerObj.foodName,
          food_desc: this.registerObj.foodDiscount,
        };
        await axios.post("/foodname/", foodData);
        //   this.matchUser = data.data;
        console.log("food data ", this.foodData);
      }
    },
  },
};
</script>

<style scoped>
.register-container {
  padding: 15rem 9%;
}

.register-container .register-form-container {
  background: #fff;
}

.register-container .register-form-container form {
  position: relative;
  left: 50%;
  transform: translate(-50%, 0%);
  max-width: 50rem;
  width: 100%;
  box-shadow: 0 1rem 1rem rgba(0, 0, 0, 0.05);
  border: 0.1rem solid rgba(0, 0, 0, 0.2);
  padding: 2rem;
  border-radius: 0.5rem;
  animation: fadeUp 0.4s linear;
}

.register-container .register-form-container form h3 {
  padding-bottom: 1rem;
  font-size: 2rem;
  text-transform: uppercase;
  color: #130f40;
  margin: 0;
}

.register-container .register-form-container form .form-control {
  margin: 0.7rem 0;
  border-radius: 0.5rem;
  background: #f7f7f7;
  padding: 2rem 1.2rem;
  font-size: 1.6rem;
  color: #130f40;
  text-transform: none;
  width: 100%;
  border: none;
}

.register-container .register-form-container form label {
  font-size: 2rem;
  margin: 0;
  padding: 0;
}

.register-container .register-form-container form span {
  font-size: 18px;
  padding-left: 5px;
  padding-right: 40px;
}

.register-container .register-form-container form .btn {
  margin: 1rem 0;
  width: 100%;
  text-align: center;
}

.register-container .register-form-container form p {
  padding-top: 1rem;
  font-size: 1.5rem;
  color: #666;
  margin: 0;
}

.register-container .register-form-container form p a {
  color: #d54d52;
}

.register-container .register-form-container form p a:hover {
  color: #130f40;
  text-decoration: underline;
}

.register-container .register-form-container form .form-group {
  margin: 0;
}

.register-container .register-form-container form .form-group .error-mess {
  font-size: 1.5rem;
  position: relative;
  color: #ff0000;
  margin: 0;
  padding: 0;
}
.b-r {
  border-radius: 0;
}

.r {
  background-color: rgb(238, 12, 12);
}
.r:hover {
  background-color: rgb(236, 39, 39);
}
</style>
