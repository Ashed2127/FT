<template>
    <vue-basic-alert :duration="300" :closeIn="2000" ref="alert" />
    <section class="order-section">

        <div class="heading">
            
            <h3>{{ langObj[this.newLangStatus].words[0] }}</h3>
        </div>

        <div class="icons-container">

            <div class="icons ">
                
                <h2>{{ langObj[this.newLangStatus].words[1] }}</h2>
                <h3>{{ langObj[this.newLangStatus].words[2] }}</h3>
            </div>


        </div>

        <!-- booking form -->
        <form id="bookTableForm" @submit="handleSubmit" novalidate autocomplete="off">

            <div class="row">
                <div class="input-box">
                    <label for="uName">{{ langObj[this.newLangStatus].words[3] }}</label>
                    <input type="text" name="uName" id="uName" v-model="orderObj.name" :placeholder=" langObj[this.newLangStatus].words[4]" >
                    <p v-if="errorObj.nameErr.length > 0">{{ errorObj.nameErr[0] }}</p>
                </div>
                <div class="input-box">
                    <label for="uPhone">{{ langObj[this.newLangStatus].words[5] }}</label>
                    <input type="text" name="uPhone" id="uPhone" v-model="orderObj.phone" :placeholder="langObj[this.newLangStatus].words[6]">
                    <p v-if="errorObj.phoneErr.length > 0">{{ errorObj.phoneErr[0] }}</p>
                </div>
            </div>

            <div class="row">
                <div class="input-box">
                    <label for="oPeople">{{ langObj[this.newLangStatus].words[7] }}</label>
                    <input type="number" name="oPeople" id="oPeople" v-model="orderObj.people">
                    <p v-if="errorObj.peopleErr.length > 0">{{ errorObj.peopleErr[0] }}</p>
                </div>
                <div class="input-box">
                    <label forinput-box="oTables">{{ langObj[this.newLangStatus].words[8] }}</label>
                    <input type="number" name="oTables" id="oTables" v-model="orderObj.tables">
                    <p v-if="errorObj.tablesErr.length > 0">{{ errorObj.tablesErr[0] }}</p>
                </div>
            </div>

            <div class="row">
                <div class="input-box">
                    <label for="oWhen">{{ langObj[this.newLangStatus].words[9] }}</label>
                    <input type="datetime-local" name="oWhen" id="oWhen" v-model="orderObj.when"
                        @click="availableTime()">
                    <p v-if="errorObj.whenErr.length > 0">{{ errorObj.whenErr[0] }}</p>
                </div>
            </div>

            <div class="row">
                <div class="input-box">
                    <label for="uMessage">{{ langObj[this.newLangStatus].words[10] }}</label>
                    <textarea :placeholder="langObj[this.newLangStatus].words[11]" name="uMessage"
                        id="uMessage" cols="30" rows="10" v-model="orderObj.note"></textarea>
                </div>
                <div class="input-box">
                    <iframe class="map"
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3945.5986171544287!2d37.97055081089951!3d8.538290196441066!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x164d291ac3042f53%3A0xe9b9ecc78ddf5a12!2sLewi%20Cafe!5e0!3m2!1sen!2set!4v1706103828101!5m2!1sen!2set"
                        loading="lazy"></iframe>
                </div>
            </div>

            <input type="submit" :value="langObj[this.newLangStatus].words[12]" class="btn">
        </form>

    </section>
</template>

