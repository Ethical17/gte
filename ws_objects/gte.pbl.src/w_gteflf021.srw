$PBExportHeader$w_gteflf021.srw
forward
global type w_gteflf021 from window
end type
type cb_4 from commandbutton within w_gteflf021
end type
type cb_1 from commandbutton within w_gteflf021
end type
type cb_3 from commandbutton within w_gteflf021
end type
type cb_2 from commandbutton within w_gteflf021
end type
type dw_1 from datawindow within w_gteflf021
end type
end forward

global type w_gteflf021 from window
integer width = 4283
integer height = 2300
boolean titlebar = true
string title = "(w_gteflf021) Shade Tree Entry"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_4 cb_4
cb_1 cb_1
cb_3 cb_3
cb_2 cb_2
dw_1 dw_1
end type
global w_gteflf021 w_gteflf021

type variables
long ll_ctr, ll_cnt,l_ctr,ll_st_year, ll_end_year,ll_user_level, ll_last, ll_ctr2
string ls_temp,ls_tmp_id,ls_last,ls_count, ls_range_id, ls_section, ls_st_id
boolean lb_neworder, lb_query
double ld_price, ld_range_from, ld_range_to, ld_len_ft, ld_len_in, ld_avg_girth_cm, ld_radius_in, ld_height_in, ld_volume_in, ld_volume_feet
datetime ld_dt, ld_temp
datawindowchild idw_section

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
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
	if (isnull(dw_1.getitemstring(fl_row,'field_id')) or  len(dw_1.getitemstring(fl_row,'field_id'))=0 or &
		isnull(dw_1.getitemstring(fl_row,'section_id')) or  len(dw_1.getitemstring(fl_row,'section_id'))=0 or &
		isnull(dw_1.getitemstring(fl_row,'species_id')) or  len(dw_1.getitemstring(fl_row,'species_id'))=0 or &
		isnull(dw_1.getitemstring(fl_row,'range_id')) or  len(dw_1.getitemstring(fl_row,'range_id'))=0 or &		
		isnull(dw_1.getitemnumber(fl_row,'st_avg_len_ft')) or  dw_1.getitemnumber(fl_row,'st_avg_len_ft')=0 or &	
		isnull(dw_1.getitemnumber(fl_row,'st_mapped_on')) or  dw_1.getitemnumber(fl_row,'st_mapped_on')=0 ) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Divison, Section, Species, Girth Range, Avg. Length(Ft.), Mapped On, Please Check !!!')
		 return -1
	end if
end if
return 1
end function

on w_gteflf021.create
this.cb_4=create cb_4
this.cb_1=create cb_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.cb_4,&
this.cb_1,&
this.cb_3,&
this.cb_2,&
this.dw_1}
end on

on w_gteflf021.destroy
destroy(this.cb_4)
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if
this.tag = Message.StringParm
ll_user_level = long(this.tag)

dw_1.GetChild ("section_id", idw_section)
idw_section.settransobject(sqlca)

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

type cb_4 from commandbutton within w_gteflf021
integer x = 823
integer y = 12
integer width = 265
integer height = 100
integer taborder = 30
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

type cb_1 from commandbutton within w_gteflf021
integer x = 27
integer y = 12
integer width = 265
integer height = 100
integer taborder = 30
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
	dw_1.setitem(dw_1.getrow(),'st_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'st_entry_dt',datetime(today()))
	dw_1.setcolumn('field_id')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'st_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'st_entry_dt',datetime(today()))
	dw_1.setcolumn('field_id')
end if

end event

type cb_3 from commandbutton within w_gteflf021
integer x = 558
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
string text = "&Save"
end type

event clicked;string ls_temp_desc, ls_sm_id

if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'field_id')) or len(dw_1.getitemstring(dw_1.rowcount(),'field_id')) = 0 ) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	
	if lb_neworder = true then		
		for ll_ctr = 1 to dw_1.rowcount() 
			if isnull(dw_1.getitemstring(ll_ctr,'st_id')) then
				ls_section = dw_1.getitemstring(ll_ctr,'section_id')
				select nvl(max(to_number(substr(st_id,-6,6))), 0) into :ll_last from fb_shade_tree where st_id like '%'||:ls_section||'%';
				if sqlca.sqlcode = -1 then
					messagebox('Error','Error occured while selecting serial no. : '+sqlca.sqlerrtext)
					return 1
				end if
				for ll_ctr2 = 1 to dw_1.rowcount()
					if ls_section = dw_1.getitemstring(ll_ctr2,'section_id') then
						ll_last = ll_last + 1
						select lpad(:ll_last,6,'0') into :ls_last from dual;
						ls_st_id = gs_garden_snm + '-' + ls_section + '-' + ls_last
						dw_1.setitem(ll_ctr2, 'st_id', ls_st_id)
					end if
				next
			end if
		next
	end if
	

	if dw_1.update(true,false) = 1 then
		dw_1.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
		dw_1.reset()
		idw_section.SetFilter ("")
		idw_section.settransobject(sqlca)	
		idw_section.retrieve()	
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
else
	return
