$PBExportHeader$w_gtepur012.srw
forward
global type w_gtepur012 from window
end type
type rb_4 from radiobutton within w_gtepur012
end type
type rb_3 from radiobutton within w_gtepur012
end type
type rb_1 from radiobutton within w_gtepur012
end type
type rb_2 from radiobutton within w_gtepur012
end type
type dp_2 from datepicker within w_gtepur012
end type
type st_3 from statictext within w_gtepur012
end type
type dp_1 from datepicker within w_gtepur012
end type
type st_2 from statictext within w_gtepur012
end type
type cb_1 from commandbutton within w_gtepur012
end type
type em_1 from editmask within w_gtepur012
end type
type st_1 from statictext within w_gtepur012
end type
type cb_2 from commandbutton within w_gtepur012
end type
type cb_4 from commandbutton within w_gtepur012
end type
type dw_1 from datawindow within w_gtepur012
end type
type gb_1 from groupbox within w_gtepur012
end type
type gb_2 from groupbox within w_gtepur012
end type
end forward

global type w_gtepur012 from window
integer width = 5632
integer height = 2328
boolean titlebar = true
string title = "(W_gtepur012) Purchase Detail For GST"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
rb_4 rb_4
rb_3 rb_3
rb_1 rb_1
rb_2 rb_2
dp_2 dp_2
st_3 st_3
dp_1 dp_1
st_2 st_2
cb_1 cb_1
em_1 em_1
st_1 st_1
cb_2 cb_2
cb_4 cb_4
dw_1 dw_1
gb_1 gb_1
gb_2 gb_2
end type
global w_gtepur012 w_gtepur012

type variables
long ll_ctr,net, ll_cnt, ll_year,ll_unitprice,ll_qnty,ll_price
string ls_temp,ls_eacsubhead_id,ls_eachead_id,ls_spc_id,ls_frym,ls_toym, ls_nppc
string ls_srep, ls_type
double ld_area
datetime ld_date
boolean lb_neworder, lb_query
datawindowchild idw_prod,idw_subexp
n_cst_powerfilter iu_powerfilter 
end variables

forward prototypes
public function integer wf_inquiry (long fl_year)
end prototypes

event ue_option();choose case gs_ueoption
	case "PRINT"
			OpenWithParm(w_print,this.dw_1)
	case "PRINTPREVIEW"
			this.dw_1.modify("datawindow.print.preview = yes")
	case "RESETPREVIEW"
			this.dw_1.modify("datawindow.print.preview = no")
	case "ZOOM"
		SetPointer (HourGlass!)											
		OpenwithParm (w_zoom,dw_1)
		SetPointer (Arrow!)						
case "SAVEAS"
			this.dw_1.saveas()
	case "SFILTER"
			iu_powerfilter.checked = NOT iu_powerfilter.checked
			iu_powerfilter.event ue_clicked()
			m_main.m_file.m_filter.checked = iu_powerfilter.checked
	case "FILTER"
			setnull(gs_filtertext)
			this.dw_1.setredraw(false)
			this.dw_1.setfilter(gs_filtertext)
			this.dw_1.filter()
			this.dw_1.groupcalc()
			if this.dw_1.rowcount() > 0 then;
				this.dw_1.setredraw(true)
			else
				Messagebox('Warning','Data Not Available In Given Criteria')
			end if
	case "SORT"
			setnull(gs_sorttext)
			this.dw_1.setredraw(false)
			this.dw_1.setsort(gs_sorttext)
			this.dw_1.sort()
			this.dw_1.groupcalc()
			if this.dw_1.rowcount() > 0 then;
				this.dw_1.setredraw(true)
			else
				Messagebox('Warning','Data Not Available In Given Criteria')
			end if
end choose

end event

public function integer wf_inquiry (long fl_year);dw_1.settransobject(sqlca)
dw_1.retrieve(gs_user,fl_year)
return 1
end function