<script>
import axios from 'axios';
import VueBasicAlert from 'vue-basic-alert';
// import { mapState } from "vuex";
export default {
    name: "Table",

    data() {
        return {
            orderObj: { name: "", phone: "", people: "", tables: "", card: "", when: "", note: "" },
            errorObj: { nameErr: [], phoneErr: [], peopleErr: [], tablesErr: [], cardErr: [], whenErr: [] },
            languageStatus : 0,
            langObj: [
                
                    { words: ["Table Form","Opening Hours","2:00am To 6:00pm","Your Name","write your account name","your phone number","write your account number","how many people","how many tables","when","note","your message", "do you want to decorate your table?","Book Now"
                     ] },
                    { words: ["Unka Gabatee","Sa'aatii Baniinsaa", "2:00am Hanga 6:00pm","Maqaa Kee", "maqaa herrega keessanii barreessaa", "lakkoofsa bilbila keessanii", "lakkoofsa herrega keessanii barreessaa", "namoota meeqa", "gabatee meeqa", "yoom","yaadannoo","ergaa kee", "minjaala kee faayuu barbaaddaa?","Amma Kitaaba"] },
                     ],
         newLangStatus : 0,
         interval: "",

        }
    },
    // computed: {
    //     ...mapState([ "user"]),

    //     // filterBooks: function () {
    //     //     return this.allBooks.filter((allbook) => allbook.book_status < 4 && allbook.book_status > 0);
    //     // },
    // },
    created() {
        this.getStatus()
    },
    mounted: function () {
        this.autoUpdate(); 
        window.addEventListener('scroll', this.handleScroll);
    },

    beforeUnmount() {
        clearInterval(this.interval);
        window.removeEventListener('scroll', this.handleScroll);
    },
    methods: {
        availableTime: function () {
            var now = new Date();
            var day = ("0" + now.getDate()).slice(-2);
            var currentMonth = ("0" + (now.getMonth() + 1)).slice(-2);
            var maxMonth = ("0" + (now.getMonth() + 3)).slice(-2);
            var hour = ("0" + (now.getHours())).slice(-2);
            var min = ("0" + (now.getMinutes())).slice(-2);
            var minRange = now.getFullYear() + "-" + currentMonth + "-" + day + "T" + hour + ":" + min;
            var maxRange = now.getFullYear() + "-" + maxMonth + "-" + day + "T" + hour + ":" + min;

            document.getElementById("oWhen").setAttribute("min", minRange);
            document.getElementById("oWhen").setAttribute("max", maxRange);
        },

        resetCheckErr: function () {
            this.errorObj.nameErr = [];
            this.errorObj.phoneErr = [];
            this.errorObj.peopleErr = [];
            this.errorObj.tablesErr = [];
            this.errorObj.cardErr = [];
            this.errorObj.whenErr = [];
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

            // Name validate
            if (!this.orderObj.name) {
                this.errorObj.nameErr.push("Entering a name is required");
            }
            else {
                if (!/^[A-Za-z]+$/.test(this.orderObj.name.replace(/\s/g, ""))) {
                    this.errorObj.nameErr.push('A name can only contain letters');
                }
            }

            // Phone validate
            if (!this.orderObj.phone) {
                this.errorObj.phoneErr.push('Entering phone number is required');
            }
            else {
                if (!this.orderObj.phone.startsWith('09')) {
                    this.errorObj.phoneErr.push('Phone numbers must start with 09');
                }

                if (!/[0-9]{10}/.test(this.orderObj.phone)) {
                    this.errorObj.phoneErr.push('Phone numbers can only contain numbers');
                }

                if (this.orderObj.phone.length != 10) {
                    this.errorObj.phoneErr.push('Phone numbers must have exactly 10 digits');
                }
            }

            if (!this.orderObj.people) {
                this.errorObj.peopleErr.push("Entering number of people is required");
            }
            else {
                if (parseInt(this.orderObj.people) > 100) {
                    this.errorObj.peopleErr.push("Each store can only serve 100 people at a time");
                }

                if (parseInt(this.orderObj.people) < 1) {
                    this.errorObj.peopleErr.push("Number of people must be greater than or equal to 1");
                }
            }

            if (!this.orderObj.tables) {
                this.errorObj.tablesErr.push("Entering number of tables is required");
            }
            else {
                if (parseInt(this.orderObj.tables) > 50) {
                    this.errorObj.tablesErr.push("Each store can only have maximum 50 tables");
                }

                if (parseInt(this.orderObj.tables) < 1) {
                    this.errorObj.tablesErr.push("Number of tables must be greater than or equal to 1");
                }

                if (parseInt(this.orderObj.people) < parseInt(this.orderObj.tables)) {
                    this.errorObj.tablesErr.push("The number of tables must be less than the number of people");
                }
            }

            if (this.orderObj.card) {
                if (!/[0-9]{10}/.test(this.orderObj.card)) {
                    this.errorObj.cardErr.push('Card numbers can only contain numbers');
                }

                if (this.orderObj.card.length != 10) {
                    this.errorObj.cardErr.push('Card number must have exactly 10 digits');
                }
            }

            if (!this.orderObj.when) {
                this.errorObj.whenErr.push("Entering when to serve is required");
            }
            else {
                let minRange = document.getElementById("oWhen").getAttribute("min");
                let maxRange = document.getElementById("oWhen").getAttribute("max");
                let dateMin = new Date(minRange);
                let dateMax = new Date(maxRange);
                let dateInput = new Date(this.orderObj.when);

                if (dateInput === "Invalid Date") {
                    this.errorObj.whenErr.push("Invalid date input");
                }

                if (dateInput.getTime() < dateMin.getTime() || dateInput.getTime() > dateMax.getTime()) {
                    this.errorObj.whenErr.push("Available reservation range is from now to next two months");
                }

                if (dateInput.getHours() < 7 || dateInput.getHours() > 22) {
                    this.errorObj.whenErr.push("Store open from 7:00 AM to 10:00 PM everyday");
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
                // console.log(data.book_phone);
                let data = {
                    book_name: this.orderObj.name,
                    book_phone: parseInt(this.orderObj.phone),
                    book_people: parseInt(this.orderObj.people),
                    book_tables: parseInt(this.orderObj.tables),
                    // user_id: parseInt(this.user.user_id),
                    book_when: this.orderObj.when,
                    book_note: this.orderObj.note,
                    book_status: 1
                }
                console.log(data);
               

                await axios.post("/booktable", data);
                this.$refs.alert.showAlert('Booking Successfully !')
                document.getElementById("bookTableForm").reset();
            }
        },
        scrollToTop() {
            window.scrollTo(0, 0);
        },
        async getStatus(){
          let langStatus = await axios.get('/langstatus/', this.languageStatus);
          this.newLangStatus = langStatus.data[0].langstatus;
        //   console.log(this.newLangStatus);
        //   console.log(this.langObj[this.newLangStatus].words[0] )
        
        },

        autoUpdate: function () {
            this.interval = setInterval(function () {
                this.getStatus();
            }.bind(this), 50);
        }
    },

    components: {
        VueBasicAlert
    }

}
</script>

<style scoped>
.order-section {
    padding: 2rem 9%;
}

.order-section .icons-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(40rem, 1fr));
    gap: 1.5rem;
    margin-bottom: 2rem;
}

