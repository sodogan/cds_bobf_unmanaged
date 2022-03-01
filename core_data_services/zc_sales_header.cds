@AbapCatalog.sqlViewName                      : 'ZCSALESHEADER'
@AbapCatalog.compiler.compareFilter           : true
@AbapCatalog.preserveKey                      : true
@AccessControl.authorizationCheck             : #CHECK
@EndUserText.label                            : 'Consumption view'
@VDM.viewType                                 : #CONSUMPTION
@ObjectModel.createEnabled                    : true
@ObjectModel.updateEnabled                    : true
@ObjectModel.deleteEnabled                    : true
@ObjectModel.compositionRoot                  : true
@ObjectModel.transactionalProcessingDelegated : true
@Metadata.allowExtensions                     : true
define view zc_sales_header as select from zi_sales_header_tp Association[1.. * ] to zc_sales_item as _salesitm on $projection.sd_uuid = _salesitm.parentkey

                               {
                                   key sd_uuid, sales_documentid, document_date, document_category, order_type, order_reason, net_value, currency,

@ObjectModel.association.type : [ #TO_COMPOSITION_CHILD]
_salesitm

}
