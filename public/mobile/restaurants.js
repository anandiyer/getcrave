Ext.regModel('Restaurants',
{
    fields: ['distance','name','id']
});

var restaurants = new Ext.data.Store({
   model: 'Restaurants',
    id: 'restaurants',

   proxy: {
       type:'ajax',
       url:'',
       reader: {
           type:'json',
           record:'restaurant'
       }
   }
});

var singleRestaurantStore = new Ext.data.Store({
    model: 'Dish',
    proxy: {
        type:'ajax',
        url:'',
       reader: {
           type:'json',
           record:'menu_item'
       }
    }
});

var aRestaurantList = new Ext.List({
    id:'aRestaurantList',
    onItemDisclosure: {
       handler: function(record, btn, index) {
           Ext.Ajax.request({
               url: (urlPrefix+'/menu_items/'+record.data.id+'.json'),
               reader: {
                    type: 'json'
               },
               success: function(response) {
                   var responseObject = eval('(' + response.responseText + ')');
                   htmlString = '<div class="dishinfo"><b>'+responseObject.menu_item.name+'</b><br/>';
                   htmlString += '$ '+responseObject.menu_item.price+'<br>';
                   htmlString += '<br><br>'+responseObject.menu_item.description+'<br>';
                   htmlString += "</div>";
                   Ext.getCmp('infoPnl').update(htmlString);
               }
           });
           Ext.getCmp('mainPnl').setActiveItem(detailPnl);
       }
    },
    itemTpl: '<tpl for="."><div class="thisdish"><b>{name}</b></div></tpl>',
    singleSelect: true,
    grouped: false,
    indexBar: false,
    layout:{type:'vbox'},
    fullscreen:false,
    store: singleRestaurantStore,

    width:'100%',
    height:'100%',
    modal:true,
    hideOnMaskTap: false
});