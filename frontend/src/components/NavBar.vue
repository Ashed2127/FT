<template>
    <div class="header">

      <nav class="navbar">
        <router-link @click="scrollToTop()" to="/">{{ langObj[this.newLangStatus].words[0] }}</router-link>
        <router-link @click="scrollToTop()" to="/menu">{{ langObj[this.newLangStatus].words[1] }}</router-link>
        <router-link @click="scrollToTop()" to="/table">{{ langObj[this.newLangStatus].words[2] }}</router-link>
        <router-link @click="scrollToTop()" to="/about">{{ langObj[this.newLangStatus].words[3] }}</router-link>
        <router-link @click="scrollToTop()" to="/pay">pay</router-link>
        <!-- <router-link @click="scrollToTop()" to="/newPay">neway</router-link> -->
    </nav>
    

        <!-- language drop down  -->
        
        <div class="icons">
            <div id="menu-btn" class="fas fa-bars menu-btn" @click="showNav"></div>
            <router-link @click="scrollToTop()" to="cart">
                <div class="fas fa-shopping-cart cart"></div>
            </router-link>

            <div v-if="!user" class="fas fa-user account" @click="showLog">
                <ul class="drop-down-select">
                    <li>
                        <router-link @click="scrollToTop()" to="/login">{{ langObj[this.newLangStatus].words[4] }}</router-link>
                    </li>
                    <li>
                        <router-link @click="scrollToTop()" to="/register">{{ langObj[this.newLangStatus].words[5] }}</router-link>
                    </li>
                </ul>

            </div>



            <div v-else class="fas fa-user account" style="background: #f38609;color: white;" @click="showLog">
                <ul class="drop-down-select">
                    <li>
                        <router-link @click="scrollToTop()" to="/myorder">{{ langObj[this.newLangStatus].words[6] }}</router-link>
                    </li>
                    <li>
                        <router-link @click="scrollToTop()" to="/mytables">{{ langObj[this.newLangStatus].words[7] }}</router-link>
                    </li>
                   
                    <li>
                        <router-link @click="handleLogout" to="/">{{ langObj[this.newLangStatus].words[8] }}</router-link>
                    </li>
                </ul>
            </div>
            
          
            <div class="fas fa-solid fa-language account" style="background: #f38609;color: white; width: 40px;" @click="showLog">
                <ul class="drop-down-select">
                    <li>
                        <router-link @click="english()" to="#">english</router-link>
                    </li>
                    <li>
                        <router-link @click="oromo()" to="#">afaan oromo</router-link>
                    </li>
                   
                    <!-- <li>
                        <router-link @click="handleLogout" to="#">amharic</router-link>
                    </li> -->
                </ul>
            </div>
        </div>
    </div>
</template>

<script>
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min.js';
import { mapState, mapMutations } from "vuex";
import axios from 'axios';
export default {
    name: 'NavBar',
    data(){
        return{
        languageStatus : 0,
        engIndex : 1,
        oroIndex : 1,
        langObj: [
        { words: ["home", "menu", "table", "about","login","register","my orders","my tables","logout"] },
        { words: ["mana", "meenuu", "Minjaala", "Waa'ee","seenuu","galmeessuu","ajaja koo", "minjaalota koo", "ba'uu"] },
        // { words: ["home", "menu", "table", "about"] },
        // { words: ["mana", "meenuu", "Minjaala", "Waa'ee"] },


        ],
         newLangStatus : 0,
         interval: "",
            //  langObj[0].words[0]
            //  langObj[1].words[0] 
    }},
   
  
    computed: {
        ...mapState(["user"])
    },

    mounted() {
      this.autoUpdate(); 
        window.addEventListener('scroll', this.handleScroll);
    },
    unmounted() {
      clearInterval(this.interval);

        window.removeEventListener('scroll', this.handleScroll);
    },

    methods: {
        ...mapMutations(["setUser"]),

        scrollToTop() {
            window.scrollTo(0, 0);
        },
       async english(){
                 await axios.put('/english/', this.engIndex);
                // console.log(eng);
                this.getStatus();

        },

        async oromo(){
               await axios.put('/oromo/', this.oroIndex);
                // console.log(oro);
                this.getStatus();
        },

        async getStatus(){
          let langStatus = await axios.get('/langstatus/', this.languageStatus);
          this.newLangStatus = langStatus.data[0].langstatus;
          // console.log(this.newLangStatus);
          // console.log(this.langObj[this.newLangStatus].words[0] )
        
        },
        
        showNav: function () {
            let navbar = document.querySelector('.header .navbar');
            navbar.classList.toggle('active');
        },

        showLog: function () {
            let mq = window.matchMedia("(max-width: 768px)");
            if (mq.matches) {
                let log = document.querySelector('.drop-down-select');
                log.classList.toggle('active');
            }
        },

        handleScroll: function () {
            let navbar = document.querySelector('.header .navbar');
            navbar.classList.remove('active');
            let log = document.querySelector('.drop-down-select');
            log.classList.remove('active');
        },

        handleLogout: function () {
            this.setUser("");
        },
        autoUpdate: function () {
            this.interval = setInterval(function () {
                this.getStatus();
            }.bind(this), 50);
        }
    }
}
</script>

