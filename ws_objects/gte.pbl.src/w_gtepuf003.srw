$PBExportHeader$w_gtepuf003.srw
forward
global type w_gtepuf003 from window
end type
type rb_2 from radiobutton within w_gtepuf003
end type
type rb_1 from radiobutton within w_gtepuf003
end type
type cb_10 from commandbutton within w_gtepuf003
end type
type cb_8 from commandbutton within w_gtepuf003
end type
type cb_7 from commandbutton within w_gtepuf003
end type
type cb_9 from commandbutton within w_gtepuf003
end type
type cb_4 from commandbutton within w_gtepuf003
end type
type cb_3 from commandbutton within w_gtepuf003
end type
type cb_2 from commandbutton within w_gtepuf003
end type
type cb_1 from commandbutton within w_gtepuf003
end type
type dw_1 from datawindow within w_gtepuf003
end type
type gb_1 from groupbox within w_gtepuf003
end type
end forward

global type w_gtepuf003 from window
integer width = 3639
integer height = 2116
boolean titlebar = true
string title = "(W_gtepuf003) Supplier"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
rb_2 rb_2
rb_1 rb_1
cb_10 cb_10
cb_8 cb_8
cb_7 cb_7
cb_9 cb_9
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_gtepuf003 w_gtepuf003

type variables
long ll_ctr, ll_cnt,ll_user_level
string ls_temp,ls_del_ind,ls_mac_id,ls_tmp_id, ls_name,ls_add, ls_phone, ls_fax, ls_mobile, ls_email, ls_count, ls_last,ls_gstin
string ls_contactp,ls_contacno,ls_cst,ls_lst,ls_website,ls_ind,ls_type
boolean lb_neworder, lb_query

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fl_sup_nm, string fl_sup_add)
public function integer wf_checkduplicate_field (string fl_field, string fl_value, string fl_message)
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

public function integer wf_check_fillcol (integer fl_row);if dw_1.rowcount() > 0 and fl_row > 0 then
	if (isnull(dw_1.getitemstring(fl_row,'sup_name')) or  len(dw_1.getitemstring(fl_row,'sup_name'))=0 or &
		 isnull(dw_1.getitemstring(fl_row,'sup_contactperson')) or  len(dw_1.getitemstring(fl_row,'sup_contactperson'))=0 or &
		 isnull(dw_1.getitemstring(fl_row,'sup_city')) or  len(dw_1.getitemstring(fl_row,'sup_city'))=0 or &
		 isnull(dw_1.getitemstring(fl_row,'sup_state')) or  len(dw_1.getitemstring(fl_row,'sup_state'))=0 or &
		 isnull(dw_1.getitemnumber(fl_row,'sup_pin')) or  dw_1.getitemnumber(fl_row,'sup_pin')=0 or &
		 isnull(dw_1.getitemstring(fl_row,'sup_type')) or  len(dw_1.getitemstring(fl_row,'sup_type'))=0 or &
		 isnull(dw_1.getitemstring(fl_row,'sup_registered')) or  len(dw_1.getitemstring(fl_row,'sup_registered'))=0 or &
		 isnull(dw_1.getitemstring(fl_row,'sup_add')) or  len(dw_1.getitemstring(fl_row,'sup_add'))=0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Supplier Name, Type, Registered, City, State,Pin,Address, Contact Person Name, Please Check !!!')
		 return -1
	elseif ((dw_1.getitemstring(fl_row,'sup_type') = 'LOCAL') and (isnull(dw_1.getitemstring(fl_row,'acsubledger_id')) or  len(dw_1.getitemstring(fl_row,'acsubledger_id'))=0)) then
		messagebox('Warning: One Of The Following Fields Are Blank','In case of Supplier Type LOCAL Supplier Subledger Should Not be Blank !!!')
		 return -1
	end if
end if
return 1
end function

public function integer wf_check_duplicate_rec (string fl_sup_nm, string fl_sup_add);long fl_row
string ls_sup_nm1, ls_sup_add1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_sup_nm1 = dw_1.getitemstring(fl_row,'sup_name')
		ls_sup_add1 = dw_1.getitemstring(fl_row,'sup_add')
		
		if ls_sup_nm1 = fl_sup_nm and ls_sup_add1 = fl_sup_add then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_checkduplicate_field (string fl_field, string fl_value, string fl_message);long fl_row
string  ls_value

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_value = dw_1.getitemstring(fl_row,''+fl_field+'')
		
		if ls_value = fl_value then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate "+fl_message +" At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtepuf003.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_10=create cb_10
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_9=create cb_9
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.rb_2,&
this.rb_1,&
this.cb_10,&
this.cb_8,&
this.cb_7,&
this.cb_9,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.gb_1}
end on