.order-section .icons-container .icons {
    border-radius: .5rem;
    padding: 2rem;
    text-align: center;
    background: #f7f7f7;
    background: #dfebeb;
}

.order-section .icons-container .icons img {
    height: 10rem;
}

.order-section .icons-container .icons h2{
    color: #130f40;
}
.order-section .icons-container .icons h3 {
    font-size: 2rem;
    color: #130f40;
    margin-top: .5rem;
}

.order-section form {
    background: #f1ecec;
    background: #ecf0f0e1;

    padding: 2rem;
    border-radius: .5rem;
}

.order-section form .row {
    justify-content: space-between;
}

.order-section form .row .input-box {
    width: 49%;
    padding: 1.8rem 0;
}

.order-section form .row label {
    font-size: 1.7rem;
    color: #666;
}

.order-section form .row p {
    font-size: 1.5rem;
    position: absolute;
    color: rgb(243, 47, 47);
    margin: 0;
    padding-top: 5px;
}

.order-section form .row input,
.order-section form .row textarea {
    width: 100%;
    margin-top: .5rem;
    padding: 1rem 1.2rem;
    width: 100%;
    border-radius: .5rem;
    font-size: 1.6rem;
    text-transform: none;
    color: #130f40;
}

.order-section form .row textarea {
    height: 20rem;
    resize: none;
}

.order-section form .row .map {
    height: 100%;
    width: 100%;
    border-radius: .5rem;
}

@media (max-width: 768px) {
    .order form .row .input-box {
        width: 100%;
    }

    .order-section form .row {
        display: block;
        max-width: 100%;
        width: 100%;
        margin: 0;
    }

    .order-section form .row .input-box {
        width: 100%;
    }

}

@media (max-width: 576px) {
    .order-section .icons-container {
        grid-template-columns: repeat(auto-fit, minmax(30rem, 1fr));
    }
}
</style>