<style scoped>
.header {
    position: sticky;
    top: 0;
    left: 0;
    right: 0;
    z-index: 1000;
    background-color: #FFA500;
    box-shadow: 0 1rem 1rem rgba(0, 0, 0, 0.05);
    color: rgb(255, 255, 255);
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 2rem 9%;
}

/* .header .logo {
    font-size: 2.5rem;
    font-weight: bolder;
    color: #130f40;
} */

.header .logo img {
    padding-right: .5rem;
    color: #27ae60;
}

.header .navbar a {
    font-size: 2rem;
    font-weight: bold;
    margin: 0 1rem;
    color: white;

}

.header .navbar a:hover {
    color: #2f5899;
}

.header .navbar a.router-link-exact-active {
    color: white;
}
.header .navbar a.router-link-exact-active:hover {
    color: #2f5899;
}
.header .icons div {
    height: 4.5rem;
    width: 4.5rem;
    line-height: 4.5rem;
    font-size: 2rem;
    color: white;
    border-radius: .5rem;
    margin-left: .3rem;
    cursor: pointer;
    text-align: center;
}

.header .icons div:hover {
    color: #2f5899;
    background: orange !important;
}

.header .icons a.router-link-exact-active .cart {
    color: white;
}

#menu-btn {
    display: none;
}

.header .icons .account .drop-down-select {
    display: none;
    position: absolute;
    margin-left: -50px;
    list-style-type: none;
}

.header .icons .account .drop-down-select a {
    text-decoration: none;
    color: #130f40;
    font-size: 15px;
    font-weight: 500;
    float: left;
    width: 95px;

}

.header .icons .account .drop-down-select.active {
    display: block !important;
}

.header .icons .account .drop-down-select.active a {
    background-color: #f7f7f7;
}

.header .icons .account .drop-down-select.active a:hover {
    background-color: #f38609;
    color: white;
}

/* .header .icons .account:hover .drop-down-select {
    display: block;
} */

.header .icons .account:hover .drop-down-select a {
    background-color: #f7f7f7;

}

.header .icons .account:hover .drop-down-select a:hover {
    background-color: #f38609;
    color: white;
}

@media (min-width: 769px) {
    .header .icons .account:hover .drop-down-select {
        display: block;
    }
}

@media (max-width: 768px) {
    .header .navbar {
        position: absolute;
        top: 99%;
        left: 0;
        right: 0;
        background-color: #f38609;
        border-top: 0.1rem solid rgba(0, 0, 0, 0.2);
        border-bottom: 0.1rem solid rgba(0, 0, 0, 0.2);
        clip-path: polygon(0 0, 100% 0, 100% 0, 0 0);
    }

    .header .navbar.active {
        clip-path: polygon(0 0, 100% 0, 100% 100%, 0% 100%);
        color: rgb(0, 0, 0);
    }

    .header .navbar a {
        font-size: 2rem;
        margin: 2rem;
        display: block;
        color: white;
        
    }
  

    #menu-btn {
        display: inline-block;
    }

}

@media (max-width: 576px) {
    .header .navbar{
        background-image: linear-gradient(90deg,#f38609, #f38609);

    }
    .header .navbar a {
        font-size: 1.5rem;
        margin: 0;
        color: white;
    }
   }
</style>