var backHandler = function(b,e) {
    if(b.getText() == "Back") {
        Ext.getCmp('mainPnl').setActiveItem(0);
    }
}
