<template>
  <div class="home">
    <div class="search">
      <div class="search-container">
        <div class="tab-change">
          <ul>
            <li>
              <input type="radio" name="radioTop" @click.stop="toggleSearch('诊断报告')" ref="radioTop" checked>
              <div class="radio-box"><p>{{'诊断报告'}}</p></div>
            </li>
            <li>
              <input type="radio" name="radioTop" @click.stop="toggleSearch('维修案例')">
              <div class="radio-box"><p>{{'维修案例'}}</p></div>
            </li>
          </ul>
        </div>
        <div class="search_type" v-if="isReport">
          <div style="float: left">
            <div class="type_territory">
              <span class="type_span">省市：</span>
              <!--<area-select class="territory_input" v-model="territoryInput" :data="pca" type="text"></area-select>-->
              <template>
                <el-select v-model="province" clearable size="small" style="margin-right: 25px;width: 155px" placeholder="省份"
                           @change="acquireCityList">
                  <el-option
                    v-for="(item,index) in provinceList"
                    :key="index"
                    :label="item"
                    :value="item">
                  </el-option>
                </el-select>
              </template>
              <template>
                <el-select v-model="city" clearable size="small" style="margin-right: 25px;width: 155px" placeholder="城市">
                  <el-option
                    v-for="(item,index) in cityList"
                    :key="index"
                    :label="item"
                    :value="item">
                  </el-option>
                </el-select>
              </template>
            </div>
            <div class="type_vin">
              <span class="type_span">数据上链ID：</span>
              <el-input class="vin_input" v-model="idInput" placeholder="请输入上链ID" size="small" style="width:334px"></el-input>
            </div>
            <div class="type_vin">
              <span class="type_span">VIN码：</span>
              <el-input class="vin_input" v-model="vinInput" placeholder="请输入VIN" size="small" style="width:334px"></el-input>
            </div>
          </div>
          <div>
            <div class="type_date">
              <span class="type_span">时间：</span>
              <el-date-picker class="date_input" v-model="dateInput" type="daterange" range-separator="至" start-placeholder="开始日期"
                              end-placeholder="结束日期"
                              value-format="yyyy-MM-dd" default-value="2018-01-01" size="small">
              </el-date-picker>
            </div>
            <div class="type_vin">
              <span class="type_span">技师号：</span>
              <el-input class="vin_input" v-model="technicianInput" placeholder="请输入技师号" size="small" style="width:334px"></el-input>
            </div>
            <div class="type_vin">
              <span class="type_span">诊断设备号：</span>
              <el-input class="vin_input" v-model="facilityInput" placeholder="请输入诊断设备号" size="small" style="width:334px"></el-input>
            </div>
          </div>
          <div style="clear:both"></div>
          <div class="type_vin">
            <span class="type_span">高级选项：</span>
            <!--<template>
              <el-select v-model="value1" clearable size="small" style="margin-right: 25px;width: 120px" placeholder="车厂">
                <el-option
                  v-for="item in options"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </template>-->
            <template>
              <el-select v-model="brand" clearable size="small" style="margin-right: 25px;width: 120px" placeholder="车系品牌"
                         @change="acquireCarTypeList">
                <el-option
                  v-for="(item,index) in brandList"
                  :key="index"
                  :label="item"
                  :value="item">
                </el-option>
              </el-select>
            </template>
            <template>
              <el-select v-model="carType" clearable size="small" style="margin-right: 25px;width: 120px" placeholder="车型">
                <el-option
                  v-for="(item,index) in carTypeList"
                  :key="index"
                  :label="index"
                  :value="index">
                </el-option>
              </el-select>
            </template>
            <template>
              <el-select v-model="year" clearable size="small" style="margin-right: 25px;width: 120px" placeholder="车年款">
                <el-option
                  v-for="(item,index) in yearList"
                  :key="index"
                  :label="item"
                  :value="item">
                </el-option>
              </el-select>
            </template>
            <template>
              <el-select v-model="mileage" clearable size="small" style="margin-right: 25px;width: 120px" placeholder="里程">
                <el-option
                  v-for="item in mileageList"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </template>
          </div>
          <button type="button" @click="reportSearch">搜索</button>
        </div>
        <div class="search-box" v-if="isCase">
          <div class="search-input">
            <input type="text" v-model="input" placeholder="请输入你想要的商品名称" @keyup.enter="caseSearch">
          </div>
          <button type="button" @click="caseSearch">搜索</button>
          <div style="clear: both"></div>
          <span class="search-tips">
            <ul id="con1" ref="con1" :class="{anim:animate==true}">
              <li v-for='item in items'>{{item.name}}</li>
            </ul>
          </span>
        </div>
      </div>
    </div>
    <div class="searchReport">
      <div class="tab-change">
        <span class="tab-tips" v-if="newAsset">最新上架资产：</span>
        <ul v-if="newAsset">
          <!--<li>
            <input type="radio" name="radioFiltrate" @click="toggleFiltrate('全部')" checked>
            <div class="radio-box"><p>全部</p></div>
          </li>-->
          <li>
            <input type="radio" name="radioFiltrate" @click="toggleFiltrate('诊断报告')" checked>
            <div class="radio-box"><p>诊断报告</p></div>
          </li>
          <li>
            <input type="radio" name="radioFiltrate" @click="toggleFiltrate('维修案例')">
            <div class="radio-box"><p>维修案例</p></div>
          </li>
        </ul>
        <span class="tab-tips" v-if="!newAsset">搜索结果：{{searchType}}</span>
        <!--  <div class="more-search">
            <img src="@/components/searchReport/images/more.png" alt="">
            <span>更多搜索</span>
          </div>-->
      </div>
      <div class="fr buy-all" v-if="bulkBuying">
          <span class="buy-tips">
            <span v-if="search">为您找到相关结果<span class="mum">{{totalCount}}</span>条，</span>本次显示 <span class="mum">{{total}}</span>条
          </span>
        <label>最新</label>
        <template>
          <el-select v-model="buyCount" size="small" style="margin-right: 4px;width: 98px;" placeholder="请选择">
            <el-option
              v-for="item in number"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
        </template>
        <button type="button" class="buy-btn" @click="bulkBuy()">一键认购</button>
      </div>
      <div class="case_list">
        <div v-for="(item,index) of searchList" :key="item.id" @click="getDetails(item.apikey,item.assetid)">
          <div class="fr_case" v-if="item.apikey==='5a6be74a55aaf50001a5e250'">
            <h4><a href="javascript:void(0)" v-html="item.assetname"></a></h4>
            <div class="attestation">
              <span class="merchant" v-if="item.authtype==='认证商家'">{{item.authtype}}</span>
              <span class="person" v-if="item.authtype==='认证个人'">{{item.authtype}}</span>
              <span class="trust" v-if="item.creditlevel!=='未认证'">{{item.creditlevel}}</span>
            </div>
            <div>
              <div class="putaway">
                <a class="time" href="javascript:void(0)"><span>上架时间：</span>{{item.sell_at}}</a>
                <a class="equity" href="javascript:void(0)"><span>权益：</span>{{item.sell_type}}</a>
              </div>
              <div class="belong">
                <a href="javascript:void(0)">
                  <span>所属人：</span>{{item.assetowner}}
                </a>
              </div>
              <div class="fault">
                <p>
                  <a href="javascript:void(0)">
                    <span>故障现象：</span><span v-html="item.assetcontent"></span>
                  </a>
                </p>
              </div>
            </div>
            <!--<div :class="item.shopcart_id?'like':'dislike'" @click="toggleLike(item.id)">收藏</div>-->
            <div class="price_box">
              <a href="javascript:void(0)"><p class="price">¥{{item.price}}</p></a>
              <a href="/caseSource" @click="getCaseSource(item.id)"><p class="tracing">可信溯源</p></a>
              <a href="javascript:void(0)" @click.stop="buy(item.id)"><p class="buy">一键购买</p></a>
            </div>
            <div class="bar"></div>
          </div>
          <div class="fr_case" v-if="item.apikey==='5b18a5b9cff7cb000194f2f7'">
            <h4><a href="javascript:void(0)" v-html="item.assetname"></a></h4>
            <div class="attestation">
              <span class="merchant" v-if="item.authtype==='认证商家'">{{item.authtype}}</span>
              <span class="person" v-if="item.authtype==='认证个人'">{{item.authtype}}</span>
              <span class="trust" v-if="item.creditlevel!=='未认证'">{{item.creditlevel}}</span>
            </div>
            <div>
              <div class="putaway putaway-report">
                <a class="time" href="javascript:void(0)"><span>报告生成时间：</span>{{item.generate_time}}</a>
                <a class="data" href="javascript:void(0)"><span>数据来源：</span>{{item.resource}}</a>
              </div>
              <div class="putaway putaway-report">
                <a class="vin" href="javascript:void(0)"><span>VIN码：</span>{{item.vin}}</a>
                <a class="breakdown" href="javascript:void(0)"><span>故障码个数：</span>{{item.fault_n}}个</a>
                <a class="equity" href="javascript:void(0)"><span>权益：</span>{{item.sell_type}}</a>
              </div>
            </div>
            <!--<div :class="item.shopcart_id?'like':'dislike'" @click="toggleLike(item.id)">收藏</div>-->
            <div class="price_box">
              <a href="javascript:void(0)"><p class="price">¥{{item.price}}</p></a>
              <a href="/caseSource" @click="getCaseSource(item.id)"><p class="tracing">可信溯源</p></a>
              <a href="javascript:void(0)" @click.stop="buy(item.id)"><p class="buy">一键购买</p></a>
            </div>
            <div class="bar"></div>
          </div>
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
  </div>
