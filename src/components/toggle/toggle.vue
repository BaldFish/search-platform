<template>
  <div class="toggle">
    <div class="toggle-box">
      <div class="logo">
        <img src="@/common/images/logo.jpg" alt="">
        <span>Trusted Assets Blockchain</span>
      </div>
      <ul>
        <li v-for="(item,index) of toggleParam" @click="toggle(index)" :class="{active:index===toggleIndex}">{{item}}</li>
      </ul>
    </div>
  </div>
</template>

<script>
  export default {
    name: "toggle",
    components: {},
    data() {
      return {
        toggleParam: ["搜索","交易平台", "转让平台"],
      }
    },
    props: {
      toggleIndex: {
        type: Number,
        default: 0
      },
    },
    created() {
    },
    mounted() {
    },
    watch: {},
    computed: {},
    methods: {
      toggle(index) {
        if (index === 0) {
          this.$router.push("/home")
        } else if (index === 1) {
/*          if(JSON.parse(sessionStorage.getItem("loginInfo"))&&JSON.parse(sessionStorage.getItem("userName"))){
            let info={};
            info.loginInfo=JSON.parse(sessionStorage.getItem("loginInfo"));
            info.userName=JSON.parse(sessionStorage.getItem("userName"));
            console.log(info);
            let popup = window.open('http://10.0.0.123:5001',"title");
            setTimeout(function () {
              popup.postMessage(info, 'http://10.0.0.123:5001');
            }, 2000);
          }else{
            window.open('http://10.0.0.123:5001')
          }*/
          window.open('http://47.92.98.66:5000')
        } else if (index === 2) {
          window.open('http://47.92.98.66:5001')
        }
      }
    },
  }
</script>

<style scoped lang="stylus">
  .toggle {
    width 100%
    border 1px solid #d91e01
    background-color #d91e01
    .toggle-box{
      width:1200px
      margin:0 auto
      .logo{
        width: 200px;
        color: #fff;
        font-size: 12px;
        float: left;
        margin-top: 4px;
        margin-right: 100px;
        span{
          margin-left: -50px;
        }
      }
      ul {
        width 1212px
        margin 0 auto
        font-size 0
        li {
          display inline-block
          margin-right 20px
          text-align center
          width 106px
          height 48px
          line-height 48px
          font-size: 16px;
          color: #f3f3f3;
          cursor pointer
        }
        li:active {
          background-color #ffffff
          color: #d91e01;
        }
        .active {
          background-color #ffffff
          color: #d91e01;
        }
      }
    }
  }

</style>