on w_gtepur012.create
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_1=create rb_1
this.rb_2=create rb_2
this.dp_2=create dp_2
this.st_3=create st_3
this.dp_1=create dp_1
this.st_2=create st_2
this.cb_1=create cb_1
this.em_1=create em_1
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_4=create cb_4
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.rb_4,&
this.rb_3,&
this.rb_1,&
this.rb_2,&
this.dp_2,&
this.st_3,&
this.dp_1,&
this.st_2,&
this.cb_1,&
this.em_1,&
this.st_1,&
this.cb_2,&
this.cb_4,&
this.dw_1,&
this.gb_1,&
this.gb_2}
end on

on w_gtepur012.destroy
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.dp_2)
destroy(this.st_3)
destroy(this.dp_1)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
lb_query = false	
lb_neworder = false

cb_1.enabled = true
em_1.enabled = true
dp_1.enabled = false
dp_2.enabled = false
setpointer(hourglass!)


end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

type rb_4 from radiobutton within w_gtepur012
integer x = 1477
integer y = 32
integer width = 343
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bill Wise"
end type

event clicked;cb_1.enabled = true
em_1.enabled = true
dp_1.enabled = false
dp_2.enabled = false
end event

type rb_3 from radiobutton within w_gtepur012
integer x = 1001
integer y = 32
integer width = 430
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bill-HSN Wise"
boolean checked = true
end type

event clicked;cb_1.enabled = false
em_1.enabled = false
dp_1.enabled = true
dp_2.enabled = true
end event

type rb_1 from radiobutton within w_gtepur012
integer x = 55
integer y = 32
integer width = 343
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Date-Wise"
end type

event clicked;cb_1.enabled = false
em_1.enabled = false
dp_1.enabled = true
dp_2.enabled = true
end event

type rb_2 from radiobutton within w_gtepur012
integer x = 398
integer y = 32
integer width = 512
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year-Month Wise"
boolean checked = true
end type

event clicked;cb_1.enabled = true
em_1.enabled = true
dp_1.enabled = false
dp_2.enabled = false
end event

type dp_2 from datepicker within w_gtepur012
integer x = 2821
integer y = 24
integer width = 398
integer height = 84
integer taborder = 60
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2022-06-20"), Time("11:29:50.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_3 from statictext within w_gtepur012
integer x = 2601
integer y = 36
integer width = 247
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To Date :"
alignment alignment = center!
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gtepur012
integer x = 2190
integer y = 24
integer width = 398
integer height = 84
integer taborder = 50
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2022-06-20"), Time("11:29:50.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_2 from statictext within w_gtepur012
integer x = 1911
integer y = 36
integer width = 297
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From Date :"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtepur012
integer x = 4375
integer y = 16
integer width = 329
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Make CSV"
end type

event clicked;if  len(trim(em_1.text)) = 0 or isnull(em_1.text) or em_1.text = 'none' or em_1.text = '000000'  then
	messagebox ('From date is blank','please Enter the Year Month')
	return 1
end if;


string ls_vou_no, ls_lpi_id, ls_gstnno,ls_rev_chrg,ls_rev_cat, ls_iss_locn,ls_party_nm,ls_bill_no,ls_invoice_no,ls_hsn, ls_uom, ls_today,ls_now,ra_yrmn,ls_vou_dt,ls_bill_dt,ls_rec
double ld_amount, ld_quantity,ld_effectiveprice, ld_cgst_per, ld_sgst_per, ld_igst_per,  ld_cgst_amt, ld_sgst_amt, ld_igst_amt
datetime ld_vou_dt, ld_bill_dt
integer li_filenum, li_rec, li_ctr
li_ctr=0;
ls_today = string(today(),'ddmmyyyy')
ls_now = string(now(),'hhmmss')
ra_yrmn = em_1.text
setpointer(hourglass!) 

setnull(ls_vou_no);setnull(ls_lpi_id);setnull(ls_gstnno);setnull(ls_rev_chrg);setnull(ls_rev_cat);setnull(ls_iss_locn);setnull(ls_party_nm);setnull(ls_bill_no);setnull(ls_invoice_no);setnull(ls_hsn);setnull(ls_uom);
setnull(ld_vou_dt);setnull(ld_bill_dt);
ld_amount = 0; ld_quantity = 0; ld_effectiveprice = 0; ld_cgst_per = 0; ld_sgst_per = 0; ld_igst_per =0;  ld_cgst_amt = 0; ld_sgst_amt = 0; ld_igst_amt = 0;

