@AbapCatalog.sqlViewName            : 'ZISALESHEADER'
@AbapCatalog.compiler.compareFilter : true
@AbapCatalog.preserveKey            : true
@AccessControl.authorizationCheck   : #CHECK
@EndUserText.label                  : 'Sales Header'
define view zi_sales_header as
    select from zsales_header {
        key sd_uuid,
            sales_documentid,
            document_date,
            document_category,
            order_type,
            order_reason,
            @Semantics.amount.currencyCode : 'currency'
            net_value,
            currency
    }
