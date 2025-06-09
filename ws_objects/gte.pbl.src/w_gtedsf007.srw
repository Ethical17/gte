$PBExportHeader$w_gtedsf007.srw
forward
global type w_gtedsf007 from window
end type
type cb_11 from commandbutton within w_gtedsf007
end type
type cb_10 from commandbutton within w_gtedsf007
end type
type cb_6 from commandbutton within w_gtedsf007
end type
type cb_5 from commandbutton within w_gtedsf007
end type
type cb_7 from commandbutton within w_gtedsf007
end type
type cb_8 from commandbutton within w_gtedsf007
end type
type cb_9 from commandbutton within w_gtedsf007
end type
type cb_4 from commandbutton within w_gtedsf007
end type
type cb_3 from commandbutton within w_gtedsf007
end type
type cb_2 from commandbutton within w_gtedsf007
end type
type cb_1 from commandbutton within w_gtedsf007
end type
type dw_1 from datawindow within w_gtedsf007
end type
type dw_2 from datawindow within w_gtedsf007
end type
end forward

global type w_gtedsf007 from window
integer width = 4603
integer height = 2548
boolean titlebar = true
string title = "(w_gtedsf007) Dispatch Invoice"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_11 cb_11
cb_10 cb_10
cb_6 cb_6
cb_5 cb_5
cb_7 cb_7
cb_8 cb_8
cb_9 cb_9
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
dw_2 dw_2
end type
global w_gtedsf007 w_gtedsf007

type variables
long ll_ctr, ll_cnt,l_ctr,ix,ll_st_year, ll_end_year, ll_user_level,ll_ac_year,ll_gpno,ll_last,ll_stno,lledno,ll_nop,ll_season, ll_tmp, ll_tino,ll_fymm,ll_dlcno
string ls_temp,ls_del_ind,ls_tmp_id,ls_entry_user,ls_cons,ls_last,ls_count, ls_ref, ls_desc, ls_pinv, ls_dtpdid,ls_adv, ls_gpno, ls_waybill, ls_type,ls_iss_gstn,ls_rec_gstn, ls_tinvno,ls_dlcno,ls_count1
string ls_bname, ls_badd, ls_cname, ls_cadd, ls_gradelist, ls_cnno, ls_cust, ls_brok,ls_lotno, ls_iss_locn, ls_rec_locn,ls_hsn_cd,ls_wareid, ls_lutno, ls_tcs_ind, ls_pan, ls_inc_gst, ls_dt1,ls_dtpd_id
boolean lb_neworder, lb_query
double ld_gwt,ld_trwt,ld_nwt,ld_tgwt,ld_tnwt, ld_insval, ld_insrate,ld_totalnwt,ld_advqty,ld_hesc,ld_cess,ld_edcess,ld_adex,ld_toll,ld_igst_per,ld_cgst_per,ld_sgst_per, ld_rate, ld_tcs_rate
datetime ld_condt, ld_invdt, ld_bill_dt
double ld_netamt, ld_tcgst, ld_tsgst, ld_tigst, ld_totfy_sale
datawindowchild idw_invno

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_invno)
public function integer wf_gradetotal (string fs_grade, string fs_inv)
public function integer wf_gradetotal_fw (string fs_grade)
public function integer wf_calnet_amt ()
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

public function integer wf_check_fillcol (integer fl_row);if dw_2.rowcount() > 0 and fl_row > 0 then
		if (isnull(dw_2.getitemstring(fl_row,'dtp_lotno')) or  len(dw_2.getitemstring(fl_row,'dtp_lotno'))=0 ) then
			 messagebox('Warning: One Of The Following Fields Are Blank','Packing Invoice No , Please Check !!!')
			 return -1
		end if
end if
return 1

end function

public function integer wf_check_duplicate_rec (string fs_invno);long fl_row
string ls_inv1

dw_2.SelectRow(0, FALSE)
if dw_2.rowcount() > 1 then
	for fl_row = 1 to (dw_2.rowcount() - 1)
		ls_inv1 = dw_2.getitemstring(fl_row,'dtp_lotno')
		if gs_garden_snm <> 'MK' then
			if trim(ls_inv1) = trim(fs_invno) then
				dw_2.SelectRow(fl_row, TRUE)
				messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
				return -1
			end if
		end if
	next 
end if 

return 1
end function

public function integer wf_gradetotal (string fs_grade, string fs_inv);long fl_row
string ls_grade1, ls_inv1
double ld_wt, ld_gtotal
dw_2.SelectRow(0, FALSE)
if dw_2.rowcount() > 0 then
	for fl_row = 1 to dw_2.rowcount()
		ls_grade1 = dw_2.getitemstring(fl_row,'tmp_id')
		ls_inv1 = dw_2.getitemstring(fl_row,'dtp_lotno')
		ld_wt = dw_2.getitemnumber(fl_row,'ntot')
		if trim(ls_grade1) = trim(fs_grade) and ls_inv1 = fs_inv then
			ld_gtotal = ld_gtotal + ld_wt
		end if
	next 
end if 

return ld_gtotal
end function

public function integer wf_gradetotal_fw (string fs_grade);long fl_row
string ls_grade1
double ld_wt, ld_gtotal
dw_2.SelectRow(0, FALSE)
if dw_2.rowcount() > 0 then
	for fl_row = 1 to dw_2.rowcount()
		ls_grade1 = dw_2.getitemstring(fl_row,'tmp_id')
		ld_wt = dw_2.getitemnumber(fl_row,'ntot')
		if trim(ls_grade1) = trim(fs_grade)  then
			ld_gtotal = ld_gtotal + ld_wt
		end if
	next 
end if 

return ld_gtotal
end function

public function integer wf_calnet_amt ();ld_netamt = dw_2.getitemnumber(1,'tot_gamt')
ld_tcgst = dw_2.getitemnumber(1,'tcgst')
ld_tsgst = dw_2.getitemnumber(1,'tsgst')
ld_tigst = dw_2.getitemnumber(1,'tigst')

if isnull(ld_netamt) then ld_netamt = 0;
if isnull(ld_tcgst) then ld_tcgst = 0;
if isnull(ld_tsgst) then ld_tsgst = 0;
if isnull(ld_tigst) then ld_tigst = 0;

if ls_tcs_ind = 'Y' then
	if dw_1.getitemstring(dw_1.getrow(),'si_type') = 'TRANSPRI' and ld_tcs_rate > 0 then
		//dw_1.setitem(dw_1.getrow(),'si_tcs_per',ld_tcs_rate)
		if ls_inc_gst = 'N' then
			dw_1.setitem(dw_1.getrow(),'si_tcs_amt', (ld_netamt *(ld_tcs_rate/100)))
		elseif ls_inc_gst = 'Y' then
			dw_1.setitem(dw_1.getrow(),'si_tcs_amt', ((ld_netamt + ld_tcgst + ld_tsgst + ld_tigst ) *(ld_tcs_rate/100)))
		end if
	end if
else
	select nvl(TL_SALE_AMT,0) into :ld_totfy_sale from fb_tcs_limit_log where TL_DATE = (select max(TL_DATE) from fb_tcs_limit_log where TL_CUS_CD = :ls_cust) and TL_CUS_CD = :ls_cust;
		
	if ld_totfy_sale + ld_netamt > 5000000 then 
	
		ld_netamt = (ld_totfy_sale + ld_netamt - 5000000)
	
		if dw_1.getitemstring(dw_1.getrow(),'si_type') = 'TRANSPRI' and ld_tcs_rate > 0 then
			//dw_1.setitem(dw_1.getrow(),'si_tcs_per',ld_tcs_rate)
			if ls_inc_gst = 'N' then
				dw_1.setitem(dw_1.getrow(),'si_tcs_amt', (ld_netamt *(ld_tcs_rate/100)))
			elseif ls_inc_gst = 'Y' then
				dw_1.setitem(dw_1.getrow(),'si_tcs_amt', ((ld_netamt + ld_tcgst + ld_tsgst + ld_tigst ) *(ld_tcs_rate/100)))
			end if
		end if	
	else
		dw_1.setitem(dw_1.getrow(),'si_tcs_per', 0)
		dw_1.setitem(dw_1.getrow(),'si_tcs_amt', 0)
	end if
end if

//dw_1.setitem(dw_1.getrow(),'dsp_totinvamt',ld_netamt)

//dw_1.setitem(dw_1.getrow(),'si_tcs_amt',ld_netamt * )
// 
//dw_1.setitem(dw_1.getrow(),'dsp_totsaleamt',(ld_netamt + ld_tcgst + ld_tsgst + ld_tigst + ld_ttcs))	

	
return 1
end function

on w_gtedsf007.create
this.cb_11=create cb_11
this.cb_10=create cb_10
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_7=create cb_7
this.cb_8=create cb_8
this.cb_9=create cb_9
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.cb_11,&
this.cb_10,&
this.cb_6,&
this.cb_5,&
this.cb_7,&
this.cb_8,&
this.cb_9,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.dw_2}
end on

on w_gtedsf007.destroy
destroy(this.cb_11)
destroy(this.cb_10)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_7)
destroy(this.cb_8)
destroy(this.cb_9)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
lb_query = false	
lb_neworder = false
//dw_1.modify("t_co.text = '"+gs_co_name+"'")
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if

