$PBExportHeader$w_gteacf014.srw
forward
global type w_gteacf014 from window
end type
type cbx_1 from checkbox within w_gteacf014
end type
type dp_2 from datepicker within w_gteacf014
end type
type st_4 from statictext within w_gteacf014
end type
type dp_1 from datepicker within w_gteacf014
end type
type st_2 from statictext within w_gteacf014
end type
type ddlb_1 from dropdownlistbox within w_gteacf014
end type
type st_3 from statictext within w_gteacf014
end type
type cb_4 from commandbutton within w_gteacf014
end type
type cb_6 from commandbutton within w_gteacf014
end type
type em_1 from editmask within w_gteacf014
end type
type st_1 from statictext within w_gteacf014
end type
type cb_2 from commandbutton within w_gteacf014
end type
type dw_1 from datawindow within w_gteacf014
end type
type cb_1 from commandbutton within w_gteacf014
end type
type cb_3 from commandbutton within w_gteacf014
end type
end forward

global type w_gteacf014 from window
integer width = 4750
integer height = 2996
boolean titlebar = true
string title = "(w_gteacf014) Green Leaf Price Adjustment"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cbx_1 cbx_1
dp_2 dp_2
st_4 st_4
dp_1 dp_1
st_2 st_2
ddlb_1 ddlb_1
st_3 st_3
cb_4 cb_4
cb_6 cb_6
em_1 em_1
st_1 st_1
cb_2 cb_2
dw_1 dw_1
cb_1 cb_1
cb_3 cb_3
end type
global w_gteacf014 w_gteacf014

type variables
long ll_ctr,ll_last
string ls_temp,ls_ac_dt,ls_rcno, ls_date,ls_sup_id,ls_frdt,ls_todt,ls_tranid, ls_type, ls_supname, ls_ledger,ls_tmp_id,ls_appr_ind
boolean lb_neworder, lb_query
double ld_qnty, ld_unitprice, ld_amount ,ld_cr_amt,ld_dr_amt, ld_adjprice
datetime ld_rcdt,ld_tran_dt



			
end variables

event ue_option();choose case gs_ueoption
	case "PRINT"
			OpenWithParm(w_print,this.dw_1)
	case "PRINTPREVIEW"
			this.dw_1.modify("datawindow.print.preview = yes")
	case "RESETPREVIEW"
			this.dw_1.modify("datawindow.print.preview = no")
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

on w_gteacf014.create
this.cbx_1=create cbx_1
this.dp_2=create dp_2
this.st_4=create st_4
this.dp_1=create dp_1
this.st_2=create st_2
this.ddlb_1=create ddlb_1
this.st_3=create st_3
this.cb_4=create cb_4
this.cb_6=create cb_6
this.em_1=create em_1
this.st_1=create st_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_3=create cb_3
this.Control[]={this.cbx_1,&
this.dp_2,&
this.st_4,&
this.dp_1,&
this.st_2,&
this.ddlb_1,&
this.st_3,&
this.cb_4,&
this.cb_6,&
this.em_1,&
this.st_1,&
this.cb_2,&
this.dw_1,&
this.cb_1,&
this.cb_3}
end on

on w_gteacf014.destroy
destroy(this.cbx_1)
destroy(this.dp_2)
destroy(this.st_4)
destroy(this.dp_1)
destroy(this.st_2)
destroy(this.ddlb_1)
destroy(this.st_3)
destroy(this.cb_4)
destroy(this.cb_6)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_3)
end on

event open;setpointer(hourglass!)
dw_1.settransobject(sqlca)
setpointer(arrow!)
//dw_1.modify("t_co.text = '"+gs_co_name+"'")
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if


setnull(ls_sup_id)

setpointer(hourglass!)
dw_1.settransobject(sqlca)
declare c1 cursor for
 select distinct b.sup_name||' ('||a.SUP_ID||')' from fb_gltransaction a,fb_supplier b 	
