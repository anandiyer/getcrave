Ext.regModel('Restaurants',
{
    fields: ['distance','name','id']
});

Ext.regModel('DishSearch',
{
    fields: ['name','id','price','description','restaurant_id']
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

function restaurantDisplay(record, btn, index) {
    singleRestaurantStore.proxy.url = (urlPrefix+'/restaurants/'+record.data.id+'/menu_items.json');

    singleRestaurantStore.load(function(){
        Ext.getCmp('mainPnl').setActiveItem(2);
    });

    Ext.Ajax.request({
        url: (urlPrefix+'/restaurants/'+record.data.id+'.json'),
        reader: {
             type: 'json'
        },
        success: function(response) {
             //populate top panel with restaurant data, map
             var responseObject = eval('(' + response.responseText + ')');
            console.log(responseObject);
             htmlString = '<div class="restaurantInfo">'+responseObject.restaurant.name+'</div>';
             Ext.getCmp('restInfoPnl').update(htmlString);

            var placeholder = new google.maps.Marker(
                {
                    position: new google.maps.LatLng(responseObject.restaurant.latitude,responseObject.restaurant.longitude),
                    map: Ext.getCmp('googleMap').map,
                    title: 'restaurant'
                }
            );
            // woah baby, this is a nasty hack but the map refuses to behave unless you trigger resize after a delay AFTER the initial ajax returns
            Ext.Ajax.request({
                url: (urlPrefix+'/restaurants/'+record.data.id+'.json'),
                reader: {
                     type: 'json'
                },
                success: function(response) {
                    google.maps.event.trigger(Ext.getCmp('googleMap').map, 'resize');
                    var initialLocation = new google.maps.LatLng(responseObject.restaurant.latitude,responseObject.restaurant.longitude);
                    Ext.getCmp('googleMap').update(initialLocation);
                    console.log('just tried');
                    //needs work becoming resuable, maybe have to destroy this on unload
                }
            });
        }
    });
}

function starDisplay(rating) {
    return '<img src="../images/ratings/rating-dish-'+parseInt(rating)+'.png">';
}
var newRestaurant = new Ext.form.FormPanel({
    scroll: 'vertical',
    dockedItems:[
       {
           dock:'top',
           xtype:'toolbar',
           ui:'light',
           title:'Crave',
           items:[{text:'Back',ui:'back', handler:backHandler}]
       }
    ],
    items: [
       {xtype: 'fieldset', title: 'New Restaurant', items: [
            {
                xtype: 'textfield',
                label:'Name',
                name: 'restaurant[name]',
                id: 'restaurantName'
		    },
           {xtype: 'textfield', name: 'restaurant[latitude]', id: 'latfield', hidden: true},
           {xtype: 'textfield', name: 'restaurant[longitude]', id: 'lngfield', hidden: true},
           {
               xtype: 'textfield',
               label:'Address',
               name: 'restaurant[street_address]',
               id: 'restaurantAddress'
           },
           {
               xtype: 'textfield',
               label:'Neighborhood',
               name: 'restaurant[neighborhood]',
               id: 'restaurantNeighborhood'
           },
           {
               xtype: 'textfield',
               label:'City',
               value: 'San Francisco',
               name: 'restaurant[city]',
               id: 'restaurantCity'
           },
           {
               xtype: 'textfield',
               value: 'CA',
               label:'State',
               name: 'restaurant[state]',
               id: 'restaurantState'
           },
           {
               xtype: 'textfield',
               label:'Zip',
               name: 'restaurant[zip]',
               id: 'restaurantZip'
           },
           {
               xtype: 'textfield',
               label:'Country',
               value: 'USA',
               name: 'restaurant[country]',
               id: 'restaurantCountry'
           },
           {
               xtype: 'textfield',
               label:'Cross Street',
               name: 'restaurant[cross_street]',
               id: 'restaurantCross'
           },
           {
               xtype:'button',
               text: 'Submit',
               handler: function() {
                   var s = Ext.getCmp('restaurantAddress').getValue()+" "+Ext.getCmp('restaurantCity').getValue()+" "+Ext.getCmp('restaurantState').getValue()+" "+Ext.getCmp('restaurantZip').getValue();

                   var geocoder = new google.maps.Geocoder();
                   geocoder.geocode( { 'address': s}, function(results, status) {
                       if (status == google.maps.GeocoderStatus.OK) {
                           stringLocation = results[0].geometry.location.toString().replace("(","").replace(")","");
                           coordsArray = stringLocation.split(",");
                           Ext.getCmp('latfield').setValue($.trim(coordsArray[0]));
                           Ext.getCmp('lngfield').setValue($.trim(coordsArray[1]));
                           reviewForm.submit({
                               url: '/restaurants',
                               method: 'post',
                               submitDisabled: true,
                               waitMsg: 'Saving Data...Please wait.',
                               success: function (objForm,httpRequest) {
                                   var mbox = new Ext.MessageBox({});
                                   mbox.alert("Record Saved");
                                   //redirect back to restaurant list?
                               },
                               failure: function() {
                                   console.log('submissionFailed');
                               }
                           })
                       } else {
                           alert("Cannot resolve that address for the following reason: " + status);
                       }
                   });
               }
           }
        ]}
    ]
});

var reviewForm = new Ext.form.FormPanel({
    scroll: 'vertical',
    items: [
       {xtype: 'fieldset', title: 'Submit Review', items: [
            {
            xtype: 'selectfield',
            name: 'menu_item_rating[rating]',
            label:'Rating',
            options: [
                    {text: '5', value: 5},
                    {text: '4', value: 4},
                    {text: '3', value: 3},
                    {text: '2', value: 2},
                    {text: '1', value: 1}
                ]
            },
            {
                xtype: 'textfield',
                label:'Review',
                name: 'menu_item_rating[review]',
                id: 'review'
		    },
           {
               xtype: 'textfield',
               name: 'menu_item_rating[menu_item_id]',
               id: 'menuId',
               hidden:true
           },
           {
               xtype: 'textfield',
               name: 'menu_item_rating[user_id]',
               id: 'userId',
               hidden:true
           },
           {
               xtype:'button',
               text: 'Submit',
               handler: function() {
                   reviewForm.submit({
                       url: '/menu_item_ratings',
                       method: 'post',
                       submitDisabled: true,
                       waitMsg: 'Saving Data...Please wait.',
                       success: function (objForm,httpRequest) {
                           var mbox = new Ext.MessageBox({});
                           mbox.alert("Record Saved");
                       },
                       failure: function() {
                           console.log('submissionFailed');
                       }
                   })
               }
           }
        ]}
    ]
});

function dishDisplay(response) {
    console.log('displaying dish');
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
    myUID = localStorage.getItem("uid");
    if(myUID!="" && myUID!=null) {
        Ext.getCmp('detailPnl').add(reviewForm);
        Ext.getCmp('userId').setValue(myUID);
        Ext.getCmp('menuId').setValue(responseObject.menu_item.id);
    }
    Ext.getCmp('detailPnl').doLayout();
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