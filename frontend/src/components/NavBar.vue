/////////////////NAVBAR//////////////////////
<template>
    <div class="header">

        <nav class="navbar">
            <router-link @click="scrollToTop()" to="/">home</router-link>
            <router-link @click="scrollToTop()" to="/menu">menu</router-link>
            <router-link @click="scrollToTop()" to="/table">table</router-link>
            <router-link @click="scrollToTop()" to="/about">about</router-link>
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
                        <router-link @click="scrollToTop()" to="/login">login</router-link>
                    </li>
                    <li>
                        <router-link @click="scrollToTop()" to="/register">register</router-link>
                    </li>
                </ul>

            </div>



            <div v-else class="fas fa-user account" style="background: #f38609;color: white;" @click="showLog">
                <ul class="drop-down-select">
                    <li>
                        <router-link @click="scrollToTop()" to="/myorder">my orders</router-link>
                    </li>
                    <li>
                        <router-link @click="scrollToTop()" to="/mytables">my tables</router-link>
                    </li>
                   
                    <li>
                        <router-link @click="handleLogout" to="/">logout</router-link>
                    </li>
                </ul>
            </div>
            
          
            <div class="fas fa-user account"  style="background: #f38609;color: white; width: 40px;" @click="showLog">
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
        // let index = [];
        engIndex : 1,
        oroIndex : 1,
        
    }},
 

    computed: {
        ...mapState(["user"])
    },

    mounted() {
        window.addEventListener('scroll', this.handleScroll);
    },
    unmounted() {
        window.removeEventListener('scroll', this.handleScroll);
    },

    methods: {
        ...mapMutations(["setUser"]),

        scrollToTop() {
            window.scrollTo(0, 0);
        },
       async english(){
                let eng = await axios.put('/english/', this.engIndex);
                console.log(eng);
        },
        async oromo(){
                let oro = await axios.put('/oromo/', this.oroIndex);
                console.log(oro);
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
    border-radius: 5%;

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