<template>
    <div class="my-order-container" :class="filterBooks.length > 0 ? '' : 'fit-screen'">
        <div v-if="filterBooks.length > 0" :class="my-order-cards">
            <div v-for="book in filterBooks.slice().reverse()" class="card" :key="book.book_id">
                <div class="card-head d-flex flex-wrap flex-sm-nowrap justify-content-between">
                    <!-- -->
                    <div><h1>{{ langObj[this.newLangStatus].words[0] }}</h1> 
                        <!-- <span>Table No - </span>
                        <span>{{ book.book_id }}</span> -->
                    </div>
                    <!-- <button @click="sendBillId(book.book_id)">Bill Detail</button> -->
                </div>

                <div class="d-flex flex-wrap flex-sm-nowrap justify-content-between card-summary">
                    <!-- <div class="w-100 text-center py-1 px-2"><span>Paid:</span>{{ " " + b.bill_paid }}
                    </div> -->
                    <div class="w-100 text-center py-1 px-2"><span>{{ langObj[this.newLangStatus].words[1] }}</span>{{avaiableStatus[book.book_status]
                    }}
                    </div>
                    <div class="w-100 text-center py-1 px-2"><span>{{ langObj[this.newLangStatus].words[2] }}</span> {{ book.book_when }}</div>
                </div>
                <div class="d-flex flex-wrap flex-sm-nowrap justify-content-between card-summary">

                    <!-- <div class="w-100 text-center py-1 px-2"><span>Total:</span> {{ b.bill_total }}birr</div> -->
                    <!-- <div class="w-100 text-ce¦nter py-1 px-2"><span>Address:</span>{{ " " + b.bill_address }}
                    </div> -->
                    <div class="w-100 text-center py-1 px-2"><span>{{ langObj[this.newLangStatus].words[3] }}</span>{{ " " + book.book_phone }}
                    </div>
                </div>

                <div class="card-body">
                    <div class="steps d-flex flex-wrap flex-sm-nowrap justify-content-between">
                        <div class="step" :class="book.book_status >= 1 ? 'completed' : ''">
                            <div class="step-icon-wrap">
                                <div class="step-icon"><i class="fa-regular fa-circle-check"></i></div>
                            </div>
                            <h4 class="step-title">{{ langObj[this.newLangStatus].words[4] }}</h4>
                        </div>
                        <div class="step" :class="book.book_status >= 2 ? 'completed' : ''">
                            <div class="step-icon-wrap">
                                <div class="step-icon">
                                    <i class="fa fa-check"></i></div>
                            </div>
                            <h4 class="step-title">{{ langObj[this.newLangStatus].words[5] }}</h4>
                        </div>
                        <div class="step" :class="book.book_status === 3 ? 'completed' : ''">
                            <div class="step-icon-wrap">
                                <div class="step-icon"><i class="fa-solid fa-chair"></i></div>
                            </div>
                            <h4 class="step-title">{{ langObj[this.newLangStatus].words[6] }}</h4>
                        </div>
                        <div class="step" :class="book.book_status >= 4 && book.book_status >3 ? 'completed-no-table' : ''">
                            <div class="step-icon-wrap">
                                <div class="step-icon"><img style="width: 40px;" src="../assets/icons/dining-room.png" alt=""></div>
                            </div>
                            <h4 class="step-title">{{ langObj[this.newLangStatus].words[7] }}</h4>
                        </div>
                        <!-- <div class="step" :class="book.book_status >= 5 ? 'completed' : ''">
                            <div class="step-icon-wrap">
                                <div class="step-icon"><i class="fa-solid fa-house-user"></i></div>
                            </div>
                            <h4 class="step-title">Delivered</h4>
                        </div> -->
                    </div>
                </div>
            </div>
        </div>


        <div v-else class="box-content row no-food">
            <div class="content">
                <h2>{{ langObj[this.newLangStatus].words[8] }}</h2>
            </div>
            <!-- <div>
                <img src="../assets/images/no-orders.png" alt="" />
            </div> -->
            <router-link class="btn" to="/table">{{ langObj[this.newLangStatus].words[9] }}</router-link>
        </div>

    </div>

</template>


