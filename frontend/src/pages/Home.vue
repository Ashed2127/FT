<template>
    <div>
        <div class="home-main">
            <!-- <img src="../assets/images/burger.png" alt="">
            <h1>ds Lorem ipsum, dolor sit amet consectetur adipisicing elit. Possimus ullam quia minus hic recusandae sint dolor eum! Ex, sit fugiat! Est molestias beatae illum harum laudantium nihil quod tenetur cum?</h1> -->
            <!-- <div class="content">
        
                <router-link @click="scrollToTop()" to="/menu" class="btn">order now</router-link>
            </div> -->
       
        </div>


        <div class="home-banner">
            <div class="grid-banner row">
                <div class="grid col-md-4">
                    <img src="../assets/images/ethio-foods.jpg" alt="">
                    <div class="content">
                        <h3>{{ langObj[this.newLangStatus].words[0] }}</h3>
                        <h3>{{ langObj[this.newLangStatus].words[1] }}</h3>
                        <router-link @click="scrollToTop()" to="/menu" class="btn">{{ langObj[this.newLangStatus].words[2] }}</router-link>
                    </div>
                </div>

                <div class="grid col-md-4">
                    <img src="../assets/images/delivery-bike.jpg" alt="">
                    <div class="content center">
                        <span>{{ langObj[this.newLangStatus].words[3] }}</span>
                      
                    </div>
                </div>

                <div class="grid col-md-4">
                    <img src="../assets/images/tables.jpg" alt="">
                    <div class="content">
                        <h3>{{ langObj[this.newLangStatus].words[4] }}</h3>
                        <router-link @click="scrollToTop()" to="/table" class="btn">{{ langObj[this.newLangStatus].words[5] }}</router-link>
                    </div>
                </div>

            </div>

        </div>

        <div class="home-about">
            
            <div class="content">
                <h3 class="title">{{ langObj[this.newLangStatus].words[6] }}</h3>
                <p>{{ langObj[this.newLangStatus].words[7] }}</p>
                <router-link @click="scrollToTop()" to="/about" class="btn">{{ langObj[this.newLangStatus].words[8] }}</router-link>

               
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios';
export default {
    name: "Home",
    data(){
        return{
        languageStatus : 0,
        // engIndex : 1,
        // oroIndex : 1,
        langObj: [
                { words: ["Make it easy","with delivery","order now","ready to deliver","reserve table","book now","delicious food","We guarantee exceptional quality in every dish. Explosive, delicate, and unforgettable flavors await, whether you dine in or enjoy our seamless delivery service.","read more"] },
                
                { words: ["Salphaa godhaa", "geejjibaa wajjin", "amma ajajaa", "geessuuf qophaa'aa", "gabatee rizaabii", "amma kitaaba", "nyaata mi’aawaa", "Nyaata hunda keessatti qulqullina addaa wabii ni kennina. Mi'aan dhoo'aa, micciiramaa fi hin dagatamne isin eegaa, tajaajila geejjibaa keenya isa walxaxaa ta'e keessa nyaattan ykn itti gammaddan.","bal'inaan dubbisaa"] },
        ],
         newLangStatus : 0,
         interval: "",

            //  langObj[0].words[0]
            //  langObj[1].words[0] 
    }},

    created() {
        this.getStatus()
    },
    mounted: function () {
        this.autoUpdate(); 
        window.addEventListener('scroll', this.handleScroll);
    },

    beforeUnmount() {
        // clearInterval(this.interval);
        window.removeEventListener('scroll', this.handleScroll);
    },


    methods: {
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
            }.bind(this), 0);
        }

        
    }
};
</script>

<style scoped>
.home-main,
.home-about,
.home-banner,
.home-category {
    padding: 2rem 9%;
}

.home-main {
    display: flex;
    align-items: center;
    flex-wrap: wrap-reverse;
    gap: 2rem;
    position: relative;
    overflow: hidden;
}

.home-main .content {
    flex: 1 1 41rem;
}
.home-about{
    width: 82%;
    margin: auto;
    margin-bottom: 2%;
}
/* .home-main .content span {
    font-size: 2rem;
    color: #27ae60;
} */

.home-main .content h3 {
    font-size: 4rem;
    color: #130f40;
    padding-top: 1rem;
}

