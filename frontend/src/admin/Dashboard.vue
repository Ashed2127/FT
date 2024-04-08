<template>
  <div class="admin-container">
    <div class="navbar navbar-expand-lg">
      <div class="container-fluid">
        <router-link @click="scrollToTop()" to="/dpRegister" class="btn"
          >Add Deliver Person</router-link
        ><router-link @click="scrollToTop()" to="/dpRegister" class="btn"
          >remove Deliver Person</router-link
        ><router-link @click="scrollToTop()" to="/dpRegister" class="btn"
          >Add foods</router-link
        ><router-link @click="scrollToTop()" to="/dpRegister" class="btn"
          >remove foods</router-link
        ><router-link @click="scrollToTop()" to="/dpRegister" class="btn"
          >Add Deliver Person</router-link
        >
        <button class="btn" @click="handleLogout()">Logout</button>
      </div>
    </div>

    <div class="table-responsive col-lg-12">
      <!-- PROJECT TABLE -->
      <table class="table colored-header datatable project-list">
        <thead>
          <tr>
            <th>Bill Id</th>
            <th>User Id</th>
            <th>Phone</th>
            <th>Address</th>
            <th>Foods</th>
            <th>When</th>
            <th>Paid</th>
            <th>Total</th>
            <th>Status</th>
            <th>Action</th>
            <th>bill id</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="b in filterBills.slice().reverse()" :key="b.bill_id">
            <td>{{ b.bill_id }}</td>
            <td>{{ b.user_id }}</td>
            <td>{{ b.bill_phone }}</td>
            <td>{{ b.bill_address }}</td>
            <td>
              <h3 v-for="(image, index) in images" :key="index">
                {{ image.foodName }}
              </h3>
              <img
                v-for="(image, index) in images"
                :key="index"
                :src="image.src"
                :alt="image.alt"
                style="width: 50px"
              />
            </td>
            <!-- <td>{{ getFoods() }}</td> -->
            <td>{{ b.bill_when }}</td>
            <td>{{ b.bill_paid }}</td>
            <td>{{ b.bill_total }}birr</td>
            <td>{{ avaiableStatus[b.bill_status] }}</td>
            <td>
              <button
                v-if="b.bill_status < 5"
                class="action-btn"
                @click="nextStatusBtn(b.bill_id)"
              >
                {{ avaiableStatus[b.bill_status + 1] }}
              </button>

              <!-- <button v-if="b.bill_status == 1" class="cancel-btn" @click="cancelBtn(b.bill_id)">
                                Cancel
                            </button> -->
              <button
                v-if="b.bill_status >= 2"
                class="undo-btn"
                @click="undoBillStatusBtn(b.bill_id)"
              >
                Undo
              </button>
              <button
                v-else-if="b.bill_status == 5 && b.bill_paid == 'false'"
                class="paid-btn"
                @click="paidBtn(b.bill_id)"
              >
                Paid
              </button>

              <button
                v-else-if="b.bill_status == 5 && b.bill_paid == 'true'"
                class="action-btn"
                @click="nextStatusBtn(b.bill_id)"
              >
                {{ avaiableStatus[b.bill_status + 1] }}
              </button>
            </td>
            <!-- <td>{{ this.id }}</td> -->
          </tr>
        </tbody>
      </table>
    </div>

    <br /><br />
    <h1>Admin Table Dashboard</h1>
    <div class="table-responsive">
      <table class="table colored-header datatable project-list">
        <thead>
          <tr>
            <!-- <th>User Id</th> -->
            <th>Name</th>
            <th>Phone</th>
            <th>People</th>
            <th>Tables</th>
            <th>When</th>
            <th>Note</th>
            <th>Status</th>
            <th>Action</th>
          </tr>
        </thead>

        <tbody>
          <tr
            v-for="allBook in filterBooks.slice().reverse()"
            :key="allBook.book_id"
          >
            <!-- <td>{{ allBook.user_id }}</td> -->
            <td>{{ allBook.book_name }}</td>
            <td>{{ allBook.book_phone }}</td>
            <td>{{ allBook.book_people }}</td>
            <td>{{ allBook.book_tables }}</td>
            <td>{{ allBook.book_when }}</td>
            <td>{{ allBook.book_note }}</td>
            <td>{{ avaiableBookStatus[allBook.book_status] }}</td>

            <button
              v-if="allBook.book_status < 4"
              class="action-btn"
              @click="nextBookBtn(allBook.book_id)"
            >
              {{ avaiableBookStatus[allBook.book_status + 1] }}
            </button>

            <button
              v-if="allBook.book_status >= 2"
              class="undo-btn"
              @click="undoBookStatusBtn(allBook.book_id)"
            >
              Undo
            </button>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import { mapState, mapMutations } from "vuex";
