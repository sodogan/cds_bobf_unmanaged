@AbapCatalog.sqlViewName                    : 'ZISALESITEMTP'
@AbapCatalog.compiler.compareFilter         : true
@AbapCatalog.preserveKey                    : true
@AccessControl.authorizationCheck           : #CHECK
@EndUserText.label                          : 'Tp Sales Item'
@VDM.viewType                               : #TRANSACTIONAL
@ObjectModel.transactionalProcessingEnabled : true
@ObjectModel.writeActivePersistence         : 'ZSALES_ITEM'
@ObjectModel.createEnabled                  : true
@ObjectModel.deleteEnabled                  : true
@ObjectModel.updateEnabled                  : true
@ObjectModel.usageType.dataClass            : #TRANSACTIONAL
define view zi_sales_item_tp as select from zsales_item Association[1..1] to zi_sales_header_tp as _saleshdr on $projection.parentkey = _saleshdr.sd_uuid {
                                    key item_uuid, parentkey, sales_documentid, sales_itemid, mat_num, mat_grp,

@Semantics.amount.currencyCode : 'currency'
net_amount, currency,
@ObjectModel.association.type  : [
    #TO_COMPOSITION_ROOT,
    #TO_COMPOSITION_PARENT
]
_saleshdr
}