this.tag = Message.StringParm
ll_user_level = long(this.tag)

dw_2.GetChild ("dtp_lotno", idw_invno)
idw_invno.settransobject(sqlca)	


if long(string(today(),'MM')) > 3 then
	ls_dt1 = '01/04/'+string(today(),'YYYY')
else
	ls_dt1 = '01/04/'+string(long(string(today(),'YYYY')) - 1)
end if

declare p1 procedure for up_tcs_upd(:ls_dt1);

if sqlca.sqlcode = -1 then
	 messagebox('SQL Error: During Procedure Declare',sqlca.sqlerrtext)
	 return 1
end if

execute p1;

if sqlca.sqlcode = -1 then
	 messagebox('SQL Error: During Procedure Execute',sqlca.sqlerrtext)
	 return 1
end if
end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if
IF KeyDown(KeyF1!) THEN
	cb_1.triggerevent(clicked!)
end if
IF KeyDown(KeyF2!) THEN
	cb_2.triggerevent(clicked!)
end if
IF KeyDown(KeyF3!) THEN
	if dw_1.rowcount() > 0  then
		cb_3.triggerevent(clicked!)
	end if
end if
end event

type cb_11 from commandbutton within w_gtedsf007
integer x = 3045
integer y = 12
integer width = 347
integer height = 100
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Credit Note"
end type

event clicked;opensheetwithparm(w_gtedsf018,this.tag,w_mdi,0,layered!)
end event

type cb_10 from commandbutton within w_gtedsf007
integer x = 1445
integer y = 12
integer width = 457
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Delivery Challan"
end type

event clicked;opensheetwithparm(w_gtedsr003d,this.tag,w_mdi,0,layered!)
end event

type cb_6 from commandbutton within w_gtedsf007
integer x = 1097
integer y = 12
integer width = 343
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Tax Invoice"
end type

event clicked;opensheetwithparm(w_gtedsr003g,this.tag,w_mdi,0,layered!)
end event

type cb_5 from commandbutton within w_gtedsf007
integer x = 4073
integer y = 24
integer width = 123
integer height = 88
integer taborder = 90
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "<<"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrolltoRow(1)
end if
end event

type cb_7 from commandbutton within w_gtedsf007
integer x = 4192
integer y = 24
integer width = 123
integer height = 88
integer taborder = 100
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "<"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrollPriorRow()
end if
end event

type cb_8 from commandbutton within w_gtedsf007
integer x = 4311
integer y = 24
integer width = 123
integer height = 88
integer taborder = 110
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = ">"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrollnextRow()
end if
end event

type cb_9 from commandbutton within w_gtedsf007
integer x = 4430
integer y = 24
integer width = 123
integer height = 88
integer taborder = 120
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = ">>"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrolltoRow(dw_1.rowcount())
end if
end event

type cb_4 from commandbutton within w_gtedsf007
integer x = 809
integer y = 12
integer width = 265
integer height = 100
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;if dw_1.modifiedcount() > 0 or dw_1.deletedcount() > 0 then
	IF MessageBox("Exit Alert", 'Do You Want To Exit....?' ,Exclamation!, YesNo!, 1) = 1 THEN
		close(parent)
	else
		return
	end if
else
	close(parent)
end if
end event

type cb_3 from commandbutton within w_gtedsf007
integer x = 544
integer y = 12
integer width = 265
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 
if dw_2.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

ll_dlcno = 0;
ll_gpno = 0;
ll_tino = 0;
if dw_2.rowcount() > 1 then
	if (isnull(dw_2.getitemstring(dw_2.rowcount(),'dtp_lotno')) or len(dw_2.getitemstring(dw_2.rowcount(),'dtp_lotno')) = 0) then 
		dw_2.deleterow(dw_2.rowcount())
	end if;
end if

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	for ix = dw_2.rowcount() to 1 step -1
		if dw_2.getitemstring(ix,'del_flag') = 'Y' and dw_2.rowcount() = dw_2.getitemnumber(ix,'sel_row') then
			messagebox('Warning!','You Cannot Delete All Records From Detail Section !!!')
			return 1
		elseif dw_2.getitemstring(ix,'del_flag') = 'Y' and dw_2.rowcount() <> dw_2.getitemnumber(ix,'sel_row') then
			ls_adv = dw_1.getitemstring(dw_1.getrow(),'advice_id')
			ls_tmp_id = dw_2.getitemstring(ix,'tmp_id')
			ls_pinv = dw_2.getitemstring(ix,'dtp_lotno')
			ld_tnwt = dw_2.getitemnumber(ix,'ntot')
			// to be check
			select nvl(sa_type,'FWD') into :ls_type from fb_advice where advice_id = :ls_adv;
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Advice Quantity',sqlca.sqlerrtext)
				return 1
			end if
			if ls_type = 'FWD' then
				if wf_gradetotal_fw(ls_tmp_id) > (ld_advqty + ld_toll) then
					messagebox('Warning!','Packing Invoice Quantity ('+string(wf_gradetotal_fw(ls_tmp_id))+') is > Advice Quantity + Tollerance ('+string(ld_advqty + ld_toll)+'), Please Check !!!')
					return 1
				elseif wf_gradetotal_fw(ls_tmp_id) < (ld_advqty - ld_toll) then
					messagebox('Warning!','Packing Invoice Quantity ('+string(wf_gradetotal_fw(ls_tmp_id))+') is < Advice Quantity - Tollerance ('+string(ld_advqty - ld_toll)+'), Please Check !!!')
					return 1
				end if		
				Select distinct 'x' into :ls_temp from fb_advicedetails where advice_id = :ls_adv and tmp_id = :ls_tmp_id and (nvl(ADVICE_ORDQUANTITY,0) - nvl(ADVICE_DELIQUANTITY,0)) >= 0;
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Advice Detail',sqlca.sqlerrtext)
					return 1
				elseif sqlca.sqlcode = 0 then	
					update fb_advicedetails set ADVICE_DELIQUANTITY = (nvl(ADVICE_DELIQUANTITY,0) - nvl(:ld_tnwt,0))
					where advice_id = :ls_adv and tmp_id = :ls_tmp_id and (nvl(ADVICE_ORDQUANTITY,0) - nvl(ADVICE_DELIQUANTITY,0)) > 0;
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Updating Delivery Quantity (Delete)',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if		
				end if		
			else
				if wf_gradetotal(ls_tmp_id,ls_pinv) > (ld_advqty + ld_toll) then
					messagebox('Warning!','Packing Invoice Quantity ('+string(wf_gradetotal(ls_tmp_id,ls_pinv))+') is > Advice Quantity + Tollerance ('+string(ld_advqty + ld_toll)+'), Please Check !!!')
					return 1
				elseif wf_gradetotal(ls_tmp_id,ls_pinv) < (ld_advqty - ld_toll) then
					messagebox('Warning!','Packing Invoice Quantity ('+string(wf_gradetotal(ls_tmp_id,ls_pinv))+') is < Advice Quantity - Tollerance ('+string(ld_advqty - ld_toll)+'), Please Check !!!')
					return 1
				end if
				
				Select distinct 'x' into :ls_temp from fb_advicedetails where advice_id = :ls_adv and tmp_id = :ls_tmp_id and SAD_INVNO = :ls_pinv and (nvl(ADVICE_ORDQUANTITY,0) - nvl(ADVICE_DELIQUANTITY,0)) >= 0;
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Advice Detail',sqlca.sqlerrtext)
					return 1
				elseif sqlca.sqlcode = 0 then	
					update fb_advicedetails set ADVICE_DELIQUANTITY = (nvl(ADVICE_DELIQUANTITY,0) - nvl(:ld_tnwt,0))
					where advice_id = :ls_adv and tmp_id = :ls_tmp_id and SAD_INVNO = :ls_pinv and (nvl(ADVICE_ORDQUANTITY,0) - nvl(ADVICE_DELIQUANTITY,0)) > 0;
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Updating Delivery Quantity (Delete)',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if		
				end if		
			end if
			// to be check
			dw_2.deleterow(ix)
		end if
	next	
	
	if dw_2.rowcount() = 0 then
		messagebox('Error','Records Should Be Available In Detail Block')
		return
	end if

	if ((dw_1.getitemstring(dw_1.getrow(),'si_type') = 'PRICONS' and (isnull(dw_1.getitemstring(dw_1.getrow(),'advice_id')) or len(dw_1.getitemstring(dw_1.getrow(),'advice_id')) = 0)) or &
		isnull(dw_1.getitemstring(dw_1.getrow(),'transp_id')) or len(dw_1.getitemstring(dw_1.getrow(),'transp_id')) = 0 or &
		isnull(dw_1.getitemstring(dw_1.getrow(),'si_cn')) or len(dw_1.getitemstring(dw_1.getrow(),'si_cn')) = 0 or &
		isnull(dw_1.getitemdatetime(dw_1.getrow(),'si_cndate'))) then
		messagebox('Warning:','One Of The Fields Are Blank : Advice ID, Transporter ID, Consignment No, Date !!!')
		dw_1.setfocus()
		dw_1.setcolumn('si_date')
		return
	elseif ((dw_1.getitemstring(dw_1.getrow(),'si_type') = 'AUCTION') and &
			((isnull(dw_1.getitemstring(dw_1.getrow(),'brok_id')) or len(dw_1.getitemstring(dw_1.getrow(),'brok_id')) = 0) or &
			(isnull(dw_1.getitemstring(dw_1.getrow(),'ware_id')) or len(dw_1.getitemstring(dw_1.getrow(),'ware_id')) = 0)))  then
			messagebox('Warning:','One Of The Fields Are Blank : Broker Id, Ware House ID (Incase Of Auction) !!!')
			dw_1.setfocus()
			dw_1.setcolumn('si_date')
			return
	elseif ((dw_1.getitemstring(dw_1.getrow(),'si_type') = 'EXP' or dw_1.getitemstring(dw_1.getrow(),'si_type') = 'SEZ') and &
			((isnull(dw_1.getitemstring(dw_1.getrow(),'si_lut_no')) or len(dw_1.getitemstring(dw_1.getrow(),'si_lut_no')) = 0)))  then
			messagebox('Warning:','One Of The Fields Are Blank : LUT No (Incase Of Export / SEZ Sale) !!!')
			dw_1.setfocus()
			dw_1.setcolumn('si_date')
			return	
	end if
	//ld_invdt = dw_1.getitemdatetime(dw_1.getrow(),'si_date')
	//if f_check_fin_yr(dw_1.getitemdatetime(dw_1.getrow(),'si_date')) = -1 then return 1
	
	ld_invdt = dw_1.getitemdatetime(dw_1.getrow(),'si_date')
	
	if long(string(today(),'mm')) < 4 then
		ll_st_year  = ((long(string(today(),'YYYY'))-1)*100)+4;
		ll_end_year = (long(string(today(),'YYYY'))*100)+3;
	else
		ll_st_year  = (long(string(today(),'YYYY'))*100)+4;
		ll_end_year = ((long(string(today(),'YYYY'))+1)*100)+3;
	end if;