<script>
import axios from "axios";
import { mapState } from "vuex";
export default {
    name: 'MyTables',

    data() {
        return {
            avaiableStatus: ["cancel",  "confirmed", "checking", "reserved", "no table"],
            allBooks: [],
            languageStatus : 0,
            langObj: [
                { words: ["Table Track Dashboard","Status:","When:","Phone:","Confirmed","Checking","Reserved","No Table","You do not have any Reservation yet","book now!"] },
                    
                { words: ["Daashboordii Hordoffii Gabatee", "Sadarkaa:","Yoom:","Bilbila:","Mirkanaa'eera", "Sakatta'uu", "Kan qabame", "Gabatee Hin Qabu", "Ammatti Reservation tokkollee hin qabdan","amma buufadhu!"
            ] },
            ],
            newLangStatus : 0,
            interval: "",

        }
    },

    created() {
        this.getAllBooks();
        this.getStatus();

    },

    mounted: function () {
        this.autoUpdate();
        window.addEventListener('scroll', this.handleScroll);

    },

    beforeUnmount() {
        clearInterval(this.interval)
    },

    computed: {
        ...mapState(["allFoods", "user"]),

        filterBooks: function () {
            return this.allBooks.filter((allbook) => allbook.book_status < 6 && allbook.book_status > 0);
           

        },
    },

    methods: {
        async getAllBooks() {
            if (this.user) {
                this.allBooks = (await axios.get('/booktable/username/' + this.user.user_name)).data;
                // console.log(this.user.user_name);
                console.log(this.allBooks);
            }
        },

        async getStatus(){
          let langStatus = await axios.get('/langstatus/', this.languageStatus);
          this.newLangStatus = langStatus.data[0].langstatus;
        //   console.log(this.newLangStatus);
        //   console.log(this.langObj[this.newLangStatus].words[0] )
        
        },
        autoUpdate: function () {
            this.interval = setInterval(function () {
                this.getAllBooks();
                this.getStatus();

            }.bind(this), 50);
        }
    },
}
</script>

<style scoped>
.my-order-container {
    padding: 8% 9%;
    background: #fff;
    height: 100%;
}

.my-order-container.fit-screen {
    height: 90vh;
}

.my-order-cards {
    margin-bottom: 2rem;
}

.card {
    margin-bottom: 3px;
}

.card-head {
    padding: 12px 0px;
    color: white;
    font-size: 16px;
    background: #2f5899;

}

.card-head span:first-of-type {
    margin-left: 20px;
}

.card-head button {
    background-color: inherit;
    color: white;
    margin-right: 20px;
    font-weight: 500;
}

.card-head button:hover {
    color: #f38609;
}

.card-summary {
    padding: 12px 10px;
    background: #eee;
    font-size: 14px;
}

.steps .step {
    display: block;
    width: 100%;
    margin-bottom: 35px;
    text-align: center
}

.steps .step .step-icon-wrap {
    display: block;
    position: relative;
    width: 100%;
    height: 80px;
    text-align: center
}

.steps .step .step-icon-wrap::before,
.steps .step .step-icon-wrap::after {
    display: block;
    position: absolute;
    top: 50%;
    width: 50%;
    height: 3px;
    margin-top: -1px;
    background-color: #e1e7ec;
    content: '';
    z-index: 1
}

.steps .step .step-icon-wrap::before {
    left: 0
}

.steps .step .step-icon-wrap::after {
    right: 0
}

.steps .step .step-icon {
    display: inline-block;
    position: relative;
    width: 80px;
    height: 80px;
    border: 1px solid #e1e7ec;
    border-radius: 50%;
    background-color: #f5f5f5;
    color: #374250;
    font-size: 38px;
    line-height: 81px;
    z-index: 5
}

.steps .step .step-title {
    margin-top: 16px;
    margin-bottom: 0;
    color: #606975;
    font-size: 14px;
    font-weight: 500
}

.steps .step:first-child .step-icon-wrap::before {
    display: none
}

.steps .step:last-child .step-icon-wrap::after {
    display: none
}

.steps .step.completed .step-icon-wrap::before,
.steps .step.completed .step-icon-wrap::after {
    background-color: #6ca404;
}

.steps .step.completed .step-icon {
    border-color: #6ca404;
    background-color: #6ca404;
    color: #fff
}
/* completed-no-table */
.steps .step.completed-no-table .step-icon{
    background-color: #d32a46;
    color: #fff
}
.no-food {
    text-align: center;
    justify-content: center;
    display: block;
    width: 100%;
    height: 100%;
    margin: auto;
}

.no-food a {
    margin-top: 20px;
    margin-left: -10px;
}

@media (max-width: 320px) {
    .my-order-container {
        padding: 0px;
    }

    .card-head {
        font-size: 14px;
    }

    .no-food .content h2 {
        font-size: 14px;
    }


}

@media (max-width: 576px) {
    .my-order-container {
        padding: 1rem 4.5%;
    }

    .flex-sm-nowrap .step .step-icon-wrap::before,
    .flex-sm-nowrap .step .step-icon-wrap::after {
        display: none
    }

    .card {
        margin-top: 20px;
    }

    .no-food div img {
        width: 85vw;
    }
}

@media (max-width: 768px) {

    .flex-md-nowrap .step .step-icon-wrap::before,
    .flex-md-nowrap .step .step-icon-wrap::after {
        display: none
    }
}

@media (max-width: 991px) {

    .flex-lg-nowrap .step .step-icon-wrap::before,
    .flex-lg-nowrap .step .step-icon-wrap::after {
        display: none
    }
}

@media (max-width: 1200px) {

    .flex-xl-nowrap .step .step-icon-wrap::before,
    .flex-xl-nowrap .step .step-icon-wrap::after {
        display: none
    }
}

.bg-faded,
.bg-secondary {
    background-color: #f5f5f5 !important;
}
</style>