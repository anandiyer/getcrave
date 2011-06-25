
function justLoggedIn() {
    myUID = localStorage.getItem("uid");
    /*
    if(myUID!="" && myUID!=null) {
        console.log('found');
        Ext.getCmp("loginButton").setVisible(false);
        Ext.getCmp("logoutButton").setVisible(true);
    } else {
        console.log('not found');
        Ext.getCmp("loginButton").setVisible(true);
        Ext.getCmp("logoutButton").setVisible(false);
    }
    */
    // ?get uid from local storage here?
    //have to reach docked bottom bar, change to sign out, display form links
}

function isLoggedIn() {
    myUID = localStorage.getItem("uid");
    if(myUID!="" && myUID!=null) {
        return true;
    } else {
        return false;
    }
}
