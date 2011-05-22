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

function starDisplay(rating) {
    return '<img src="../images/ratings/rating-dish-'+parseInt(rating)+'.png">';
}
function dishDisplay(response) {
    var responseObject = eval('(' + response.responseText + ')');
    htmlString = '<div class="dishinfo"><b>'+responseObject.menu_item.name+'</b><br/>';
    htmlString += '@'+responseObject.menu_item.restaurant.name+'<br>';
    htmlString += '$ '+responseObject.menu_item.price+'<br>';
    if(responseObject.menu_item.menu_item_avg_rating_count) {
        htmlString += starDisplay(responseObject.menu_item.menu_item_avg_rating_count.avg_rating);
        htmlString += ' '+responseObject.menu_item.menu_item_avg_rating_count.count+' ratings';
    }
    htmlString += '<br><br>'+responseObject.menu_item.description+'<br>';
    /*for(i=0;i<responseObject[0].ingredients.length;i++) {
     htmlString += responseObject[0].ingredients[i].item;
        if(i<responseObject[0].ingredients.length - 1) {
            htmlString += ", ";
        }
    }*/
    htmlString += "</div>";
    /*
    for(i=0;i<responseObject[0].images.length;i++) {
        object = new Object();
        object.html = '<div class="foodImg"><img width="100" src="'+responseObject[0].images[i].file+'"></div>';
        object.xtype = 'panel';
        Ext.getCmp('carouselPnl').add(object);
    }
    */
    if(responseObject.menu_item.menu_item_ratings) {
        reviewString = "<br><br><b>Reviews</b><br><br>";
        for(i=0;i<responseObject.menu_item.menu_item_ratings.length;i++) {
            reviewString += '<div class="picanddata"><div class="data">'+starDisplay(responseObject.menu_item.menu_item_ratings[i].rating)+'</div> <div class="reviewtext">'+responseObject.menu_item.menu_item_ratings[i].review+'</div></div>';
        }
        Ext.getCmp('detailPnl').add(reviewPnl);
        Ext.getCmp('reviewPnl').update(reviewString);
    }
    //Ext.getCmp('detailPnl').add(carouselPnl);
    Ext.getCmp('infoPnl').update(htmlString);
}

var aRestaurantList = new Ext.List({
    id:'aRestaurantList',
    onItemDisclosure: {
       handler: function(record, btn, index) {
           console.log(urlPrefix+'/menu_items/'+record.data.id+'.json');
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
    itemTpl: '<tpl for="."><div class="thisdish"><b>{name}</b></div></tpl>',
    singleSelect: true,
    grouped: false,
    indexBar: false,
    layout:{type:'vbox'},
    fullscreen:false,
    store: singleRestaurantStore,

    width:'100%',
    height:'334px',
    modal:true,
    hideOnMaskTap: false
});