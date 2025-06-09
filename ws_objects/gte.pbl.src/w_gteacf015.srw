$PBExportHeader$w_gteacf015.srw
forward
global type w_gteacf015 from window
end type
type em_1 from editmask within w_gteacf015
end type
type st_1 from statictext within w_gteacf015
end type
type cb_4 from commandbutton within w_gteacf015
end type
type cb_3 from commandbutton within w_gteacf015
end type
type cb_2 from commandbutton within w_gteacf015
end type
type cb_1 from commandbutton within w_gteacf015
end type
type dw_1 from datawindow within w_gteacf015
end type
end forward

global type w_gteacf015 from window
integer width = 4521
integer height = 2448
boolean titlebar = true
string title = "(w_gteacf015) Statutory Payment / Dues Return"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
em_1 em_1
st_1 st_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteacf015 w_gteacf015

type variables
long ll_ctr, ll_cnt,ll_rank,ll_user_level,ll_yrmn, ll_so,ll_sso
string ls_temp,ls_del_ind,ls_tpc_id,ls_pro_id,ls_tmp_id,ls_count,ls_last, ls_grade, ls_type, ls_sub_cat, ls_cat,ls_desc, ls_sub_desc
boolean lb_neworder, lb_query

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_tpc_id, string fs_name, string fs_sub_cat, string fs_type)
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
	if (isnull(dw_1.getitemnumber(fl_row,'sp_so')) or  dw_1.getitemnumber(fl_row,'sp_so')=0 or &
		 isnull(dw_1.getitemstring(fl_row,'sp_description')) or  len(dw_1.getitemstring(fl_row,'sp_description'))=0 or &
		 isnull(dw_1.getitemnumber(fl_row,'sp_subso')) or  dw_1.getitemnumber(fl_row,'sp_subso') = 0 ) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Main So, Particular, Sub So, Please Check !!!')
		 return -1
	end if
end if
return 1

end function

public function integer wf_check_duplicate_rec (string fs_tpc_id, string fs_name, string fs_sub_cat, string fs_type);long fl_row
string ls_tpc_id1,ls_name1, ls_sub_cat1, ls_type1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_tpc_id1 = dw_1.getitemstring(fl_row,'tpc_id')
		ls_name1  = dw_1.getitemstring(fl_row,'tmp_name')
		ls_sub_cat1  = dw_1.getitemstring(fl_row,'tmp_sub_category')
		ls_type1  = dw_1.getitemstring(fl_row,'tmp_type')
		
		if ls_tpc_id1 = fs_tpc_id  and  ls_name1 = fs_name and ls_sub_cat1 = ls_sub_cat1 and fs_type = ls_type1 then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1



end function

on w_gteacf015.create
this.em_1=create em_1
this.st_1=create st_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.em_1,&
this.st_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteacf015.destroy
destroy(this.em_1)
destroy(this.st_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if

//dw_1.modify("t_co.text = '"+gs_co_name+"'")

this.tag = Message.StringParm
ll_user_level = long(this.tag)

em_1.text = string(today(),'YYYYMM')
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

type em_1 from editmask within w_gteacf015
integer x = 325
integer y = 24
integer width = 247
integer height = 76
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
string mask = "000000"
end type

type st_1 from statictext within w_gteacf015
integer x = 23
integer y = 32
integer width = 302
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year Month"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_gteacf015
integer x = 1390
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

type cb_3 from commandbutton within w_gteacf015
integer x = 1125
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

IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'sp_description')) or len(dw_1.getitemstring(dw_1.rowcount(),'sp_description'))=0) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF
IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

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

type cb_2 from commandbutton within w_gteacf015
integer x = 859
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

event clicked;if isnull(em_1.text) or len(em_1.text) = 0 or em_1.text = '000000' then
	messagebox('Warning!','Please Enter The Year Month First  !!!')
	return 1
end if

ll_yrmn = long(em_1.text)

if cb_2.text = "&Query" then
	lb_neworder = true
	if dw_1.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	dw_1.reset()
	//dw_1.settaborder('tmp_name',10)
	lb_query = true
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('sp_so')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(ll_yrmn)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gteacf015
integer x = 594
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
if isnull(em_1.text) or len(em_1.text) = 0 or em_1.text = '000000' then
	messagebox('Warning!','Please Enter The Year Month First  !!!')
	return 1
end if

ll_yrmn = long(em_1.text)

select distinct 'x' into :ls_temp from fb_statutory_paydue where SP_YEARMONTH = (:ll_yrmn + 1);
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Next Month Details',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode = 0 then
	messagebox('Warning!','Next Month Data Already Exists, Please check !!!')
	return 1
