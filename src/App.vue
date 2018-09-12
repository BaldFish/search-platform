<template>
  <div id="app">
    <div class="head-wrap">
      <my-toggle :toggleIndex="toggleIndex"></my-toggle>
    </div>

    <div class="search">
      <div class="search-box">
        <div class="search-input">
          <input type="text" placeholder="请输入你想要的商品名称">
        </div>
        <button type="button">搜索</button>
        <div style="clear: both"></div>
        <span class="search-tips">百万积分大派送， 微信支付送等额可行积分！</span>
      </div>
    </div>

    <div class="main_wrap">
      <router-view class="main" v-if="isRouterAlive"></router-view>
    </div>

    <div class="footer-wrap">
      <div class="footer">
        <div class="ft-box">
          <a href="/">
            <p>Trusted Assets Blockchain</p>
          </a>
        </div>
        <div class="ft-box">
          <span>资产服务</span>
          <ul class="text">
            <li><a href="javascript:void(0)">维修案例</a></li>
            <li><a href="javascript:void(0)">维修设备</a></li>
            <li><a href="javascript:void(0)">汽车资产</a></li>
            <li><a href="javascript:void(0)">汽车零部件</a></li>
          </ul>
        </div>
        <div class="ft-box">
          <ul class="code">
            <li>
              <a href="javascript:void(0)">
                <img class="ft_code" src="./common/images/Android.png" alt="Android">
                <p>Android版</p>
              </a>
            </li>
            <li>
              <a href="javascript:void(0)">
                <img class="ft_code" src="./common/images/IOS.png" alt="IOS">
                <p>IOS版</p>
              </a>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import "@/common/stylus/index.styl";
  import {baseURL, cardURL} from '@/common/js/public.js';
  import myTopSearch from "@/components/topSearch/topSearch"
  import myToggle from "@/components/toggle/toggle"
  
  export default {
    name: 'App',
    components: {
      myTopSearch,
      myToggle,
    },
    provide() {
      return {
        reload: this.reload
      }
    },
    data() {
      return {
        isRouterAlive: true,
        switchover: false,

        userName: "",
        toggleIndex: 0,

      }
    },
    beforeMount() {
      if (JSON.parse(sessionStorage.getItem("loginInfo"))) {
        this.isLogin = true;
        this.userName = JSON.parse(sessionStorage.getItem("userName")).phone
      } else {
        this.isLogin = false
      }
      this.changTop()
    },
    beforeUpdate() {
      if (JSON.parse(sessionStorage.getItem("loginInfo"))) {
        this.isLogin = true;
        this.userName = JSON.parse(sessionStorage.getItem("userName")).phone
      } else {
        this.isLogin = false
      }
      this.changTop()
    },
    computed: {},
    watch: {},
    methods: {
      changTop() {
        if (this.$route.path == "/login") {
          this.isShowTopSearch = false;
          this.isShowLogin = true;
          this.isShowRegister = false;
          this.isShowForgetPassword = false;
        } else if (this.$route.path == "/register") {
          this.isShowTopSearch = false;
          this.isShowLogin = false;
          this.isShowRegister = true;
          this.isShowForgetPassword = false;
        } else if (this.$route.path == "/forgetPassword") {
          this.isShowTopSearch = false;
          this.isShowLogin = false;
          this.isShowRegister = false;
          this.isShowForgetPassword = true;
        } else {
          this.isShowTopSearch = true;
          this.isShowLogin = false;
          this.isShowRegister = false;
          this.isShowForgetPassword = false;
        }
      },
      reload() {
        this.isRouterAlive = false;
        this.$nextTick(() => {
          this.isRouterAlive = true
        })
      },
      dropOut(command) {
        sessionStorage.removeItem('loginInfo');
        sessionStorage.removeItem('userInfo');
        sessionStorage.removeItem('userName');
        this.switchover = false;
        location.reload()
      },
      toggle() {
        this.switchover = !this.switchover
      },
      leaveUl() {
        this.switchover = false
      },
    }
  }
