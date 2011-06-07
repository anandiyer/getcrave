dishTemplate = new Ext.XTemplate('<tpl for="."><div class="adish"><img src="../images/no-image-default.png" class="dishImg"><div class="dishListinfo"><span class="dishname">{name}</span><span class="restaurantName">@{restaurant_name}</span><span class="distanceFigure">{[this.distDisplay(values.distance)]}</span></div><span class="chevrony"></span></span></div></tpl>',
    {distDisplay: function(miles) {
        feet = Math.round(miles * 5280);
        if(feet<1000) {
            return feet+" feet";
        } else {
            return parseFloat(miles).toFixed(1)+' miles';
        }
    }});

Ext.regModel('Dish',
{
    fields: ['name','id','price','description','restaurant_id','restaurant','distance','menu_item_avg_rating_count','avg_rating',{
        name: 'rating',
        convert: function(value, record) {
            console.log(record.get('menu_item_avg_rating_count').avg_rating);
            return record.get('menu_item_avg_rating_count').avg_rating.toString();
        }
    },{
        name: 'restaurant_name',
        convert: function(value, record) {
            return record.get('restaurant').name.toString();
        }
    }]
});

var dishStore = new Ext.data.Store({
    model: 'Dish',
    sorters: [{property: 'arating', direction: 'DESC'}],
    getGroupString : function(record) {
        rating = parseInt(record.get('rating'));
        if(rating==5) {
            return "<img src='../images/rating-stars/rating-dish-5.png'>";
        }
        if(rating==4) {
            return "<img src='../images/rating-stars/rating-dish-4.png'>";
        }
        if(rating==3) {
            return "<img src='../images/rating-stars/rating-dish-3.png'>";
        }
        if(rating==2) {
            return "<img src='../images/rating-stars/rating-dish-2.png'>";
        }
        if(rating==1) {
            return "<img src='../images/rating-stars/rating-dish-1.png'>";
        }
    },
    proxy: {
        type:'ajax',
        url:'',
       reader: {
           type:'json',
           record:'menu_item'
       }
    }
});

var newDishForm = new Ext.form.FormPanel({
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
                hidden:true,
                name: 'menu_item[restaurant_id]',
                id: 'restaurantId'
		    },
           {
               xtype: 'textfield',
               label:'Name',
               name: 'menu_item[name]',
               id: 'menuItemName'
           },
           {
               xtype: 'textfield',
               label:'Description',
               name: 'menu_item[description]',
               id: 'menuItemDescription'
           },
           {
               xtype: 'textfield',
               hidden:true,
               name: 'menu_item[user_id]',
               id: 'userId'
           },

           {
               xtype:'button',
               text: 'Submit',
               handler: function() {
                   Ext.getCmp('restaurantId').setValue(localStorage.getItem('editRestaurantId'));
                   Ext.getCmp('userId').setValue(localStorage.getItem("uid"));
                   newDishForm.submit({
                       url: '/menu_items',
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
               }
           }
        ]}
    ]
});
