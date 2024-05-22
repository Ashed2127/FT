import {createStore} from "vuex"
import axios from "axios"

const store = createStore({
    state() {
        return {
          allFoods: [],
          user: undefined,
          admin: undefined,
          deliver_person: undefined,
        };
    },
    mutations: {
        setFoodsData(state, payload){
            state.allFoods = payload;
        },
        setUser(state, payload){
            state.user = payload;
        },
        setAdmin(state, payload){
            state.admin = payload;
        },
        setDp(state, payload){
            state.dp = payload;
        },
        
    },
    actions: {
        async getFoodsData(context){
                await axios.get('/foods')
            .then(function (response) {
                context.commit("setFoodsData", response.data);
            })
            .catch(function (error) {
                console.log(error);
            });
            
        },

        ////////////updater/////////////
        //  async pollFoodsData(context) {
        //     // Polling interval in milliseconds (e.g., 10 seconds)
        //     const pollingInterval = 1000;

        //     setInterval(async () => {
        //         try {
        //             const response = await axios.get('/foods');
        //             context.commit("setFoodsData", response.data);
        //         } catch (error) {
        //             console.error(error);
        //         }
        //     }, pollingInterval);
        // },
    },
});

export default store;