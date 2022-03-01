class zcl_data_generator_ext definition
  public
  inheriting from zcl_data_generator
  final
  create public .

  public section.
    methods: generate_header_data redefinition,
      generate_item_data redefinition.
  protected section.
  private section.
endclass.



class zcl_data_generator_ext implementation.
  method generate_header_data.
    data(lt_result) = value tt_sales_header(  ).

    break sodogan.
** clear out the data first!
    delete from zsales_header.

**select the data from vbak to load into the Header data
    select * from vbak
    into table @data(lt_vbak)
    up to 100 rows
    order by vbeln ascending
    .

    if sy-subrc is initial.
**copy the data to zsales_header
      lt_result = value #( for ls_vbak in lt_vbak ( sd_uuid = zcl_utility=>generate_guid( )
                                                    sales_documentid = ls_vbak-vbeln
                                                    order_type =  ls_vbak-auart
                                                    order_reason =   ls_vbak-augru
                                                    document_date = ls_vbak-audat
                                                    document_category = ls_vbak-vbtyp
                                                    net_value = ls_vbak-netwr
                                                    currency = ls_vbak-waerk
                                                  ) ).


      insert zsales_header from table lt_result.
      commit work.
      return_code = xsdbool( sy-subrc = 0 ).


    endif.


  endmethod.

  method generate_item_data.
    data(lt_header) = value tt_sales_header(  ).
    data(lt_result) = value tt_sales_item(  ).
    data:tr_sales_doc type range of vbeln_vl.

    break sodogan.
** clear out the data first!
    delete from zsales_item.

**selection will be based on the zsales-header table
    select 'I' as sign,
           'EQ' as option,
            sales_documentid as low
             from zsales_header
    into table @tr_sales_doc
    .

**select the data from vbak to load into the Header data
    select * from vbap
    into table @data(lt_vbap)
    where vbeln in @tr_sales_doc
    order by vbeln ascending, posnr ascending.

    if sy-subrc is initial.
**copy the data to zsales_header
      lt_result = value #( for ls_vbap in lt_vbap (  item_uuid = zcl_utility=>generate_guid( )
                                                    sales_documentid = ls_vbap-vbeln
                                                    sales_itemid = ls_vbap-posnr
                                                    mat_num = ls_vbap-matnr
                                                    mat_grp = ls_vbap-matkl
                                                    net_amount = ls_vbap-netwr
                                                    currency = ls_vbap-waerk
                                                  ) ).
**Now update the parent keys
      select *    from zsales_header
     into table lt_header
     .

      loop at lt_result reference into data(lr_result).
*find the the matching
        if line_exists( lt_header[ sales_documentid = lr_result->sales_documentid ] ).
          DATA(ls_matching) = lt_header[ sales_documentid = lr_result->sales_documentid ].
         lr_result->parentkey = ls_matching-sd_uuid.

        else.
        assert 1 = 2.
       endif.
      endloop.

*      lt_result = value #( for ls_header in lt_header  where ( sales_documentid = ls_header-sales_documentid ) ( parentkey = ls_header-sd_uuid ) ).



      insert zsales_item from table lt_result.
      commit work.
      return_code = xsdbool( sy-subrc = 0 ).
    endif.
  endmethod.

endclass.