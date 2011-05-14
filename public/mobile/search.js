var dishSearchStore = new Ext.data.Store({
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

var restaurantSearchStore = new Ext.data.Store({
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

var restaurantSearchList = new Ext.List({
    onItemDisclosure: {
        //todo: abstrack drill down handlers so they are reusable
        handler: function(record, btn, index) {
            result = helloThere();
            singleRestaurantStore.proxy.url = (urlPrefix+'/restaurants/'+record.data.id+'/menu_items.json');

            singleRestaurantStore.load(function(){
                Ext.getCmp('mainPnl').setActiveItem(detailPnl);
            });

            Ext.Ajax.request({
                url: (urlPrefix+'/restaurants/'+record.data.id+'.json'),
                reader: {
                     type: 'json'
                },
                success: function(response) {
                     //populate top panel with restaurant data, map
                     var responseObject = eval('(' + response.responseText + ')');
                     htmlString = '<div class="restaurantInfo">'+responseObject.restaurant.name+'</div>';
                     Ext.getCmp('restPnl').update(htmlString);
                }
            });
        }
    },
    itemTpl: dishTemplate,
    singleSelect: true,
    grouped: false,
    indexBar: false,
    store: restaurantSearchStore
});

var dishSearchList = new Ext.List({
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
                   Ext.getCmp('detailPnl').add(infoPnl);
                   Ext.getCmp('infoPnl').update(htmlString);
               }
           });
           Ext.getCmp('mainPnl').setActiveItem(detailPnl);
       }
    },
    itemTpl: dishTemplate,
    singleSelect: true,
    grouped: false,
    indexBar: false,
    store: dishSearchStore,
    scroll:'vertical'
});

var searchPnl = new Ext.Panel({
    items: [restaurantSearchList,dishSearchList],
    id: 'searchPnl',
    width:'100%',
    height:'100%'

});

var searchForm = new Ext.form.FormPanel({
    id: 'searchForm',
    items: [
        {
            xtype: 'textfield',
            name: 'searchString',
            inputType: 'search',
            id: 'searchBox',
            ui: 'search',
            placeHolder: 'Search for dish, cuisine or diet...',
            listeners: {
                change: function() {
                    //make 2 ajax requests
                    searchValue = Ext.getCmp("searchBox").getValue();
                    restaurantSearchStore.proxy.url = urlPrefix+'/restaurants/search.json?q='+searchValue;
                    restaurantSearchStore.load();
                    dishSearchStore.proxy.url = urlPrefix+'/menu_items/search.json?q='+searchValue;
                    dishSearchStore.load();
                    Ext.getCmp('listPnl').setActiveItem(searchPnl);
                }
            }
        }
    ]
});