where a.sup_id = b.sup_id AND a.gt_type in ('PURCHASE','SALE') and GT_VOU_NO is not null;
   
 open c1;
  
IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_sup_id;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(string(ls_sup_id))
		fetch c1 into :ls_sup_id;
	loop
	close c1;
end if

setpointer(arrow!)
end event

event key;IF KeyDown(KeyF2!) THEN
	cb_2.triggerevent(clicked!)
end if

end event

type cbx_1 from checkbox within w_gteacf014
integer x = 1079
integer y = 16
integer width = 379
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Un Approved"
boolean checked = true
end type

type dp_2 from datepicker within w_gteacf014
boolean visible = false
integer x = 3419
integer y = 8
integer width = 357
integer height = 84
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2019-11-11"), Time("16:05:54.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

event valuechanged;ls_frdt = dp_1.text 
ls_todt = dp_2.text

ddlb_1.reset()
setpointer(hourglass!)
dw_1.settransobject(sqlca)
declare c1 cursor for
 select distinct b.sup_name||' ('||a.SUP_ID||')' from fb_gltransaction a,fb_supplier b 	
where a.sup_id = b.sup_id AND a.gt_type in ('PURCHASE','SALE') and GT_VOU_NO is not null AND 
       	 trunc(GT_DATE) between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy');
   
 open c1;
  
IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_sup_id;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(string(ls_sup_id))
		fetch c1 into :ls_sup_id;
	loop
	close c1;
end if

setpointer(arrow!)
end event

type st_4 from statictext within w_gteacf014
boolean visible = false
integer x = 2816
integer y = 16
integer width = 160
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gteacf014
boolean visible = false
integer x = 2926
integer y = 8
integer width = 352
integer height = 84
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2019-11-11"), Time("16:05:54.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

event valuechanged;ls_frdt = dp_1.text 
ls_todt = dp_2.text

ddlb_1.reset()
setpointer(hourglass!)
dw_1.settransobject(sqlca)
declare c1 cursor for
 select distinct b.sup_name||' ('||a.SUP_ID||')' from fb_gltransaction a,fb_supplier b 	
where a.sup_id = b.sup_id AND a.gt_type in ('PURCHASE','SALE') and GT_VOU_NO is not null AND 
       	 trunc(GT_DATE) between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy');
   
 open c1;
  
IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_sup_id;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(string(ls_sup_id))
		fetch c1 into :ls_sup_id;
	loop
	close c1;
end if

setpointer(arrow!)
end event

type st_2 from statictext within w_gteacf014
boolean visible = false
integer x = 2747
integer y = 16
integer width = 169
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From :"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gteacf014
boolean visible = false
integer x = 3762
integer width = 494
integer height = 900
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean allowedit = true
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_gteacf014
boolean visible = false
integer x = 3813
integer y = 20
integer width = 238
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Supplier"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_gteacf014
integer x = 805
integer y = 4
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

type cb_6 from commandbutton within w_gteacf014
integer x = 2395
integer width = 343
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "A/C Process"
end type

event clicked; n_fames luo_fames
 luo_fames = Create n_fames
 
 if isdate(em_1.text) = false then
	messagebox('Error :','Please Enter Valid Account Process date')
	rollback using sqlca;
	return 1;
else
	ls_ac_dt = em_1.text
end if;	

if f_check_mep(ls_ac_dt) = -1 then return 1

