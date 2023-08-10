@AbapCatalog.sqlViewName: 'ZVNSOITEM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Item - BO view'

define view zi_mso_item
  as select from znwd_so_item as Item
  association     to parent zi_mso_header as _SalesOrder on $projection.SalesorderId = _SalesOrder.SalesorderId
  association [1] to SEPM_I_Product_E     as _Product    on $projection.Prodid = _Product.Product
  association [1] to zepmra_atp_vh        as _Atp        on $projection.Available = _Atp.Atp
  association [1] to zepmra_prodname_vh   as _Pdesc      on $projection.Prodid = _Pdesc.Product
{
  key  Item.salesorderid as  SalesorderId,
  key  Item.itempos      as Itempos,
       Item.prodid       as Prodid,
       Item.unitid       as Unitid,
       Item.quantity     as Quantity,
       Item.currencycode as Currencycode,
       Item.grossamount  as Grossamount,
       Item.net_amount   as Net_Amount,
       Item.available    as Available,
       /* Associations */
       _SalesOrder,
       _Product,
       _Atp,
       _Pdesc
}