</template>

<script>
  import axios from "axios";
  import _ from "lodash";
  import {baseURL, bigDataURL,loginPlatform} from '@/common/js/public.js';
  import utils from "@/common/js/utils.js";
  import {pca, pcaa} from 'area-data';
  
  const querystring = require('querystring');
  
  export default {
    name: "home",
    components: {},
    data() {
      return {
        page: 1,
        limit: 10,
        total: 10,
        totalCount: "",
        input: "",
        searchType: "",
        bulkBuying: true,
        search: false,
        newAsset: true,
        isReport: true,
        isCase: false,
        territoryInput: [],
        dateInput: ["", ""],
        idInput: "",
        technicianInput: "",
        vinInput: "",
        facilityInput: "",
        pca: pca,
        searchList: [],
        userId: "",
        token: "",
        apiKey: "",
        assetId: "",
        id: "",
        provinceList: [],
        cityList: [],
        brandList: [],
        carTypeList: {},
        yearList: [],
        mileageList: [{
          value: '0-10000',
          label: '1万以下'
        }, {
          value: '10000-30000',
          label: '1万-3万'
        }, {
          value: '30000-50000',
          label: '3万-5万'
        }, {
          value: '50000-100000',
          label: '5万-10万'
        }, {
          value: '100000-200000',
          label: '10万-20万'
        }, {
          value: '200000-500000',
          label: '20万-50万'
        }, {
          value: '500000-99999999',
          label: '50万以上'
        },],
        province: "",
        city: "",
        brand: "",
        carType: "",
        year: "",
        mileage: "",
        startMileage: "",
        endMileage: "",
        number: [],
        buyCount: '',
        bulkBuyData: {
          //nums:"",
          province: "",
          city: "",
          start_time: "",
          end_time: "",
          vin: "",
          brand: "",
          style: "",
          style_year: "",
          terminal_id: "",
          technician_id: "",
          start_mileage: "",
          end_mileage: "",
          uuid:"",
        },
        animate: false,
        items: [
          {name: "百万积分大派送！"},
          {name: "百万积分大派送， 今秋送好礼！"},
          {name: "百万积分大派送， 微信支付送等额数据豆！"}
        ]
      }
    },
    created() {
      setInterval(this.scroll, 2000)
    },
    mounted() {
      if (JSON.parse(sessionStorage.getItem("loginInfo"))) {
        this.userId = JSON.parse(sessionStorage.getItem("loginInfo")).user_id;
        this.token = JSON.parse(sessionStorage.getItem("loginInfo")).token;
      }
      this.acquireCacheReportList();
      //this.acquireSearchAllList();
      this.acquireProvinceList();
      this.acquireBrandList();
    },
    computed: {
      newTerritoryInput: function () {
        if (this.territoryInput.length !== 0) {
          return this.territoryInput
        } else {
          return ["", ""]
        }
      }
    },
    watch: {
      carType: function () {
        this.yearList = this.carTypeList[this.carType]
      },
      mileage: function () {
        this.startMileage = this.mileage.split("-")[0];
        this.endMileage = this.mileage.split("-")[1];
      }
    },
    methods: {
      login() {
        let redirectURL = window.location.href;
        let url=`?redirectURL=${redirectURL}`;
        window.location.href=`${loginPlatform}${url}`;
      },
      scroll() {
        this.animate = true;    // 因为在消息向上滚动的时候需要添加css3过渡动画，所以这里需要设置true
        setTimeout(() => {      //  这里直接使用了es6的箭头函数，省去了处理this指向偏移问题，代码也比之前简化了很多
          this.items.push(this.items[0]);  // 将数组的第一个元素添加到数组的
          this.items.shift();               //删除数组的第一个元素
          this.animate = false;  // margin-top 为0 的时候取消过渡动画，实现无缝滚动
        }, 500)
      },
      open() {
        this.$confirm('此操作需要先登录, 是否登录?', '提示', {
          confirmButtonText: '是',
          cancelButtonText: '否',
          type: 'warning',
          center: true
        }).then(() => {
          this.login();
        }).catch(() => {
        });
      },
      openNumHint() {
        this.$confirm('请选择购买数量', '提示', {
          confirmButtonText: '是',
          cancelButtonText: '否',
          type: 'warning',
          center: true
        }).then(() => {
        }).catch(() => {
        });
      },
      //搜索诊断报告
      reportSearch() {
        //this.$set(this.$refs.radioTop, 'checked', true)
        //this.$refs.radioTop.checked=true
        this.page = 1;
        this.number = [];
        this.acquireSearchReportList();
        this.bulkBuying = true;
        this.search = true;
        this.newAsset = false;
      },
      //搜索维修案例
      caseSearch() {
        this.page = 1;
        this.number = [];
        this.acquireSearchCaseList();
        this.bulkBuying = true;
        this.search = true;
        this.newAsset = false;
      },
      //顶部搜索类型切换
      toggleSearch(val) {
        if (val === "诊断报告") {
          this.isReport = true;
          this.isCase = false;
        } else if (val === "维修案例") {
          this.isReport = false;
          this.isCase = true;
        }
      },
      //最新上架资产按类型切换筛查
      toggleFiltrate(val) {
        this.page = 1;
        this.number = [];
        if (val === "全部") {
          this.acquireSearchAllList();
          this.bulkBuying = false;
        } else if (val === "诊断报告") {
          this.acquireCacheReportList();
          this.bulkBuying = true;
        } else if (val === "维修案例") {
          this.acquireSearchCaseList();
          this.bulkBuying = true;
        }
      },
      //获取搜索所有列表
      acquireSearchAllList() {
        this.searchType = "全部";
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
      //获取缓存诊断报告列表
      acquireCacheReportList() {
        this.searchType = "";
        //加载蒙层
        let loading = this.$loading({
          lock: true,
          text: '数据源较大，请耐心等待......',
          spinner: 'el-icon-loading',
          background: 'rgba(0, 0, 0, 0.7)'
        });
        axios({
          method: "GET",
          url:
            `${baseURL}/v1/asset/diagnoseReport?page=${this.page}&limit=${this.limit}`,
          headers: {
            "Content-Type": "application/json",
          }
        }).then((res) => {
          loading.close();//关闭蒙层
          if (res.data.data === null) {
            this.searchList = [];
            this.total = res.data.count;
            this.totalCount = res.data.total_count;
            return;
          } else {
            this.total = res.data.count;
            this.totalCount = res.data.total_count;
            this.number = res.data.levels;
            for (let v of res.data.data) {
              v.generate_time = utils.formatDate(new Date(v.generate_time), "yyyy-MM-dd hh:mm:ss");
              v.sell_at = utils.formatDate(new Date(v.sell_at), "yyyy-MM-dd hh:mm:ss");
              v.assetname = utils.searchHighlight(v.assetname, this.input, "color", "#c6351e");
            }
            this.$set(this.dateInput, "0", res.data.default_search.start_time);
            this.$set(this.dateInput, "1", res.data.default_search.end_time);
            this.bulkBuyData.start_time = res.data.default_search.start_time;
            this.bulkBuyData.end_time = res.data.default_search.end_time;
            this.searchList = res.data.data;
          }
        }).catch((err) => {
          console.log(err);
        })
      },
      //获取搜索诊断报告列表(默认最多返回1000条数据，返回数量是搜索时间最近两天的数量)
      acquireSearchReportList() {
        this.searchType = "诊断报告";
        //加载蒙层
        let loading = this.$loading({
          lock: true,
          text: '数据源较大，请耐心等待......',
          spinner: 'el-icon-loading',
          background: 'rgba(0, 0, 0, 0.7)'
        });
        this.buyCount = "";
        if (this.dateInput === null) {
          this.bulkBuyData = {
            province: this.province,
            city: this.city,
            start_time: "",
            end_time: "",
            vin: this.vinInput,
            brand: this.brand,
            style: this.carType,
            style_year: this.year,
            terminal_id: this.facilityInput,
            technician_id: this.technicianInput,
            start_mileage: this.startMileage,
            end_mileage: this.endMileage,
            uuid:this.idInput
          };
        } else {
          this.bulkBuyData = {
            province: this.province,
            city: this.city,
            start_time: this.dateInput[0],
            end_time: this.dateInput[1],
            vin: this.vinInput,
            brand: this.brand,
            style: this.carType,
            style_year: this.year,
            terminal_id: this.facilityInput,
            technician_id: this.technicianInput,
            start_mileage: this.startMileage,
            end_mileage: this.endMileage,
            uuid:this.idInput
          };
        }
        axios({
          method: "GET",
          url:
            `${baseURL}/v1/asset/diagnoseReport/search?page=${this.page}&limit=${this.limit}&province=${this.bulkBuyData.province}&city=${this.bulkBuyData.city}&start_time=${this.bulkBuyData.start_time}&end_time=${this.bulkBuyData.end_time}&uuid=${this.bulkBuyData.uuid}&technician_id=${this.bulkBuyData.technician_id}&vin=${this.bulkBuyData.vin}&terminal_id=${this.bulkBuyData.terminal_id}&brand=${this.bulkBuyData.brand}&style=${this.bulkBuyData.style}&style_year=${this.bulkBuyData.style_year}&start_mileage=${this.bulkBuyData.start_mileage}&end_mileage=${this.bulkBuyData.end_mileage}`,
          headers: {
            "Content-Type": "application/json",
          }
        }).then((res) => {
          loading.close();//关闭蒙层
          if (res.data.data === null) {
            this.searchList = [];
            this.total = res.data.count;
            this.totalCount = res.data.total_count;
            return;
          } else {
            this.total = res.data.count;
            this.totalCount = res.data.total_count;
            this.number = res.data.levels;
            for (let v of res.data.data) {
              v.generate_time = utils.formatDate(new Date(v.generate_time), "yyyy-MM-dd hh:mm:ss");
              v.sell_at = utils.formatDate(new Date(v.sell_at), "yyyy-MM-dd hh:mm:ss");
              v.assetname = utils.searchHighlight(v.assetname, this.input, "color", "#c6351e");
            }
            this.searchList = res.data.data;
          }
          if(this.bulkBuyData.uuid===""){
            this.acquireRealReportCount();
          }
        }).catch((err) => {
          console.log(err);
        })
      },
      //获取搜索诊断报告真实数据量
      acquireRealReportCount() {
        this.searchType = "诊断报告";
        //加载蒙层
        /*let loading = this.$loading({
          lock: true,
          text: '数据源较大，请耐心等待......',
          spinner: 'el-icon-loading',
          background: 'rgba(0, 0, 0, 0.7)'
        });*/
        this.buyCount = "";
        if (this.dateInput === null) {
          this.bulkBuyData = {
            province: this.province,
            city: this.city,
            start_time: "",
            end_time: "",
            vin: this.vinInput,
            brand: this.brand,
            style: this.carType,
            style_year: this.year,
            terminal_id: this.facilityInput,
            technician_id: this.technicianInput,
            start_mileage: this.startMileage,
            end_mileage: this.endMileage,
            uuid:this.idInput
          };
        } else {
          this.bulkBuyData = {
            province: this.province,
            city: this.city,
            start_time: this.dateInput[0],
            end_time: this.dateInput[1],
            vin: this.vinInput,
            brand: this.brand,
            style: this.carType,
            style_year: this.year,
            terminal_id: this.facilityInput,
            technician_id: this.technicianInput,
            start_mileage: this.startMileage,
            end_mileage: this.endMileage,
            uuid:this.idInput
          };
        }
        axios({
          method: "GET",
          url:
            `${baseURL}/v1/asset/diagnoseReport/count?province=${this.bulkBuyData.province}&city=${this.bulkBuyData.city}&start_time=${this.bulkBuyData.start_time}&end_time=${this.bulkBuyData.end_time}&uuid=${this.bulkBuyData.uuid}&technician_id=${this.bulkBuyData.technician_id}&vin=${this.bulkBuyData.vin}&terminal_id=${this.bulkBuyData.terminal_id}&brand=${this.bulkBuyData.brand}&style=${this.bulkBuyData.style}&style_year=${this.bulkBuyData.style_year}&start_mileage=${this.bulkBuyData.start_mileage}&end_mileage=${this.bulkBuyData.end_mileage}`,
          headers: {
            "Content-Type": "application/json",
          }
        }).then((res) => {
          //loading.close();//关闭蒙层
          /*if (res.data.data === null) {
            this.searchList = [];
            this.total = res.data.count;
            this.totalCount = res.data.total_count;
            return;
          } else {
            this.total = res.data.count;
            this.totalCount = res.data.total_count;
            this.number = res.data.levels;
            for (let v of res.data.data) {
              v.generate_time = utils.formatDate(new Date(v.generate_time), "yyyy-MM-dd hh:mm:ss");
              v.sell_at = utils.formatDate(new Date(v.sell_at), "yyyy-MM-dd hh:mm:ss");
              v.assetname = utils.searchHighlight(v.assetname, this.input, "color", "#c6351e");
            }
            this.searchList = res.data.data;
          }*/
          this.totalCount = res.data.total_count;
          this.number = res.data.levels;
        }).catch((err) => {
          console.log(err);
        })
      },
      //获取搜索案例列表
      acquireSearchCaseList() {
        this.searchType = "维修案例";
        //加载蒙层
        let loading = this.$loading({
          lock: true,
          text: '数据源较大，请耐心等待......',
          spinner: 'el-icon-loading',
          background: 'rgba(0, 0, 0, 0.7)'
        });
        axios({
          method: "GET",
          url: `${baseURL}/v1/asset/casus/search?key=${this.input}&page=${this.page}&limit=${this.limit}`,
          headers: {
            "Content-Type": "application/json",
          }
        }).then((res) => {
          loading.close();//关闭蒙层
          this.total = res.data.count;
          this.totalCount = res.data.total_count;
          this.number = res.data.levels;
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
      getDetails(apiKey, assetId) {
        var tempWindow=window.open('_blank');
        axios({
          method: "GET",
          url: `${baseURL}/v1/asset/redirect/${apiKey}/${assetId}`,
          headers: {
            "Content-Type": "application/json",
          }
        }).then((res) => {
          //window.open(`http://localhost:5000/caseDetails?apikey=${apiKey}&assetid=${assetId}`, "_blank")
          tempWindow.location=res.data.url
        }).catch((err) => {
          console.log(err);
        })
      },
      /*getReportDetails(val) {
        this.$store.commit("changeReportDetails", _.find(this.searchList, function (o) {
          return o.id === val
        }));
      },*/
      /*getCaseDetails(val) {
        this.$store.commit("changeCaseDetails", _.find(this.searchList, function (o) {
          return o.id === val
        }));
      },*/
      handleCurrentChange(val) {
        this.page = val;
        this.pagingSearch()
      },
      //分页获取相对应的列表
      pagingSearch() {
        if (this.searchType === "") {
          this.acquireCacheReportList();
        } else if (this.searchType === "诊断报告") {
          this.acquireSearchReportList();
        } else if (this.searchType === "维修案例") {
          this.acquireSearchCaseList();
        }
      },
      //批量购买创建订单
      bulkBuy(val) {
        if (JSON.parse(sessionStorage.getItem("loginInfo"))) {
          let buyInfoObj = this.searchList[0];
          this.apiKey = buyInfoObj.apikey;
          this.assetId = buyInfoObj.assetid;
          this.userId = JSON.parse(sessionStorage.getItem("loginInfo")).user_id;
          this.bulkBuyData.nums = this.buyCount;
          if (this.bulkBuyData.nums === "") {
            this.openNumHint()
          } else if(this.bulkBuyData.nums ==="1"){
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
              window.open(res.data.judge_url)
              //window.open(`http://localhost:5000/checkOrder?order_id=${res.data.orderNum}`)
            }).catch((err) => {
              console.log(err);
            })
          } else {
            axios({
              method: "POST",
              url: `${baseURL}/v1/order/batch/${this.userId}/${this.apiKey}`,
              headers: {
                "Content-Type": "application/x-www-form-urlencoded",
                "X-Access-Token": this.token,
              },
              data: querystring.stringify(this.bulkBuyData),
            }).then((res) => {
              window.open(res.data.judge_url)
              //window.open(`http://localhost:5000/checkOrder?order_id=${res.data.orderNum}`)
            }).catch((err) => {
              console.log(err);
            })
          }
        } else {
          this.open()
        }
      },
      //单独购买创建订单
      buy(val) {
        if (JSON.parse(sessionStorage.getItem("loginInfo"))) {
          let buyInfoObj = _.find(this.searchList, function (o) {
            return o.id === val
          });
          this.apiKey = buyInfoObj.apikey;
          this.assetId = buyInfoObj.assetid;
          this.userId = JSON.parse(sessionStorage.getItem("loginInfo")).user_id;
          let data = {};
          data.nums = 1;
          var tempWindow=window.open('_blank');
          axios({
            method: "POST",
            url: `${baseURL}/v1/order/${this.userId}/${this.apiKey}/${this.assetId}`,
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
              "X-Access-Token": this.token,
            },
            data: querystring.stringify(data),
          }).then((res) => {
            tempWindow.location=res.data.judge_url;
            //window.open(res.data.judge_url)
            //window.open(`http://localhost:5000/checkOrder?order_id=${res.data.orderNum}`)
          }).catch((err) => {
            console.log(err);
          })
        } else {
          this.open()
        }
      },
      /*getBuy(val) {
        this.$store.commit("changeBuy", val);
      },*/
      //获取车系品牌列表
      acquireBrandList() {
        axios({
          method: "GET",
          url: `${bigDataURL}/vehicle_brand/get_list`,
          headers: {
            "Content-Type": "application/json",
          }
        }).then((res) => {
          this.brandList = res.data.brand_list
        }).catch((err) => {
          console.log(err);
        })
      },
      //根据品牌获取车型列表
      acquireCarTypeList() {
        this.carTypeList = {};
        if (this.brand !== "") {
          axios({
            method: "POST",
            url: `${bigDataURL}/vehicle_type/get_list`,
            //data: querystring.stringify({brand:`${this.brand}`}),
            data: JSON.stringify({brand: `${this.brand}`})
          }).then((res) => {
            this.carTypeList = res.data;
          }).catch((err) => {
            console.log(err);
          })
        }
      },
      //获取省份列表
      acquireProvinceList() {
        axios({
          method: "GET",
          url: `${bigDataURL}/province/get_list`,
          headers: {
            "Content-Type": "application/json",
          }
        }).then((res) => {
          this.provinceList = res.data.province_list;
        }).catch((err) => {
          console.log(err);
        })
      },
      //根据省份获取城市列表
      acquireCityList() {
        this.cityList = [];
        this.city = "";
        if (this.province !== "") {
          axios({
            method: "POST",
            url: `${bigDataURL}/city/get_list`,
            data: JSON.stringify({province: `${this.province}`})
          }).then((res) => {
            this.cityList = res.data.city_list;
          }).catch((err) => {
            console.log(err);
          })
        }
      },
    },
  }
</script>

<style scoped lang="stylus">
  .home {
    .search {
      width: 100%;
      background-color: #ffffff;
      box-shadow: -1px 3px 6px 1px rgba(0, 0, 0, 0.13);
      .search-container {
        box-sizing border-box
        width: 1200px
        margin: 0 auto
        .tab-change {
          display inline-block
          height: 50px
          margin: 0 auto
          margin-left 30px
          /*.tab-tips {
            font-size: 16px;
            color: #666666;
            display inline-block
            line-height: 50px
          }*/
          ul {
            height: 50px;
            float left
            li {
              float left
              width: 160px;
              height: 50px;
              line-height 50px
              font-size: 16px;
              color: #333333;
              text-align center
              input {
                width: 100px;
                height: 50px;
                position: relative;
                z-index: 10;
                cursor: pointer;
                opacity 0
              }
              input:checked + .radio-box {
                color: #d91e01
              }
              .radio-box {
                position: relative;
                bottom: 69px;
                text-align: center;
                height: 50px;
              }
            }
          }
          /*.more-search {
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
          }*/
        }
        .search_type {
          box-sizing border-box
          width 1200px
          margin 0 auto
          background-color: #fafafa;
          box-shadow: 0px 0px 13px 1px rgba(2, 2, 2, 0.16);
          border: solid 1px #dcdcdc;
          position relative
          button {
            width: 120px;
            height: 45px;
            background-color: #c6351e;
            outline: none;
            border: none;
            cursor: pointer;
            font-size: 18px;
            color: #fff;
            position absolute
            top 72px
            right 80px
          }
          /*button:active {
            background-color: #ffffff;
            color: #d92104;
          }*/
        }
        .search-box {
          width: 1040px
          margin: 0 auto
          .search-input {
            box-sizing: border-box;
            float left
            width: 857px;
            height: 45px;
            border: solid 2px #d92104;
            font-size: 14px;
            input {
              width: 820px;
              outline none
              position: relative;
              top: 12px;
              left: 16px;
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
            line-height 20px
            height: 20px;
            overflow: hidden;
            cursor pointer
          }
        }
      }
    }
    
    .searchReport {
      width 1200px
      margin 0 auto
      .tab-change {
        display inline-block
        height: 50px
        margin: 0 auto
        .tab-tips {
          font-size: 16px;
          color: #666666;
          display inline-block
          line-height: 50px
        }
        ul {
          height: 50px;
          float right
          li {
            float left
            width: 100px;
            height: 50px;
            line-height 50px
            font-size: 16px;
            color: #333333;
            text-align center
            input {
              width: 100px;
              height: 50px;
              position: relative;
              z-index: 10;
              cursor: pointer;
              opacity 0
            }
            input:checked + .radio-box {
              color: #d91e01
            }
            .radio-box {
              position: relative;
              bottom: 69px;
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
        display inline-block
        margin: 0 auto
        margin-top: 9px;
        text-align right
        .buy-tips {
          font-size: 13px;
          color: #666666;
          margin-right 80px
          .mum {
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
      .case_list {
        width 1200px
        margin 0 auto
        .fr_case {
          cursor pointer
          width 1200px
          height 220px
          margin 0 auto
          margin-bottom 18px
          position relative
          box-sizing border-box
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
              background-image: url('./images/time.png');
            }
            .data {
              background-image: url('./images/data.png');
            }
            .vin {
              background-image: url('./images/vin.png');
              width 250px
              display: inline-block;
            }
            .breakdown {
              background-image: url('./images/breakdown.png');
              width 140px
            }
            .equity {
              background-image: url('./images/Profit.png');
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
              background-image: url('./images/person.png');
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
            background-image: url('./images/dislike.png');
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
            background-image: url('./images/like.png');
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
              //background-image: url('./images/currency.png');
              //background-repeat: no-repeat;
              //background-position: top left;
              //padding-left 26px
              margin-bottom 8px
            }
            .tracing {
              color: #f3b43f;
              font-size 14px
              background-image: url('./images/credible.png');
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
          box-shadow: 0px 0px 13px 1px rgba(218, 44, 89, 0.4);
        }
      }
    }
    .paging {
      width: 1080px;
      margin: 0 auto;
      text-align: center
      margin-bottom 20px
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
  
  #box {
    width: 300px;
    height: 32px;
    overflow: hidden;
    padding-left: 30px;
    border: 1px solid black;
  }
  
  .anim {
    transition: all 0.5s;
    margin-top: -30px;
  }
  
  #con1 li {
    list-style: none;
    height: 30px;
  }
</style>
