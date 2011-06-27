var backHandler = function(b,e) {
    if(b.getText() == "Back") {
        Ext.getCmp('mainPnl').setActiveItem(0);
    }
}
var rateHandler = function(b,e) {
    if(b.getText() == "Rate") {
        Ext.getCmp('mainPnl').setActiveItem(reviewForm);
    }

    if(b.getText() == "Submit") {
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