SetPointer(HourGlass!);
if f_check_fin_yr(datetime(ls_ac_dt)) = -1 then;	return 1;end if;

	for ll_ctr = 1 to dw_1.rowcount() 
		if dw_1.getitemstring(ll_ctr,'appr_flag') = 'Y'  and isnull(dw_1.getitemstring(ll_ctr,'aj_vou_no')) = true then
			if luo_fames.wf_purchase_adjto_account(dw_1.getitemstring(ll_ctr,'aj_id'),ls_ac_dt) = -1 then 
				rollback using sqlca;
				return 1;
			end if;
			//Update DailyExpense
			if dw_1.getitemstring(ll_ctr,'gt_type')='PURCHASE' then
				string ls_exsub_head
				setnull(ls_exsub_head)
				select distinct DR_EACSUBHEAD_ID into :ls_exsub_head from fb_acautoprocess 
				where AC_PROCESS='Green Leaf Purchase' and AC_PROCESS_DETAIL = 'Purchase  Leaf';
				
				if sqlca.sqlcode = -1  then
					messagebox('SQL Error: During Getting The Expense Sub Head A/c',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				if len(ls_exsub_head) > 0  then
					if luo_fames.wf_upd_mes(ls_ac_dt,ls_exsub_head,dw_1.getitemnumber(ll_ctr,'aj_adjamount'),'C','N')  = -1 then 
						rollback using sqlca;
						return 1;
					end if;	
				else
					messagebox('Warning','Expense Sub Head A/c Not In A/c Auto Process Master, Please Check')
					rollback using sqlca;
					return 1
				end if
				
			end if
		end if
	next	
	
dw_1.update( )
commit using sqlca;
SetPointer(Arrow!);
DESTROY n_fames
messagebox('Information;',' JV Created Successfully')
cb_6.enabled = false

if cbx_1.checked then
	ls_appr_ind = 'Y';
else
	ls_appr_ind = 'N';
end if
dw_1.Retrieve(ls_appr_ind)
end event

type em_1 from editmask within w_gteacf014
integer x = 1961
integer y = 8
integer width = 411
integer height = 84
integer taborder = 60
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
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

event modified;if isdate(em_1.text) = false then 
	messagebox('Error At Process date','Please Enter Account Process date...!')
	cb_6.enabled = false	
	return -1
else
	ls_temp = em_1.text
	//cb_6.enabled = true
	if dw_1.rowcount() > 0 then
		for ll_ctr = 1 to dw_1.rowcount() 
			if dw_1.getitemstring(ll_ctr,'appr_flag') = 'Y'  and isnull(dw_1.getitemstring(ll_ctr,'aj_vou_no')) = true then
				cb_6.enabled = true
			end if
		next	
	else
		messagebox('Warning:','Please Select a record for process')
		return 1
	end if;	
end if;	
end event

type st_1 from statictext within w_gteacf014
integer x = 1550
integer y = 20
integer width = 411
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = " A/C Process Date :"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gteacf014
integer x = 274
integer y = 4
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

event clicked;if cbx_1.checked then
	ls_appr_ind = 'Y';
else
	ls_appr_ind = 'N';
end if

if cb_2.text = "&Query" then
	if dw_1.modifiedcount() > 0  then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	lb_query = true
	lb_neworder = true
	dw_1.reset()
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('gt_id')
	cb_2.text = "&Run"
	cb_3.enabled = false
	cb_1.enabled = false
else
	lb_query = false
	lb_neworder = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(ls_appr_ind)
 	dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if


end event

type dw_1 from datawindow within w_gteacf014
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 14
integer y = 112
integer width = 4480
integer height = 2200
integer taborder = 50
string dataobject = "dw_gteacf014"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
//	if currentrow <> dw_1.rowcount() then
//		IF wf_check_fillcol(currentrow) = -1 THEN
//			return 1
//		END IF
//	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'aj_entry_by',gs_user)
		dw_1.setitem(newrow,'aj_entry_dt',datetime(today()))
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_1.deleterow(dw_1.rowcount())
	end if	
end if

end event

event ue_keydwn;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_1.deleterow(dw_1.rowcount())
	end if
	
end if

end event

event itemchanged;if lb_query  = false then
	if dwo.name = 'gt_id' then
		ls_tranid = trim(data)
		
		select GT_ID, trunc(GT_DATE) GT_DATE ,gt_type,a.SUP_ID,b.sup_name,ACSUBLEDGER_ID,GT_QUANTITY,GT_UNITPRICE,GT_NETAMOUNT
		into :ls_tranid, :ld_tran_dt, :ls_type, :ls_sup_id, :ls_supname, :ls_ledger, :ld_qnty, :ld_unitprice, :ld_amount
		from fb_gltransaction a, fb_supplier b
		where a.SUP_ID = b. SUP_ID and  GT_ID = :ls_tranid;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Green Leaf Details !!!!',sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 100 then
			messagebox('Warning !!!','Invalid Transaction ID, Please Check !!!')
			return 1
		elseif sqlca.sqlcode = 0 then
			dw_1.setitem(row,'gt_id',ls_tranid)
			dw_1.setitem(row,'gt_date',ld_tran_dt)
			dw_1.setitem(row,'gt_type',ls_type)
			dw_1.setitem(row,'sup_id',ls_sup_id)
			dw_1.setitem(row,'sup_name',ls_supname)
			dw_1.setitem(row,'acsubledger_id',ls_ledger)		
			dw_1.setitem(row,'gt_quantity',ld_qnty)
			dw_1.setitem(row,'gt_unitprice',ld_unitprice)
			dw_1.setitem(row,'gt_netamount',ld_amount)
		end if
		
	end if
	if dwo.name = 'aj_adjprice' then
		ld_adjprice =double(data)
		ld_qnty = dw_1.getitemnumber(row,'gt_quantity')
		if isnull(ld_qnty) then ld_qnty = 0;
		if isnull(ld_adjprice) then ld_adjprice = 0;
		dw_1.setitem(row,'aj_adjamount',ld_adjprice * ld_qnty)
	end if
//	if dwo.name = 'appr_flag'  then
//		ls_tmp_id =data
//		if ls_tmp_id = 'Y' then
//			dw_1.setitem(row,'aj_approved_by',gs_user)
//			dw_1.setitem(row,'aj_approved_dt',datetime(today())) 
//		elseif ls_tmp_id = 'N' then		
//			setnull(ls_temp)		
//			dw_1.setitem(row,'aj_approved_by',ls_temp)
//			dw_1.setitem(row,'aj_approved_dt',datetime(ls_temp)) 		
//		end if	
//	end if
end if
if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if

cb_3.enabled = true
end event

type cb_1 from commandbutton within w_gteacf014
integer x = 9
integer y = 4
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
end if

dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'aj_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'aj_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'aj_date',datetime(today()))
	dw_1.setcolumn('aj_adjprice')