//	if (long(string(ld_invdt,'yyyymm')) < ll_st_year or long(string(ld_invdt,'yyyymm')) > ll_end_year) then
//		messagebox('Warning!','Invoice Date Should Be Between Current Financial Year, Please Check !!!')
//		return 1
//	end if
	ls_adv = dw_1.getitemstring(dw_1.getrow(),'advice_id')
	ls_waybill = dw_1.getitemstring(dw_1.getrow(),'si_waybillno')
	ld_invdt = dw_1.getitemdatetime(dw_1.getrow(),'si_date')
	ls_cnno = dw_1.getitemstring(dw_1.getrow(),'si_cn')
	
	
	 select distinct SI_ID into :ls_temp from fb_saleinvoice where si_date between to_date('01/01/'||to_char(:ld_invdt,'YYYY'),'dd/mm/yyyy') and to_date('31/12/'||to_char(:ld_invdt,'YYYY'),'dd/mm/yyyy') and si_cn = :ls_cnno;
         if sqlca.sqlcode = -1 then
                  messagebox('Error : While Checking Duplicate CN NO.',sqlca.sqlerrtext)
                  rollback using sqlca;
                  return 1
         elseif sqlca.sqlcode = 0 then
                  messagebox('Warning !!!','Duplicate CN No Exists In Sale ID '+ls_temp)
                  rollback using sqlca;
                  return 1
         end if     
	
//	if not isnull(ll_waybill) or ll_waybill > 0 then
//		update fb_waybilldetail set WBD_CNNO = :ls_cnno, WBD_DATE = trunc(:ld_invdt)	where WBD_WAYBILLNO = :ll_waybill;
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Updating Way Bill No.',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		end if						
//	end if
	
	if dw_2.rowcount() > 0 then
		for ll_ctr = 1 to dw_2.rowcount( ) 
			IF wf_check_fillcol(ll_ctr) = -1 THEN 
				return 1
			end if
			ls_adv = dw_1.getitemstring(dw_1.getrow(),'advice_id')
			ls_tmp_id = dw_2.getitemstring(ll_ctr,'tmp_id')
			ld_tnwt = dw_2.getitemnumber(ll_ctr,'ntot')
			ls_lotno =  dw_2.getitemstring(ll_ctr,'dtp_lotno')
			ls_pinv = dw_2.getitemstring(ll_ctr,'dtp_lotno')
			ls_dtpd_id=dw_2.getitemstring(ll_ctr,'dtpd_id')
			
			select nvl(sa_type,'FWD') into :ls_type from fb_advice where advice_id = :ls_adv;
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Advice Quantity',sqlca.sqlerrtext)
				return 1
			end if
			if ls_type = 'FWD' then			
				Select distinct 'x' into :ls_temp from fb_advicedetails where advice_id = :ls_adv and tmp_id = :ls_tmp_id and (nvl(ADVICE_ORDQUANTITY,0) - nvl(ADVICE_DELIQUANTITY,0)) > 0;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Advice Detail',sqlca.sqlerrtext)
					return 1
				elseif sqlca.sqlcode = 0 then	
					update fb_advicedetails set ADVICE_DELIQUANTITY = (nvl(ADVICE_DELIQUANTITY,0) + nvl(:ld_tnwt,0))
					where advice_id = :ls_adv and tmp_id = :ls_tmp_id and (nvl(ADVICE_ORDQUANTITY,0) - nvl(ADVICE_DELIQUANTITY,0)) > 0;
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Updating Delivery Quantity',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if		
				end if			
			else
				Select distinct 'x' into :ls_temp from fb_advicedetails where advice_id = :ls_adv and tmp_id = :ls_tmp_id and SAD_INVNO = :ls_pinv and (nvl(ADVICE_ORDQUANTITY,0) - nvl(ADVICE_DELIQUANTITY,0)) > 0;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Advice Detail',sqlca.sqlerrtext)
					return 1
				elseif sqlca.sqlcode = 0 then	
					update fb_advicedetails set ADVICE_DELIQUANTITY = (nvl(ADVICE_DELIQUANTITY,0) + nvl(:ld_tnwt,0))
					where advice_id = :ls_adv and tmp_id = :ls_tmp_id and SAD_INVNO = :ls_pinv and (nvl(ADVICE_ORDQUANTITY,0) - nvl(ADVICE_DELIQUANTITY,0)) > 0;
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Updating Delivery Quantity',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if		
				end if							
			end if
			
			setnull(ls_temp)
			select distinct 'x' into :ls_temp from fb_dailyteapacked where dtp_id in (select dtp_Id from fb_dtpdetails where trim(dtpd_id)=:ls_dtpd_id) and nvl(dtp_dispind,'N') = 'N';
			if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Dispatch Indicator',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
			elseif sqlca.sqlcode = 0 then
				update fb_dailyteapacked set dtp_dispind = 'Y'	where trim(dtp_lotno) = :ls_lotno ;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Updating Packing Dispatch NEW Indicator',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			elseif sqlca.sqlcode = 100 then
				update fb_dailyteapacked_new set dtp_dispind = 'Y'	where trim(dtp_lotno) = :ls_lotno ;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Updating Packing Dispatch Indicator',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			end if		
				
		next	
	end if
				

	if dw_1.getitemstatus(dw_1.getrow(),0,primary!) = NewModified! or dw_1.getitemstatus(dw_1.getrow(),0,primary!) = New! then
		if ll_gpno = 0 then
			
			if long(string(ld_invdt,'mm')) < 4 then
				ll_ac_year = long(string(ld_invdt,'YYYY'))-1
			else
				ll_ac_year = long(string(ld_invdt,'YYYY'))
			end if;
			
			ll_gpno = f_get_lastno('GP',string(ll_ac_year));

			dw_1.setitem(dw_1.getrow(),'si_centralexciseno',string(ll_gpno))
			if ll_gpno = -1 then 
				rollback using sqlca;
				return 1;
			end if;	
		else
			ll_gpno = ll_gpno + 1
			dw_1.setitem(dw_1.getrow(),'si_centralexciseno',string(ll_gpno))
		end if
		
		if isnull(ls_iss_gstn) then ls_iss_gstn = 'X';
		if isnull(ls_rec_gstn) then ls_rec_gstn = 'X';
		
//======
		if ls_iss_gstn <> ls_rec_gstn then		
			if ll_tino = 0 then
				ll_fymm  =  long(string(dw_1.getitemdatetime(dw_1.getrow(),'si_date'),'yyyymm'))
				
				select distinct 'x' into :ls_temp from FB_SERIAL_NO where SN_DOC_TYPE in ('TI') and SN_ACCT_YEAR=to_char(to_date(:ll_fymm,'yyyymm'),'yyyymm');
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'TI', 0, to_char(to_date(:ll_fymm,'yyyymm'),'yyyymm')); 
					commit using sqlca;
				end if
					
				ll_tino = f_get_lastno('TI',string(ll_fymm))
				
				if ll_tino < 0 then
					messagebox('Error At Last No Getting',sqlca.sqlerrtext)
					return 1
				end if
			else
				ll_tino = ll_tino + 1
			end if
	
			if ll_tino >= 0 then
				ls_count = string(ll_tino,'000')
				ls_tinvno =gs_garden_snm+"/TI/"+string(ll_fymm)+"-"+ls_count					
				dw_1.setitem(dw_1.getrow(),'SI_TAXINVNO',ls_tinvno)	
			end if 
			
			if not isnull(ls_rec_gstn) and len(ls_rec_gstn) > 0 then
				declare p2 procedure for up_post_e_invoicing ('PSINV',:ls_tinvno, 'GTEDSF007');
			
				if sqlca.sqlcode = -1 then
					 messagebox('SQL Error: During Procedure Declare',sqlca.sqlerrtext)
					 return 1
				end if
				
				execute p2;
				
				if sqlca.sqlcode = -1 then
					 messagebox('SQL Error: During Procedure Execute',sqlca.sqlerrtext)
					 return 1
				end if	
			end if
			
