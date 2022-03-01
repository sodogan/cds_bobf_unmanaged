class zcl_utility definition
  public
  final
  create public .

  public section.
    class-methods: generate_guid exporting ev_guid_22  type guid_22 
                                           ev_guid_32  type guid_32 
                                    returning value(rv_guid_16)   type guid_16
                                           .
  protected section.
  private section.
endclass.



class zcl_utility implementation.
  method generate_guid.
   call function 'GUID_CREATE'
      importing
        ev_guid_16 = rv_guid_16
        ev_guid_22 = ev_guid_22
        ev_guid_32 = ev_guid_32
        .

  endmethod.

endclass.