else
//	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
//		return 1
//	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'aj_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'aj_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'aj_date',datetime(today()))
	dw_1.setcolumn('aj_adjprice')
end if

//if lb_neworder = false then
//	if dw_1.modifiedcount() > 0 then
//		if messagebox("Confirmation","Row has been modified, Do You Want To Add New Record ...!",question!,yesno!,1) = 2 then
//			return
//		end if
//	end if
//end if
//dw_1.reset()
//
//dw_1.settransobject(sqlca)
//
//if isnull(dp_1.text) or dp_1.text='00/00/0000' then
//	messagebox('Warning','Please Enter The "From" Date !!!')
//	return 
//end if
//
//if isnull(dp_2.text) or dp_2.text='00/00/0000' then
//	messagebox('Warning','Please Enter The "To" Date !!!')
//	return 
//end if
//
//if date(dp_1.text) > date(dp_2.text)  then
//	messagebox('Warning ','The From Date Should be <= TO Date , Please check ...!')
//	return 1
//end if
//
//
//if trim(ddlb_1.text) = "" or isnull(ddlb_1.text) then 
//	messagebox('Warning !','Please Select A Supplier...!')
//	return -1
//end if;
//
//setnull(ls_sup_id)
//
//ls_sup_id =left(right(ddlb_1.text ,9),8) 
//ls_frdt = dp_1.text 
//ls_todt = dp_2.text 
//
//
//DECLARE c1 CURSOR FOR  
//select GT_ID, trunc(GT_DATE),gt_type,a.SUP_ID,b.sup_name,ACSUBLEDGER_ID,GT_QUANTITY,GT_UNITPRICE,GT_NETAMOUNT
//from fb_gltransaction a, fb_supplier b
//where a.sup_id = b.sup_id AND gt_type in ('PURCHASE','SALE') and GT_VOU_NO is not null AND a.SUP_ID = :ls_sup_id AND 
//	        trunc(GT_DATE) between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy');
//
//open c1;
//	
//IF sqlca.sqlcode = 0 THEN
//	fetch c1 into :ls_tranid, :ld_tran_dt, :ls_type, :ls_sup_id, :ls_supname, :ls_ledger, :ld_qnty, :ld_unitprice, :ld_amount;
//	
//	do while sqlca.sqlcode <> 100
//		dw_1.scrolltorow(dw_1.insertrow(0))
//		dw_1.setitem(dw_1.getrow(),'aj_id',ls_tranid)
//		dw_1.setitem(dw_1.getrow(),'aj_date',ld_tran_dt)
//		dw_1.setitem(dw_1.getrow(),'gt_type',ls_type)
//		dw_1.setitem(dw_1.getrow(),'sup_id',ls_sup_id)
//		dw_1.setitem(dw_1.getrow(),'sup_name',ls_supname)
//		dw_1.setitem(dw_1.getrow(),'acsubledger_id',ls_ledger)		
//		dw_1.setitem(dw_1.getrow(),'gt_quantity',ld_qnty)
//		dw_1.setitem(dw_1.getrow(),'gt_unitprice',ld_unitprice)
//		dw_1.setitem(dw_1.getrow(),'gt_netamount',ld_amount)
//		
//		setnull(ls_tranid); setnull(ld_tran_dt); setnull(ls_type); setnull(ls_sup_id); setnull(ls_supname); setnull(ls_ledger); ld_qnty = 0; ld_unitprice = 0; ld_amount = 0;		
//		fetch c1 into :ls_tranid, :ld_tran_dt, :ls_type, :ls_sup_id, :ls_supname, :ls_ledger, :ld_qnty, :ld_unitprice, :ld_amount;
//	loop
//END IF
//close c1;
//dw_1.setfocus()
//dw_1.scrolltorow(1)
//dw_1.setcolumn('aj_adjprice')
//lb_neworder = true
//lb_query = false
//
//
//
end event

