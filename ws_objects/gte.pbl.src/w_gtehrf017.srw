$PBExportHeader$w_gtehrf017.srw
forward
global type w_gtehrf017 from window
end type
type st_1 from statictext within w_gtehrf017
end type
type em_1 from editmask within w_gtehrf017
end type
type cb_4 from commandbutton within w_gtehrf017
end type
type cb_3 from commandbutton within w_gtehrf017
end type
type cb_2 from commandbutton within w_gtehrf017
end type
type cb_1 from commandbutton within w_gtehrf017
end type
type dw_1 from datawindow within w_gtehrf017
end type
end forward

global type w_gtehrf017 from window
integer width = 2939
integer height = 2144
boolean titlebar = true
string title = "(w_gtehrf017) Executive PF Entry"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_1 st_1
em_1 em_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtehrf017 w_gtehrf017

type variables
long ll_ctr, ll_cnt,ll_st_year,ll_user_level,ll_yrmn
string ls_temp,ls_last,ls_pfno
datetime ld_date
double ld_wages,ld_epf
boolean lb_neworder, lb_query
datawindowchild idw_emp
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (long fl_yrmn, string fl_pfno)
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
	if (	 isnull(dw_1.getitemnumber(fl_row,'ef_yearmonth')) or dw_1.getitemnumber(fl_row,'ef_yearmonth') = 0 or &
		 isnull(dw_1.getitemstring(fl_row,'ef_pfno')) or len(dw_1.getitemstring(fl_row,'ef_pfno')) = 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'ef_wages')) or dw_1.getitemnumber(fl_row,'ef_wages') = 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'ef_epf')) or dw_1.getitemnumber(fl_row,'ef_epf') = 0) then
			messagebox('Warning: One Of The Following Fields Are Blank','Year Month, PF No, Salary, EPF , Please Check !!!')
			return -1
	end if
end if
return 1

end function

public function integer wf_check_duplicate_rec (long fl_yrmn, string fl_pfno);long fl_row, ll_yrmn1
string ls_pfno1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ll_yrmn1  = dw_1.getitemnumber(fl_row,'ef_yearmonth')
		ls_pfno1  = dw_1.getitemstring(fl_row,'ef_pfno')
			
		if ll_yrmn1 = fl_yrmn and ls_pfno1 = fl_pfno then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1



end function

