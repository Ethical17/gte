$PBExportHeader$w_gtepuf014.srw
forward
global type w_gtepuf014 from window
end type
type cb_5 from commandbutton within w_gtepuf014
end type
type cb_7 from commandbutton within w_gtepuf014
end type
type cb_8 from commandbutton within w_gtepuf014
end type
type cb_9 from commandbutton within w_gtepuf014
end type
type dw_2 from datawindow within w_gtepuf014
end type
type cb_4 from commandbutton within w_gtepuf014
end type
type cb_3 from commandbutton within w_gtepuf014
end type
type cb_2 from commandbutton within w_gtepuf014
end type
type cb_1 from commandbutton within w_gtepuf014
end type
type dw_1 from datawindow within w_gtepuf014
end type
end forward

global type w_gtepuf014 from window
integer width = 4315
integer height = 2084
boolean titlebar = true
string title = "(W_gtepuf014) Service Order "
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
global w_gtepuf014 w_gtepuf014

type variables
long ll_last,ll_ctr,ll_cnt,ll_count
string ls_temp,ls_cons,ls_sup_id,ls_indent_id,ls_tmp_id,ls_sp_id,ls_rem
boolean lb_neworder, lb_query
double ld_efunit_price,ld_amount,ld_qnty,ld_old_qnty,ld_indqnty
datetime ld_date
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_cal_datediff (datetime fd_frdt, datetime fd_todt)
public function integer wf_check_duplicate_rec (string fs_con_id)
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