ChangeDirectory("c:\")
if DirectoryExists("temp") = false then
	CreateDirectory ("temp")
end if
	ChangeDirectory("temp")
	
	if fileexists("c:\temp\purgst_"+ls_today+"_"+ls_now+".csv") = true then
		filedelete("c:\temp\purgst_"+ls_today+"_"+ls_now+".csv")
	end if

li_filenum =  fileopen("c:\temp\purgst_"+ls_today+"_"+ls_now+".csv",linemode!,write!,lockreadwrite!,replace!)

DECLARE c1 CURSOR FOR
select LPI_VOU_NO, LPI_VOU_DT,lpi.lpi_id, sum(nvl(LPI_EFFECTIVEUNITPRICE,0) * nvl(LPI_QUANTITY,0)) Amount,LPI_ISS_GSTNNO,LPI_REV_CHRG, LPI_REV_CAT,LPI_ISS_LOCN,
     initcap(sup_name) party_name,LPI_BILLNO, LPI_BILLDATE,RCI_INVOICE_NO, sp.SP_HSN_NO, sp.SP_UNIT,       
    LPI_QUANTITY,LPI_EFFECTIVEUNITPRICE, LPI_CGST_PER, LPI_SGST_PER, LPI_IGST_PER, 
    sum(nvl(LPI_CGST_AMT,0)) LPI_CGST_AMT, sum(nvl(LPI_SGST_AMT,0)) LPI_SGST_AMT, sum(nvl(LPI_IGST_AMT,0)) LPI_IGST_AMT
from fb_localpurchaseinvoice lpi, fb_lpidetails lpd, fb_localpurchaseorder lpo, fb_supplier sup, (select distinct RCI_INVOICE_NO, RCI_REF_NO from FB_REVCHARGE_INVOICE)  rc, fb_storeproduct sp
where lpi.lpi_id = lpd.lpi_id and lpi.lpo_id = lpo.lpo_id and lpo.sup_id = sup.sup_id(+) and lpi.lpi_vou_no = rc.rci_ref_no(+) and lpd.sp_id = sp.sp_id and 
  to_char(lpi_vou_dt,'YYYYMM') = :ra_yrmn
group by LPI_VOU_NO, LPI_VOU_DT,lpi.lpi_id, LPI_ISS_GSTNNO, LPI_REC_GSTNNO,LPI_REV_CHRG, LPI_REV_CAT,LPI_ISS_LOCN, LPI_REC_LOCN,  
    lpo.sup_id, initcap(sup_name),LPI_BILLNO, LPI_BILLDATE,RCI_INVOICE_NO,         
    LPI_QUANTITY,LPI_EFFECTIVEUNITPRICE,LPI_CGST_PER, LPI_SGST_PER, LPI_IGST_PER,sp.SP_HSN_NO, sp.SP_UNIT
union all
select vh_vou_no, vh_vou_date, null, sum(nvl(VD_BILL_AMT, 0)), SUP_GSTNNO, nvl(VD_REVCHG_IND, 'N'), VD_REVCHG_CATG, SUP_GSTN_STCD, initcap(sup_name), VD_REF_NO, VD_REF_DATE, null, vd_hsn_cd, null, null, null,
	sum(nvl(VD_CGST_PRCNT, 0)), sum(nvl(VD_SGST_PRCNT, 0)), sum(nvl(VD_IGST_PRCNT, 0)), sum(nvl(VD_CGST_AMT, 0)), sum(nvl(VD_SGST_AMT, 0)), sum(nvl(VD_IGST_AMT, 0))
from fb_vou_head a, fb_vou_det b, fb_acsubledger c, fb_supplier d, fb_gardenmaster
where vh_doc_Srl = vd_Doc_srl  and vd_sgl_Cd = c.acsubledger_id and c.acsubledger_id = d.acsubledger_id  and nvl(unit_active_ind , 'N') = 'Y' and nvl(vd_gst_ind , 'N') = 'Y'
	and  to_char(vh_vou_date,'YYYYMM') = :ra_yrmn
group by vh_vou_no, vh_vou_date , SUP_GSTNNO,  nvl(VD_REVCHG_IND, 'N'), VD_REVCHG_CATG, SUP_GSTN_STCD, sup_name, VD_REF_NO, VD_REF_DATE, vd_hsn_cd
order by 6, 2, 3;

 open c1;

 if sqlca.sqlcode = 0 then
	setnull(ls_vou_no);setnull(ls_lpi_id);setnull(ls_gstnno);setnull(ls_rev_chrg);setnull(ls_rev_cat);setnull(ls_iss_locn);setnull(ls_party_nm);setnull(ls_bill_no);setnull(ls_invoice_no);setnull(ls_hsn);setnull(ls_uom);
	setnull(ld_vou_dt);setnull(ld_bill_dt);
	ld_amount = 0; ld_quantity = 0; ld_effectiveprice = 0; ld_cgst_per = 0; ld_sgst_per = 0; ld_igst_per =0;  ld_cgst_amt = 0; ld_sgst_amt = 0; ld_igst_amt = 0;
	
   fetch c1 into :ls_vou_no,:ld_vou_dt,:ls_lpi_id,:ld_amount,:ls_gstnno,:ls_rev_chrg,:ls_rev_cat,:ls_iss_locn,:ls_party_nm,:ls_bill_no,:ld_bill_dt,:ls_invoice_no,:ls_hsn,:ls_uom,:ld_quantity,:ld_effectiveprice, :ld_cgst_per, :ld_sgst_per, :ld_igst_per,  :ld_cgst_amt, :ld_sgst_amt, :ld_igst_amt;

	do while sqlca.sqlcode <> 100
		
		ls_vou_dt = string(ld_vou_dt,'dd/mm/yyyy')
		ls_bill_dt = string(ld_bill_dt,'dd/mm/yyyy')
		if isnull(ls_vou_no) then; ls_vou_no=""; end if;
		if isnull(ls_vou_dt) then; ls_vou_dt=""; end if;
   		if isnull(ls_lpi_id) then; ls_lpi_id=""; end if;
		if isnull(ld_amount) then; ld_amount= 0; end if;
   		if isnull(ls_gstnno) then; ls_gstnno=""; end if;
   		if isnull(ls_rev_chrg) then; ls_rev_chrg=""; end if;		
		if isnull(ls_rev_cat) then; ls_rev_cat=""; end if;		
		if isnull(ls_iss_locn) then; ls_iss_locn=""; end if;		
		if isnull(ls_party_nm) then; ls_party_nm=""; end if;		
		if isnull(ls_bill_no) then; ls_bill_no=""; end if;		
		if isnull(ls_bill_dt) then; ls_bill_dt=""; end if;		
		if isnull(ls_invoice_no) then; ls_invoice_no=""; end if;		
		if isnull(ls_hsn) then; ls_hsn=""; end if;		
		if isnull(ls_uom) then; ls_uom=""; end if;	
		if isnull(ld_quantity) then; ld_quantity= 0; end if;	
		if isnull(ld_effectiveprice) then; ld_effectiveprice=0; end if;	
		if isnull(ld_cgst_per) then; ld_cgst_per=0; end if;	
		if isnull(ld_sgst_per) then; ld_cgst_per=0; end if;	
		if isnull(ld_igst_per) then; ld_igst_per=0; end if;	
		if isnull(ld_cgst_amt) then; ld_cgst_amt=0; end if;	
		if isnull(ld_sgst_amt) then; ld_cgst_amt=0; end if;	
		if isnull(ld_igst_amt) then; ld_igst_amt=0; end if;	
		
				
		ls_rec = gs_garden_snm + ","+ ls_vou_no +"," + ls_vou_dt + "," + ls_lpi_id + "," + string(ld_amount) + "," + ls_gstnno + "," + ls_rev_chrg + "," +  ls_rev_cat + "," + ls_iss_locn + "," + ls_party_nm + ","
		ls_rec = ls_rec + ls_bill_no + "," + ls_bill_dt + "," + ls_invoice_no + "," + ls_hsn + "," + ls_uom + "," + string(ld_quantity) + "," + string(ld_effectiveprice) + "," + string(ld_cgst_per) + "," + string(ld_sgst_per) + "," + string(ld_igst_per) + ","  
		ls_rec = ls_rec + string(ld_cgst_amt) + "," + string(ld_sgst_amt) + "," + string(ld_igst_amt)
		
		filewrite(li_filenum,ls_rec)

		
		li_rec++
		li_ctr++
		
	setnull(ls_vou_no);setnull(ls_lpi_id);setnull(ls_gstnno);setnull(ls_rev_chrg);setnull(ls_rev_cat);setnull(ls_iss_locn);setnull(ls_party_nm);setnull(ls_bill_no);setnull(ls_invoice_no);setnull(ls_hsn);setnull(ls_uom);
	setnull(ld_vou_dt);setnull(ld_bill_dt);
	ld_amount = 0; ld_quantity = 0; ld_effectiveprice = 0; ld_cgst_per = 0; ld_sgst_per = 0; ld_igst_per =0;  ld_cgst_amt = 0; ld_sgst_amt = 0; ld_igst_amt = 0;

	
  	 fetch c1 into :ls_vou_no,:ld_vou_dt,:ls_lpi_id,:ld_amount,:ls_gstnno,:ls_rev_chrg,:ls_rev_cat,:ls_iss_locn,:ls_party_nm,:ls_bill_no,:ls_bill_dt,:ls_invoice_no,:ls_hsn,:ls_uom,:ld_quantity,:ld_effectiveprice, :ld_cgst_per, :ld_sgst_per, :ld_igst_per,  :ld_cgst_amt, :ld_sgst_amt, :ld_igst_amt;

   loop
	close c1;
else
	messagebox('Error: During Opening of Cursor',sqlca.sqlerrtext)
	return 1
end if

fileclose(li_filenum)

setpointer(arrow!) 
messagebox('Confirmation','Total No Of Records : '+string(li_ctr))
return 1
end event

type em_1 from editmask within w_gtepur012
integer x = 3570
integer y = 24
integer width = 219
integer height = 84
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "YYYYMM"
end type

type st_1 from statictext within w_gtepur012
integer x = 3241
integer y = 36
integer width = 315
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year Month:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gtepur012
integer x = 3835
integer y = 16
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&OK"
end type

event clicked;if rb_1.checked then
	if  len(trim(dp_1.text)) = 0 or isnull(dp_1.text) then
		messagebox ('From date is blank','please Enter the from date.')
		return 1
	end if;
	
	if  len(trim(dp_2.text)) = 0 or isnull(dp_2.text) then
		messagebox ('To date is blank','please Enter the To date.')
		return 1
	end if;
		
	if  date(dp_2.text) < date(dp_1.text) then
		messagebox ('Enter the correct To Date','To Date cannot be less than from date.')
		return 1
	end if;
end if


if rb_2.checked then
	if  len(trim(em_1.text)) = 0 or isnull(em_1.text) then
		messagebox ('From date is blank','please Enter the Year Month')
		return 1
	end if;
end if

if rb_1.checked then
	ls_type = 'DT'
elseif rb_2.checked then
	ls_type = 'YM'
end if

if rb_3.checked then
	dw_1.dataobject = 'dw_gtepur012'
elseif rb_4.checked then
	dw_1.dataobject = 'dw_gtepur012_sum'
end if

dw_1.settransobject(sqlca)
dw_1.retrieve(ls_type, dp_1.text, dp_2.text, em_1.text)

end event

type cb_4 from commandbutton within w_gtepur012
integer x = 4105
integer y = 16
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_gtepur012
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 27
integer y = 120
integer width = 5463
integer height = 2060
integer taborder = 50
string dataobject = "dw_gtepur012"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF
end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

type gb_1 from groupbox within w_gtepur012
integer x = 969
integer width = 896
integer height = 116
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylebox!
end type

type gb_2 from groupbox within w_gtepur012
integer x = 32
integer width = 896
integer height = 116
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylebox!
end type

