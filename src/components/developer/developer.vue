<template>
  <div class="developer">
    <div class="dev">
      <ul>
        <li>
          <img src="./images/1.png" alt="">
          <div class="presentation">
            <h4>Engine API 白皮书</h4>
            <p>介绍了平台所提供的API接口，主要分为 HTTP 和 gRPC 两类，用于完成数据的上链存证、数据获取和查询、数据所在区块信息等操作。</p>
            <a href="javascript:void(0)">下载</a>
          </div>
        </li>
        <li></li>
        <li></li>
        <li></li>
      </ul>
    </div>
  </div>
</template>

<script>
  export default {
    name: "developer",
    components: {},
    data() {
      return {}
    },
    created() {
    },
    mounted() {
    },
    watch: {},
    computed: {},
    methods: {},
  }
</script>

<style scoped lang="stylus">
.developer{
  .dev{
    width 1212px
    height 600px
    background-color bisque
    margin 0 auto
    ul{
      li{
        img{
          width 142px
          height 172px
        }
        .presentation{
          box-sizing border-box
          width: 1016px;
          height: 120px;
          background-color: #ffffff;
          box-shadow: -1px 1px 7px 0px rgba(14, 14, 14, 0.1);
          border-radius: 4px;
          color: #333333;
          position relative
          padding-top 22px
          padding-left 46px
          h4{
            
            font-size: 20px;
          }
          p{
            font-size: 14px;
            margin-top 20px
          }
          a{
            //display inline-block
            position absolute
            top 46px
            right 20px
            background-color: #d92104;
            border-radius: 4px;
            padding 10px 18px
            color #ffffff
          }
        }
      }
    }
  }
}
</style>