//		end if
		elseif ls_iss_gstn = ls_rec_gstn then		
			if ll_dlcno = 0 then
				ll_fymm  =  long(string(dw_1.getitemdatetime(dw_1.getrow(),'si_date'),'yyyymm'))
				
				select distinct 'x' into :ls_temp from FB_SERIAL_NO where SN_DOC_TYPE in ('DC') and SN_ACCT_YEAR=to_char(to_date(:ll_fymm,'yyyymm'),'yyyymm');
				if sqlca.sqlcode = 100 then
					INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'DC', 0, to_char(to_date(:ll_fymm,'yyyymm'),'yyyymm')); 
					commit using sqlca;
				end if
					
				ll_dlcno = f_get_lastno('DC',string(ll_fymm))
				
				if ll_dlcno < 0 then
					messagebox('Error At Last No Getting',sqlca.sqlerrtext)
					return 1
				end if
			else
				ll_dlcno = ll_dlcno + 1
			end if
	
			if ll_dlcno >= 0 then
				ls_count1 = string(ll_dlcno,'000')
				ls_dlcno =gs_garden_snm+"/DC/"+string(ll_fymm)+"-"+ls_count1					
				dw_1.setitem(dw_1.getrow(),'si_delvchno',ls_dlcno)	
			end if 
			
		end if
//                 messagebox('Information;',' Voucher No Created :'+ls_tmp_id)
//======
		
		if ll_last=0 then
			select nvl(MAX(substr(SI_ID,3,10)),0) into :ll_last from fb_saleinvoice;
		end if
		ll_last = ll_last + 1
		ls_tmp_id = 'SI'+string(ll_last,'0000000000')
		dw_1.setitem(dw_1.getrow(),'si_id',ls_tmp_id)
		for ix = 1 to dw_2.rowcount()
			dw_2.setitem(ix,'si_id',ls_tmp_id)
		next
	end if		
	
	if dw_1.update(true,false) = 1 and dw_2.update(true,false) = 1 then
		if dw_1.getitemstatus(dw_1.getrow(),0,primary!) = NewModified! or dw_1.getitemstatus(dw_1.getrow(),0,primary!) = New! then
			if f_upd_lastno('GP',string(ll_ac_year),ll_gpno) = -1 then 
				rollback using sqlca;
				return 1
			end if;	
			
			if ll_tino > 0 then
				///update last no
				if ls_iss_gstn <> ls_rec_gstn then	
					if f_upd_lastno('TI',string(ll_fymm),ll_tino) = -1 then
						rollback using sqlca;			
						return 1
					end if	
				end if
			end if
			if ll_dlcno > 0 then
				 if ls_iss_gstn = ls_rec_gstn then	
					if f_upd_lastno('DC',string(ll_fymm),ll_dlcno) = -1 then
						rollback using sqlca;			
						return 1
					end if		
				end if
			end if
		end if
		dw_2.resetupdate();
		dw_1.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
		cb_1.enabled = true
		dw_1.reset()
		dw_2.reset()
		idw_invno.settransobject(sqlca)
		idw_invno.retrieve( )
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
else
	return
end if 
end event

type cb_2 from commandbutton within w_gtedsf007
integer x = 279
integer y = 12
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Query"
end type

event clicked;if cb_2.text = "&Query" then
	if dw_1.modifiedcount() > 0 or dw_2.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	lb_query = true
	lb_neworder = true
	dw_1.reset()
	dw_2.reset()
   	cb_3.enabled = false
  	cb_5.enabled = false
	cb_7.enabled = false
	cb_8.enabled = false
	cb_9.enabled = false
	cb_1.enabled = false
	dw_1.settaborder('si_id',5)
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('si_id')
	cb_2.text = "&Run"
	cb_3.enabled = false
else
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user,gs_garden_snm)
 	dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
	dw_1.settaborder('si_id',0)
	dw_1.settaborder('cus_id',0)
	cb_2.text = "&Query"
   	cb_5.enabled = true
   	cb_7.enabled = true
   	cb_8.enabled = true
   	cb_9.enabled = true
	cb_1.enabled = true
end if
lb_neworder = false

end event

type cb_1 from commandbutton within w_gtedsf007
integer x = 14
integer y = 12
integer width = 265
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&New"
end type

event clicked;if lb_neworder = false then
	if dw_1.modifiedcount() > 0 then
		if messagebox("Confirmation","Row has been modified, Do You Want To Add New Record ...!",question!,yesno!,1) = 2 then
			return
		end if
	end if
	dw_1.reset()
	dw_2.reset()
end if

dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

//select max(to_number(si_centralexciseno)) into :ls_temp  from fb_saleinvoice where 
//decode(sign(to_number(to_char(si_date,'MM')) - 4),-1,to_number(to_char(si_date,'YYYY')) - 1,to_number(to_char(si_date,'YYYY'))) = decode(sign(to_number(to_char(sysdate,'MM')) - 4),-1,to_number(to_char(sysdate,'YYYY')) - 1,to_number(to_char(sysdate,'YYYY')));
//
//if sqlca.sqlcode = -1 then
//	messagebox('Error : While Getting Max Gate Pass No ',sqlca.sqlerrtext)
//	rollback using sqlca;
//	return 1
//elseif sqlca.sqlcode  = 0 then
//	messagebox('Information !','Last Gate Pass No Generated Is : ('+ls_temp+')')
//end if	


//select max(decode(PD_DOC_TYPE,'EXCISE-HC',nvl(PD_VALUE,0),0)) hescess,
//	   max(decode(PD_DOC_TYPE,'EXCISE-CS',nvl(PD_VALUE,0),0)) cess,
//	   max(decode(PD_DOC_TYPE,'EXCISE-EC',nvl(PD_VALUE,0),0)) educess,
//	   max(decode(PD_DOC_TYPE,'EXCISE',nvl(PD_VALUE,0),0)) addex
//into :ld_hesc,:ld_cess,:ld_edcess,:ld_adex
//from fb_param_detail where PD_PERIOD_TO is null;
//

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'si_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'si_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'si_date',datetime(today()))
//	dw_1.setitem(dw_1.getrow(),'si_exciseduty',ld_adex)
//	dw_1.setitem(dw_1.getrow(),'si_cess',ld_cess)
//	dw_1.setitem(dw_1.getrow(),'si_educationalcess',ld_edcess)
//	dw_1.setitem(dw_1.getrow(),'si_hsecess',ld_hesc)
	dw_1.setitem(dw_1.getrow(),'ra_gsn',gs_garden_snm)
	dw_1.setitem(dw_1.getrow(),'si_iss_locn',gs_gstn_stcd)
	dw_1.setitem(dw_1.getrow(),'si_iss_gstnno',gs_gstnno)
	dw_1.settaborder('cus_id',60)
	dw_1.setcolumn('si_type')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'si_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'si_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'si_date',datetime(today()))
//	dw_1.setitem(dw_1.getrow(),'si_exciseduty',ld_adex)
//	dw_1.setitem(dw_1.getrow(),'si_cess',ld_cess)
//	dw_1.setitem(dw_1.getrow(),'si_educationalcess',ld_edcess)
//	dw_1.setitem(dw_1.getrow(),'si_hsecess',ld_hesc)
	dw_1.setitem(dw_1.getrow(),'ra_gsn',gs_garden_snm)
	dw_1.setitem(dw_1.getrow(),'si_iss_locn',gs_gstn_stcd)
	dw_1.setitem(dw_1.getrow(),'si_iss_gstnno',gs_gstnno)
	dw_1.setcolumn('si_type')
end if
cb_1.enabled = false

end event

type dw_1 from datawindow within w_gtedsf007
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 9
integer y = 116
integer width = 4539
integer height = 1084
integer taborder = 30
string dataobject = "dw_gtedsf007"
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'si_entry_by',gs_user)
		dw_1.setitem(newrow,'si_entry_dt',datetime(today()))
		dw_1.setcolumn('si_type')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if lb_query = false then
	if dwo.name = 'si_type' then
		setnull(ls_temp)
		if data <> 'TRANSPRI' and data <> 'TRANSFREE' then
			messagebox('Warning', 'Kindly select either Private or Free sale type')
			return 1
		end if
		
		if data = 'AUCTION' then 
			dw_1.setitem(row,'advice_id',ls_temp)
//			idw_invno.SetFilter ("upper(sp_name) like '%BROWN%'") 
//			idw_invno.filter( )
		elseif data = 'PRICONS' then 
			dw_1.setitem(row,'brok_id',ls_temp)
			dw_1.setitem(row,'ware_id',ls_temp)
