$PBExportHeader$w_gtedsf008.srw
forward
global type w_gtedsf008 from window
end type
type cb_5 from commandbutton within w_gtedsf008
end type
type cb_7 from commandbutton within w_gtedsf008
end type
type cb_8 from commandbutton within w_gtedsf008
end type
type cb_9 from commandbutton within w_gtedsf008
end type
type dw_2 from datawindow within w_gtedsf008
end type
type cb_4 from commandbutton within w_gtedsf008
end type
type cb_3 from commandbutton within w_gtedsf008
end type
type cb_2 from commandbutton within w_gtedsf008
end type
type cb_1 from commandbutton within w_gtedsf008
end type
type dw_1 from datawindow within w_gtedsf008
end type
end forward

global type w_gtedsf008 from window
integer width = 4320
integer height = 2380
boolean titlebar = true
string title = "(w_gtedsf008) Tax Invoice"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_5 cb_5
cb_7 cb_7
cb_8 cb_8
cb_9 cb_9
dw_2 dw_2
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtedsf008 w_gtedsf008

type variables
long ll_ctr,ll_user_level,ll_cnt
string ls_temp,ls_last,ls_count, ls_ref,ls_inv_no, ls_custid,ls_stcd
boolean lb_neworder, lb_query
double ld_qnty,ld_uprice,ld_saleprice,ld_taxrate,ld_vatp
datawindowchild idw_item

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_invno, string fs_item)
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
	if ( isnull(dw_2.getitemstring(fl_row,'ti_packinvno')) or  len(dw_2.getitemstring(fl_row,'ti_packinvno'))=0 or &
		isnull(dw_2.getitemstring(fl_row,'ti_itemcd')) or  len(dw_2.getitemstring(fl_row,'ti_itemcd'))=0 or &
		isnull(dw_2.getitemnumber(fl_row,'ti_qnty')) or dw_2.getitemnumber(fl_row,'ti_qnty') = 0 or &
		isnull(dw_2.getitemnumber(fl_row,'ti_unitprice')) or  dw_2.getitemnumber(fl_row,'ti_unitprice')= 0 or &
		isnull(dw_2.getitemnumber(fl_row,'ti_taxrate')) or  dw_2.getitemnumber(fl_row,'ti_taxrate') =0 ) then
		 messagebox('Warning: One Of The Following Fields Are Blank','Packing Invoice No, Item Code, Quantity, Unit Price, Vat %, Please Check !!!')
		 return -1
	end if
end if
return 1
end function

public function integer wf_check_duplicate_rec (string fs_invno, string fs_item);long fl_row
string ls_inv1,ls_item1

dw_2.SelectRow(0, FALSE)
if dw_2.rowcount() > 1 then
	for fl_row = 1 to (dw_2.rowcount() - 1)
		ls_inv1 = dw_2.getitemstring(fl_row,'ti_packinvno')
		ls_item1 = dw_2.getitemstring(fl_row,'ti_itemcd')
		
		if ls_inv1 = fs_invno and fs_item = ls_item1 then
			dw_2.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtedsf008.create
this.cb_5=create cb_5
this.cb_7=create cb_7
this.cb_8=create cb_8
this.cb_9=create cb_9
this.dw_2=create dw_2
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_5,&
this.cb_7,&
this.cb_8,&
this.cb_9,&
this.dw_2,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtedsf008.destroy
destroy(this.cb_5)
destroy(this.cb_7)
destroy(this.cb_8)
destroy(this.cb_9)
destroy(this.dw_2)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
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

dw_2.GetChild ("ti_itemcd", idw_item)
idw_item.settransobject(sqlca)	

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

type cb_5 from commandbutton within w_gtedsf008
integer x = 3785
integer y = 24
integer width = 123
integer height = 88
integer taborder = 60
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

type cb_7 from commandbutton within w_gtedsf008
integer x = 3904
integer y = 24
integer width = 123
integer height = 88
integer taborder = 60
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

type cb_8 from commandbutton within w_gtedsf008
integer x = 4023
integer y = 24
integer width = 123
integer height = 88
integer taborder = 60
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

type cb_9 from commandbutton within w_gtedsf008
integer x = 4142
integer y = 24
integer width = 123
integer height = 88
integer taborder = 60
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