on w_gtepuf003.destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_10)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_9)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
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
lb_query = false	
lb_neworder = false

this.tag = Message.StringParm
ll_user_level = long(this.tag)


if ll_user_level=1 then
	cb_3.enabled=true
else
	cb_3.enabled=false
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

type rb_2 from radiobutton within w_gtepuf003
integer x = 795
integer y = 32
integer width = 219
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "NEW"
boolean checked = true
end type

type rb_1 from radiobutton within w_gtepuf003
integer x = 567
integer y = 32
integer width = 219
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "OLD"
end type

type cb_10 from commandbutton within w_gtepuf003
integer x = 3035
integer y = 24
integer width = 142
integer height = 80
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<<"
end type

event clicked;if dw_1.rowcount() > 0 then
//	dw_1.setcolumn('ind1')
	dw_1.ScrolltoRow(1)
end if
end event

type cb_8 from commandbutton within w_gtepuf003
integer x = 3173
integer y = 24
integer width = 142
integer height = 80
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "<"
end type

event clicked;if dw_1.rowcount() > 0 then
//	dw_1.setcolumn('ind1')
	dw_1.ScrollPriorRow()
end if
end event

type cb_7 from commandbutton within w_gtepuf003
integer x = 3310
integer y = 24
integer width = 142
integer height = 80
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
end type

event clicked;if dw_1.rowcount() > 0 then
//	dw_1.setcolumn('ind1')
	dw_1.ScrollnextRow()
end if
end event

type cb_9 from commandbutton within w_gtepuf003
integer x = 3447
integer y = 24
integer width = 142
integer height = 80
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;if dw_1.rowcount() > 0 then
//	dw_1.setcolumn('ind1')
	dw_1.ScrolltoRow(dw_1.rowcount())
end if
end event

type cb_4 from commandbutton within w_gtepuf003
integer x = 1339
integer y = 20
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

type cb_3 from commandbutton within w_gtepuf003
integer x = 288
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
boolean enabled = false
string text = "&Save"
end type

event clicked;
if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'sup_name')) or len(dw_1.getitemstring(dw_1.rowcount(),'sup_name'))=0) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	if dw_1.rowcount() > 0 then
		IF wf_check_fillcol(dw_1.getrow()) = -1 THEN 
			return 1
		end if
	end if
	
	if lb_neworder = true then
		select nvl(MAX(SUP_ID),0) into :ls_last from fb_supplier where sup_id like 'S%';
		ls_last = right(ls_last,5)
		ll_cnt = long(ls_last)
	end if
	
	if dw_1.rowcount() > 0 then
		for ll_ctr = 1 to dw_1.rowcount( ) 
			if lb_neworder = true then
				
				
				ls_type=dw_1.getitemstring(ll_ctr,'sup_type')
				
				if ls_type <>'GLS' then
					messagebox('Error ..!',' Other than Green Leaf Cannot be Entered By garden')
					return;
				end if
				
				
				ls_add = dw_1.getitemstring(ll_ctr,'sup_add')
				ls_name = dw_1.getitemstring(ll_ctr,'sup_name')
							
				select distinct 'x' into :ls_temp from fb_supplier where upper(sup_name) = upper(:ls_name) and upper(sup_add) = upper(:ls_add);
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Supplier Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode  = 0 then
					messagebox('Warning!','Supplier Already Exists, Please Check !!!')
					return 1
				end if	
				
				ll_cnt = ll_cnt + 1
				select lpad(:ll_cnt,5,'0') into :ls_count from dual;
				ls_tmp_id = 'SUP'+ls_count
				dw_1.setitem(ll_ctr,'sup_id',ls_tmp_id)
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

type cb_2 from commandbutton within w_gtepuf003
integer x = 1056
integer y = 24
integer width = 265
integer height = 96
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Query"
end type

event clicked;
if rb_1.checked then 
	ls_ind='O'
else
	ls_ind='N'
End if	
cb_3.enabled=false
if cb_2.text = "&Query" then
	lb_neworder = true
	if dw_1.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	dw_1.reset()
	dw_1.settaborder('sup_id',5)
	lb_query = true
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('sup_id')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.settaborder('sup_id',0)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user,ls_ind)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtepuf003
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
end if

dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

cb_3.enabled=true

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'sup_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'sup_entry_dt',datetime(today()))
	dw_1.setcolumn('sup_name')
	if gs_garden_snm <> 'KG' then
		dw_1.setitem(dw_1.getrow(),'sup_type','GLS')
		dw_1.settaborder('sup_type',0)
	end if
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'sup_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'sup_entry_dt',datetime(today()))
	dw_1.setcolumn('sup_name')
