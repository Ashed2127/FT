<template>
    
    <vue-basic-alert :duration="300" :closeIn="2000" ref="alert" />

    <div class="login-container">
        <div class="login-form-container">

            <form id="loginForm" @submit="handleSubmit" novalidate autocomplete="off">

                <h3>{{ langObj[this.newLangStatus].words[0] }}</h3>

                <div v-if="errors.length" class="error-box">
                    <ul>
                        <li v-for="error in errors" :key="error">{{ error }}</li>
                    </ul>
                </div>

                <div class="form-group">
                    <input type="email" id="uEmail" name="uEmail" class="form-control" :placeholder="langObj[this.newLangStatus].words[1]"
                        v-model="loginObj.email" />
                </div>

                <div class="form-group">
                    <input type="password" id="uPass" name="uPass" class="form-control"
                        :placeholder="langObj[this.newLangStatus].words[2]" v-model="loginObj.pass" />
                </div>

                <div class="form-group">
                    <input type="submit" :value="langObj[this.newLangStatus].words[3]" class="btn">
                    <p>{{ langObj[this.newLangStatus].words[4] }}<router-link @click="scrollToTop()" to="/register">{{ langObj[this.newLangStatus].words[5] }}
                        </router-link>
                    </p>
                </div>
            </form>
        </div>
    </div>
</template>


<script>
import axios from "axios";
import { mapMutations } from "vuex";
import VueBasicAlert from 'vue-basic-alert';
export default {
    name: 'Login',

    data() {
        return {
            loginObj: { email: "", pass: "" },
            matchUser: undefined,
            errors: [],

            languageStatus : 0,
            langObj: [
                { words: ["LOGIN","enter your email","enter your password","login now","don't have an account? ","create one"
            ] },
                    
                    { words: ["SEENAA", "email keessan galchaa", "jecha icciitii keessan galchaa", "amma seeni", "account hin qabdan? ", "tokko uumuu"] },
            ],
            newLangStatus : 0,
            interval: "",
                }
    },
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
        ...mapMutations(["setUser"]),

        scrollToTop() {
            window.scrollTo(0, 0);
        },

        async getMatchUser(email) {
            let data = await axios.get('/users/' + email);
            this.matchUser = data.data;
        },

        async handleSubmit(e) {
            this.errors = [];

            if (!this.loginObj.email) {
                this.errors.push("Entering a email is required");
            }
            else {
                if (!/[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$/.test(this.loginObj.email)) {
                    this.errors.push('Email must be valid');
                }
            }


            if (!this.loginObj.pass) {
                this.errors.push('Password is required');
            }

            if (!this.errors.length === 0) {
                e.preventDefault();
            }
            else {
                e.preventDefault();
                await this.getMatchUser(this.loginObj.email);
                if (!this.matchUser) {
                    this.errors.push("Incorrect email or password!")
                }
                else {
                    if (this.matchUser.user_password === this.loginObj.pass) {
                        this.matchUser.user_password = "";

                        this.setUser(this.matchUser);
                        
                        // this.$refs.alert.showAlert('Booking Successfully !')

                        this.$router.push("/");



                    }
                    
                    else {
                        this.errors.push("Incorrect email or password!")
                    }
                }
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
                this.getStatus();
            }.bind(this), 50);
        }
    }
    ,

components: {
    VueBasicAlert
}
    
}


</script>

<style scoped>
.login-container {
    padding: 2rem 9%;
}

.login-container .login-form-container {
    background-color: #fff;
    height: 90vh;
}

.login-container .login-form-container form {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    max-width: 40rem;
    width: 100%;
    box-shadow: 0 1rem 1rem rgba(0, 0, 0, 0.05);
    border: 0.1rem solid rgba(0, 0, 0, 0.2);
    padding: 2rem;
    border-radius: .5rem;
    animation: fadeUp .4s linear;
}

.login-container .login-form-container form h3 {
    padding-bottom: 1rem;
    font-size: 2rem;
    font-weight: bolder;
    text-transform: uppercase;
    color: #130f40;
    margin: 0;
}

.login-container .login-form-container form .form-control {
    margin: .7rem 0;
    border-radius: .5rem;
    background: #f7f7f7;
    padding: 2rem 1.2rem;
    font-size: 1.6rem;
    color: #130f40;
    text-transform: none;
    width: 100%;
    border: none;
}

.login-container .login-form-container form .btn {
    margin-bottom: 1rem;
    margin-top: 1rem;
    width: 100%;
}

.login-container .login-form-container form p {
    padding-top: 1rem;
    font-size: 1.5rem;
    color: #666;
    margin: 0;
}

.login-container .login-form-container form p a {
    color: #d54d52;
}

.login-container .login-form-container form p a:hover {
    color: #130f40;
    text-decoration: underline;
}

.login-container .login-form-container form .error-box {
    background-color: #fff9fa;
    box-sizing: border-box;
    border: 2px solid rgba(255, 66, 79, .2);
    border-radius: 2px;
    font-size: 12px;
    margin-bottom: 20px;
}

.login-container .login-form-container form .error-box ul {
    list-style-type: none;
    margin: 0;
    padding: 10px 0px;
}

.login-container .login-form-container form .error-box ul li {
    padding-left: 10px;
    color: rgb(182, 0, 0);
}
</style>