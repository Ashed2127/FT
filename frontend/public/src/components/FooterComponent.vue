<template>
    <div class="footer">
    

        <div class="box-container">
                <h3>quick links</h3>
                <div class="box">
                <router-link @click="scrollToTop()" to="/"      class="footer-items">  home</router-link>
                <router-link @click="scrollToTop()" to="/about" class="footer-items"> about</router-link>
                <router-link @click="scrollToTop()" to="/menu"  class="footer-items">  menu</router-link>
                <router-link @click="scrollToTop()" to="/table" class="footer-items"> book a table
                </router-link>
                </div>
        </div>

    </div>
</template>

<script>
import { mapState } from 'vuex'
export default {
    name: 'FooterComponent',

    computed: {
        ...mapState(['user'])
    },

    methods: {
        scrollToTop() {
            window.scrollTo(0, 0);
        }
    }
}
</script>

<style scoped>
/* footer */
.footer {
    background: #ffffff;
    padding: 2rem 9%;
    
}

.footer .news-letter {
    text-align: center;
    margin-bottom: 2rem;
}

.footer .news-letter h3 {
    font-size: 2.5rem;
    color: #130f40;
    padding-bottom: 1rem;
}

.footer .news-letter form {
    max-width: 70rem;
    margin: 1rem auto;
    max-width: 70rem;

    display: flex;
    border-radius: .5rem;
    overflow: hidden;
}

.footer .news-letter form input[type="email"] {
    height: 100%;
    width: 100%;
    padding: 1rem 1.2rem;
    font-size: 1.6rem;
    color: #130f40;
    text-transform: none;
}

.footer .news-letter form input[type="submit"] {
    padding: 0 2rem;
    font-size: 1.6rem;
    color: #fff;
    background: #27ae60;
    cursor: pointer;
}

.footer .news-letter form input[type="submit"]:hover {
    background: #130f40;
}
.footer{
    background-color: #FFA500;
    width: 100%;
    height: 10%;
}
.footer .box-container h3{
   display: block;
   padding-left: 40%;
   padding-top: 0.5%;
   padding-bottom: 1%;
}
.footer .box-container .box {
    width: 60%;
    margin:  auto;
    display: flex;
    justify-content: space-around;
}

.footer .box-container .box h3 {
    font-size: 2.2rem;
    color: #130f40;

}

.footer .box-container .box p {
    font-size: 1.4rem;
    color: #fefdfd;
    padding: 1rem 0;
}

.footer .box-container .box a {
    display: block;
    font-size: 1.4rem;
    color: #fffbfb;
    padding: 1rem 0;
}

.footer .box-container .box a:hover {
    color: #fa9806;
}


.footer .bottom {
    padding-top: 1rem;
    text-align: center;
}

.footer .bottom .share {
    margin: 1.5rem 0;
}

.footer .bottom .share a {
    height: 4.5rem;
    width: 4.5rem;
    line-height: 4.5rem;
    font-size: 2rem;
    border-radius: .5rem;
    margin: 0 .3rem;
    color: #fff;
    background: #27ae60;
}

.footer .bottom .share a:hover {
    background: #130f40;
}

@media (max-width: 576px) {
    .footer .box-container {

        grid-template-columns: repeat(auto-fit, minmax(15rem, 1fr));

    }

}
</style>