var loggedoutProfilePnl = new Ext.Panel({
    html:'<div class="fancyImage"><img class="logoutButton" src="../images/profile-cold-food.png"></div><div class="explanation">Rate & Save Dishes, Follow Foodies</div><a href="/auth/facebook" class="loginButton"></a>',
    id: 'loggedoutProfilePnl',
    scroll:'vertical'
});

Ext.regModel('User',
{
    fields: ['user_name']
});
/*
Ext.regModel("User", {
    fields: [
        'user', {
        name: 'user_name',
        convert: function(value, record) {
            if(record.get('user').user_name) {
                return record.get('user').user_name.toString();
            } else {
                return "unknown";
            }
        }
    }, {
        name: 'user_profile_pic_url',
        convert: function(value, record) {
            if(record.get('user').user_profile_pic_url) {
                return record.get('user').user_profile_pic_url.toString();
            } else {
                return "unknown";
            }
        }
    }
    ]//,

    //hasMany: {model: 'MyRatings', name: 'menu_item_ratings'}
});
*/
Ext.regModel('MyRatings',
{
    fields: ['review','id','menu_item_id','rating']
});

var myDishStore = new Ext.data.Store({
    model: 'MyRatings',
    data:[]
/* [{
rating: 4,
menu_item_id: 254296,
review: "This is a tender, tasty meat on a small, crunchy slice of bread",
id: 621
},
{
rating: 5,
menu_item_id: 254158,
review: "Awesome fusion dish usually prepared with love by its namesake's grillmistress",
id: 622
},
{
rating: 3,
menu_item_id: 137323,
review: "Order without tortilla or rice for 4HB compliance",
id: 660
}
] */
});

reviewTemplate = new Ext.XTemplate.from('reviewDishTemplate');

var myDishList = new Ext.List({
    itemTpl: reviewTemplate,
    itemSelector: '.adish',
    singleSelect: true,
    grouped: true,
    indexBar: false,
    store: myDishStore,
    id:'myDishList',
    scroll:'vertical',
    width:'100%',
    height:'100%',
    hideOnMaskTap: false,
    clearSectionOnDeactivate:true
});
myDishList.on('itemtap', function(dataView, index, item, e) {
    thisId = myDishStore.findRecord("name",$(".dishname", item).text()).data.id;
    Ext.Ajax.request({
        url: (urlPrefix+'/items/'+thisId+'.json'),
        reader: {
             type: 'json'
        },
        success: function(response) {
            dishDisplay(response);
        }
    });
    Ext.getCmp('mainPnl').setActiveItem(0);
});


var profileInfoPnl = new Ext.Panel({
    html:'<div class="userTopPnl"><div class="userPic"></div><div class="userInfoPnl"></div></div>',
    id: 'profileInfoPnl',
    height:100,
    width:'100%'
});

var blankPnl = new Ext.Panel({
    html:'',
    id: 'profileInfoPnl',
    scroll:'none',
    height:'100%',
    width:'100%'
});

var loggedinProfilePnl = new Ext.Panel({
    items:[profileInfoPnl,myDishList],
    layout: {
        type: 'vbox',
        align: 'start',
        direction: 'normal'
    },
    id: 'loggedinProfilePnl',
    height:'100%',
    width:'100%'
});

var signoutHandler = function(b,e) {
    if(b.getText() == "Sign Out") {
        localStorage.setItem("uid","");
        Ext.getCmp("profilePnl").setActiveItem(1);
    }
}

var profilePnl = new Ext.Panel({
    items:[blankPnl,loggedoutProfilePnl,loggedinProfilePnl],
    id: 'profilePnl',
    height:'100%',
    width:'100%',
    layout: 'card',
    activeItem:0,
    dockedItems:[
        {
            dock:'top',
            xtype:'toolbar',
            ui:'light',
            title:'<img class="cravelogo" src="../images/crave-logo-horizontal-white.png">',
            items:[{text:'Sign Out',ui:'normal', handler:signoutHandler}]
        }
    ],
    cardSwitchAnimation: 'pop',
    direction:'horizontal'
});

profilePnl.on('afterrender', function() {
    //this is not even being called a tall now
    console.log('am i logged in? '+isLoggedIn());
    var loggedIn = isLoggedIn();
    if(loggedIn) {
        console.log('setting as logged in');
        profilePnl.setActiveItem(2);
    } else {
        profilePnl.setActiveItem(1);
        console.log('set profilePnl to 1');
    }
    
});