</script>

<style scoped lang="stylus">
  #app {
    min-height: 98vh;
    display: flex;
    flex-direction: column;
  }
  
  .head-wrap {
    width: 100%;
    min-width 1212px
    height: auto;
    z-index: 9999;
    .head {
      box-sizing: border-box
      width: 1212px;
      margin: 0 auto;
      text-align right
      line-height 34px
      a {
        color: #666666;
      }
      .no_login {
        display inline-block
        width 160px
        a {
          margin-left 28px
          color: #666666;
        }
      }
      .login {
        display inline-block
        cursor pointer
        width 160px
        position relative
        ul {
          background-color #ffffff
          position absolute
          top 34
          right 0
          text-align center
          width 86px
          color #666666
          li:hover {
            color #c6351e
            a {
              color #c6351e
            }
          }
        }
      }
    }

  }

  .search{
    width: 100%;
    height: 100px;
    background-color: #ffffff;
    box-shadow: -1px 3px 6px 1px rgba(0, 0, 0, 0.13);
    margin-bottom: 22px;
    .search-box{
      width:1040px
      margin:0 auto
      margin-top: 18px;
      .search-input{
        width: 857px;
        height: 45px;
        border: solid 2px #d92104;
        float left
        font-size: 14px;
        box-sizing:border-box;
        input{
          outline none
          position: relative;
          left: 16px;
          top: 12px;
          width: 820px;
        }
      }
      button{
        width: 173px;
        height: 45px;
        background-color: #d92104;
        outline: none;
        border: none;
        cursor: pointer;
        font-size: 16px;
        color: #fff;
        margin-left: 6px;
      }
      .search-tips{
        font-size: 12px;
        color: #d92104;
        margin: 10px 0
        display: inline-block;
      }
    }
  }

  .login-header {
    width: 100%;
    height: 130px;
    background-color: #f3f3f3;
    .login-header-cont {
      width: 1200px;
      margin: 0 auto;
      height: 100%;
      padding-top 36px
      img {
        width: 280px;
        height: 58px;
        display: inline-block;
      }
    }
  }
  
  .forget_psw_header {
    width: 100%;
    height: 130px;
    background-color: #f3f3f3;
    section {
      width: 1200px;
      margin: 0 auto;
      padding-top: 36px;
      p {
        float: right;
        margin-top: 36px;
        font-size: 16px;
        color: #222222;
        .to_login {
          color: #c6351e;
        }
      }
    }
  }
  
  .main_wrap {
    flex: 1;
    box-sizing: border-box;
    margin: 0 auto;
    width 100%
    min-width 1212px
    background-color #f3f3f3
  }
  
  .footer-wrap {
    width 100%
    min-width 1212px
    background-color: #272324;
    .footer {
      box-sizing: border-box
      width 1212px
      height 156px
      margin 0 auto
      font-size 0
      text-align center
      .ft-box {
        display inline-block
        font-size 16px
        vertical-align top
        margin-right 66px
        span {
          padding-top 45px
          display block
          color #ffffff
          text-align left
        }
        .text {
          font-size 0
          li {
            padding-top 25px
            display inline-block
            font-size 14px
            margin-right 77px
            a {
              color #ffffff
            }
          }
          li:last-child {
            margin-right 0
          }
        }
        .code {
          font-size 0
          li {
            padding 30px 16px 0
            display inline-block
            font-size 14px
            a {
              color #ffffff
              p {
                font-size 16px
                color #ffffff
                padding-top 14px
              }
            }
          }
        }
      }
      .ft-box:last-child {
        margin-right -16px
      }
      .ft-box:first-child {
        margin-right 42px
        a {
          display inline-block
          color #d92000
          font-size 10px
          margin-top 38px
          background-image: url('./common/images/logo_footer.png');
          background-position: top left;
          background-repeat: no-repeat;
          width 240px
          height 82px
          position relative
          p {
            position absolute
            left 90px
            bottom 0
          }
        }
      }
    }
  }
</style>
