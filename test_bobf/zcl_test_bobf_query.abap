class zcl_test_bobf_query definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun .
    class-methods:class_contructor.
    methods:constructor.
  protected section.
  private section.
    methods: create_new_record.
    methods:select_by_attribute returning value(rt_keys) type /bobf/t_frw_key.
    methods:select_all returning value(rt_keys) type /bobf/t_frw_key.
    data: mo_service_manager type ref to /bobf/if_tra_service_manager.
    data: mo_txn_manager type ref to /bobf/if_tra_transaction_mgr.
    data: mo_conf type ref to /bobf/if_frw_configuration.
endclass.



class zcl_test_bobf_query implementation.

  method class_contructor.
    break sodogan.
  endmethod.

  method constructor.

**First get the service manager
* get the transaction manager
    try.
        mo_service_manager =   /bobf/cl_tra_serv_mgr_factory=>get_service_manager(
                  exporting
                    iv_bo_key                     = /bobf/if_demo_customer_c=>sc_bo_key
                ).

        mo_txn_manager = /bobf/cl_tra_trans_mgr_factory=>get_transaction_manager( ).


**Get the configuration
        mo_conf =   /bobf/cl_frw_factory=>get_configuration(
                /bobf/if_demo_customer_c=>sc_bo_key ).

      catch /bobf/cx_frw_contrct_violation into data(lo_exception).
        break sodogan.
    endtry.

  endmethod.

  method if_oo_adt_classrun~main.


**Combined table type
     create_new_record(  ).
*    data(lt_keys) = select_by_attribute(  ).
    data(lt_keys) = select_all(  ).

    out->write( lt_keys ).
  endmethod.


  method select_all.
    data: lt_data type /bobf/t_demo_customer_hdr_k.

**Do a query
    try.
        mo_service_manager->query(
          exporting
            iv_query_key            = /bobf/if_demo_customer_c=>sc_query-root-select_all
          importing
*            et_data                 = lt_data
           et_key                  = rt_keys ).
      catch /bobf/cx_frw_contrct_violation into data(lo_exception).
        assert 1 = 2.
    endtry.
  endmethod.


  method select_by_attribute.
    data: lt_data type /bobf/t_demo_customer_hdr_k.

    data lt_parameters    type /bobf/t_frw_query_selparam.
    append initial line to lt_parameters assigning field-symbol(<ls_parameter>).
    <ls_parameter>-attribute_name =    /bobf/if_demo_customer_c=>sc_query_attribute-root-select_by_attributes-customer_id.
    <ls_parameter>-sign           = 'I'.
    <ls_parameter>-option         = 'EQ'.
    <ls_parameter>-low            = '1400'.


**Do a query
    try.
        mo_service_manager->query(
          exporting
            iv_query_key            = /bobf/if_demo_customer_c=>sc_query-root-select_by_attributes
*         it_filter_key           =
            it_selection_parameters = lt_parameters
          importing
*            et_data                 = lt_data
           et_key                  = rt_keys ).
      catch /bobf/cx_frw_contrct_violation into data(lo_exception).
        assert 1 = 2.
    endtry.
  endmethod.

  method create_new_record.
    data lt_mod      type /bobf/t_frw_modification.
    data lo_change   type ref to /bobf/if_tra_change.
    data lo_message  type ref to /bobf/if_frw_message.
    data lv_rejected type boole_d.
    data lx_bopf_ex  type ref to /bobf/cx_frw.
    data lv_err_msg  type string.

    data lr_s_root     type ref to /bobf/s_demo_customer_hdr_k.
    data lr_s_txt      type ref to /bobf/s_demo_short_text_k.
    data lr_s_txt_hdr  type ref to /bobf/s_demo_longtext_hdr_k.
    data lr_s_txt_cont type ref to /bobf/s_demo_longtext_item_k.

    "Build the ROOT node:
    create data lr_s_root.
    lr_s_root->key = /bobf/cl_frw_factory=>get_new_key( ).
    lr_s_root->customer_id    = '999'.
    lr_s_root->sales_org      = 'AMER'.
    lr_s_root->cust_curr      = 'USD'.
    lr_s_root->address_contry = 'US'.
    lr_s_root->address        = '1234 Any Street'.



    append initial line to lt_mod assigning field-symbol(<ls_mod>).
    <ls_mod>-node        = /bobf/if_demo_customer_c=>sc_node-root.
    <ls_mod>-change_mode = /bobf/if_frw_c=>sc_modify_create.
    <ls_mod>-key         = lr_s_root->key.
    <ls_mod>-data        = lr_s_root.




    "Create the customer record:
    mo_service_manager->modify(
      exporting
         it_modification = lt_mod
       importing
         eo_change       = lo_change
         eo_message      = lo_message ).
*     catch /bobf/cx_frw_contrct_violation.



    "Check for errors:
    if lo_message is bound.
      if lo_message->check( ) eq abap_true.
         break sodogan.
        return.
      endif.
    endif.



    "Apply the transactional changes:
    mo_txn_manager->save(
*      exporting
*        iv_transaction_pattern = /bobf/if_tra_c=>gc_tp_save_and_continue
      importing
        ev_rejected            = lv_rejected
        eo_change              = lo_change
*        eo_message             =
*        et_rejecting_bo_key    =
    ).



  endmethod.

endclass.