type cb_3 from commandbutton within w_gteacf014
integer x = 539
integer y = 4
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 
ll_last = 0
IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	for ll_ctr = dw_1.rowcount() to 1 step -1
		IF (isnull(dw_1.getitemnumber(ll_ctr,'aj_adjprice')) or dw_1.getitemnumber(ll_ctr,'aj_adjprice') = 0) THEN
			 dw_1.deleterow(ll_ctr)
		END IF
	next	
	if dw_1.rowcount() > 0 then		 
		for ll_ctr = 1 to dw_1.rowcount( ) 
			if dw_1.getitemstatus(ll_ctr,0,primary!) = NewModified! or dw_1.getitemstatus(ll_ctr,0,primary!) = New! or dw_1.getitemstatus(ll_ctr,0,primary!) = DataModified! then
				if dw_1.getitemstatus(ll_ctr,0,primary!) = NewModified! or dw_1.getitemstatus(ll_ctr,0,primary!) = New! then
					if ll_last=0 then
						select nvl(MAX(substr(aj_id,3,10)),0) into :ll_last from FB_GLTRANSACTION_adj;
					end if
					ll_last = ll_last + 1
					ls_tmp_id = 'AJ'+string(ll_last,'0000000000')
					dw_1.setitem(ll_ctr,'aj_id',ls_tmp_id)
					dw_1.setitem(ll_ctr,'aj_date',datetime(today()))
				end if	
			end if
		next
	end if
	if dw_1.update(true,false) = 1 then
		dw_1.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
		dw_1.reset()
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
else
	return
end if 
end event

