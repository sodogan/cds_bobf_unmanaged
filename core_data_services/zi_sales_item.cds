@AbapCatalog.sqlViewName            : 'ZISALESITEM'
@AbapCatalog.compiler.compareFilter : true
@AbapCatalog.preserveKey            : true
@AccessControl.authorizationCheck   : #CHECK
@EndUserText.label                  : 'Sales item interface view'
define view zi_sales_item as
    select from zsales_item {
        key item_uuid        as sd_item_key,
            parentkey        as Parentkey,
            sales_documentid as SalesDocumentid,
            sales_itemid     as SalesItemid,
            mat_num          as MatNum,
            mat_grp          as MatGrp,
            @Semantics.amount.currencyCode : 'Currency'
            net_amount       as NetAmount,
            currency         as Currency
    }
