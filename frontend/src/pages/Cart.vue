<template>
    <div class="shopping-cart-section">

        <div class="heading">
            <h3>{{ langObj[this.newLangStatus].words[0] }}</h3>
        </div>

        <div class="container">
            <div class="wrapper wrapper-content">
                <div class="row">
                    <div class="in-cart col-md-9">
                        <div class="box">
                            <div class="box-title item-total row">
                                <h3>
                                    <p style="font-size: 15px;">{{ filterFoods.length.toString() }}
                                        <span v-if="filterFoods.length < 2">{{ langObj[this.newLangStatus].words[ 1] }}</span>
                                        <span v-else>{{ langObj[this.newLangStatus].words[2] }}</span>
                                    </p>{{ langObj[this.newLangStatus].words[3] }}
                                </h3>
                            </div>

                            <div v-if="!filterFoods.length">
                                <div class="box-content row no-food">
                                    <div class="content">
                                        <h2 style="color: #057835fa;">{{ langObj[this.newLangStatus].words[ 4] }}</h2>
                                    </div>
                                  
                                </div>
                            </div>
                            <div v-else>
                                <div v-for="(f, index) in filterFoods" :key="index">
                                    <div class="box-content row">
                                        <div class="image-box col-sm-3" style="padding-left: 0;">
                                            <img :src="require(`../assets/images/${f.food_src}`)" alt=""
                                                class="cart-product-img" />
                                        </div>

                                        <div class="desc col-sm-4">
                                            <h2 class="item-name">{{ f.food_name }}</h2>
                                            <div class="item-desc">
                                                <b>{{ langObj[this.newLangStatus].words[5] }}</b>
                                                <p>{{ f.food_desc }}</p>
                                            </div>
                                            <button class="btn remove-btn" @click="removeBtn(index)"><i
                                                    class="fa fa-trash"></i>{{ langObj[this.newLangStatus].words[6] }}</button>
                                        </div>

                                        <div class="item-price col-sm-1">
                                            <span class="sale-price">{{ parseFloat(f.food_price) -
                                                    parseFloat(f.food_discount)
                                            }}birr</span>
                                            <p class="text-muted first-price"
                                                v-if="parseFloat(f.food_discount) != 0.00">
                                                {{
                                                        parseFloat(f.food_price)
                                                }}birr

                                            </p>
                                        </div>

                                        <div class="item-qty col-sm-2 d-inline">
                                            <label for="iQuantity"
                                                style="font-size: 12px; padding-right: 2px;">{{ langObj[this.newLangStatus].words[14] }}</label>
                                            <input type="number" id="iQuantity" class="form-control item-quantity"
                                                :value="itemQuantity[index]" min="1" max="1000"
                                                @change="onQtyChange($event, index)">
                                        </div>

                                        <div class="cal-total col-sm-2">
                                            <h4 class="item-total">{{
                                                    calculateItemPrice(index)
                                            }}birr
                                            </h4>
                                        </div>
                                    </div>
                                </div>
                            </div>


                        </div>

                        <div class="box-content row col-sm-3 col-md-3 col-lg-5  col-9 ">
                            <router-link to="/menu" class="btn shop-btn  backbtn"><i class="fa fa-arrow-left"></i>{{ langObj[this.newLangStatus].words[7] }}</router-link>
                            <button class="btn check-out-btn col-sm-6 col-lg-7 checkbtn" 
                                :disabled="filterFoods.length ? false : true" @click="checkOutBtn()">{{ langObj[this.newLangStatus].words[8] }}</button>
                        </div>
                    </div>


                    <div class="col-md-3 col-sm-2">
                        <div class="box">
                            <div class="box-title">
                                <h3>{{ langObj[this.newLangStatus].words[9] }}</h3>
                            </div>

                            <div class="box-content">
                                <span>{{ langObj[this.newLangStatus].words[10] }}</span>
                                <h3 class="font-bold total-first-price">{{ calculateSummaryPrice()[0] }}birr</h3>

                                <span>{{ langObj[this.newLangStatus].words[11] }}</span>
                                <h3 class="font-bold total-discount">{{ calculateSummaryPrice()[1] }}birr</h3>

                                <span>{{ langObj[this.newLangStatus].words[12] }}</span>
                                <h3 class="font-bold total-delivery">{{ calculateSummaryPrice()[2] }}birr</h3>

                                <hr />

                                <span>{{ langObj[this.newLangStatus].words[13] }}</span>
                                <h2 class="font-bold total-sale">{{ calculateSummaryPrice()[3] }}birr</h2>
