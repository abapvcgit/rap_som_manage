CLASS lhc_SalesOrder DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE SalesOrder.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE SalesOrder.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE SalesOrder.

    METHODS read FOR READ
      IMPORTING keys FOR READ SalesOrder RESULT result.

    METHODS cba_ITEM FOR MODIFY
      IMPORTING entities_cba FOR CREATE SalesOrder\_item.

    METHODS rba_ITEM FOR READ
      IMPORTING keys_rba FOR READ SalesOrder\_item FULL result_requested RESULT result LINK association_links.

    METHODS get_features FOR FEATURES
      IMPORTING keys REQUEST requested_features FOR SalesOrder RESULT result.

ENDCLASS.

CLASS lhc_SalesOrder IMPLEMENTATION.

  METHOD create.
    DATA : ls_salesorder TYPE znwd_so_header,
           ls_mapped     LIKE LINE OF mapped-salesorder.
    DATA lv_timestamp TYPE timestampl.
    GET TIME STAMP FIELD lv_timestamp.

    SELECT MAX( salesorderid ) AS soid INTO @DATA(lv_soid)
    FROM znwd_so_header.

    LOOP AT entities INTO DATA(ls_entitie).

      ADD 1 TO lv_soid.
      ls_entitie-SalesorderId = |{ lv_soid ALPHA = IN }|.
      ls_entitie-Overallstatus = 'N'.
      ls_entitie-Crea_Uname = sy-uname.
      ls_entitie-Crea_Date_Time = lv_timestamp.
      ls_entitie-Lchg_Uname = sy-uname.
      ls_entitie-Lchg_Date_Time = lv_timestamp.

      MOVE-CORRESPONDING ls_entitie TO ls_salesorder.

      ls_mapped-%cid = ls_entitie-%cid.
      ls_mapped-SalesorderId = ls_salesorder-salesorderid.
      INSERT znwd_so_header FROM  ls_salesorder.
      APPEND ls_mapped TO mapped-salesorder.
    ENDLOOP.

  ENDMETHOD.

  METHOD delete.


    LOOP AT keys INTO DATA(ls_key).
      DELETE FROM znwd_so_header
      WHERE salesorderid = ls_key-SalesorderId.
      IF sy-subrc EQ 0.
        DELETE FROM znwd_so_item WHERE salesorderid = ls_key-SalesorderId.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD read.

    SELECT *
    FROM znwd_so_header INTO CORRESPONDING FIELDS OF TABLE @result
    FOR ALL ENTRIES IN @keys
    WHERE salesorderid = @keys-SalesorderId.
  ENDMETHOD.

  METHOD cba_ITEM.
  ENDMETHOD.

  METHOD rba_ITEM.
  ENDMETHOD.

  METHOD get_features.
    " Read the travel status of the existing travels
    READ ENTITIES OF zi_mso_header IN LOCAL MODE
     ENTITY SalesOrder FIELDS ( Businesspartner ) WITH CORRESPONDING #( keys )
     RESULT DATA(salesorders)
     FAILED failed.

    result = VALUE #( FOR saleorder IN salesorders
               LET bp = COND #( WHEN saleorder-Businesspartner IS INITIAL
                                   THEN if_abap_behv=>fc-f-mandatory
                                   ELSE if_abap_behv=>fc-f-read_only )
*                   agency = COND #( WHEN travel-AgencyId IS INITIAL
*                                   THEN if_abap_behv=>fc-f-mandatory
*                                   ELSE if_abap_behv=>fc-f-read_only )
                            IN ( %key = saleorder-%key
                                 %field-Businesspartner = bp )
                                     ).
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zi_mso_header DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS check_before_save REDEFINITION.

    METHODS finalize          REDEFINITION.

    METHODS save              REDEFINITION.

ENDCLASS.

CLASS lsc_zi_mso_header IMPLEMENTATION.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD finalize.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

ENDCLASS.
