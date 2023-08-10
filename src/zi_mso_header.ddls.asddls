@AbapCatalog.sqlViewName: 'ZVNSOHEADER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Header  - BO view'


/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define root view zi_mso_header
  as select from znwd_so_header as SalesOrder
  composition [0..*] of zi_mso_item          as _Item

  association [1] to SEPM_I_BusinessPartner  as _Partner    on $projection.Businesspartner = _Partner.BusinessPartner
  association [1] to I_Currency              as _Currency   on $projection.Currencycode = _Currency.Currency
  association [1] to zepmra_overralstatus_vh as _OvStatus   on $projection.Overallstatus = _OvStatus.OvStatusID
  association [1] to zepmra_billstatus_vh    as _BillStatus on $projection.Billingstatus = _BillStatus.BillStatusID
  association [1] to zepmra_delivery_vh      as _DelStatus  on $projection.Deliverystatus = _DelStatus.DeliveryStatusID
  association [1] to zepmra_paymentmth_vh    as _PayMethod  on $projection.Paymentmethod = _PayMethod.PaymentID
  association [1] to zepmra_paymenterms_vh   as _PayTerms   on $projection.Paymentterms = _PayTerms.PaymentTID
{
  key SalesOrder.salesorderid    as SalesorderId,
      SalesOrder.businesspartner as Businesspartner,
      SalesOrder.currencycode    as Currencycode,
      SalesOrder.grossamount     as Grossamount,
      SalesOrder.netamount       as Netamount,
      SalesOrder.overallstatus   as Overallstatus,
      SalesOrder.billingstatus   as Billingstatus,
      SalesOrder.deliverystatus  as Deliverystatus,
      SalesOrder.paymentmethod   as Paymentmethod,
      SalesOrder.paymentterms    as Paymentterms,
      SalesOrder.deliverydate    as Deliverydate,
      SalesOrder.crea_date_time  as Crea_Date_Time,
      SalesOrder.crea_uname      as Crea_Uname,
      SalesOrder.lchg_date_time  as Lchg_Date_Time,
      SalesOrder.lchg_uname      as Lchg_Uname,
      /* Associations */
      _Item,
      _Partner,
      _Currency,
      _OvStatus,
      _BillStatus,
      _DelStatus,
      _PayMethod,
      _PayTerms
}