.home-main .content p {
    font-size: 1.4rem;
    color: #666;
    line-height: 2;
    padding: 1rem 0;
}

.home-main .image {
    flex: 1 1 41rem;
    margin: 2rem 0;
    pointer-events: none;
}

.home-main .image .home-img {
    width: 100%;
    margin-top: 5rem;
}

.home-main .home-parallax-img {
    position: absolute;
    top: -15rem;
    right: -15rem;
    width: 80vw;

}

/* home category */
.home-category {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(10rem, 1fr));
    gap: 1.5rem;
    padding-bottom: 5rem;
}

.home-category .box {
    padding: 2rem;
    text-align: center;
    border-radius: .5rem;
    background: #f7f7f7;
}

.home-category .box:hover {
    background: #d54d52;
}

.home-category .box:hover h3 {
    color: #000000;
}

.home-category .box img {
    height: 7rem;
}

.home-category .box h3 {
    font-size: 1.8rem;
    color: #130f40;
}


/* home banner */
.home-banner .row-banner {
    background: url(../assets/images/row-banner.png) no-repeat;
    height: 45rem;
    background-size: cover;
    background-position: center;
    position: relative;
}

.home-banner .row-banner .content {
    position: absolute;
    top: 50%;
    left: 7%;
    transform: translateY(-50%);
}

.home-banner .row-banner .content span {
    font-family: 'Satisfy', cursive;
    font-size: 4rem;
    color: #27ae60;
    color: #130f40;
}

.home-banner .row-banner .content h3 {
    font-size: 6rem;
    color: orange;
    text-transform: uppercase;
}

.home-banner .row-banner .content p {
    font-size: 2rem;
    padding-bottom: 1rem;
}


.home-banner .grid-banner .grid {
    border-radius: 1rem;
    overflow: hidden;
    height: 45rem;
}

.home-banner .grid-banner .grid:hover img {
    transform: scale(1.2);
}

.home-banner .grid-banner .grid img {
    height: 100%;
    width: 100%;
    object-fit: cover;
}

.home-banner .grid-banner .grid .content {
    position: absolute;
    top: 2rem;
    padding: 0 2rem;
}

.home-banner .grid-banner .grid .content.center {
    text-align: center;
    width: 100%;
}

.home-banner .grid-banner .grid .content.center span {
    color: #666;
}

.home-banner .grid-banner .grid .content.center h3 {
    color: #130f40;
}

.home-banner .grid-banner .grid .content span {
    font-size: 2.5rem;
    color: #fff;
}

.home-banner .grid-banner .grid .content h3 {
    font-size: 3rem;
    color: #fff;
    padding-top: .5rem;
}

.home-about {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 2rem;
    background: #f7f7f7;
}

.home-about .image {
    flex: 1 1 40rem;
}

.home-about .image img {
    width: 100%;
}

.home-about .content {

    flex: 1 1 40rem;
}

.home-about .content span {
    font-family: 'Satisfy', cursive;
    font-size: 3rem;
    color: #27ae60;
}

.home-about .content .title {
    font-size: 3rem;
    padding-top: .5rem;
    color: #130f40;
}

.home-about .content p {
    padding: 1rem 0;
    line-height: 2;
    font-size: 1.4rem;
    color: #666;
}

.home-about .content .icons-container {
    margin-top: 2rem;
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
}

.home-about .content .icons-container .icons {
    flex: 1 1 20rem;
    border-radius: .5rem;
    background: #fff;
    box-shadow: 0 1rem 1rem rgba(0, 0, 0, 0.05);
    display: flex;
    align-items: center;
    gap: 2rem;
    padding: 2rem;
}

.home-about .content .icons-container .icons h3 {
    font-size: 1.7rem;
    color: #130f40;
}



@media (max-width: 768px) {
    #menu-btn {
        display: inline-block;
    }

    .home-main .home-parallax-img {
        top: 0;
        right: 0;
        width: 100%;
    }

    .home-banner .grid-banner .content h3 {
        font-size: 15px !important;
    }

    .home-banner .grid-banner .content.center {
        padding-left: 0px !important;
    }

}



@media (max-width: 576px) {
    .home-main .content h3 {
        font-size: 3rem;
    }

    .home-main .content p {
        font-size: 1.5rem;
    }
}
</style>




