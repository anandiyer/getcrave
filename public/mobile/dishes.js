dishTemplate = new Ext.XTemplate('<tpl for="."><div class="adish"><b>{name}</b><br/>{[this.distDisplay(parent.distance)]}</div></tpl>',
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
    fields: ['name','id','price','description','restaurant_id']
});