//			idw_invno.SetFilter ("upper(sp_name) like '%WHITE%'") 
//			idw_invno.filter( )			
		elseif data = 'EXP' or data = 'SEZ' then 
			select distinct unit_lut_no into :ls_lutno from fb_gardenmaster where nvl(unit_active_ind,'N') = 'Y';
			dw_1.setitem(row,'ware_id',ls_temp)
			dw_1.setitem(row,'si_lut_no',ls_lutno)
//			idw_invno.SetFilter("") 
//			idw_invno.filter( )	
		else
			dw_1.setitem(row,'ware_id',ls_temp)
//			idw_invno.SetFilter("") 
//			idw_invno.filter( )	
		end if
	end if
	
	if dwo.name = 'si_date'  then
		ld_invdt = datetime(data)
		if date(ld_invdt) > today() then
			messagebox('Warning!','Invoice Date Should Not Be > Current date, Please Check !!!')
			return 1
		end if
		
		if long(string(today(),'mm')) < 4 then
			ll_st_year  = ((long(string(today(),'YYYY'))-1)*100)+4;
			ll_end_year = (long(string(today(),'YYYY'))*100)+3;
		else
			ll_st_year  = (long(string(today(),'YYYY'))*100)+4;
			ll_end_year = ((long(string(today(),'YYYY'))+1)*100)+3;
		end if;
//		if (long(string(ld_invdt,'yyyymm')) < ll_st_year or long(string(ld_invdt,'yyyymm')) > ll_end_year) then
//			messagebox('Warning!','Invoice Date Should Be Between Current Financial Year, Please Check !!!')
//			return 1
//		end if
	else 
		ld_invdt = dw_1.getitemdatetime(row,'si_date')
	end if
	
	if dwo.name = 'cus_id'  then
		ls_cust = trim(data)
		
		select CUS_GSTN_STCD, nvl(CUS_TCS_IND,'N'), CUS_PANNO, cus_gstnno  into :ls_rec_locn, :ls_tcs_ind, :ls_pan, :ls_rec_gstn from fb_customer  where CUS_ID = :ls_cust;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error During Select Of Customer Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 100 then
			messagebox('Warning!','Customer Not In Master, Please Check !!!')
			rollback using sqlca;
			return 1
		end if	
		
		//if ls_tcs_ind = 'Y' then
			ld_bill_dt = dw_1.getitemdatetime(row,'si_date')
			if isnull(ls_pan) or len(ls_pan) = 0 then
				select tm_tcs_wtopan, nvl(tm_inc_gst,'N') into :ld_tcs_rate, :ls_inc_gst from fb_tcsparam_mast where tm_co_cd = :gs_co_id and tm_effective_date = (select max(tm_effective_date) from fb_tcsparam_mast 
				where tm_co_cd = :gs_co_id and tm_effective_date <= trunc(:ld_bill_dt))  and tm_py_turnover = 100000000;
			else
				select tm_tcs_wtpan, nvl(tm_inc_gst,'N') into :ld_tcs_rate, :ls_inc_gst from fb_tcsparam_mast where tm_co_cd = :gs_co_id and tm_effective_date = (select max(tm_effective_date) from fb_tcsparam_mast 
				where tm_co_cd = :gs_co_id and tm_effective_date <= trunc(:ld_bill_dt)) and tm_py_turnover = 100000000;		
			end if
//		elseif ls_tcs_ind = 'N' then
			
	//	end if
		
		if isnull(ld_tcs_rate) then ld_tcs_rate = 0;
		if isnull(ls_inc_gst) then ls_inc_gst = 'N';
		
		dw_1.setitem(row,'si_rec_locn',ls_rec_locn)	
		dw_1.setitem(row,'si_rec_gstnno',ls_rec_gstn)
		dw_1.setitem(row,'si_tcs_per',ld_tcs_rate)	
		
		ls_iss_locn = dw_1.getitemstring(row,'si_iss_locn')
		ls_rec_locn = dw_1.getitemstring(row,'si_rec_locn')	
		
//		if isnull(ls_rec_locn) or len(ls_rec_locn) = 0 then
//			messagebox('Warning!','Customer GSTN State Is Blank, Please Update Now !!!')
//			rollback using sqlca;
//			return 1
//		end if
	end if
	
//	if dwo.name = 'brok_id'  then
//		ls_brok = trim(data)
//		
//		select brok_GSTN_STCD  into :ls_rec_locn from fb_broker  where brok_ID = :ls_brok;
//		
//		if sqlca.sqlcode = -1 then
//			messagebox('Error During Select Of Broker Details',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 100 then
//			messagebox('Warning!','Broker Not In Master, Please Check !!!')
//			rollback using sqlca;
//			return 1
//		end if	
//		dw_1.setitem(row,'si_rec_locn',ls_rec_locn)	
//		ls_iss_locn = dw_1.getitemstring(row,'si_iss_locn')
//		ls_rec_locn = dw_1.getitemstring(row,'si_rec_locn')	
////		if isnull(ls_rec_locn) or len(ls_rec_locn) = 0 then
////			messagebox('Warning!','Customer GSTN State Is Blank, Please Update Now !!!')
////			rollback using sqlca;
////			return 1
////		end if
//	end if	

	if dwo.name = 'ware_id'  then
		ls_wareid = trim(data)
		
		select ware_GSTN_STCD, ware_gstnno  into :ls_rec_locn, :ls_rec_gstn from fb_warehouse  where ware_ID = :ls_wareid;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error During Select Of Ware Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 100 then
			messagebox('Warning!','Ware Not In Master, Please Check !!!')
			rollback using sqlca;
			return 1
		end if	
		dw_1.setitem(row,'si_rec_locn',ls_rec_locn)	
		dw_1.setitem(row,'si_rec_gstnno',ls_rec_gstn)				
		ls_iss_locn = dw_1.getitemstring(row,'si_iss_locn')
		ls_rec_locn = dw_1.getitemstring(row,'si_rec_locn')	
//		if isnull(ls_rec_locn) or len(ls_rec_locn) = 0 then
//			messagebox('Warning!','Customer GSTN State Is Blank, Please Update Now !!!')
//			rollback using sqlca;
//			return 1
//		end if
	end if	
	
//	if dwo.name = 'si_centralexciseno'  then
//		ls_gpno = trim(data)
//
//		select distinct 'x' into :ls_temp  from fb_saleinvoice where si_centralexciseno = :ls_gpno and 
//		decode(sign(to_number(to_char(si_date,'MM')) - 4),-1,to_number(to_char(si_date,'YYYY')) - 1,to_number(to_char(si_date,'YYYY'))) = decode(sign(to_number(to_char(:ld_invdt,'MM')) - 4),-1,to_number(to_char(:ld_invdt,'YYYY')) - 1,to_number(to_char(:ld_invdt,'YYYY')));
//		
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Gate Pass No. ',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 0 then	
//			messagebox('Warning!','Gate Pass No Already Exists, Please Check !!!')
//			select max(to_number(si_centralexciseno)) into :ls_temp  from fb_saleinvoice where 
//				decode(sign(to_number(to_char(si_date,'MM')) - 4),-1,to_number(to_char(si_date,'YYYY')) - 1,to_number(to_char(si_date,'YYYY'))) = decode(sign(to_number(to_char(sysdate,'MM')) - 4),-1,to_number(to_char(sysdate,'YYYY')) - 1,to_number(to_char(sysdate,'YYYY')));
//				
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Getting Max Gate Pass No ',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				elseif sqlca.sqlcode  = 0 then
//					messagebox('Information !','Last Gate Pass No Generated Is : ('+ls_temp+')')
//				end if	
//			rollback using sqlca;
//			return 1
//		end if		
//	end if
	
	if lb_neworder = true and dw_2.rowcount() = 0 then
		dw_2.setfocus() 
		dw_2.insertrow(0)
		dw_1.setfocus()
	end if;
	
	
	if dwo.name = 'advice_id'  then
		ls_adv = data
		
		select trim(ADVICE_TYPE), cust_id, broker_id into :ls_temp, :ls_cust, :ls_brok  from fb_advice where ADVICE_ID = :data;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Advice Type',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 0 then	
			dw_1.setitem(row,'si_type',ls_temp)
			dw_1.setitem(row,'cus_id',ls_cust)
			dw_1.setitem(row,'brok_id',ls_brok)
		elseif sqlca.sqlcode = 100 then
			messagebox('Warning!','Invalid Advice No., Please Check !!!')
			rollback using sqlca;
			return 1
		end if		
//			select tmp_id,dtpd_srnostart,dtpd_srnoend,(dtpd_srnoend-dtpd_srnostart+1),dtpd_indwt,dtpd_chestwt,(nvl(dtpd_indwt,0) - nvl(dtpd_chestwt,0)) ntwt,
//			(dtpd_srnoend-dtpd_srnostart+1)* dtpd_indwt gwt,
//			(dtpd_srnoend-dtpd_srnostart+1)* (nvl(dtpd_indwt,0) - nvl(dtpd_chestwt,0)) gwt,b.dtpd_id
	//	into :ls_tmp_id,:ll_stno,:lledno,:ll_nop,:ld_gwt,:ld_trwt,:ld_nwt,:ld_tgwt,:ld_tnwt,:ls_dtpdid
	//	from fb_dailyteapacked a,fb_dtpdetails b 
	//	where a.dtp_id= b.dtp_id and dtp_lotno = :ls_pinv;