end if


end event

type dw_1 from datawindow within w_gtepuf003
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 14
integer y = 128
integer width = 3575
integer height = 1828
integer taborder = 30
string dataobject = "dw_gtepuf003"
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
		dw_1.setitem(newrow,'sup_entry_by',gs_user)
		dw_1.setitem(newrow,'sup_entry_dt',datetime(today()))
		dw_1.setcolumn('sup_name')
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
	if dw_1.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event ue_keydwn;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_1.deleterow(dw_1.rowcount())
	end if
	if dw_1.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event itemchanged;if lb_query = false then
	if dwo.name = 'sup_name'  then
		ls_name = data
		
		if f_check_initial_space(ls_name) = -1 then return 1
		
		if  f_check_alphanumeric(ls_name) = -1 then return 1
		
	//	if f_check_string_sp(ls_name) = -1 then return 1
		
	end if
	
	if dwo.name = 'sup_add'  then
		ls_add = data
		ls_name = dw_1.getitemstring(row,'sup_name')
		
		if f_check_initial_space(ls_add) = -1 then return 1
		
		//if f_check_string(ls_add) = -1 then return 1
	
		if  wf_check_duplicate_rec(ls_name, ls_add) = -1 then return 1
		
		select distinct 'x' into :ls_temp from fb_supplier where upper(sup_name) = upper(:ls_name) and upper(sup_add) = upper(:ls_add);
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Supplier Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox('Warning!','Supplier Already Exists, Please Check !!!')
			return 1
		end if
		
	end if
	
	if dwo.name = 'sup_telephone' then
		ls_phone = data
		if f_check_initial_space(ls_add) = -1 then return 1
		if f_check_numeric_sp(ls_phone) = -1 then return 1
	end if
	
	if dwo.name = 'sup_fax' then
		ls_fax = data
		if f_check_initial_space(ls_add) = -1 then return 1
		if f_check_numeric_sp(ls_fax) = -1 then return 1
	end if
	
	if dwo.name = 'sup_mobile' then
		ls_mobile = data
		if f_check_initial_space(ls_add) = -1 then return 1
		if f_check_numeric_sp(ls_mobile) = -1 then return 1
	end if
	
	if dwo.name = 'sup_email' then
		ls_email = data
		if f_check_initial_space(ls_add) = -1 then return 1
		if f_check_email(ls_email) = -1 then return 1
	end if
	
	if dwo.name = 'sup_pan' then
		if f_check_initial_space(data) = -1 then return 1
		//if f_check_alphanumeric(data) = -1 then return 1
		if f_check_pan(data) = -1 then return 1
		if wf_checkduplicate_field('sup_pan',data,'PAN No') = -1 then return 1
		
		select distinct sup_name into :ls_temp from fb_supplier where SUP_PAN = :data;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Supplier PAN No',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox('Warning!','PAN No Already Assigned To '+ls_temp+' Supplier , Please Check !!!')
			return 1
		end if
	end if		
	
	if dwo.name = 'sup_contactperson' then
		ls_contactp = data
		if f_check_initial_space(ls_contactp) = -1 then return 1
		if f_check_string(ls_contactp) = -1 then return 1
	end if
	
	if dwo.name = 'sup_contactno' then
		ls_contacno = data
		if f_check_initial_space(ls_contacno) = -1 then return 1
		if f_check_numeric_sp(ls_contacno) = -1 then return 1
	end if
	
	if dwo.name = 'sup_lsaletaxno' then
		ls_lst = data
		if f_check_initial_space(ls_lst) = -1 then return 1
		if f_check_string_sp(ls_lst) = -1 then return 1
	end if
	
	if dwo.name = 'sup_csaletaxno' then
		ls_cst = data
		if f_check_initial_space(ls_cst) = -1 then return 1
		if f_check_string_sp(ls_cst) = -1 then return 1
	end if
	
	if dwo.name = 'sup_website' then
		ls_website = data
		if f_check_initial_space(ls_website) = -1 then return 1
		//if f_check_string(ls_website) = -1 then return 1
	end if
	
	if dwo.name='sup_gstnno' then
		ls_gstin=data
		if len(ls_gstin)<>15 then return 1
		IF match(mid(ls_gstin,1,2),"^[0-9][0-9]$")=FALSE THEN return 1
		if match(mid(ls_gstin,13,1),"^[0-9]$")= FALSE THEN return 1
		//if mid(ls_gstin,14,1)<>'Z'  then return 1 
		if match(mid(ls_gstin,3,5),"^[a-z-A-Z*][a-z-A-Z*][a-z-A-Z*][a-z-A-Z*][a-zA-Z1-9*]$")= FALSE THEN return 1
		if match(mid(ls_gstin,8,4),"^[0-9][0-9][0-9][0-9]$")= FALSE THEN return 1
		if match(mid(ls_gstin,12,1),"^[a-z-A-Z*]$")= FALSE THEN return 1
	end if
	
	if dwo.name = 'sup_bank_name' then
		ls_contactp = data
		if f_check_initial_space(ls_contactp) = -1 then return 1
		if f_check_string(ls_contactp) = -1 then return 1
	end if
	if dwo.name = 'sup_bank_location' then
		ls_contactp = data
		if f_check_initial_space(ls_contactp) = -1 then return 1
		if f_check_string(ls_contactp) = -1 then return 1
	end if
	if dwo.name = 'sup_bank_ifsc_cd' then
		ls_contactp = data
		if f_check_initial_space(ls_contactp) = -1 then return 1
	end if
	if dwo.name = 'sup_bank_acno' then
		ls_contacno = data
		if f_check_initial_space(ls_contacno) = -1 then return 1
	//	if f_check_numeric_sp(ls_contacno) = -1 then return 1
	end if
	
	dw_1.setitem(row,'sup_entry_by',gs_user)
	dw_1.setitem(row,'sup_entry_dt',datetime(today()))
	if ll_user_level=1 then
		cb_3.enabled=true
	else
		cb_3.enabled=false
	end if