public function integer wf_check_fillcol (integer fl_row);//if dw_1.rowcount() > 0 and fl_row > 0 then
//	if (isnull(dw_1.getitemstring(fl_row,'machine_id')) or  len(dw_1.getitemstring(fl_row,'machine_id'))=0 or &
//		 isnull(dw_1.getitemdatetime(fl_row,'peg_date'))) then
//	    messagebox('Warning: One Of The Following Fields Are Blank','Machine ID, Run Date, Please Check !!!')
//		 return -1
//	end if
//end if
if dw_2.rowcount() > 0 and fl_row > 0 then
	if (isnull(dw_2.getitemstring(fl_row,'sm_id')) or  len(dw_2.getitemstring(fl_row,'sm_id'))=0 or &
	    isnull(dw_2.getitemnumber(fl_row,'lpo_quantity')) or dw_2.getitemnumber(fl_row,'lpo_quantity') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Product, Quantity, Please Check !!!')
	    return -1
	end if
end if
return 1

end function

public function integer wf_cal_datediff (datetime fd_frdt, datetime fd_todt);double ld_hrs1

select round(((:fd_todt - :fd_frdt) * 24),2) into :ld_hrs1 from dual;

return ld_hrs1
end function

public function integer wf_check_duplicate_rec (string fs_con_id);long fl_row

dw_2.SelectRow(0, FALSE)
if dw_2.rowcount() > 1 then
	for fl_row = 1 to (dw_2.rowcount() - 1)
		if dw_2.getitemstring(fl_row,'sm_id') = fs_con_id  then
			dw_2.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtepuf014.create
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

on w_gtepuf014.destroy
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

event open;//dw_1.modify("t_co.text = '"+gs_CO_name+"'")
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if


dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
lb_query = false	
lb_neworder = false


//this.tag = Message.StringParm
//ll_user_level = long(this.tag)

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

type cb_5 from commandbutton within w_gtepuf014
integer x = 3648
integer y = 28
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

type cb_7 from commandbutton within w_gtepuf014
integer x = 3767
integer y = 28
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

type cb_8 from commandbutton within w_gtepuf014
integer x = 3886
integer y = 28
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

type cb_9 from commandbutton within w_gtepuf014
integer x = 4005
integer y = 28
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

type dw_2 from datawindow within w_gtepuf014
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 14
integer y = 824
integer width = 4256
integer height = 1168
integer taborder = 40
string dataobject = "dw_gtepuf014a"
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

event itemchanged;if lb_query = false then
	if dwo.name = 'sm_id'  then
		ls_sp_id = data	
		
		setnull(ls_temp);ld_indqnty=0
		
		if  wf_check_duplicate_rec(ls_sp_id) = -1 then return 1
	
	end if;
	if row = dw_2.rowcount() and dwo.name <> 'del_flag'  then		
		   dw_2.insertrow(0)
	end if
	
	
	//ld_old_qnty=dw_2.getitemnumber(row,'old_po_qnty') 
	
	if dwo.name = 'lpo_quantity' then
		ld_qnty=double(data)
		ld_efunit_price =dw_2.getitemnumber(row,'lpo_unitprice')
		ld_amount=ld_qnty * ld_efunit_price 
		dw_2.setitem(row,'amount',ld_amount)
	end if;	
	
	if dwo.name = 'lpo_unitprice' then
		ld_efunit_price =double(data)
		ld_qnty =dw_2.getitemnumber(row,'lpo_quantity')
		
		ld_amount=ld_qnty * ld_efunit_price 
		dw_2.setitem(row,'amount',ld_amount)
	end if
end if;
cb_3.enabled = true
end event

type cb_4 from commandbutton within w_gtepuf014
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

type cb_3 from commandbutton within w_gtepuf014
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

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	if dw_2.rowcount() > 1 then
		if (isnull(dw_2.getitemstring(dw_2.rowcount(),'sm_id')) or len(dw_2.getitemstring(dw_2.rowcount(),'sm_id')) = 0) then 
			dw_2.deleterow(dw_2.rowcount())
		end if;
	end if
	for ll_cnt = dw_2.rowcount() to 1 step -1
		if dw_2.getitemstring(ll_cnt,'del_flag') = 'Y' and dw_2.rowcount() = dw_2.getitemnumber(ll_cnt,'sel_row') then
			messagebox('Warning!','You Cannot Delete All Records From Detail Section !!!')
			return 1
		elseif dw_2.getitemstring(ll_cnt,'del_flag') = 'Y' and dw_2.rowcount() <> dw_2.getitemnumber(ll_cnt,'sel_row') then
			dw_2.deleterow(ll_cnt)
		end if
	next	
	
	if dw_2.rowcount() = 0 then
		messagebox('Error','Records Should Be Available In Detail Block')
		return
	end if

	if (isnull(dw_1.getitemstring(dw_1.getrow(),'lpo_desc')) or isnull(dw_1.getitemstring(dw_1.getrow(),'lpo_desc')) or &
		isnull(dw_1.getitemstring(dw_1.getrow(),'sup_id'))) then
		messagebox('Warning:','One Of The Fields Are Blank : Description, Indent Id, Supplier Id !!!')
		dw_1.setfocus()
		dw_1.setcolumn('lpo_desc')
		return
	end if
	
	ls_sup_id = dw_1.getitemstring(dw_1.getrow(),'sup_id')
	
	select SUP_ADD into :ls_temp from fb_supplier  where SUP_ID = :ls_sup_id and ACSUBLEDGER_ID is not null;
	
	if sqlca.sqlcode = -1 then
		messagebox('Error During Select Of Supplier Address',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 100 then
		messagebox('Warning!','Subledger For The Supplier Is Blank, Please Update First !!!')
		rollback using sqlca;
		return 1
	end if	
	
	if dw_2.rowcount() > 0 then
		for ll_ctr = 1 to dw_2.rowcount( ) 
			IF wf_check_fillcol(ll_ctr) = -1 THEN 
				return 1
			end if
		next	
	end if
	
		
	if lb_neworder = true then
		ll_last =0
		if ll_last=0 then
			select nvl(MAX(substr(lpo_id,4,10)),0) into :ll_last from fb_servicepurchaseorder;
		end if

			ll_last = ll_last + 1
			ls_tmp_id = 'SPO'+string(ll_last,'0000000000') 
			dw_1.setitem(dw_1.getrow(),'lpo_id',ls_tmp_id)	
//			dw_1.setitem(dw_1.getrow(),'lpo_date',datetime(today()))
			
	
		//New/Update  received qnty  update in indent
		for ll_cnt = 1 to dw_2.rowcount()	
			dw_2.setitem(ll_cnt,'lpo_id',ls_tmp_id)		
		next
   	end if		
	  
	if lb_neworder = true then
		Messagebox('Information!','Service Purchase Order No Generated Is ('+ls_tmp_id+')')
	end if
	if dw_1.update(true,false) = 1 then
		if dw_2.update(true,false) = 1 then
			dw_2.resetupdate();
			dw_1.resetupdate();
			commit using sqlca;
			cb_3.enabled = false
			cb_1.enabled = true
			dw_1.reset()
			dw_2.reset()
		else
			rollback using sqlca;
			return 1
		end if
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
	
//	dw_2.update();
//	dw_1.update();
//	commit using sqlca;
//	cb_3.enabled = false
//	dw_1.reset()
//	dw_2.reset()

else
	return
end if 
end event

type cb_2 from commandbutton within w_gtepuf014
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
	dw_1.settaborder('lpo_id',5)
	dw_1.settaborder('lpo_date',7)
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('lpo_desc')
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
	cb_2.text = "&Query"
	dw_1.settaborder('lpo_id',0)
	dw_1.settaborder('lpo_date',0)
   	cb_5.enabled = true
   	cb_7.enabled = true
   	cb_8.enabled = true
   	cb_9.enabled = true
	cb_1.enabled = true	
end if
lb_neworder = false

end event

type cb_1 from commandbutton within w_gtepuf014
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
	dw_1.setitem(dw_1.getrow(),'lpo_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'lpo_entry_dt',datetime(today()))
	dw_1.setcolumn('lpo_date')
else
	IF wf_check_fillcol(dw_2.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'lpo_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'lpo_entry_dt',datetime(today()))
	dw_1.setcolumn('lpo_date')
end if

cb_1.enabled = false
end event

type dw_1 from datawindow within w_gtepuf014
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 14
integer y = 116
integer width = 4261
integer height = 700
integer taborder = 30
string dataobject = "dw_gtepuf014"
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
		dw_1.setitem(newrow,'hopi_entry_by',gs_user)
		dw_1.setitem(newrow,'hopi_entry_dt',datetime(today()))
		dw_1.setcolumn('hopi_desc')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if lb_query = false then
	if lb_neworder = true and dw_2.rowcount() = 0 then
		dw_2.setfocus() 
		dw_2.insertrow(0)
		dw_1.setfocus()
	end if;
	
	if dwo.name = 'lpo_date'   then
			
		select max(lpo_date) into :ld_date from fb_localpurchaseorder;  		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Maximum Purchase Order Date',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		
		if date(ld_date) > date(data) then
			messagebox('Warning!','Purchase Order Date Should Be >= '+string(ld_date,'dd/mm/yyyy')+', Please Check !!!')
			return 1
		end if
		
		if date(data) > today() then
			messagebox('Warning!','Purchase Order Date Should Not Be > Current Date, Please Check !!!')
			return 1
		end if
	end if;	
	
	
	if dwo.name = 'sup_id'  then
		ls_sup_id = data
		
		select SUP_ADD into :ls_temp from fb_supplier  where SUP_ID = :ls_sup_id and ACSUBLEDGER_ID is not null;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error During Select Of Supplier Address',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 100 then
			messagebox('Warning!','Subledger For The Supplier Is Blank, Please Update First !!!')
			rollback using sqlca;
			return 1
		end if	
		
		dw_1.setitem(row,'sup_add',ls_temp)	
	
	end if;	
	
	
	
	dw_1.setitem(row,'lpo_entry_by',gs_user)
	dw_1.setitem(row,'lpo_entry_dt',datetime(today()))
	
	cb_3.enabled = true
end if
	
end event

event rowfocuschanged;if lb_query = false then
	if lb_neworder = false  then
		if dw_1.rowcount() > 0 then
			dw_2.reset()
			dw_2.retrieve(dw_1.getitemstring(dw_1.getrow(),'lpo_id'))
		end if
	end if
end if
end event