//

		//-------
//		, (nvl(b.advice_ordquantity,0) - nvl(b.advice_deliquantity,0))  qnty
		declare c1 cursor for
		select distinct TMP_ID 
		from fb_advice a,fb_advicedetails b 
		where a.advice_id = b.advice_id and b.advice_deliquantity < b.advice_ordquantity and a.advice_active='1' and
				 a.advice_id = :ls_adv
		order by 1;
		
		open c1;
		setnull(ls_tmp_id);setnull(ls_gradelist);
		IF sqlca.sqlcode = 0 THEN 
			fetch c1 into :ls_tmp_id;
			
			do while sqlca.sqlcode <> 100
				if isnull(ls_gradelist) then
					ls_gradelist = "'"+ls_tmp_id+"'"
				else
					ls_gradelist = ls_gradelist + ','+"'"+ls_tmp_id+"'"
				end if
				fetch c1 into:ls_tmp_id;
			loop
			close c1;
		end if
		//---
		
		idw_invno.SetFilter ("tmp_id in ("+ls_gradelist+")") 
		idw_invno.filter( )
	end if
	
	if dwo.name = 'si_cndate'  then
		ld_invdt = dw_1.getitemdatetime(row,'si_date')
		ld_condt = datetime(data)
		if date(ld_condt) < date(ld_invdt) then
			messagebox('Warning!','Consignment Date Should Be >= Invoice Date, Please Check !!!')
			return 1
		end if
		
		if long(string(today(),'mm')) < 4 then
			ll_st_year  = ((long(string(today(),'YYYY'))-1)*100)+4;
			ll_end_year = (long(string(today(),'YYYY'))*100)+3;
		else
			ll_st_year  = (long(string(today(),'YYYY'))*100)+4;
			ll_end_year = ((long(string(today(),'YYYY'))+1)*100)+3;
		end if;
	
//		if (long(right(string(ld_condt,'dd/mm/yyyy'),4)) * 100 + long(mid(string(ld_condt,'dd/mm/yyyy'),4,2))) < ll_st_year or &
//			(long(right(string(ld_condt,'dd/mm/yyyy'),4)) * 100 + long(mid(string(ld_condt,'dd/mm/yyyy'),4,2)))  > ll_end_year then
//			messagebox('Warning!','Consignment Date Should Be Between Current Financial Year, Please Check !!!')
//			return 1
//		end if
		
	end if
	
	if dwo.name = 'si_cn'  then	
		if f_check_initial_space(data) = -1 then return 1
//		if f_check_string_sp(data) = -1 then return 1
	end if
	
	if dwo.name = 'si_ship_to_add' then
		dw_2.setfocus()
		dw_2.setcolumn('dtp_lotno')
	end if
	
	//
	
	if not isnull(dw_1.getitemstring(row,'si_taxinvno')) and dwo.name = 'si_einv_ind' and data = 'Y' then
		if MessageBox("Alert", 'Do You Want To Confirm For E-invoice ....?' ,Exclamation!, YesNo!, 1) = 1 then
			ls_tinvno = dw_1.getitemstring(row,'si_taxinvno')
			select distinct 'x' into :ls_temp from fb_einvoice where docno = :ls_tinvno;
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error: During checking existing records',sqlca.sqlerrtext)
				return 1
			elseif sqlca.sqlcode = 0 then
				messagebox('Warning','Record already exists for this taxinvoice in E-invoice data')
				return 1
			end if
			declare p2 procedure for up_post_e_invoicing ('PSINV',:ls_tinvno, 'GTEDSF007');
			
			if sqlca.sqlcode = -1 then
				 messagebox('SQL Error: During Procedure Declare',sqlca.sqlerrtext)
				 return 1
			end if
			
			execute p2;
			
			if sqlca.sqlcode = -1 then
				 messagebox('SQL Error: During Procedure Execute',sqlca.sqlerrtext)
				 return 1
			end if			
		else
			return 1
		end if
	end if
	
	dw_1.setitem(row,'si_entry_by',gs_user)
	dw_1.setitem(row,'si_entry_dt',datetime(today()))

	
	cb_3.enabled = true
end if
end event

event rowfocuschanged;if lb_query = false then
	if lb_neworder = false  then
		if dw_1.rowcount() > 0 then
			ls_ref = dw_1.getitemstring(dw_1.getrow(),'si_id')
			dw_2.reset()
			dw_2.retrieve(ls_ref)
		end if
	end if
end if
end event

type dw_2 from datawindow within w_gtedsf007
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 402
integer y = 1208
integer width = 3730
integer height = 1200
integer taborder = 40
string dataobject = "dw_gtedsf007a"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
//	if currentrow <> dw_2.rowcount() then
//		IF wf_check_fillcol(currentrow) = -1 THEN
//			return 1
//		END IF
//	END If
	if dw_2.rowcount() > 1 then
		dw_2.setitem(newrow,'si_id',dw_2.getitemstring(currentrow,'si_id'))
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;//if lb_neworder = true then
//	IF KeyDown(KeyF6!) THEN
//		dw_2.deleterow(dw_2.getrow())
//	end if
//	if dw_2.rowcount() = 0 then
//		cb_3.enabled = false
//	end if
//end if
//
end event

event ue_keydwn;//if lb_neworder = true then
//	IF KeyDown(KeyF6!) THEN
//		dw_2.deleterow(dw_2.getrow())
//	end if
//	if dw_2.rowcount() = 0 then
//		cb_3.enabled = false
//	end if
//end if
//
end event

event itemchanged;//if dwo.name = 'tpc_id' then
//	ls_tpc_id = data
//	
//	ix=idw_grade.SetFilter ("tpc_id = '"+ls_tpc_id+"'")
//	idw_grade.settransobject(sqlca)	
//	idw_grade.retrieve()		
//end if