elseif sqlca.sqlcode = 100 then
	select distinct 'x' into :ls_temp	from fb_statutory_paydue where SP_YEARMONTH = (:ll_yrmn);
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Current Month Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
		messagebox('Warning!','Current Month Data Already Exists, You Can Modify By clicking On Query/Run !!!')
		return 1
	elseif sqlca.sqlcode = 100 then
		select distinct 'x' into :ls_temp	from fb_statutory_paydue where SP_YEARMONTH = (:ll_yrmn - 1);
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Previous Month Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 0 then
			DECLARE c1 CURSOR FOR  
			select distinct SP_SO,SP_DESCRIPTION,  SP_SUBSO, SP_SUBDESCRIPTION from fb_statutory_paydue where SP_YEARMONTH = (:ll_yrmn - 1) order by SP_SO,SP_SUBSO;		
			open c1;
			IF sqlca.sqlcode = 0 THEN
				fetch c1 into :ll_so,:ls_desc,:ll_sso,:ls_sub_desc;
				
				do while sqlca.sqlcode <> 100
					dw_1.scrolltorow(dw_1.insertrow(0))
					dw_1.setitem(dw_1.getrow(),'sp_so',ll_so)
					dw_1.setitem(dw_1.getrow(),'sp_yearmonth',ll_yrmn)
					dw_1.setitem(dw_1.getrow(),'sp_description',ls_desc)
					dw_1.setitem(dw_1.getrow(),'sp_subso',ll_sso)
					dw_1.setitem(dw_1.getrow(),'sp_subdescription',ls_sub_desc)
					dw_1.setitem(dw_1.getrow(),'sp_entry_by',gs_user)
					dw_1.setitem(dw_1.getrow(),'sp_entry_dt',datetime(today()))
					fetch c1 into :ll_so,:ls_desc,:ll_sso,:ls_sub_desc;
				loop
			END IF
			close c1;
			dw_1.setfocus()
			dw_1.scrolltorow(1)
			dw_1.setcolumn('sp_so')		
		elseif sqlca.sqlcode = 100 then
			if dw_1.rowcount() = 0 then
				dw_1.scrolltorow(dw_1.insertrow(0))
				dw_1.setfocus()
				dw_1.setitem(dw_1.getrow(),'sp_yearmonth',ll_yrmn)
				dw_1.setitem(dw_1.getrow(),'sp_entry_by',gs_user)
				dw_1.setitem(dw_1.getrow(),'sp_entry_dt',datetime(today()))
				dw_1.setcolumn('sp_so')
			else
				IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
					return 1
				END IF
				dw_1.scrolltorow(dw_1.insertrow(0))
				dw_1.setfocus()
				dw_1.setitem(dw_1.getrow(),'sp_yearmonth',ll_yrmn)
				dw_1.setitem(dw_1.getrow(),'sp_entry_by',gs_user)
				dw_1.setitem(dw_1.getrow(),'sp_entry_dt',datetime(today()))
				dw_1.setcolumn('sp_so')
			end if			
		end if		
	end if
end if

lb_neworder = true
lb_query = false




end event

type dw_1 from datawindow within w_gteacf015
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 116
integer width = 4457
integer height = 2052
integer taborder = 30
string dataobject = "dw_gteacf015"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
 end if
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'sp_yearmonth',dw_1.getitemnumber(currentrow,'sp_yearmonth'))
		dw_1.setitem(newrow,'sp_so',dw_1.getitemnumber(currentrow,'sp_so'))
		dw_1.setitem(newrow,'sp_description',dw_1.getitemstring(currentrow,'sp_description'))
		dw_1.setitem(newrow,'sp_entry_by',gs_user)
		dw_1.setitem(newrow,'sp_entry_dt',datetime(today()))
		dw_1.setcolumn('sp_so')
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
//	if dwo.name = 'tpc_id'  then
//		ls_sp_id = data
//	
//		if f_check_initial_space(ls_sp_id) = -1 then return 1
//		if f_check_special_char(ls_sp_id) = -1 then return 1
//			
//	end if
//	
//	if dwo.name = 'sp_name'  then
//		ls_grade = data	
//		if f_check_initial_space(ls_grade) = -1 then return 1		
//		if f_check_string_sp(ls_grade) = -1 then return 1
//		if f_check_special_char(ls_grade) = -1 then return 1
//		dw_1.setitem(row,'sp_manid',data)
//	end if

	dw_1.setitem(row,'sp_entry_by',gs_user)
	dw_1.setitem(row,'sp_entry_dt',datetime(today()))
	cb_3.enabled = true
end if
	
if dw_1.getrow() = dw_1.rowcount() then
	dw_1.insertrow(0)
end if

end event