end if

//if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
//	dw_1.insertrow(0)
//end if


end event

event updatestart;//
integer li_column, li_row // variables to hold the column index and row number
string ls_old_value, ls_new_value // variables to hold the old and new values
long ll_coumnid
string ls_columnname,ls_unique_id




// Loop through all rows in the DataWindow control
FOR li_row = 1 TO This.RowCount()
//SELECT max(COLUMN_ID) COLUMN_id, into :ll_cnt  FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_teamadeproduct') and column_id not in (9,10);
////ll_no =  
//    // Loop through all data columns in the DataWindow control
//    FOR li_column = 1 TO ll_cnt
//
//        // Get the old value for the data column
//        ls_old_value = dw_1.GetItemString(li_row, li_column, Primary!, true)
//
//        // Get the new value for the data column
//        ls_new_value = This.GetItemString(li_row, li_column)
//
//        // Compare the old and new values
//        if ls_old_value <> ls_new_value then
//            // Code to execute if the values are different
//				
//				insert into fb_log(OBJECT, SUBOBJECT, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
//				('fb_teamadeproduct','fb_teamadeproduct','U',:li_column,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
//				if sqlca.sqlcode = -1 then
//							messagebox("SQL Error : While Inserting Into LOg Table ",SQLCA.SQLErrtext,Information!)
//							rollback using sqlca;
//							return -1 
//				end if		
//				
//				
//				
//        end if
//
//    NEXT

DECLARE c1 CURSOR FOR  

SELECT COLUMN_ID,COLUMN_Name FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_supplier');

close c1;
open c1;
if sqlca.sqlcode = -1 then
				messagebox('Error', 'Error occured while opening cursor c1 : '+sqlca.sqlerrtext)
				rollback using sqlca;
				return 1;
		
elseIF sqlca.sqlcode = 0 THEN
	setnull(ll_coumnid);setnull(ls_columnname);
	fetch c1 into :ll_coumnid,:ls_columnname;

		do while sqlca.sqlcode <> 100
 			// Get the old value for the data column
			       ls_old_value = dw_1.GetItemString(li_row, ll_coumnid, Primary!, true)
			 // Get the new value for the data column
			       ls_new_value = This.GetItemString(li_row, ll_coumnid)
			
			// Get the unique Value of Row
			
			ls_unique_id=dw_1.GetItemString(li_row, 1, Primary!, true)
					 
					 
					 if ls_old_value <> ls_new_value then
						insert into fb_log(table_name, Unique_key, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
												('fb_supplier',:ls_unique_id,'U',:ls_columnname,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
							if sqlca.sqlcode = -1 then
								messagebox("SQL Error : While Inserting Into Log Table ",SQLCA.SQLErrtext,Information!)
								rollback using sqlca;
								return -1 
							 end if
						end if
					 
					 
					 
		setnull(ll_coumnid);setnull(ls_columnname);

	fetch c1 into :ll_coumnid,:ls_columnname;
	loop
end if	
NEXT
close c1;
end event

type gb_1 from groupbox within w_gtepuf003
integer x = 558
integer y = 16
integer width = 466
integer height = 96
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
end type

