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
        handler: function(record, btn, index) {
            restaurantDisplay(record, btn, index);
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
                   dishDisplay(response);
               }
           });
           Ext.getCmp('mainPnl').setActiveItem(1);
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
    items: [dishSearchList,restaurantSearchList],
    layout:'card',
    id: 'searchPnl',
    width:'100%',
    height:'288px'
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
                    searchValue = Ext.getCmp("searchBox").getValue();
                    //get active button, do appropriate search, set card in searchPnl
                    if(Ext.getCmp('restaurantsButton').pressed) {
                        restaurantSearchStore.proxy.url = urlPrefix+'/restaurants/search.json?q='+searchValue;
                        restaurantSearchStore.load();
                        console.log(restaurantSearchStore.proxy.url);
                        Ext.getCmp('listPnl').setActiveItem(searchPnl);
                        Ext.getCmp('searchPnl').setActiveItem(restaurantSearchList);
                    }
                    if(Ext.getCmp('dishesButton').pressed) {
                        dishSearchStore.proxy.url = urlPrefix+'/menu_items/search.json?q='+searchValue;
                        dishSearchStore.load();
                        console.log(dishSearchStore.proxy.url);
                        Ext.getCmp('listPnl').setActiveItem(searchPnl);
                        Ext.getCmp('searchPnl').setActiveItem(dishSearchList);                        
                    }
                }
            }
        }
    ]
});