if dwo.name = 'dtp_lotno' then
	ls_pinv = data
	ls_adv = dw_1.getitemstring(dw_1.getrow(),'advice_id')
	idw_invno.accepttext( )
	if  wf_check_duplicate_rec(ls_pinv) = -1 then return 1
	    ll_season = idw_invno.getitemnumber(idw_invno.getrow(),'dtp_season')
		ll_stno = idw_invno.getitemnumber(idw_invno.getrow(),'dtpd_srnostart')
		lledno = idw_invno.getitemnumber(idw_invno.getrow(),'dtpd_srnoend')
		ll_nop = (lledno - ll_stno) + 1
		ld_gwt = idw_invno.getitemnumber(idw_invno.getrow(),'gwt') 
		ld_trwt = idw_invno.getitemnumber(idw_invno.getrow(),'trwt') 
		ld_nwt = idw_invno.getitemnumber(idw_invno.getrow(),'ntwt')
		ld_tgwt = idw_invno.getitemnumber(idw_invno.getrow(),'tgwt')
		ld_tnwt = idw_invno.getitemnumber(idw_invno.getrow(),'tnwt')
		ls_dtpdid = idw_invno.getitemstring(idw_invno.getrow(),'dtpd_id')
		ls_tmp_id = idw_invno.getitemstring(idw_invno.getrow(),'tmp_id')
		
		dw_2.setitem(row,'sid_season',ll_season)
		dw_2.setitem(row,'tmp_id',ls_tmp_id)
		dw_2.setitem(row,'sid_srnostart',ll_stno)
		dw_2.setitem(row,'sid_srnoend',lledno)
		dw_2.setitem(row,'nop',ll_nop)
		dw_2.setitem(row,'dtpd_indwt',ld_gwt)
		dw_2.setitem(row,'dtpd_chestwt',ld_trwt)
		dw_2.setitem(row,'netwt',ld_nwt)
		dw_2.setitem(row,'gtot',ld_tgwt)
		dw_2.setitem(row,'ntot',ld_tnwt)
		dw_2.setitem(row,'dtpd_id',ls_dtpdid)
		

		if dw_1.getitemstring(dw_1.getrow(),'si_type') = 'PRICONS' then
			select nvl(sa_type,'FWD') into :ls_type from fb_advice where advice_id = :ls_adv;
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Advice Quantity',sqlca.sqlerrtext)
				return 1
			end if
			if ls_type = 'FWD' then
				select nvl(ADVICE_ORDQUANTITY,0) into :ld_advqty from fb_advicedetails where advice_id = :ls_adv and TMP_ID = :ls_tmp_id;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Advice Quantity',sqlca.sqlerrtext)
					return 1
				elseif sqlca.sqlcode = 100 then
					messagebox('Warning!','Invalid Advice No, Please Check !!!')
					return 1
				elseif sqlca.sqlcode = 0 then
					select nvl(pd_value,0) into :ld_toll from fb_param_detail where pd_doc_type = 'TOLERANCE' and PD_PERIOD_TO is null;
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Getting Tollerance Quantity',sqlca.sqlerrtext)
						return 1
					end if 
					
					if isnull(ld_toll) then ld_toll = 0;
					if wf_gradetotal_fw(ls_tmp_id) > (ld_advqty + ld_toll) then
						messagebox('Warning!','Packing Invoice Quantity ('+string(wf_gradetotal_fw(ls_tmp_id))+') is > Advice Quantity + Tollerance ('+string(ld_advqty + ld_toll)+'), Please Check !!!')
						setnull(ls_temp); setnull(ll_tmp)
						dw_2.setitem(row,'sid_season',ll_tmp)
						dw_2.setitem(row,'tmp_id',ll_tmp)
						dw_2.setitem(row,'sid_srnostart',ll_tmp)
						dw_2.setitem(row,'sid_srnoend',ll_tmp)
						dw_2.setitem(row,'nop',ll_tmp)
						dw_2.setitem(row,'dtpd_indwt',ll_tmp)
						dw_2.setitem(row,'dtpd_chestwt',ll_tmp)
						dw_2.setitem(row,'netwt',ll_tmp)
						dw_2.setitem(row,'gtot',ll_tmp)
						dw_2.setitem(row,'ntot',ll_tmp)
						dw_2.setitem(row,'dtpd_id',ls_temp)
						return 1
					end if		//if wf_gradetotal_fw(ls_tmp_id) > (ld_advqty + ld_toll) then
				end if  //if sqlca.sqlcode = -1			
			else
				select nvl(ADVICE_ORDQUANTITY,0) into :ld_advqty from fb_advicedetails where advice_id = :ls_adv and TMP_ID = :ls_tmp_id and SAD_INVNO = :ls_pinv;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Advice Quantity',sqlca.sqlerrtext)
					return 1
				elseif sqlca.sqlcode = 100 then
					messagebox('Warning!','Invalid Advice No, Please Check !!!')
					return 1
				elseif sqlca.sqlcode = 0 then
					
					select nvl(pd_value,0) into :ld_toll from fb_param_detail where pd_doc_type = 'TOLERANCE' and PD_PERIOD_TO is null;
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Getting Tollerance Quantity',sqlca.sqlerrtext)
						return 1
					end if 
					
					if isnull(ld_toll) then ld_toll = 0;
	//				wf_gradetotal_fw
					if wf_gradetotal(ls_tmp_id,ls_pinv) > (ld_advqty + ld_toll) then
						messagebox('Warning!','Packing Invoice Quantity ('+string(wf_gradetotal(ls_tmp_id,ls_pinv))+') is > Advice Quantity + Tollerance ('+string(ld_advqty + ld_toll)+'), Please Check !!!')
						setnull(ls_temp); setnull(ll_tmp)
						dw_2.setitem(row,'sid_season',ll_tmp)
						dw_2.setitem(row,'tmp_id',ll_tmp)
						dw_2.setitem(row,'sid_srnostart',ll_tmp)
						dw_2.setitem(row,'sid_srnoend',ll_tmp)
						dw_2.setitem(row,'nop',ll_tmp)
						dw_2.setitem(row,'dtpd_indwt',ll_tmp)
						dw_2.setitem(row,'dtpd_chestwt',ll_tmp)
						dw_2.setitem(row,'netwt',ll_tmp)
						dw_2.setitem(row,'gtot',ll_tmp)
						dw_2.setitem(row,'ntot',ll_tmp)
						dw_2.setitem(row,'dtpd_id',ls_temp)
						return 1
	//				elseif wf_gradetotal(ls_tmp_id) < (ld_advqty - ld_toll) then
	//					messagebox('Warning!','Packing Invoice Quantity ('+string(wf_gradetotal(ls_tmp_id))+') is < Advice Quantity - Tollerance ('+string(ld_advqty - ld_toll)+'), Please Check !!!')
	//					setnull(ls_temp); setnull(ll_tmp)
	//					dw_2.setitem(row,'sid_season',ll_tmp)
	//					dw_2.setitem(row,'tmp_id',ll_tmp)
	//					dw_2.setitem(row,'sid_srnostart',ll_tmp)
	//					dw_2.setitem(row,'sid_srnoend',ll_tmp)
	//					dw_2.setitem(row,'nop',ll_tmp)
	//					dw_2.setitem(row,'dtpd_indwt',ll_tmp)
	//					dw_2.setitem(row,'dtpd_chestwt',ll_tmp)
	//					dw_2.setitem(row,'netwt',ll_tmp)
	//					dw_2.setitem(row,'gtot',ll_tmp)
	//					dw_2.setitem(row,'ntot',ll_tmp)
	//					dw_2.setitem(row,'dtpd_id',ls_temp)
	//					return 1
					end if  //if wf_gradetotal(ls_tmp_id,ls_pinv)
				end if  //if sqlca.sqlcode = -1
			end if //if ls_type = 'FWD' then
		end if //if dw_1.getitemstring(dw_1.getrow(),'si_type') = 'PRICONS'
	
	// Insurance calc
	ld_totalnwt = dw_2.getitemnumber(row,'tot_ntwt')
	
	select nvl(PD_VALUE,0) into :ld_insrate from fb_param_detail where PD_DOC_TYPE = 'INSURANCE' and PD_PERIOD_TO is null;
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Insurance Rate',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
		if isnull(ld_totalnwt) then ld_totalnwt = 0;
		if isnull(ld_insrate) then ld_insrate = 0;
		ld_insval = ld_totalnwt * ld_insrate;
		if isnull(ld_insval) then ld_insval = 0;
		dw_1.setitem(dw_1.getrow(),'si_insurancevalue',ld_insval)
	end if
	// Insurance calc
	
	ld_rate = dw_2.getitemnumber(row,'sid_rate')
	ls_cust = dw_1.getitemstring(dw_1.getrow(),'cus_id')
	ls_type = dw_1.getitemstring(dw_1.getrow(),'si_type')
	ls_iss_locn = dw_1.getitemstring(1,'si_iss_locn')
	ls_rec_locn = dw_1.getitemstring(1,'si_rec_locn')
	ld_invdt = dw_1.getitemdatetime(1,'si_date')
	ld_tnwt = dw_2.getitemnumber(row,'ntot')
	ls_tmp_id = dw_2.getitemstring(row,'tmp_id')
	
	if ls_type <> 'TRANSFREE' then
		if ld_rate = 0 then
			//messagebox('Warning','Rate Must Be > 0, Please Check... ')
			//return 1
		end if
	else
		 ld_rate = 0
	end if
	
	if ls_type = 'AUCTION' then
//		select brok_gstnno into :ls_rec_gstn from fb_broker where brok_id = :ls_brok;
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Recving GSTIN',sqlca.sqlerrtext)
//			return 1
//		end if 
		
		select ware_gstnno into :ls_rec_gstn from fb_warehouse where ware_id = :ls_wareid;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Recving GSTIN',sqlca.sqlerrtext)
			return 1
		end if 					
	else		
		select cus_gstnno into :ls_rec_gstn from fb_customer where cus_id = :ls_cust;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Recving GSTIN',sqlca.sqlerrtext)
			return 1
		end if 	
	end if
	
	select UNIT_GSTNNO into :ls_iss_gstn from fb_gardenmaster where unit_active_ind = 'Y';
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Issue GSTIN',sqlca.sqlerrtext)
		return 1
	end if 		

	if isnull(ls_rec_locn) or len(ls_rec_locn) = 0 then
		messagebox('Error','Customer Sate Code No Update, Please Update Now !!!')
		return 1
	end if
		
	if isnull(ls_iss_locn) or len(ls_iss_locn) = 0 then
		messagebox('Error','Garden Sate Code No Update, Please Update Now !!!')
		return 1
	end if
	
	select TMP_HSN_NO into :ls_hsn_cd from fb_teamadeproduct where tmp_id =  :ls_tmp_id;
	if sqlca.sqlcode = -1 then 
		messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
		return 1
	elseif sqlca.sqlcode = 100 then 
		messagebox('Error','Item HSN Code Missing, Please Check !!!')
		return 1
	end if;	
	
	if isnull(ls_iss_gstn) then ls_iss_gstn = 'X';
	if isnull(ls_rec_gstn) then ls_rec_gstn = 'X';

	
	if ls_iss_gstn <> ls_rec_gstn then
		select nvl(HM_CGST_RATE,0), nvl(HM_SGST_RATE,0), nvl(HM_IGST_RATE,0) into :ld_cgst_per, :ld_sgst_per, :ld_igst_per
		from fb_hsn_master where HM_HSN_code = :ls_hsn_cd and trunc(:ld_invdt) between trunc(HM_FROM_DT) and trunc(nvl(HM_TO_DT,sysdate)) and HM_APPROVED_DT is not null;
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 100 then 
			messagebox('Error','Item HSN Code/Rate Is Missing, Please Check !!!')
			return 1
		end if;				
		if ls_iss_locn = ls_rec_locn then
			ld_igst_per = 0
		elseif ls_iss_locn <> ls_rec_locn then
			ld_cgst_per = 0; ld_sgst_per = 0;
		end if
		
		if ld_igst_per > 0 then
			ld_cgst_per = 0
			ld_sgst_per = 0
			dw_2.setitem(row,'sid_cgst_per',0)
			dw_2.setitem(row,'sid_sgst_per',0)
			dw_2.setitem(row,'sid_igst_amt',((ld_tnwt * ld_rate) *(ld_igst_per/100)))
			dw_2.setitem(row,'ngamt',((ld_tnwt * ld_rate))) 
			dw_2.setitem(row,'sid_igst_per',ld_igst_per)
			dw_2.setitem(row,'sid_cgst_amt',0) 
			dw_2.setitem(row,'sid_sgst_amt',0) 
			if dw_1.getitemstring(dw_1.getrow(),'si_type') = 'EXP' or dw_1.getitemstring(dw_1.getrow(),'si_type') = 'SEZ' then
				dw_2.setitem(row,'sid_igst_amt',0) 
				dw_2.setitem(row,'sid_igst_per',0)
			end if
		elseif ld_cgst_per > 0 or ld_sgst_per > 0 then
			ld_igst_per = 0
			dw_2.setitem(row,'sid_igst_per',0)
			dw_2.setitem(row,'sid_cgst_amt',((ld_tnwt * ld_rate) *(ld_cgst_per/100))) 
			dw_2.setitem(row,'sid_sgst_amt',((ld_tnwt * ld_rate) *(ld_sgst_per/100))) 
			dw_2.setitem(row,'ngamt',((ld_tnwt * ld_rate))) 
			dw_2.setitem(row,'sid_cgst_per',ld_cgst_per) 
			dw_2.setitem(row,'sid_sgst_per',ld_sgst_per) 				
			dw_2.setitem(row,'sid_igst_amt',0) 			
			if dw_1.getitemstring(dw_1.getrow(),'si_type') = 'EXP' or dw_1.getitemstring(dw_1.getrow(),'si_type') = 'SEZ' then
				dw_2.setitem(row,'sid_cgst_amt',0) 
				dw_2.setitem(row,'sid_cgst_per',0)
				dw_2.setitem(row,'sid_sgst_amt',0) 
				dw_2.setitem(row,'sid_sgst_per',0)				
			end if			
		end if
		if ls_pan <> gs_panno then
			if wf_calnet_amt() =-1 then return 
		end if
	else
		ld_cgst_per = 0; ld_cgst_per = 0; ld_igst_per = 0;
		dw_2.setitem(row,'sid_igst_per',0)
		dw_2.setitem(row,'sid_cgst_amt',0) 
		dw_2.setitem(row,'sid_sgst_amt',0) 
		dw_2.setitem(row,'sid_cgst_per',0) 
		dw_2.setitem(row,'sid_sgst_per',0) 				
		dw_2.setitem(row,'sid_igst_amt',0) 			
	end if
	

