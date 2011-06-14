
dishSearchTemplate = new Ext.XTemplate('<tpl for="."><div class="adish"><b>{name}</b><br/>{description}</div></tpl>');


var dishSearchStore = new Ext.data.Store({
    model: 'DishSearch',
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
    itemTpl: dishTemplate,
    singleSelect: true,
    grouped: false,
    indexBar: false,
    store: restaurantSearchStore
});

restaurantSearchList.on('itemtap', function(dataView, index, item, e) {
    record = dataView.store.data.items[index];
    dishDisplay(record, index);
});

var dishSearchList = new Ext.List({
    itemTpl: dishSearchTemplate,
    singleSelect: true,
    grouped: false,
    indexBar: false,
    store: dishSearchStore,
    scroll:'vertical'
});

dishSearchList.on('itemtap', function(dataView, index, item, e) {
    record = dataView.store.data.items[index];
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
                    if(Ext.getCmp('placesButton').pressed) {
                        restaurantSearchStore.proxy.url = urlPrefix+'/places/search.json?q='+searchValue;
                        restaurantSearchStore.load();
                        console.log(restaurantSearchStore.proxy.url);
                        Ext.getCmp('listPnl').setActiveItem(searchPnl);
                        Ext.getCmp('searchPnl').setActiveItem(restaurantSearchList);
                    }
                    if(Ext.getCmp('dishesButton').pressed) {
                        dishSearchStore.proxy.url = urlPrefix+'/items/search.json?q='+searchValue;
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
