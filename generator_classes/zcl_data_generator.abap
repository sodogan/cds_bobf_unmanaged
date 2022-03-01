class zcl_data_generator definition
  public
  abstract
  create public .

  public section.
    constants: tg type i value 100.
    types: tt_sales_header type standard table of zsales_header with empty key,
           tt_sales_item type standard table of zsales_item with empty key
           .
    constants: begin of config,
                 max_rows type i value 100,
               end of config.


    interfaces if_oo_adt_classrun .
    methods: generate_header_data abstract
      importing max_rows type i returning value(return_code) type abap_bool .
    methods: generate_item_data abstract
      importing max_rows type i returning value(return_code) type abap_bool.

  protected section.

  private section.
endclass.



class zcl_data_generator implementation.

  method if_oo_adt_classrun~main.
**Step by Step
    if generate_header_data( config-max_rows ).
      out->write( 'Header data is inserted into zsales_header' ).
    endif.
    if   generate_item_data( config-max_rows ).
      out->write( 'Item data is inserted into zsales_item' ).
    endif..
  endmethod.



endclass.