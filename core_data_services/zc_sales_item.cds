@AbapCatalog.sqlViewName                      : 'ZCSALESITEM'
@AbapCatalog.compiler.compareFilter           : true
@AbapCatalog.preserveKey                      : true
@AccessControl.authorizationCheck             : #CHECK
@EndUserText.label                            : 'Sales item Consumption view'
@VDM.viewType                                 : #CONSUMPTION
@ObjectModel.createEnabled                    : true
@ObjectModel.updateEnabled                    : true
@ObjectModel.deleteEnabled                    : true
@ObjectModel.compositionRoot                  : true
@ObjectModel.transactionalProcessingDelegated : true
define view zc_sales_item as select from zi_sales_item_tp Association[1..1] to zc_sales_header as _saleshdr on $projection.parentkey = _saleshdr.sd_uuid {
                                 key item_uuid, parentkey, sales_documentid, sales_itemid, mat_num, mat_grp, net_amount, currency,

@ObjectModel.association.type : [
    #TO_COMPOSITION_ROOT,
    #TO_COMPOSITION_PARENT
]
_saleshdr

}