type dw_2 from datawindow within w_gtedsf008
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 375
integer y = 696
integer width = 3474
integer height = 1564
integer taborder = 40
string dataobject = "dw_gtedsf008a"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_2.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_2.deleterow(dw_2.getrow())
	end if
	if dw_2.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event ue_keydwn;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_2.deleterow(dw_2.getrow())
	end if
	if dw_2.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event itemchanged;IF lb_query = false then
	if dwo.name = 'ti_packinvno'  then
		ls_inv_no = data
		ls_custid = dw_1.getitemstring(dw_1.getrow(),'ti_custid')
		
		select distinct 'x' into :ls_temp from fb_dailyteapacked where DTP_LOTNO = :ls_inv_no;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Packing Invoice No',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 100 then	
			messagebox('Warning !','Invalid Packing Invoice No Or Not Exists In Master, Please Check !!!')
			return 1
		end if		
		
		select distinct 'x' into :ls_temp from fb_taxinvhdr where TI_INVNO = :ls_inv_no;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Packing Invoice No',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 0 then	
			messagebox('Warning !','Packing Invoice No Already Exists, Please Check !!!')
			return 1
		end if

		select CUS_STATEID into :ls_stcd from fb_customer where CUS_ID = :ls_custid;

		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting State Code',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		if not isnull(ls_stcd) then
			select nvl(PD_VALUE,0) into :ld_taxrate from fb_param_detail where PD_DOC_TYPE = 'TAX' and PD_CODE = :ls_stcd and PD_PERIOD_TO is null;
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Vat Percentage',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			end if

			if isnull(ld_taxrate) then ld_taxrate = 0;
			dw_2.setitem(row,'ti_taxrate',ld_taxrate)
		end if	
		
		idw_item.SetFilter ("dtp_lotno = '"+ls_inv_no+"'")
		idw_item.settransobject(sqlca)	
		idw_item.retrieve()			
	end if
	
	if dwo.name = 'ti_itemcd' then
		ls_inv_no = dw_2.getitemstring(row,'ti_packinvno')
		
		if wf_check_duplicate_rec(ls_inv_no,data) = -1 then return 1
	end if

	if dwo.name = 'ti_qnty' then
		ld_qnty = double(data)
		ld_uprice = dw_2.getitemnumber(row,'ti_unitprice')
		
		if isnull(ld_uprice) then ld_uprice = 0
		if isnull(ld_qnty) then ld_qnty = 0	
		ld_saleprice = ld_uprice * ld_qnty
		dw_2.setitem(row,'ti_saleprice',ld_saleprice)
		if isnull(ld_saleprice) then ld_saleprice = 0	
		ld_vatp = round(((ld_taxrate * ld_saleprice) / 100),2)
		dw_2.setitem(row,'ti_vatpayable',ld_vatp)
	end if
	
	if dwo.name = 'ti_unitprice' then
		ld_uprice = double(data)
		ld_qnty = dw_2.getitemnumber(row,'ti_qnty')
		
		if isnull(ld_uprice) then ld_uprice = 0
		if isnull(ld_qnty) then ld_qnty = 0	
		ld_saleprice = ld_uprice * ld_qnty
		dw_2.setitem(row,'ti_saleprice',ld_saleprice)
		if isnull(ld_saleprice) then ld_saleprice = 0	
		ld_vatp = round(((ld_taxrate * ld_saleprice) / 100),2)
		dw_2.setitem(row,'ti_vatpayable',ld_vatp)
	end if
	
	if dwo.name = 'ti_taxrate' then
		ld_taxrate = double(data)
		ld_saleprice = dw_2.getitemnumber(row,'ti_saleprice')
		
		if isnull(ld_taxrate) then ld_taxrate = 0
		if isnull(ld_saleprice) then ld_saleprice = 0	
		ld_vatp = round(((ld_taxrate * ld_saleprice) / 100),2)
		dw_2.setitem(row,'ti_vatpayable',ld_vatp)
	end if
end if

if row = dw_2.rowcount() and dwo.name <> 'del_flag'  then
		dw_2.insertrow(0)
end if

cb_3.enabled = true
end event

type cb_4 from commandbutton within w_gtedsf008
integer x = 809
integer y = 12
integer width = 265
integer height = 100
integer taborder = 50
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

type cb_3 from commandbutton within w_gtedsf008
integer x = 544
integer y = 12
integer width = 265
integer height = 100
integer taborder = 40
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
ll_cnt = 0 
if dw_2.rowcount() > 0 then
	if (isnull(dw_2.getitemstring(dw_2.rowcount(),'ti_itemcd')) or len(dw_2.getitemstring(dw_2.rowcount(),'ti_itemcd')) = 0) then 
		dw_2.deleterow(dw_2.rowcount())
	end if;
end if

if dw_2.rowcount() = 0 then
	messagebox('Error','Records Should Be Available In Detail Block')
	return 1