end if
end event

type cb_2 from commandbutton within w_gteflf021
integer x = 293
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
	lb_neworder = true
	if dw_1.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	dw_1.reset()
	lb_query = true
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('field_id')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve()
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	lb_query = false
	cb_1.enabled = true
end if
end event

type dw_1 from datawindow within w_gteflf021
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 120
integer width = 4197
integer height = 2052
integer taborder = 30
string dataobject = "dw_gteflf021"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

event key_down;string ls_temp_desc

if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() and dw_1.rowcount() > 1 then	
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'st_entry_by',gs_user)
		dw_1.setitem(newrow,'st_entry_dt',datetime(today()))
		
		dw_1.setcolumn('field_id')
	end if
 end if
end if
end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;//if lb_neworder = true then
//	IF KeyDown(KeyF6!) THEN
//		dw_1.deleterow(dw_1.rowcount())
//	end if
//	if dw_1.rowcount() = 0 then
//		cb_3.enabled = false
//	end if
//end if
//
end event

event ue_keydwn;//if lb_neworder = true then
//	IF KeyDown(KeyF6!) THEN
//		dw_1.deleterow(dw_1.rowcount())
//	end if
//	if dw_1.rowcount() = 0 then
//		cb_3.enabled = false
//	end if
//end if
//
end event

event itemchanged;if lb_query = false then
	if dwo.name = "field_id" then
		idw_section.SetFilter ("field_id = '"+trim(data)+"'")
		idw_section.settransobject(sqlca)	
		idw_section.retrieve()	
		setnull(ls_temp)
		dw_1.setitem(row, 'section_id', ls_temp)
	end if
	
	if dwo.name = "range_id" then
		ls_range_id = data;
		select range_from, range_to into :ld_range_from, :ld_range_to from fb_shadetreegirthrange where range_id = :ls_range_id;
		if sqlca.sqlcode = -1 then
			messagebox('Error','Error occured while select from, to from range master : '+sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 100 then
			messagebox('Warning','No records found in range master')
			return 1
		end if	
	else
		ls_range_id = dw_1.getitemstring(row,'range_id');
		if not isnull(ls_range_id) then
			select range_from, range_to into :ld_range_from, :ld_range_to from fb_shadetreegirthrange where range_id = :ls_range_id;
			if sqlca.sqlcode = -1 then
				messagebox('Error','Error occured while select from, to from range master : '+sqlca.sqlerrtext)
				return 1
			elseif sqlca.sqlcode = 100 then
				messagebox('Warning','No records found in range master')
				return 1
			end if	
		end if
	end if
	
	if dwo.name = 'st_avg_len_ft' then
		ld_len_ft = double(data)
		if ld_len_ft <= 0 then
			messagebox('Warning','Avg. length (feet) can not be less than or equal to 0')
			return 1
		end if
	else
		ld_len_ft = dw_1.getitemnumber(row,'st_avg_len_ft')
	end if
	
	if dwo.name = 'st_avg_len_in' then
		ld_len_in = double(data)
		if ld_len_in >= 12 then
			messagebox('Warning','Avg. length (inch) can not be greater than or equal to 12')
			return 1
		end if
	else
		ld_len_in = dw_1.getitemnumber(row,'st_avg_len_in')
	end if
	
	if dwo.name = "range_id" or dwo.name = 'st_avg_len_ft' or dwo.name = 'st_avg_len_in' then
		if isnull(ld_range_from) then ld_range_from = 0;
		if isnull(ld_range_to) then ld_range_to = 0;
		if isnull(ld_len_ft) then ld_len_ft = 0;
		if isnull(ld_len_in) then ld_len_in = 0;
		ld_avg_girth_cm = (ld_range_from + ld_range_to) / 2
		ld_radius_in = (ld_avg_girth_cm / pi(2)) / 2.54
		ld_height_in = (ld_len_ft * 12) + ld_len_in
		ld_volume_in = pi(ld_radius_in * ld_radius_in * ld_height_in)
		ld_volume_feet = ld_volume_in / 1728
		dw_1.setitem(row,'st_volume',ld_volume_feet)
	end if
	
	if dwo.name = 'st_mapped_on' then
		select to_date(:data,'YYYYMM') into :ld_temp from dual;
		if sqlca.sqlcode = -1 then
			messagebox('Error','Error occured while validating year month : '+sqlca.sqlerrtext)
			return 1
		end if
	end if
	
	dw_1.setitem(row,'st_entry_by',gs_user)
	dw_1.setitem(row,'st_entry_dt',datetime(today()))
	cb_3.enabled = true
end if	


if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if

end event