import burger from "../assets/images/burger.png";
import burrito from "../assets/images/burrito-img.png";
export default {
  name: "Dashboard",

  data() {
    return {
      avaiableStatus: [
        "cancel",
        "confirmed",
        "preparing",
        "checking",
        "delivering",
        "delivered",
        "completed",
      ],
      allBills: [],
      showOrderDetails: false,
      sendId: undefined,
      interval: "",
      allBooks: [],
      avaiableBookStatus: [
        "cancel",
        "confirmed",
        "checking",
        "reserved",
        "no table",
      ],
      images: [
        { src: burger, foodName: "burger" },
        { src: burrito, foodName: "burrito" },
        // { src: '../assets/images/ethio-foods.jpg', alt: 'Image 3' }
      ],
      userFoodsData: "",
      foods: [],
      userFoods: "",
      foodSrc: "",
    };
  },

  created() {
    this.getAllBills();
    this.getAllBooks();
    this.getFoodsData();
    this.getFoodsById();
    this.display();

    if (!this.admin) {
      this.$router.push("/");
    }
  },

  mounted: function () {
    this.autoUpdate();
  },

  beforeUnmount() {
    clearInterval(this.interval);
  },

  computed: {
    ...mapState(["allFoods", "admin"]),

    filterBills: function () {
      return this.allBills.filter(
        (b) => b.bill_status < 6 && b.bill_status > 0
      );
    },
    filterBooks: function () {
      return this.allBooks.filter(
        (allbook) => allbook.book_status < 6 && allbook.book_status > 0
      );
    },
  },

  methods: {
    ...mapMutations(["setAdmin"]),

    //get all bill status from billstatus table
    async getAllBills() {
      this.allBills = (await axios.get("/billstatus")).data;
    },

    // get all book tables from booktable
    async getAllBooks() {
      this.allBooks = (await axios.get("/booktable")).data;
      // this.userid = (await axios.get('/userid')).data;
    },

    sendBillId: function (id) {
      this.sendId = id;
      this.showOrderDetails = !this.showOrderDetails;
    },

    closeView: function () {
      this.showOrderDetails = !this.showOrderDetails;
    },

    handleLogout: function () {
      this.setAdmin("");
    },

    async nextStatusBtn(id) {
      await axios.put("/billstatus/" + id);
      this.getAllBills();
    },

    async paidBtn(id) {
      await axios.put("/billstatus/paid/" + id);
      this.getAllBills();
    },

    // async cancelBtn(id) {
    //     await axios.put('/billstatus/cancel/' + id);
    //     this.getAllBills();
    // },
    async undoBillStatusBtn(id) {
      await axios.put("/billstatus/undo/" + id);
      this.getAllBills();
    },
    async nextBookBtn(id) {
      await axios.put("/booktable/" + id);
      this.getAllBooks();
    },

    async undoBookStatusBtn(id) {
      await axios.put("/booktable/undo/" + id);
      this.getAllBooks();
    },

    async getFoodsData() {
      this.userFoodsData = await axios.get("/userfoods/", this.foods);

      for (let i = 0; i < this.userFoodsData.data.length; i++) {
        var amount = i;
        var food = this.userFoodsData.data[amount];
        // var foodId = food.food_id;
        var billId = food.bill_id;
        // console.log(billId);
        // console.log(foodId);
      }
      return billId;
    },

    async display() {
      return this.getFoodsData();
    },

    async getFoodsById() {
      this.userFoods = await axios.get("/getuserfoods/" + this.display());
      console.log("food source: ",this.userFoods.data);
    },

    async foodSource() {
      this.getFoodsById().then((data) => {
        console.log("fetched food source: ", data);
      });
    },
    autoUpdate: function () {
      this.interval = setInterval(
        function () {
          this.getAllBills();
          this.getAllBooks();
          // this.getFoodsData();
          // this.getFoodsById();
          // this.display();
        }.bind(this),
        50
      );
    },
  },
};
</script>

<style scoped>
.admin-container {
  background-color: #fefeff;
  height: 100vh;
  padding: 2rem 9%;
  font-size: 16px;
}
.admin-container .container-fluid {
  background-color: #2f5899;
}
.project-list > tbody > tr > td {
  padding: 12px 8px;
}

.project-list > tbody > tr > td .avatar {
  width: 22px;
}

.table-responsive {
  margin-top: 8vh;
  margin-left: 5vh;
  /* width: 800px; */
}

.action-btn,
.cancel-btn,
.paid-btn {
  width: 100px;
  height: 25px;
  color: white;
  text-transform: capitalize;
}

.action-btn {
  background-color: #0da9ef;
  margin-right: 10px;
}

.cancel-btn,
.paid-btn {
  background-color: red;
}
.undo-btn {
  width: 60px;
  height: 25px;
  background-color: rgb(233, 138, 14);
}

.action-btn:hover {
  background-color: #27ae60;
}

.table-contain {
  height: 5px;
  widows: 100%;
  color: orange;
}

.colored-header {
  background-color: #fffbfb;
  color: rgb(0, 0, 0);
}
</style>