end if

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	for ll_ctr = dw_2.rowcount() to 1 step -1
		if dw_2.getitemstring(ll_ctr,'del_flag') = 'Y' and dw_2.rowcount() = dw_2.getitemnumber(ll_ctr,'sel_row') then
			messagebox('Warning!','You Cannot Delete All Records From Detail Section !!!')
			return 1
		elseif dw_2.getitemstring(ll_ctr,'del_flag') = 'Y' and dw_2.rowcount() <> dw_2.getitemnumber(ll_ctr,'sel_row') then
			dw_2.deleterow(ll_ctr)
		end if
	next	
	

	if (	isnull(dw_1.getitemstring(dw_1.getrow(),'ti_supid')) or len(dw_1.getitemstring(dw_1.getrow(),'ti_supid')) = 0 or &
		isnull(dw_1.getitemstring(dw_1.getrow(),'ti_custid')) or len(dw_1.getitemstring(dw_1.getrow(),'ti_custid')) = 0 or &
		isnull(dw_1.getitemstring(dw_1.getrow(),'ti_term')) or len(dw_1.getitemstring(dw_1.getrow(),'ti_term')) = 0) then
		messagebox('Warning:','One Of The Fields Are Blank : Supplier ID, Buyer ID, Payment Term !!!')
		dw_1.setfocus()
		dw_1.setcolumn('ti_supid')
		return 1
	end if
		
	if dw_2.rowcount() > 0 then
		for ll_ctr = 1 to dw_2.rowcount( ) 
			IF wf_check_fillcol(ll_ctr) = -1 THEN 
				return 1
			end if
		next	
	end if

	if dw_1.getitemstatus(dw_1.getrow(),0,primary!) = NewModified! or dw_1.getitemstatus(dw_1.getrow(),0,primary!) = New! then
		
		if ll_cnt=0 then
			select nvl(MAX(ti_ID),0) into :ll_cnt from fb_taxinvhdr;
		end if
		ll_cnt = ll_cnt + 1
		ls_count = string(ll_cnt,'0000000000')
		ls_inv_no = string(ll_cnt)+'/'+right(string(today()),2)
		dw_1.setitem(dw_1.getrow(),'ti_id',ll_cnt)
		dw_1.setitem(dw_1.getrow(),'ti_invno',ls_inv_no)
		dw_1.setitem(dw_1.getrow(),'ti_invdt',today())
		for ll_ctr = 1 to dw_2.rowcount()
			dw_2.setitem(ll_ctr,'td_id',ll_cnt)
		next
	end if		
	
	if dw_1.update(true,false) = 1 and dw_2.update(true,false) = 1 then
		dw_2.resetupdate();
		dw_1.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
		dw_1.reset()
		dw_2.reset()
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
else
	return
end if 
end event

type cb_2 from commandbutton within w_gtedsf008
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
	dw_1.settaborder('ti_invno',5)
	dw_1.settaborder('ti_supid',7)
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('ti_invno')
	cb_2.text = "&Run"
	cb_3.enabled = false
else
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user)
 	dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
	dw_1.settaborder('ti_invno',0)
	dw_1.settaborder('ti_supid',0)
	cb_2.text = "&Query"
   	cb_5.enabled = true
   	cb_7.enabled = true
   	cb_8.enabled = true
   	cb_9.enabled = true
end if
lb_neworder = false

end event

type cb_1 from commandbutton within w_gtedsf008
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

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'ti_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'ti_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'ti_supid',gs_supid)
	dw_1.setcolumn('ti_custid')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'ti_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'ti_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'ti_supid',gs_supid)
	dw_1.setcolumn('ti_custid')
end if


end event

type dw_1 from datawindow within w_gtedsf008
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 9
integer y = 116
integer width = 4251
integer height = 572
integer taborder = 30
string dataobject = "dw_gtedsf008"
boolean hscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'ti_entry_by',gs_user)
		dw_1.setitem(newrow,'ti_entry_dt',datetime(today()))
		dw_1.setcolumn('ti_supid')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if lb_neworder = true and dw_2.rowcount() = 0 then
	dw_2.setfocus()
	dw_2.insertrow(0)
	dw_1.setfocus()
	dw_1.setcolumn('ti_supid')		
end if;
cb_3.enabled = true

end event

event rowfocuschanged;if lb_query = false then
	if lb_neworder = false  then
		if dw_1.rowcount() > 0 then
			dw_2.reset()
			dw_2.retrieve(dw_1.getitemnumber(dw_1.getrow(),'ti_id'))
		end if
	end if
end if
end event

