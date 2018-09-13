<template>
  <div id="app">
    <div class="head-wrap">
      <my-toggle :toggleIndex="toggleIndex"></my-toggle>
    </div>
    
    <div class="search">
      <div class="search-container">
        <div class="search-box">
          <div class="search-input">
            <input type="text" v-model="input" placeholder="请输入你想要的商品名称" @keyup.enter="search()">
          </div>
          <button type="button" @click="search()">搜索</button>
          <div style="clear: both"></div>
          <span class="search-tips">百万积分大派送， 微信支付送等额可信积分！</span>
        </div>
      </div>
    </div>
    <div class="main_wrap">
      <div class="searchReport">
        <div class="tab-change">
          <span class="tab-tips">最新上架资产：</span>
          <ul>
            <li v-for="(item,index) of searchField">
              <input type="radio" name="radio" @click="toggleSearch(item)">
              <div class="radio-box"><p>{{item}}</p></div>
            </li>
          </ul>
          <!--  <div class="more-search">
              <img src="@/components/searchReport/images/more.png" alt="">
              <span>更多搜索</span>
            </div>-->
        </div>
        <div v-if="isReport" class="search_type">
          <div class="type_territory">
            <span class="type_span">省市：</span>
            <area-select class="territory_input" v-model="territoryInput" :data="pca" type="text" @change="acquireSearchReportList"></area-select>
          </div>
          <div class="type_date">
            <span class="type_span">时间：</span>
            <el-date-picker class="date_input" v-model="dateInput" type="daterange" range-separator="至" start-placeholder="开始日期"
                            end-placeholder="结束日期"
                            format="yyyy-MM-dd" default-value="2018-01-01" size="small" @change="acquireSearchReportList">
            </el-date-picker>
          </div>
          <div class="type_vin">
            <span class="type_span">VIN码：</span>
            <el-input class="vin_input" v-model="vinInput" placeholder="请输入VIN" size="small" style="width:334px"
                      @change="acquireSearchReportList"></el-input>
          </div>
          <div class="type_vin">
            <span class="type_span">技师号：</span>
            <el-input class="vin_input" v-model="vinInput" placeholder="请输入技师号" size="small" style="width:334px"
                      @change="acquireSearchReportList"></el-input>
          </div>
          <div class="type_vin">
            <span class="type_span">里程：</span>
            <el-input class="vin_input" v-model="vinInput" placeholder="请输入里程" size="small" style="width:334px"
                      @change="acquireSearchReportList"></el-input>
            <span class="type_span" style="text-align: left;margin-left: 10px;">公里</span>
          </div>
          <div class="type_vin">
            <span class="type_span">诊断设备号：</span>
            <el-input class="vin_input" v-model="vinInput" placeholder="请输入诊断设备号" size="small" style="width:334px"
                      @change="acquireSearchReportList"></el-input>
          </div>
          <div class="type_vin">
            <span class="type_span">高级选项：</span>
            <template>
              <el-select v-model="value1" size="small" style="margin-right: 25px" placeholder="车系品牌">
                <el-option
                  v-for="item in options"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </template>
            <template>
              <el-select v-model="value2" size="small" style="margin-right: 25px" placeholder="车年款">
                <el-option
                  v-for="item in options"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </template>
            <template>
              <el-select v-model="value3" size="small" placeholder="车厂">
                <el-option
                  v-for="item in options"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </template>
          </div>
        </div>
        <div class="buy-all"  v-if="isAll">
          <span class="buy-tips">
            搜索出<span>{{total}}</span>条，总共<span>{{totalCount}}</span>条；一次性购买<span>1000</span>条以上可享优惠
          </span>
          <label>最新</label>
          <template>
            <el-select v-model="numbervalue" size="small" style="margin-right: 4px;width: 98px;" placeholder="请选择">
              <el-option
                v-for="item in number"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
          </template>
          <button type="button" class="buy-btn">一键认购</button>
        </div>
        <div class="case_list">
          <div class="fr_case" v-for="(item,index) of searchList" :key="item.id">
            <h4><a href="/caseDetails" @click="getReportDetails(item.id)" v-html="item.assetname"></a></h4>
            <div class="attestation">
              <span class="merchant" v-if="item.authtype==='认证商家'">{{item.authtype}}</span>
              <span class="person" v-if="item.authtype==='认证个人'">{{item.authtype}}</span>
              <span class="trust" v-if="item.creditlevel!=='未认证'">{{item.creditlevel}}</span>
            </div>
            <div v-if="item.apikey==='5a6be74a55aaf50001a5e250'">
              <div class="putaway">
                <a class="time" href="/caseDetails" @click="getCaseDetails(item.id)"><span>上架时间：</span>{{item.sell_at}}</a>
                <a class="equity" href="/caseDetails" @click="getCaseDetails(item.id)"><span>权益：</span>{{item.sell_type}}</a>
              </div>
              <div class="belong">
                <a href="/caseDetails" @click="getCaseDetails(item.id)">
                  <span>所属人：</span>{{item.assetowner}}
                </a>
              </div>
              <div class="fault">
                <p>
                  <a href="/caseDetails" @click="getCaseDetails(item.id)">
                    <span>故障现象：</span><span v-html="item.assetcontent"></span>
                  </a>
                </p>
              </div>
            </div>
            <div v-if="item.apikey==='5b18a5b9cff7cb000194f2f7'">
              <div class="putaway putaway-report">
                <a class="time" href="/reportDetails" @click="getReportDetails(item.id)"><span>报告生成时间：</span>{{item.generate_time}}</a>
                <a class="data" href="/reportDetails" @click="getReportDetails(item.id)"><span>数据来源：</span>{{item.resource}}</a>
              </div>
              <div class="putaway putaway-report">
                <a class="vin" href="/reportDetails" @click="getReportDetails(item.id)"><span>VIN码：</span>{{item.vin}}</a>
                <a class="breakdown" href="/reportDetails" @click="getReportDetails(item.id)"><span>故障码个数：</span>{{item.fault_n}}个</a>
                <a class="equity" href="/reportDetails" @click="getReportDetails(item.id)"><span>权益：</span>{{item.sell_type}}</a>
              </div>
            </div>
            <!--<div :class="item.shopcart_id?'like':'dislike'" @click="toggleLike(item.id)">收藏</div>-->
            <div class="price_box">
              <a href="/caseDetails" @click="getCaseDetails(item.id)"><p class="price">{{item.price}}</p></a>
              <!-- <a href="/caseSource" @click="getCaseSource(item.id)"><p class="tracing">可信溯源</p></a>
               <a href="javascript:void(0)" @click="buy(item.id)"><p class="buy">一键购买</p></a>-->
            </div>
            <div class="bar"></div>
          </div>
        </div>
        <div class="clearfix paging">
          <el-pagination class="my_paging"
                         layout="prev, pager, next"
                         :background=true
                         :total=total
                         :page-size=limit
                         :current-page.sync=page
                         @current-change="handleCurrentChange">
          </el-pagination>
        </div>
      </div>
      <!--    <router-view class="main"></router-view>-->
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
  import "@/common/stylus/paging.styl";
  import axios from "axios";
  import _ from "lodash";
  import {baseURL, cardURL} from '@/common/js/public.js';
  import myTopSearch from "@/components/topSearch/topSearch"
  import myToggle from "@/components/toggle/toggle"
  import utils from "@/common/js/utils.js";
  import {pca, pcaa} from 'area-data';
  
  const querystring = require('querystring');
  
  export default {
    name: 'App',
    components: {
      myTopSearch,
      myToggle,
    },
    data() {
      return {
        page: 1,
        limit: 10,
        total: 10,
        totalCount:"",
        input: "",
        searchType:"all",
        isAll:false,
        territoryInput: [],
        dateInput: ["", ""],
        vinInput: "",
        pca: pca,
        searchList: [],
        userId: "",
        token: "",
        apiKey: "",
        assetId: "",
        id: "",
        toggleIndex: 0,
        isReport: false,
        searchField: ["诊断报告", "维修案例"],
        options: [{
          value: '选项1',
          label: '一汽大众'
        }, {
          value: '选项2',
          label: '本田'
        }, {
          value: '选项3',
          label: '宝马'
        }, {
          value: '选项4',
          label: '广汽传祺'
        }, {
          value: '选项5',
          label: '雪佛莱'
        }],
        value1: '',
        value2: '',
        value3: '',
        number: [{
          value: '选项1',
          label: '1000'
        }, {
          value: '选项2',
          label: '2000'
        }, {
          value: '选项3',
          label: '3000'
        }],
        numbervalue: '',
      }
    },
    mounted() {
      if (JSON.parse(sessionStorage.getItem("loginInfo"))) {
        this.userId = JSON.parse(sessionStorage.getItem("loginInfo")).user_id;
        this.token = JSON.parse(sessionStorage.getItem("loginInfo")).token;
      }
      this.acquireSearchAllList();
    },
    computed: {
      searchValue: function () {
        return this.$store.state.searchValue
      },
      searchInput: function () {
        return this.$store.state.searchInput
      },
      newTerritoryInput: function () {
        if (this.territoryInput.length !== 0) {
          return this.territoryInput
        } else {
          return ["", ""]
        }
      }
    },
    watch: {
      searchInput: function () {
        this.acquireSearchReportList();
      },
    },
    methods: {
      search() {
        if(this.searchType==="all"){
          this.acquireSearchAllList();
        }else if(this.searchType==="report"){
          this.acquireSearchReportList()
        }else if(this.searchType==="case"){
          this.acquireSearchCaseList()
        }
      },
      toggleSearch(val) {
        if (val === "诊断报告") {
          this.isReport = true;
          this.isAll=true;
          this.searchType="report";
          this.page=1;
          this.acquireSearchReportList();
        } else if(val === "维修案例"){
          this.isReport = false;
          this.isAll=true;
          this.searchType="case";
          this.page=1;
          this.acquireSearchCaseList();
        }
      },
      //获取搜索所有列表
      acquireSearchAllList() {
        axios({
          method: "GET",
          url: `${baseURL}/v1/asset/search_all?key=${this.input}&page=${this.page}&limit=${this.limit}`,
          headers: {
            "Content-Type": "application/json",
          }
        }).then((res) => {
          this.total = res.data.count;
          for (let v of res.data.data) {
            v.assetname = utils.searchHighlight(v.assetname, this.input, "color", "#c6351e");
            if (v.apikey === "5a6be74a55aaf50001a5e250") {
              v.sell_at = utils.formatDate(new Date(v.sell_at), "yyyy-MM-dd hh:mm:ss");
              v.assetcontent = utils.searchHighlight(v.assetcontent, this.input, "color", "#c6351e");
            } else if (v.apikey === "5b18a5b9cff7cb000194f2f7") {
              v.generate_time = utils.formatDate(new Date(v.generate_time), "yyyy-MM-dd hh:mm:ss");
            }
          }
          this.searchList = res.data.data;
        }).catch((err) => {
          console.log(err);
        })
      },
      //获取搜索诊断报告列表
      acquireSearchReportList() {
        axios({
          method: "GET",
          url:
            `${baseURL}/v1/asset/diagnoseReport/search?key=${this.input}&page=${this.page}&limit=${this.limit}&province=${this.newTerritoryInput[0]}&city=${this.newTerritoryInput[1]}&vin=${this.vinInput}&start_time=${this.dateInput[0]}&end_time=${this.dateInput[1]}`,
          headers: {
            "Content-Type": "application/json",
          }
        }).then((res) => {
          if (res.data.data === null) {
            this.searchList = [];
            this.total = res.data.count;
            this.totalCount = res.data.total_count;
            return;
          } else {
            this.total = res.data.count;
            this.totalCount = res.data.total_count;
            for (let v of res.data.data) {
              v.generate_time = utils.formatDate(new Date(v.generate_time), "yyyy-MM-dd hh:mm:ss");
              v.sell_at = utils.formatDate(new Date(v.sell_at), "yyyy-MM-dd hh:mm:ss");
              v.assetname = utils.searchHighlight(v.assetname, this.input, "color", "#c6351e");
            }
            this.searchList = res.data.data;
          }
        }).catch((err) => {
          console.log(err);
        })
      },
      //获取搜索案例列表
      acquireSearchCaseList() {
        axios({
          method: "GET",
          url: `${baseURL}/v1/asset/casus/search?key=${this.input}&page=${this.page}&limit=${this.limit}`,
          headers: {
            "Content-Type": "application/json",
          }
        }).then((res) => {
          this.total = res.data.count;
          this.totalCount = res.data.total_count;
          for (let v of res.data.data) {
            v.sell_at = utils.formatDate(new Date(v.sell_at), "yyyy-MM-dd hh:mm:ss");
            v.assetname = utils.searchHighlight(v.assetname, this.input, "color", "#c6351e");
            v.assetcontent = utils.searchHighlight(v.assetcontent, this.input, "color", "#c6351e");
          }
          this.searchList = res.data.data;
        }).catch((err) => {
          console.log(err);
        })
      },
      getReportDetails(val) {
        this.$store.commit("changeReportDetails", _.find(this.searchList, function (o) {
          return o.id === val
        }));
      },
      getCaseDetails(val) {
        this.$store.commit("changeCaseDetails",_.find(this.searchList,function (o) {
          return o.id===val
        }));
      },
      handleCurrentChange(val) {
        this.page = val;
        this.search()
      },
      open() {
        this.$confirm('此操作需要先登录, 是否登录?', '提示', {
          confirmButtonText: '是',
          cancelButtonText: '否',
          type: 'warning',
          center: true
        }).then(() => {
          this.$router.push("/login")
        }).catch(() => {
        });
      },
      /*buy(val) {
        if (JSON.parse(sessionStorage.getItem("loginInfo"))) {
          let buyInfoObj = _.find(this.searchReportList, function (o) {
            return o.id === val
          });
          this.apiKey = buyInfoObj.apikey;
          this.assetId = buyInfoObj.assetid;
          let data = {};
          data.nums = 1;
          axios({
            method: "POST",
            url: `${baseURL}/v1/order/${this.userId}/${this.apiKey}/${this.assetId}`,
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
              "X-Access-Token": this.token,
            },
            data: querystring.stringify(data),
          }).then((res) => {
            buyInfoObj = res.data;
            this.getBuy(buyInfoObj);
            this.$router.push("/checkOrder")
          }).catch((err) => {
            console.log(err);
          })
        } else {
          this.open()
        }
      },
      getBuy(val) {
        this.$store.commit("changeBuy", val);
      },
      toggleLike(val) {
        if (sessionStorage.getItem("loginInfo")) {
          let likeInfo = _.find(this.searchReportList, function (o) {
            return o.id === val
          });
          this.apiKey = likeInfo.apikey;
          this.assetId = likeInfo.assetid;
          if (likeInfo.shopcart_id === "") {
            axios({
              method: "POST",
              url: `${baseURL}/v1/shopcart/${this.userId}/${this.apiKey}/${this.assetId}`,
              headers: {
                "Content-Type": "application/x-www-form-urlencoded",
                "X-Access-Token": this.token
              }
            }).then((res) => {
              this.id = res.data._id;
              likeInfo.shopcart_id = this.id;
              this.addCollection()
            }).catch((err) => {
              console.log(err);
            });
          } else if (likeInfo.shopcart_id !== "") {
            this.id = likeInfo.shopcart_id;
            axios({
              method: "DELETE",
              url: `${baseURL}/v1/shopcart/${this.userId}/${this.id}`,
              headers: {
                "Content-Type": "application/x-www-form-urlencoded",
                "X-Access-Token": this.token
              }
            }).then((res) => {
              likeInfo.shopcart_id = "";
              this.subtractCollection()
            }).catch((err) => {
              console.log(err);
            });
          }
        } else {
          this.open()
        }
      },
      addCollection() {
        this.$store.commit("addCollection")
      },
      subtractCollection() {
        this.$store.commit("subtractCollection")
      },*/
    },
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
  
  .search {
    width: 100%;
    height: 100px;
    background-color: #ffffff;
    box-shadow: -1px 3px 6px 1px rgba(0, 0, 0, 0.13);
    margin-bottom: 22px;
    .search-container {
      width: 1200px
      margin: 0 auto
      .search-box {
        width: 1040px
        margin: 0 auto
        margin-top: 18px;
        .search-input {
          width: 857px;
          height: 45px;
          border: solid 2px #d92104;
          float left
          font-size: 14px;
          box-sizing: border-box;
          input {
            outline none
            position: relative;
            left: 16px;
            top: 12px;
            width: 820px;
          }
        }
        button {
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
        .search-tips {
          font-size: 12px;
          color: #d92104;
          margin: 10px 0
          display: inline-block;
        }
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

<style scoped lang="stylus">
  .searchReport {
    
    .tab-change {
      width: 1200px
      height: 50px
      margin: 0 auto
      .tab-tips {
        font-size: 16px;
        color: #666666;
        display inline-block
        line-height: 50px
      }
      ul {
        width: 1078px;
        height: 50px;
        background-color: #ffffff;
        float right
        li {
          float left
          width: 160px;
          height: 50px;
          line-height 50px
          font-size: 16px;
          color: #d91e01;
          input {
            width: 160px;
            height: 50px;
            position: relative;
            z-index: 10;
            cursor: pointer;
            opacity 0
          }
          input:checked + .radio-box {
            background-color #d91e01
            color: #fff
          }
          .radio-box {
            position: relative;
            bottom: 70px;
            text-align: center;
            height: 50px;
          }
        }
      }
      .more-search {
        font-size: 13px;
        color: #666;
        position: relative;
        bottom: 31px;
        left: 1100px;
        cursor: pointer;
        width: 100px;
        img {
          margin-right 6px
        }
      }
    }
    .buy-all {
      width 1200px
      margin: 0 auto
      margin-top: 20px;
      .buy-tips {
        font-size: 13px;
        color: #666666;
        margin-right 48px
        margin-left: 525px;
        span {
          color: #d91e01;
        }
      }
      label {
        font-size: 14px;
        color: #666666;
        margin-right 8px
      }
      .buy-btn {
        outline: none
        width: 97px;
        height: 30px;
        background-color: #d92104;
        border none
        cursor pointer
        font-size: 14px;
        color: #ffffff;
        position: relative;
        top: 1px;
      }
    }
    
    .search_type {
      width 1198px
      margin 0 auto
      background-color: #fafafa;
      box-shadow: 0px 0px 13px 1px rgba(2, 2, 2, 0.16);
      border: solid 1px #dcdcdc;
      margin-top 20px
    }
    
    .case_list {
      width 1212px
      margin 0 auto
      padding-top: 12px
      .fr_case {
        margin 0 auto
        margin-bottom 18px
        position relative
        box-sizing border-box
        width 1198px
        height 220px
        background-color rgba(255, 255, 255, 0.8)
        /*opacity: 0.8;*/
        padding 15px 20px
        h4 {
          width 1060px
          overflow: hidden;
          text-overflow: ellipsis;
          white-space: nowrap;
          a {
            color: #222222;
            font-size: 20px;
          }
        }
        .attestation {
          width 800px
          height 74px
          font-size 0px
          span {
            text-align center
            color #ffffff
            font-size 14px
            display inline-block
            width 70px
            height 30px
            line-height 30px
            margin-right 14px
            margin-top 14px
            margin-bottom 30px
          }
          .trust {
            background-color #99c7ff
          }
          .person {
            background-color #ffdd99
          }
          .merchant {
            background-color #ffa799
          }
        }
        .putaway {
          a {
            padding-left 26px
            padding-top 2px
            padding-bottom 2px
            color #666666;
            font-size 14px
            margin-right 43px
            background-repeat: no-repeat;
            background-position: top left;
            line-height 22px
            span {
              color #222222;
              font-size 16px
            }
          }
          .time {
            background-image: url('./components/searchReport/images/time.png');
          }
          .data {
            background-image: url('./components/searchReport/images/data.png');
          }
          .vin {
            background-image: url('./components/searchReport/images/vin.png');
            width 250px
            display: inline-block;
          }
          .breakdown {
            background-image: url('./components/searchReport/images/breakdown.png');
            width 140px
          }
          .equity {
            background-image: url('./components/searchReport/images/Profit.png');
          }
        }
        .putaway-report {
          margin-bottom 20px
        }
        .belong {
          a {
            display block
            line-height 22px
            padding-left 26px
            background-image: url('./components/searchReport/images/person.png');
            background-repeat: no-repeat;
            background-position: top left;
            color #666666;
            font-size 14px;
            span {
              color #222222;
              font-size 16px
            }
          }
        }
        .fault {
          p {
            padding-top 4px
            width 562px
            height 54px
            line-height 18px
            a {
              color #666666;
              font-size 14px
              display block
              display: -webkit-box;
              -webkit-box-orient: vertical;
              -webkit-line-clamp: 3;
              overflow: hidden;
              span:first-child {
                font-size 16px
                color #222222;
              }
            }
          }
        }
        .dislike {
          position absolute
          top 15px
          right 30px
          height 20px
          line-height 20px
          color: #979797;
          cursor pointer
          padding-left 26px
          background-image: url('./components/searchReport/images/dislike.png');
          background-repeat: no-repeat;
          background-position: top left;
        }
        .like {
          position absolute
          top 15px
          right 30px
          height 20px
          line-height 20px
          color: #c6351e;
          cursor pointer
          padding-left 26px
          background-image: url('./components/searchReport/images/like.png');
          background-repeat: no-repeat;
          background-position: top left;
        }
        .price_box {
          position absolute
          top 78px
          left 1000px
          .price {
            min-width 18px
            height 24px
            font-size: 24px;
            color: #c6351e;
            background-image: url('./components/searchReport/images/currency.png');
            background-repeat: no-repeat;
            background-position: top left;
            padding-left 26px
            margin-bottom 8px
          }
          .tracing {
            color: #f3b43f;
            font-size 14px
            background-image: url('./components/searchReport/images/credible.png');
            background-repeat: no-repeat;
            background-position: top left;
            padding-left 26px
            height 18px
            line-height 18px
            margin-bottom 24px
          }
          .buy {
            width 114px
            height 36px
            background-color #c6351e
            color #ffffff
            font-size 18px
            line-height 36px
            text-align center
          }
        }
        .bar {
          width 10px
          height 100%
          background-color #ff3b0b
          position absolute
          top 0
          right 0
        }
      }
      .fr_case:hover {
        box-shadow: 2px 1px 17px 1px rgba(98, 98, 98, 0.28);
      }
    }
    .fr_report:hover {
      box-shadow: 0px 0px 13px 1px rgba(218, 44, 89, 0.4);
    }
  }
</style>
<style lang="stylus">
  .search_type {
    font-size 0
    .type_span {
      box-sizing border-box
      display inline-block
      font-size 14px
      padding 10px 0
      text-align right
      width 100px
      color: #666666;
    }
    .type_territory {
      margin 10px 0
      .area-select-wrap {
        display: inline-block
        vertical-align top
        .area-select:nth-child(1) {
          margin-left 0
        }
      }
    }
    .type_date {
      margin 10px 0
      .el-range-editor--small.el-input__inner {
        height: 32px;
        width 334px
      }
      .el-range-editor.is-active, .el-range-editor.is-active:hover {
        border-color: #a1a4ad;
      }
    }
    .type_vin {
      margin 10px 0
      .el-input {
        vertical-align top
        .el-input__inner:focus {
          border-color #a1a4ad
        }
      }
    }
  }

</style>