end if //if dwo.name = 'dtp_lotno' then
//==============
if dwo.name = 'sid_rate' then
	ld_rate = double(data)
	ls_cust = dw_1.getitemstring(dw_1.getrow(),'cus_id')
	ls_type = dw_1.getitemstring(dw_1.getrow(),'si_type')
	ls_iss_locn = dw_1.getitemstring(1,'si_iss_locn')
	ls_rec_locn = dw_1.getitemstring(1,'si_rec_locn')
	ld_invdt = dw_1.getitemdatetime(1,'si_date')
	ld_tnwt = dw_2.getitemnumber(row,'ntot')
	ls_tmp_id = dw_2.getitemstring(row,'tmp_id')
	
	if ls_type <> 'TRANSFREE' then
		if ld_rate = 0 then
			messagebox('Warning','Rate Must Be > 0, Please Check... ')
			return 1
		end if
	else
		 ld_rate = 0
	end if
	
	if ls_type = 'AUCTION' then
//		select brok_gstnno into :ls_rec_gstn from fb_broker where brok_id = :ls_brok;
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Recving GSTIN',sqlca.sqlerrtext)
//			return 1
//		end if 
		
		select ware_gstnno into :ls_rec_gstn from fb_warehouse where ware_id = :ls_wareid;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Recving GSTIN',sqlca.sqlerrtext)
			return 1
		end if 					
	else		
		select cus_gstnno into :ls_rec_gstn from fb_customer where cus_id = :ls_cust;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Recving GSTIN',sqlca.sqlerrtext)
			return 1
		end if 	
	end if
	
	select UNIT_GSTNNO into :ls_iss_gstn from fb_gardenmaster where unit_active_ind = 'Y';
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Issue GSTIN',sqlca.sqlerrtext)
		return 1
	end if 		

	if isnull(ls_rec_locn) or len(ls_rec_locn) = 0 then
		messagebox('Error','Customer Sate Code No Update, Please Update Now !!!')
		return 1
	end if
		
	if isnull(ls_iss_locn) or len(ls_iss_locn) = 0 then
		messagebox('Error','Garden Sate Code No Update, Please Update Now !!!')
		return 1
	end if
	
	select TMP_HSN_NO into :ls_hsn_cd from fb_teamadeproduct where tmp_id =  :ls_tmp_id;
	if sqlca.sqlcode = -1 then 
		messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
		return 1
	elseif sqlca.sqlcode = 100 then 
		messagebox('Error','Item HSN Code Missing, Please Check !!!')
		return 1
	end if;	
	
	if isnull(ls_iss_gstn) then ls_iss_gstn = 'X';
	if isnull(ls_rec_gstn) then ls_rec_gstn = 'X';

	
	if ls_iss_gstn <> ls_rec_gstn then
		select nvl(HM_CGST_RATE,0), nvl(HM_SGST_RATE,0), nvl(HM_IGST_RATE,0) into :ld_cgst_per, :ld_sgst_per, :ld_igst_per
		from fb_hsn_master where HM_HSN_code = :ls_hsn_cd and trunc(:ld_invdt) between trunc(HM_FROM_DT) and trunc(nvl(HM_TO_DT,sysdate)) and HM_APPROVED_DT is not null;
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 100 then 
			messagebox('Error','Item HSN Code/Rate Is Missing, Please Check !!!')
			return 1
		end if;				
		if ls_iss_locn = ls_rec_locn then
			ld_igst_per = 0
		elseif ls_iss_locn <> ls_rec_locn then
			ld_cgst_per = 0; ld_sgst_per = 0;
		end if
		
		if ld_igst_per > 0 then
			ld_cgst_per = 0
			ld_sgst_per = 0
			dw_2.setitem(row,'sid_cgst_per',0)
			dw_2.setitem(row,'sid_sgst_per',0)
			dw_2.setitem(row,'ngamt',((ld_tnwt * ld_rate))) 
			dw_2.setitem(row,'sid_igst_amt',((ld_tnwt * ld_rate) *(ld_igst_per/100))) 
			dw_2.setitem(row,'sid_igst_per',ld_igst_per)
			dw_2.setitem(row,'sid_cgst_amt',0) 
			dw_2.setitem(row,'sid_sgst_amt',0) 
			if dw_1.getitemstring(dw_1.getrow(),'si_type') = 'EXP' or dw_1.getitemstring(dw_1.getrow(),'si_type') = 'SEZ' then
				dw_2.setitem(row,'sid_igst_amt',0) 
				dw_2.setitem(row,'sid_igst_per',0)
			end if						
			
//			if dw_1.getitemstring(dw_1.getrow(),'dsp_saletype') = 'PS' and ld_tcs_rate > 0 then
//				dw_2.setitem(row,'did_tcs_per',ld_tcs_rate)
//				if ls_inc_gst = 'N' then
//					dw_2.setitem(row,'did_tcs_amt', (ld_amt *(ld_tcs_rate/100)))
//				elseif ls_inc_gst = 'Y' then
//					dw_2.setitem(row,'did_tcs_amt', ((ld_amt +(ld_amt *(ld_igst_per/100)) ) *(ld_tcs_rate/100)))
//				end if
//			end if
			
		elseif ld_cgst_per > 0 or ld_sgst_per > 0 then
			ld_igst_per = 0
			dw_2.setitem(row,'sid_igst_per',0)
			dw_2.setitem(row,'ngamt',((ld_tnwt * ld_rate))) 
			dw_2.setitem(row,'sid_cgst_amt',((ld_tnwt * ld_rate) *(ld_cgst_per/100))) 
			dw_2.setitem(row,'sid_sgst_amt',((ld_tnwt * ld_rate) *(ld_sgst_per/100))) 
			dw_2.setitem(row,'sid_cgst_per',ld_cgst_per) 
			dw_2.setitem(row,'sid_sgst_per',ld_sgst_per) 				
			dw_2.setitem(row,'sid_igst_amt',0) 	
			if dw_1.getitemstring(dw_1.getrow(),'si_type') = 'EXP' or dw_1.getitemstring(dw_1.getrow(),'si_type') = 'SEZ' then
				dw_2.setitem(row,'sid_cgst_amt',0) 
				dw_2.setitem(row,'sid_cgst_per',0)
				dw_2.setitem(row,'sid_sgst_amt',0) 
				dw_2.setitem(row,'sid_sgst_per',0)				
			end if						
		end if
		if ls_pan <> gs_panno then
			if wf_calnet_amt() =-1 then return 
		end if
	else
		ld_cgst_per = 0; ld_cgst_per = 0; ld_igst_per = 0;
		dw_2.setitem(row,'sid_igst_per',0)
		dw_2.setitem(row,'sid_cgst_amt',0) 
		dw_2.setitem(row,'sid_sgst_amt',0) 
		dw_2.setitem(row,'sid_cgst_per',0) 
		dw_2.setitem(row,'sid_sgst_per',0) 				
		dw_2.setitem(row,'sid_igst_amt',0) 			
	end if
	
end if
//==============	


if lb_neworder = true then
	if row = dw_2.rowcount() and dwo.name <> 'del_flag'  then
		dw_2.insertrow(0)
	end if
end if
cb_3.enabled = true
end event

