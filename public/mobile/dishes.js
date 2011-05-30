dishTemplate = new Ext.XTemplate('<tpl for="."><div class="adish"><b>{name}</b><br/>{[this.distDisplay(values.distance)]}</div></tpl>',
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
    fields: ['name','id','price','description','restaurant_id','distance','menu_item_avg_rating_count','avg_rating',{
        name: 'rating',
        convert: function(value, record) {
            return record.get('menu_item_avg_rating_count').avg_rating.toString();
        }
    }]
});

var dishStore = new Ext.data.Store({
    model: 'Dish',
    sorters: [{property: 'arating', direction: 'DESC'}],
    getGroupString : function(record) {
        return record.get('rating');
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

