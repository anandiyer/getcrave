
function justLoggedIn() {
    myUID = localStorage.getItem("uid");
    alert(myUID);
    if(myUID!="" && myUID!=null) {
        console.log('found');
        $(".loginButton").css("display","none");
        //$(".logoutButton").css("display","block");
    } else {
        console.log('not found');
        $(".loginButton").css("display","block");
        //$(".logoutButton").css("display","none");
    }
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
