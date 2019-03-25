import './assets/style/bootstrap.min.css';
import 'bootstrap-vue/dist/bootstrap-vue.css'
import './assets/style/style.css';
import $ from 'jquery';
import 'bootstrap';
import Humanize from './libraries/humanize.min.js';
import Vue from 'vue';
import BootstrapVue from 'bootstrap-vue';
import App from './App.vue';

Vue.use(BootstrapVue);

Vue.mixin({
	methods: {
		capitalize: function(string){
			return Humanize.capitalize(string);
		},
		formatDateTime: function(dateString){
			var d = new Date(dateString);
			return d.toLocaleString('en-US');
		}
	}
});

new Vue({
	el: '#app', 
	render: h => h(App)
});