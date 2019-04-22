import Vue from 'vue'
import Router from 'vue-router'
import myHome from '@/components/home/home'
import myDeveloper from '@/components/developer/developer'
Vue.use(Router);

export default new Router({
  mode: 'history',
  routes: [
    {
      path: "/",
      redirect: "/home"
    },
    {
      path: '/home',
      name: 'home',
      component: myHome
    },
    {
      path:'/developer',
      name:'developer',
      component: myDeveloper
    },
  ]
})