<!-- 
                                <div class="btn-group">
                                    <button class="btn check-out-btn" :disabled="filterFoods.length ? false : true"
                                        @click="checkOutBtn()"><i class="fa fa-shopping-cart"></i>
                                        Checkout</button>
                                    <button class="btn cancel-btn" @click="cancelBtn()"
                                        :disabled="filterFoods.length ? false : true">
                                        Cancel</button>
                                </div> -->
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";
export default {
    name: "Cart",

    data() {
        return {
            cartItem: [],
            itemQuantity: [],

            languageStatus : 0,
            langObj: [
                { words: ["your cart","item","items","in your cart","Empty Cart, Add Now","Description","Remove item","Back to menu","Checkout","Cart Summary","Summary","Discount","Delivery fee","Total","Quantity:"


            ] },
                    
                    { words: ["gaarii kee", "wanta","wantoota","gaarii keessan keessa", "Gaarii Duwwaa, Amma Dabaluu", "Ibsa","Meeshaa balleessi", "Gara menutti deebi'a", "Kaffaltii", "Cuunfaa Gaarii", "Cuunfaa","Gatii gadi bu'aa","Kaffaltii geejjibaa", "Ida'ama","Baay'ina:"] },
            ],
            newLangStatus : 0,
            interval: "",
        };
    },

    created() {
        this.getAllCartItem();
        this.getStatus();
    },
    mounted: function () {
        this.autoUpdate(); 
        window.addEventListener('scroll', this.handleScroll);
    },

    beforeUnmount() {
        clearInterval(this.interval);
        window.removeEventListener('scroll', this.handleScroll);
    },
    computed: {
        ...mapState(["allFoods", "user"]),

        filterFoods: function () {
            return this.allFoods.filter(
                (f) => this.matchID(f, this.cartItem)
            );
        },
    },

    methods: {
        matchID: function (food, cartArray) {
            let temp = "";
            cartArray.forEach(element => {
                if (parseInt(food.food_id) == element) {
                    temp = food
                }
            });
            return temp
        },

        calculateItemPrice: function (index) {
            return ((parseInt(this.filterFoods[index].food_price) - parseInt(this.filterFoods[index].food_discount)) * this.itemQuantity[index]).toString()
        },

        calculateSummaryPrice: function () {
            let subtotal = 0;
            let discount = 0;
            let delivery = 15;
            let i = 0;
            while (i < this.itemQuantity.length) {
                subtotal = subtotal + parseInt(this.filterFoods[i].food_price) * this.itemQuantity[i]
                discount = discount + parseInt(this.filterFoods[i].food_discount) * this.itemQuantity[i]
                i = i + 1
            }
            if (!this.filterFoods.length) {
                delivery = 0
            }
            let total = subtotal - discount + delivery;
            return [subtotal, discount, delivery, total];
        },

        async onQtyChange(e, i) {
            if (e.target.value < 1) {
                e.target.value = 1
                this.itemQuantity[i] = 1
            } else {
                this.itemQuantity[i] = e.target.value;
            }

            let data = {
                user_id: parseInt(this.user.user_id),
                food_id: parseInt(this.cartItem[i]),
                item_qty: this.itemQuantity[i]
            };
            await axios.put("/cartItem/", data)
        },

        async cancelBtn() {
            await axios.delete("/cartItem/" + this.user.user_id);

            this.cartItem = [];
            this.itemQuantity = [];
        },

        checkOutBtn: function () {
            this.$router.push("/checkout");
        },

        async removeBtn(index) {
            await axios.delete("/cartItem/" + this.user.user_id + "/" + this.cartItem[index]);

            this.cartItem.splice(index, 1);
            this.itemQuantity.splice(index, 1);
        },

        async getAllCartItem() {
            if (this.user) {
                let existItem = await axios.get('/cartItem/' + this.user.user_id);
                existItem.data.forEach(element => {
                    this.cartItem.push(element.food_id);
                    this.itemQuantity.push(element.item_qty);
                });
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

}
</script>


<style scoped>
.shopping-cart-section {
    background: #fff;
    padding: 4rem 9%;
}

.item-name {
    color: #27ae60
}

.cart-product-img {
    text-align: center;
    width: 100%;
    height: 125px;
    object-fit: cover;
    background-color: #f7f7f7;

}

.box {
    clear: both;
    margin: 0;
    margin-bottom: 20px;
    padding: 0;
}

.box:after,
.box:before {
    display: table;
}

.box-title {
    background-color: inherit;
    border-color: #e7eaec;
    border-style: solid solid none;
    border-width: 3px 0 0;
    color: inherit;
    margin-bottom: 0;
    padding: 14px 15px 7px;
    min-height: 78px;
}

.box-content {
    background-color: inherit;
    color: inherit;
    padding: 15px 20px 20px 20px;
    border-color: #e7eaec;
    border-image: none;
    border-style: solid solid none;
    border-width: 1px 0;

}

.item-desc b {
    font-size: 12px;
}

.item-desc p {
    font-size: 10px;
}

.sale-price,
.first-price,
.item-quantity {
    font-size: 12px;
}

.item-quantity {
    width: 60px;
    height: 15px;
}

.first-price {
    text-decoration: line-through;
}

.remove-btn {
    font-size: 10px;
    padding: 5px;
    margin-top: 27px;
}

.remove-btn i {
    padding-right: 5px;
}

.box-content button i,
.box-content a i {
    padding-right: 5px;
}

.no-food {
    text-align: center;
    justify-content: center;
    display: block;
}

.no-food .image img {
    width: 200px;
    height: 200px;
}

.checkbtn{
    margin-left: 210px;
    position: relative;
    bottom: 42px;
}
.backbtn{
    margin-right: 90px;
}
@media (max-width: 768px) {
    .box-content .item-name {
        font-size: 14px;
    }

    .desc button {
        position: absolute;
        bottom: 0;
    }

    .box-content .btn-group {
        display: block;
    }

    .box-content .btn-group button {
        border-radius: .5rem !important;
    }

    .box-content .btn-group button i {
        margin-top: 3px;
    }

    .box-content .btn-group .check-out-btn {
        display: flex;
        margin-top: 10px;
        margin-bottom: 10px;
    }
    
.checkbtn{
    margin-left: 160px;
    position: relative;
    bottom: 33.5px;
}
}

@media (max-width: 576px) {

    .box-title {
        min-height: 48px;
    }

    .box-title.item-total {
        border: none;
    }

    .in-cart .box-content .btn-group {
        margin-top: 5px;
        display: inline-flex;
    }

    .in-cart .box-content .btn-group .check-out-btn {
        display: flex;
        margin-top: 0px;
        margin-right: 5px;
        margin-bottom: 0px;
    }

    .image-box {
        position: absolute;
        opacity: 0.8;
        max-width: 100%;
        width: 100%;
        max-height: 100%;
        filter: brightness(60%);
        padding: none;
    }

    .image-box img {
        border-radius: 15px;

    }

    .in-cart .box-content {
        color: white;
        margin-left: -25px;
        border: none;
        display: flex;
    }

    .desc .item-name {
        font-size: 16px;
        filter: brightness(160%);
    }

    .desc b {
        font-size: 10px;
    }

    .desc p {
        font-size: 12px;
    }

    .desc .remove-btn {
        font-size: 10px;
        position: relative;

    }

    .item-price {
        position: absolute;
        margin-top: 55px;
    }

    .item-price .first-price {
        display: inline;
        padding-left: 5px;
        color: red !important;
    }

    .item-qty {
        position: absolute;
        margin-top: 55px;
        padding-left: 160px;
    }

    .cal-total {
        display: none;
    }

    .in-cart .box-content .check-out-btn {
        display: block;
    }
    
.checkbtn{
    margin-left: 160px;
    position: relative;
    bottom: 33.5px;
}

}
</style>