on w_gtehrf017.create
this.st_1=create st_1
this.em_1=create em_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.em_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtehrf017.destroy
destroy(this.st_1)
destroy(this.em_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false
//dw_1.modify("t_co.text = '"+gs_co_name+"'")
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if

this.tag = Message.StringParm
ll_user_level = long(this.tag)

dw_1.GetChild ("emp_id", idw_emp)
idw_emp.settransobject(sqlca)		
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

type st_1 from statictext within w_gtehrf017
integer x = 14
integer y = 20
integer width = 297
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

type em_1 from editmask within w_gtehrf017
integer x = 311
integer y = 8
integer width = 270
integer height = 88
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
maskdatatype maskdatatype = datemask!
string mask = "YYYYMM"
boolean dropdowncalendar = true
end type

type cb_4 from commandbutton within w_gtehrf017
integer x = 1413
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

type cb_3 from commandbutton within w_gtehrf017
integer x = 1147
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

IF (isnull(dw_1.getitemnumber(dw_1.rowcount(),'ef_yearmonth')) or len(string(dw_1.getitemnumber(dw_1.rowcount(),'ef_yearmonth'))) = 0) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	if dw_1.rowcount() > 0 then
		if wf_check_fillcol(dw_1.getrow()) = -1 then return 1
	end if

	
	for ll_ctr = dw_1.rowcount() to 1 step -1
		if dw_1.getitemstring(ll_ctr,'del_flag') = 'Y' then
			dw_1.deleterow(ll_ctr)
		end if
	next	
	
	
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

type cb_2 from commandbutton within w_gtehrf017
integer x = 882
integer width = 265
integer height = 100
integer taborder = 30
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
	dw_1.setcolumn('ef_yearmonth')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtehrf017
integer x = 617
integer width = 265
integer height = 100
integer taborder = 20
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

if isnull(em_1.text) or len(em_1.text) = 0 or double(em_1.text) <= 0 then
	messagebox('Warning!','Rate Should Be > 0, Please Check !!!')
	return 1
end if

if left(em_1.text,4) <> string(today(),'YYYY') then
	messagebox('warning!','Year Should be Current Year, Please Check !!!')
	return 1
elseif long(right(em_1.text,2)) < 1 or long(right(em_1.text,2)) > 12 then
	messagebox('warning!','Month Should be Between (1 To 12), Please Check !!!')
	return 1			
end if

ll_yrmn = long(em_1.text)

dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

select distinct 'x' into :ls_temp from fb_executivepf where ef_YEARMONTH = :ll_yrmn - 1;
if sqlca.sqlcode = -1 then 
	messagebox('Error','Error During Fetching Data'+sqlca.sqlerrtext);
	return 1
elseif  sqlca.sqlcode = 0 then
	
	declare c1 cursor for 
	select   ef_PFNO, ef_wages, ef_epf, ef_jobleavingdt from fb_executivepf 
	where ef_YEARMONTH = :ll_yrmn - 1;
	
	open c1;   
	
	if sqlca.sqlcode = -1 then 
		messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
		rollback using sqlca; 
		return 1; 
	else 
		setnull(ls_pfno);ld_wages = 0; ld_epf = 0; setnull(ld_date)
		fetch c1 into :ls_pfno,:ld_wages, :ld_epf, :ld_date;
		if sqlca.sqlcode = -1 then 
			messagebox('Error','Error During Fetching Data'+sqlca.sqlerrtext);
			return 1
		end if;
		do while sqlca.sqlcode <> 100     
				dw_1.scrolltorow(dw_1.insertrow(0))
				dw_1.setitem(dw_1.getrow(),'ef_YEARMONTH',ll_yrmn)
				dw_1.setitem(dw_1.getrow(),'ef_PFNO',ls_pfno)
				dw_1.setitem(dw_1.getrow(),'ef_wages',ld_wages)
				dw_1.setitem(dw_1.getrow(),'ef_epf',ld_epf)
				dw_1.setitem(dw_1.getrow(),'ef_jobleavingdt',ld_date)
				dw_1.setitem(dw_1.getrow(),'ef_entry_by',gs_user)
				dw_1.setitem(dw_1.getrow(),'ef_entry_dt',datetime(today()))
	
		setnull(ls_pfno);ld_wages = 0; ld_epf = 0; setnull(ld_date)
		fetch c1 into :ls_pfno,:ld_wages, :ld_epf, :ld_date;
			  
	  loop;
	close c1;  
	end if;	
	setpointer(arrow!)
elseif  sqlca.sqlcode = 100 then
	if dw_1.rowcount() = 0 then
		dw_1.scrolltorow(dw_1.insertrow(0))
		dw_1.setfocus()
		dw_1.setitem(dw_1.getrow(),'ef_entry_by',gs_user)
		dw_1.setitem(dw_1.getrow(),'ef_entry_dt',datetime(today()))
		dw_1.setcolumn('ef_yearmonth')
	else
		IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
			return 1
		END IF
		dw_1.scrolltorow(dw_1.insertrow(0))
		dw_1.setfocus()
		dw_1.setitem(dw_1.getrow(),'ef_entry_by',gs_user)
		dw_1.setitem(dw_1.getrow(),'ef_entry_dt',datetime(today()))
		dw_1.setcolumn('ef_yearmonth')
	end if
	dw_1.setfocus()
end if

lb_neworder = true
lb_query = false


end event

type dw_1 from datawindow within w_gtehrf017
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_kewdwn pbm_keydown
integer x = 9
integer y = 104
integer width = 2843
integer height = 1920
string dataobject = "dw_gtehrf017"
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
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'ef_entry_by',gs_user)
		dw_1.setitem(newrow,'ef_entry_dt',datetime(today()))
		dw_1.setcolumn('ef_yearmonth')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_1.deleterow(dw_1.getrow())
	end if
	if dw_1.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event ue_kewdwn;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_1.deleterow(dw_1.getrow())
	end if
	if dw_1.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event itemchanged;if lb_query = false then
	
	if dwo.name = 'ef_yearmonth'  then		
		ls_pfno = dw_1.getitemstring(row,'ef_pfno')
		ll_yrmn = long(data)
		
		if left(data,4) <> string(today(),'YYYY') then
			messagebox('warning!','Year Should be Current Year, Please Check !!!')
			return 1
		elseif long(right(data,2)) < 1 or long(right(data,2)) > 12 then
			messagebox('warning!','Month Should be Between (1 To 12), Please Check !!!')
			return 1			
		end if
		if  wf_check_duplicate_rec(long(data),ls_pfno) = -1 then return 1 

		select distinct 'x' into :ls_temp from fb_executivepf where ef_yearmonth = :ll_yrmn and ef_PFNO = :ls_pfno;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 0 then	
			messagebox('Warning: ','Record For This Year Month Already Exists, Please Check .....!')
			return 1
		end if				
	end if

	if dwo.name = 'ef_pfno' then
		ls_pfno = data
		ll_yrmn = dw_1.getitemnumber(row,'ef_yearmonth')
		
		if  wf_check_duplicate_rec(ll_yrmn,ls_pfno) = -1 then return 1  
		
		select distinct 'x' into :ls_temp from fb_executivepf where ef_yearmonth = :ll_yrmn and ef_PFNO = :ls_pfno;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 0 then	
			messagebox('Warning: ','Record For This Year Month Already Exists, Please Check .....!')
			return 1
		end if		
	end if		

	dw_1.setitem(row,'ef_entry_by',gs_user)
	dw_1.setitem(row,'ef_entry_dt',datetime(today()))
	
	cb_3.enabled = true
end if

if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if


end event

