    @Metadata.layer : #CORE
    @UI             : {headerInfo : {
    typeName       : 'Travel',
    typeNamePlural : 'Travels',
    title          : {
        type  : #STANDARD,
        label : 'Travel',
        value : 'TravelID'
    }
}}
annotate view zc_sales_header with {
    //sd_uuid;
    @UI             : {lineItem : [{position : 10}]}
    sales_documentid;
    @UI             : {lineItem : [{position : 20}]}
    document_date;
    @UI             : {lineItem : [{position : 30}]}
    document_category;
    @UI             : {lineItem : [{position : 40}]}
    order_type;
    @UI             : {lineItem : [{position : 50}]}
    order_reason;
    @UI             : {lineItem : [{position : 60}]}
    net_value;
    @UI             : {lineItem : [{position : 70}]}
    currency;

/* Associations */
//_salesitm ;

}
