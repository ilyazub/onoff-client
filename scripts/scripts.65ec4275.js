(function(){"use strict";angular.module("onoffClientApp",["ngAnimate","ngCookies","ngResource","ngRoute","ngSanitize","ngTouch","restangular","ngStorage","ilyazub.dragndrop-object"]).config(["$routeProvider",function(a){return a.when("/",{templateUrl:"views/foreman.html",controller:"ForemanCtrl"}).otherwise({redirectTo:"/"})}]).config(["RestangularProvider","apiUrl",function(a,b){return a.setBaseUrl(b),a.setDefaultHttpFields({cache:!0,withCredentials:!0})}])}).call(this),function(){"use strict";var a=[].slice,b={}.hasOwnProperty,c=function(a,c){function d(){this.constructor=a}for(var e in c)b.call(c,e)&&(a[e]=c[e]);return d.prototype=c.prototype,a.prototype=new d,a.__super__=c.prototype,a};angular.module("onoffClientApp").controller("ForemanCtrl",["$scope","$http","Restangular","CartsModel","DevicesSvc","CartItemsModel","SeriesSvc","DeviceSeriesSvc","SKUsSvc","DeviceSeriesSKUsSvc","ParametersSvc","ValuesSvc",function(b,d,e,f,g,h){var i,j,k,l,m,n,o,p,q,r;for(k=function(a){return b.devices=a},j=function(a){return b.cart=a,b.cartItems=new h({service:b.cart.cartItems}),b.newCart=new i.Models.Cart({id:a.id,cartItems:b.cart.cartItems})},g.getList().then(k),f.initialize(j),i={Models:{},Collections:{}},i.Models.Base=function(){function a(a,b){this.attributes=null!=a?a:{},this.options=null!=b?b:{},this.defineProperties(),this.options.collection&&(this.collection=this.options.collection),this.initialize(this.attributes,this.options)}return a.prototype.initialize=function(){},a.prototype.defineProperties=function(){var a,b,c,d;c=this.attributes,d=[];for(a in c)b=c[a],d.push(this.defineProperty(a,b));return d},a.prototype.defineProperty=function(a,b){var c;return c=this,c.attributes[a]=b,function(a){return Object.defineProperty(c,a,{enumerable:!0,configurable:!0,get:function(){return c.attributes[a]},set:function(b){return c.attributes[a]=b}})}(a)},a.prototype.toJSON=function(){return angular.copy(this.attributes)},a}(),q=["has"],m=0,o=q.length;o>m;m++)l=q[m],i.Models.Base.prototype[l]=function(){var b;return b=1<=arguments.length?a.call(arguments,0):[],b.unshift(this.attributes),_[l].apply(_,b)};for(i.Collections.Base=function(){function a(a,b){null==a&&(a=[]),null==b&&(b={}),b.model&&(this.model=b.model),this.reset(a,b),this.initialize(a,b)}return a.prototype.model=i.Models.Base,a.prototype.initialize=function(){},a.prototype.reset=function(a,b){var c;return this.models=function(){var d,e,f;for(f=[],d=0,e=a.length;e>d;d++)c=a[d],b.collection=this,f.push(new this.model(c,b));return f}.call(this)},a.prototype.findWhere=function(a){return _.find(this.models,function(b){var c,d;for(c in a)if(d=a[c],b[c]!==d)return!1;return!0},this)},a.prototype.size=function(){return this.models.length},a.prototype.toJSON=function(){var a,b,c,d,e;for(d=this.models,e=[],b=0,c=d.length;c>b;b++)a=d[b],e.push(a.toJSON());return e},a}(),r=["pluck","where","find","reduce"],n=0,p=r.length;p>n;n++)l=r[n],i.Collections.Base.prototype[l]=function(){var b;return b=1<=arguments.length?a.call(arguments,0):[],b.unshift(this.models),_[l].apply(_,b)};return i.Models.Cart=function(a){function b(){return b.__super__.constructor.apply(this,arguments)}return c(b,a),b.prototype.initialize=function(){return this.expanded=!0,this.cartItems=new i.Collections.CartItems(this.cartItems,{cart:this})},b.prototype.loadSeries=function(){return d.get("/api/carts/"+this.id+"/series").then(function(a){return function(b){return a.series=new i.Collections.Series(b.data,{cart:a}),a.expanded=!1}}(this))},b.prototype.amountOfDevices=function(a){return this.cartItems.amountOfDevices(a)},b}(i.Models.Base),i.Models.CartItem=function(a){function b(){return b.__super__.constructor.apply(this,arguments)}return c(b,a),b.prototype.initialize=function(){return this.device=new i.Models.Device(this.device,{cartItem:this})},b.prototype.amountOfDevices=function(a){return this.device.id===a?this.amount:0},b}(i.Models.Base),i.Collections.CartItems=function(a){function b(){return b.__super__.constructor.apply(this,arguments)}return c(b,a),b.prototype.model=i.Models.CartItem,b.prototype.amountOfDevices=function(a){return this.reduce(function(b,c){return b+c.amountOfDevices(a)},0)},b}(i.Collections.Base),i.Models.Device=function(a){function b(){return b.__super__.constructor.apply(this,arguments)}return c(b,a),b}(i.Models.Base),i.Collections.Devices=function(a){function b(){return b.__super__.constructor.apply(this,arguments)}return c(b,a),b.prototype.model=i.Models.Device,b}(i.Models.Base),i.Models.Series=function(a){function b(){return b.__super__.constructor.apply(this,arguments)}return c(b,a),b.prototype.initialize=function(){return this.parameters=new i.Collections.Parameters(this.parameters,{series:this,cart:this.options.cart}),this.skus=new i.Collections.SKU(this.skus,{series:this})},b.prototype.price=function(){return this.skus.price(this.parameters,this.options.cart)},b.prototype.toJSON=function(){var a;return a=b.__super__.toJSON.apply(this,arguments),delete a.title,delete a.manufacturer,a},b}(i.Models.Base),i.Collections.Series=function(a){function b(){return b.__super__.constructor.apply(this,arguments)}return c(b,a),b.prototype.model=i.Models.Series,b}(i.Collections.Base),i.Models.Parameter=function(a){function b(){return b.__super__.constructor.apply(this,arguments)}return c(b,a),b.prototype.initialize=function(){return this.values=new i.Collections.Values(this.values,{parameter:this,series:this.options.series,cart:this.options.cart})},b.prototype.selectedValue=function(){return this.values.selectedValue()},b.prototype.selectedValueId=function(){return this.values.selectedValueId()},b.prototype.toJSON=function(){var a;return a=b.__super__.toJSON.apply(this,arguments),delete a.variable,delete a.description,a},b}(i.Models.Base),i.Collections.Parameters=function(a){function b(){return b.__super__.constructor.apply(this,arguments)}return c(b,a),b.prototype.model=i.Models.Parameter,b}(i.Collections.Base),i.Models.Value=function(a){function b(){return b.__super__.constructor.apply(this,arguments)}return c(b,a),b.prototype.initialize=function(){return this.selected?this.update():void 0},b.prototype.select=function(){return this.selected?void 0:(this.collection.unselect(),this.selected=!0,this.update())},b.prototype.unselect=function(){return this.selected=!1},b.prototype.update=function(){return d.put("/api/carts/"+this.options.cart.id+"/values",angular.toJson(this))},b.prototype.toJSON=function(){var a;return a=b.__super__.toJSON.apply(this,arguments),delete a.code,delete a.description,a.parameter_id=this.options.parameter.id,a},b}(i.Models.Base),i.Collections.Values=function(a){function b(){return b.__super__.constructor.apply(this,arguments)}return c(b,a),b.prototype.model=i.Models.Value,b.prototype.selectedValue=function(){return this.findWhere({selected:!0})},b.prototype.selectedValueId=function(){return this.selectedValue().id},b.prototype.unselect=function(){var a,b,c,d,e;for(d=this.models,e=[],b=0,c=d.length;c>b;b++)a=d[b],e.push(a.unselect());return e},b}(i.Collections.Base),i.Models.SKU=function(a){function b(){return b.__super__.constructor.apply(this,arguments)}return c(b,a),b.prototype.initialize=function(){return this.skuParameters=new i.Collections.SkuParameters(this.parameters,{sku:this})},b.prototype.price=function(a,b){var c;return c=this.unitPrice?this.unitPrice:this.skuParameters.price(a),c*this.amount*b.amountOfDevices(this.deviceId)},b}(i.Models.Base),i.Collections.SKU=function(a){function b(){return b.__super__.constructor.apply(this,arguments)}return c(b,a),b.prototype.model=i.Models.SKU,b.prototype.price=function(a,b){return this.reduce(function(c,d){return c+d.price(a,b)},0)},b}(i.Collections.Base),i.Models.SkuParameter=function(a){function b(){return b.__super__.constructor.apply(this,arguments)}return c(b,a),b.prototype.initialize=function(){return this.skuValues=new i.Collections.SkuValues(this.values,{parameter:this})},b.prototype.price=function(a){return a.reduce(function(a,b){return this.parameterId===b.id?a+this.getValuePrice(b.selectedValueId()):a},0,this)},b.prototype.getValuePrice=function(a){return this.skuValues.get(a).unitPrice},b}(i.Models.Base),i.Collections.SkuParameters=function(a){function b(){return b.__super__.constructor.apply(this,arguments)}return c(b,a),b.prototype.model=i.Models.SkuParameter,b.prototype.price=function(a){return this.reduce(function(b,c){return b+c.price(a)},0)},b}(i.Collections.Base),i.Models.SkuValue=function(a){function b(){return b.__super__.constructor.apply(this,arguments)}return c(b,a),b}(i.Models.Base),i.Collections.SkuValues=function(a){function b(){return b.__super__.constructor.apply(this,arguments)}return c(b,a),b.prototype.model=i.Models.SkuValue,b.prototype.get=function(a){return this.findWhere({valueId:a})},b}(i.Collections.Base)}])}.call(this),function(){"use strict";angular.module("onoffClientApp").constant("apiUrl","/api")}.call(this),function(){"use strict";angular.module("onoffClientApp").factory("CartsSvc",["Restangular",function(a){return a.extendModel("carts",function(b){return b.restangularizeNested=function(){return a.restangularizeCollection(b,b.cartItems,"cart_items"),b.cartItems.restangularizeNested(b)},b}),a.service("carts")}])}.call(this),function(){"use strict";angular.module("onoffClientApp").factory("DevicesSvc",["Restangular",function(a){return a.extendModel("devices",function(a){return a.toJSON=function(){var b;return b=a.plain(),delete b.deviceSeries,b},a.restangularizeNested=function(){},a}),a.service("devices")}])}.call(this),function(){"use strict";angular.module("onoffClientApp").factory("CartItemsSvc",["Restangular",function(a){var b;return a.extendCollection("cart_items",function(b){return b.add=function(a){var c;return c=b.indexOf(a),-1===c&&(b.push(a),a.restangularizeNested()),b},b["delete"]=function(a){var c;return c=b.indexOf(a),c>-1&&b.splice(c,1),b},b.series=function(){var c,d,e,f,g,h,i,j,k,l;for(e=[],h=0,j=b.length;j>h;h++)for(d=b[h],g=d.series()||[],i=0,k=g.length;k>i;i++)f=g[i],(c=_.find(e,{id:f.id}))?(l=c.deviceSeriesSkus).push.apply(l,f.deviceSeriesSkus):e.push(f);return a.restangularizeCollection(d.cart,e,"series"),e.restangularizeNested(),e},b.restangularizeNested=function(a){var c,d,e;for(d=0,e=b.length;e>d;d++)c=b[d],c.restangularizeNested({cart:a});return b},b}),a.extendModel("cart_items",function(b){return b.series=function(){return b.device.series},b.toJSON=function(){var a;return a=b.plain(),delete a.device,a},b.restangularizeNested=function(c){var d,e,f,g;for(null==c&&(c={}),a.restangularizeElement(null,b.device,"devices"),b.device.restangularizeNested(),e=f=0,g=c.length;g>f;e=++f)d=c[e],b[d]=e;return b},b}),b=a.service("cart_items")}])}.call(this),function(){"use strict";angular.module("onoffClientApp").directive("devices",function(){return{templateUrl:"views/devices.html",restrict:"EA"}})}.call(this),function(){"use strict";angular.module("onoffClientApp").directive("cartItems",function(){return{templateUrl:"views/cartitems.html",restrict:"EA"}})}.call(this),function(){"use strict";angular.module("onoffClientApp").directive("series",function(){return{templateUrl:"views/series.html",restrict:"EA"}})}.call(this),function(){"use strict";angular.module("onoffClientApp").factory("CartsModel",["$localStorage","CartsSvc",function(a,b){var c;return c=a.cart,{initialize:function(a){return c?b.one(c.id).put().then(function(b){return function(c){return b.initializeCart(c,a)}}(this)):b.post().then(function(b){return function(c){return b.initializeCart(c,a)}}(this))},initializeCart:function(b,d){return d(b),c=a.$reset({cart:{id:b.id}}),b.restangularizeNested()}}}])}.call(this),function(){"use strict";angular.module("onoffClientApp").factory("DeviceModel",["DevicesSvc",function(){}])}.call(this),function(){"use strict";var a=function(a,b){return function(){return a.apply(b,arguments)}};angular.module("onoffClientApp").factory("CartItemsModel",["CartItemsSvc",function(){var b;return b=function(){function b(b){var c;this._options=b,this._updateItem=a(this._updateItem,this),this._addItem=a(this._addItem,this),this.remove=a(this.remove,this),this.update=a(this.update,this),this.add=a(this.add,this),c=this._options,this.model=c.model,this.collection=c.collection,this.service=c.service}return b.prototype.add=function(a){var b,c;return b=this._newCartItem(a),null!=(c=this.service)?c.post(b).then(this._addItem):void 0},b.prototype.update=function(a){return a.put().then(this._updateItem,function(a){return console.warn(a)})},b.prototype.remove=function(a){return a.remove().then(angular.bind(this,this._deleteItem,a),function(a){return console.warn(a)})},b.prototype._addItem=function(a){var b;return null!=(b=this.service)?b.add(a):void 0},b.prototype._updateItem=function(){},b.prototype._deleteItem=function(a,b){var c;return null!=(c=this.service)?c["delete"](a,b):void 0},b.prototype._newCartItem=function(a){return{device_id:a.id,amount:1}},b}()}])}.call(this),function(){"use strict";angular.module("onoffClientApp").service("DeviceSeriesSvc",["Restangular",function(a){return a.extendCollection("device_series",function(a){return a.restangularizeNested=function(){var b,c,d;for(c=0,d=a.length;d>c;c++)b=a[c],b.restangularizeNested();return a},a}),a.extendModel("device_series",function(b){return b.restangularizeNested=function(c){var d,e,f,g;for(null==c&&(c={}),a.restangularizeCollection(b,b.deviceSeriesSkus,"device_series_skus"),b.deviceSeriesSkus.restangularizeNested(b),e=f=0,g=c.length;g>f;e=++f)d=c[e],b[d]=e;return b},b}),a.service("device_series")}])}.call(this),function(){"use strict";angular.module("onoffClientApp").service("DeviceSeriesSKUsSvc",["Restangular",function(a){return a.extendCollection("device_series_skus",function(a){return a.price=function(b){var c,d;return null==b&&(b=1),c=a.hasParameters()?"compiledPrice":"price",d=_.reduce(a,function(a,b){return a+b[c]()},0),b*d},a.hasParameters=function(){var b,c,d;for(c=0,d=a.length;d>c;c++)if(b=a[c],b.hasParameters())return!0;return!1},a.restangularizeNested=function(b){var c,d,e,f,g;for(c=b.clone(),delete c.deviceSeriesSkus,e={device_series:c},f=0,g=a.length;g>f;f++)d=a[f],d.restangularizeNested(e);return a},a}),a.extendModel("device_series_skus",function(b){return b.compiledTitle=function(){var a,c,d,e,f;if(b.parameters.length>0){for(d=b.parameters.selectedValues(),a=void 0,e=0,f=d.length;f>e;e++)c=d[e],a=b.compileTitle(c,a);return a}return b.sku.title},b.compileTitle=function(a,c){return null==c&&(c=b.sku.title),c.replace(a.parameter.variable,a.code)},b.price=function(){return b.amount*b.sku.unitPrice},b.compiledPrice=function(){return b.amount*b.parameters.selectedValuesPrice()},b.hasParameters=function(){return b.parameters.length>0},b.toJSON=function(){var a;return a=b.clone(),delete a.device_series,delete a.parameters,a},b.restangularizeNested=function(c){var d,e;a.restangularizeElement(null,b.sku,"skus"),a.restangularizeCollection(b,b.parameters,"parameters"),b.parameters.restangularizeNested(b);for(d in c)e=c[d],b[d]=e;return b},b}),a.service("device_series_skus")}])}.call(this),function(){"use strict";angular.module("onoffClientApp").service("ParametersSvc",["Restangular",function(a){return a.extendCollection("parameters",function(a){return a.selectedValues=function(){var b;return _.flatten(function(){var c,d,e;for(e=[],c=0,d=a.length;d>c;c++)b=a[c],e.push(b.selectedValue());return e}())},a.selectedValuesPrice=function(){return _.reduce(a.selectedValues(),function(a,b){return a+b.unitPrice},0)},a.restangularizeNested=function(b){var c,d,e,f;for(d={deviceSeriesSku:b},e=0,f=a.length;f>e;e++)c=a[e],c.restangularizeNested(d);return a},a}),a.extendModel("parameters",function(b){return b.selectedValue=function(){return b.values.getSelected()},b.restangularizeNested=function(c){var d,e;a.restangularizeCollection(b,b.values,"values"),b.values.restangularizeNested(b);for(d in c)e=c[d],b[d]=e;return b},b}),a.service("parameters")}])}.call(this),function(){"use strict";angular.module("onoffClientApp").service("ValuesSvc",["Restangular",function(a){return a.extendCollection("values",function(a){return a.unselect=function(){var b,c,d,e;for(e=[],c=0,d=a.length;d>c;c++)b=a[c],e.push(b.unselect());return e},a.getSelected=function(){return _.filter(a,"selected")},a.restangularizeNested=function(b){var c,d,e,f,g;for(e=b.clone(),delete e.values,d={parameter:e,collection:a},f=0,g=a.length;g>f;f++)c=a[f],c.restangularizeNested(d);return a},a}),a.extendModel("values",function(a){return a.toJSON=function(){var b;return b=a.clone(),delete b.collection,b},a.select=function(){return a.selected!==!0?(a.collection.unselect(),a.selected=!0):void 0},a.unselect=function(){return a.selected=!1},a.restangularizeNested=function(b){var c,d,e;null==b&&(b={}),e=[];for(c in b)d=b[c],e.push(a[c]=d);return e},a}),a.service("values")}])}.call(this),function(){"use strict";angular.module("onoffClientApp").service("SKUsSvc",["Restangular",function(a){return a.service("markings")}])}.call(this),function(){"use strict";angular.module("onoffClientApp").directive("parameters",function(){return{templateUrl:"views/parameters.html",restrict:"EA"}})}.call(this),function(){"use strict";angular.module("onoffClientApp").directive("deviceSeriesImage",function(){return{templateUrl:"views/deviceseriesimage.html",restrict:"EA"}})}.call(this),function(){"use strict";angular.module("onoffClientApp").directive("deviceSeries",function(){return{templateUrl:"views/deviceseries.html",restrict:"EA"}})}.call(this),function(){"use strict";angular.module("onoffClientApp").directive("selectedSkus",function(){return{templateUrl:"views/selectedskus.html",restrict:"EA"}})}.call(this),function(){"use strict";angular.module("onoffClientApp").factory("SeriesSvc",["Restangular",function(a){return a.extendModel("series",function(b){return b.price=function(){var a,c,d,e,f;for(e=b.deviceSeriesSkus,f=[],c=0,d=e.length;d>c;c++)a=e[c],f.push(a.unitPrice);return f},b.restangularizeNested=function(c){var d,e,f,g;for(null==c&&(c={}),a.restangularizeCollection(b,b.deviceSeriesSkus,"device_series_skus"),b.deviceSeriesSkus.restangularizeNested(b),e=f=0,g=c.length;g>f;e=++f)d=c[e],b[d]=e;return b},b}),a.extendCollection("series",function(a){return a.restangularizeNested=function(b){var c,d,e;for(d=0,e=a.length;e>d;d++)c=a[d],c.restangularizeNested({cart:b});return a},a}),a.service("series")}])}.call(this);