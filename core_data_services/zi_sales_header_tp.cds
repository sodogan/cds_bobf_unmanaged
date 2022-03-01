@AbapCatalog.sqlViewName                    : 'ZISALESHEADERTP'
@AbapCatalog.compiler.compareFilter         : true
@AbapCatalog.preserveKey                    : true
@AccessControl.authorizationCheck           : #CHECK
@EndUserText.label                          : 'TP sales header View'
@VDM.viewType                               : #TRANSACTIONAL
@ObjectModel.transactionalProcessingEnabled : true
@ObjectModel.writeActivePersistence         : 'ZSALES_HEADER'
@ObjectModel.modelCategory                  : #BUSINESS_OBJECT
@ObjectModel.compositionRoot                : true
@ObjectModel.createEnabled                  : true
@ObjectModel.deleteEnabled                  : true
@ObjectModel.updateEnabled                  : true
@ObjectModel.usageType.dataClass            : #TRANSACTIONAL
define view zi_sales_header_tp as select from zsales_header Association[1.. * ] to zi_sales_item_tp as _salesitm on $projection.sd_uuid = _salesitm.parentkey

                                  {

                                      key sd_uuid, sales_documentid, document_date, document_category, order_type, order_reason,

@Semantics.amount.currencyCode : 'currency'
net_value, currency,
@ObjectModel.association.type  : [ #TO_COMPOSITION_CHILD]
_salesitm
}
