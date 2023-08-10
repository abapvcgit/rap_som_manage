@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order - Consumption View'

@Search.searchable: true
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['SalesorderID']
define root view entity zc_mso_header
  as projection on zi_mso_header as SalesOrder
{
      @Search.defaultSearchElement: true
  key SalesorderId,
      @Consumption.valueHelpDefinition: [{ association: '_Partner' }]
      @ObjectModel:{ text.element: ['PartnerName']}
      Businesspartner,
      _Partner.CompanyName      as PartnerName,
      Currencycode,
      @Semantics.amount.currencyCode: 'currencycode'
      Grossamount,
      @Semantics.amount.currencyCode: 'currencycode'
      Netamount,
      @Consumption.valueHelpDefinition: [{ association: '_OvStatus' }]
      @ObjectModel.text.element: ['OvStatusTxt']
      Overallstatus,
      _OvStatus.OvStatus        as OvStatusTxt,
      @ObjectModel.text.element: ['BillStatusTxt']
      @Consumption.valueHelpDefinition: [{ association: '_BillStatus' }]
      Billingstatus,
      _BillStatus.BillStatus    as BillStatusTxt,
      @Consumption.valueHelpDefinition: [{ association: '_DelStatus' }]
      @ObjectModel.text.element: ['DelivetyStatusTxt']
      Deliverystatus,
      _DelStatus.DeliveryStatus as DelivetyStatusTxt,
      @Consumption.valueHelpDefinition: [{ association: '_PayMethod' }]
      @ObjectModel.text.element: ['PaymentMethodTxt']
      Paymentmethod,
      _PayMethod.PaymentMethod  as PaymentMethodTxt,

      @Consumption.valueHelpDefinition: [{ association: '_PayTerms' }]
      @ObjectModel.text.element: ['PaymentTermsTxt']
      Paymentterms,
      _PayTerms.PaymentTerms    as PaymentTermsTxt,
      Deliverydate,
      Crea_Date_Time,
      Crea_Uname,

      Lchg_Date_Time,

      Lchg_Uname,
      /* Associations */
      _BillStatus,
      _Currency,
      _DelStatus,
      _Item : redirected to composition child zc_mso_item,
      _OvStatus,
      _Partner,
      _PayMethod,
      _PayTerms
}
