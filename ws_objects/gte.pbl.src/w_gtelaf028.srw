$PBExportHeader$w_gtelaf028.srw
forward
global type w_gtelaf028 from window
end type
type dp_2 from datepicker within w_gtelaf028
end type
type dp_1 from datepicker within w_gtelaf028
end type
type dw_2 from datawindow within w_gtelaf028
end type
type rb_1 from radiobutton within w_gtelaf028
end type
type rb_2 from radiobutton within w_gtelaf028
end type
type st_3 from statictext within w_gtelaf028
end type
type st_6 from statictext within w_gtelaf028
end type
type st_7 from statictext within w_gtelaf028
end type
type em_1 from editmask within w_gtelaf028
end type
type cb_4 from commandbutton within w_gtelaf028
end type
type cb_3 from commandbutton within w_gtelaf028
end type
type cb_2 from commandbutton within w_gtelaf028
end type
type cb_1 from commandbutton within w_gtelaf028
end type
type dw_1 from datawindow within w_gtelaf028
end type
type gb_1 from groupbox within w_gtelaf028
end type
end forward

global type w_gtelaf028 from window
integer width = 4608
integer height = 2152
boolean titlebar = true
string title = "(W_gtelaf028) Labour Disciplinary"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
dp_2 dp_2
dp_1 dp_1
dw_2 dw_2
rb_1 rb_1
rb_2 rb_2
st_3 st_3
st_6 st_6
st_7 st_7
em_1 em_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_gtelaf028 w_gtelaf028

type variables
long ll_ctr,net, ll_cnt,l_ctr,ix,ll_labage,ll_user_level,ll_last,ll_adoleage, ll_child
string ls_temp,ls_emp_id,ls_date,ls_ref,ls_labour_id,ls_kam_id,ls_dt,ls_kam_id_old,ls_tmp_id
boolean lb_neworder, lb_query
datetime ld_dob,ld_frdate,ld_todate,ld_dt
double ld_afrate, ld_adfrate, ld_cfrate,ld_rate,ld_wages,ld_hour, ld_amt,ld_amt_old

string LS_ID, LS_TYPE,LS_DESC, LS_ENTRY_BY ,Ls_PERIOD_FR,Ls_PERIOD_TO
date LD_DATE,LD_ENTRY_DT,LD_PRINT_DT
double ld_absent
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function double wf_kamjari_rate (datetime fd_date, string fs_labourid, string fs_kamid)
public function integer wf_check_duplicate_rec (string fs_con_id, datetime fd_con_dt, datetime fd_con_dt2)
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
	if (isnull(dw_1.getitemstring(dw_1.getrow(),'fd_type')) or len(dw_1.getitemstring(dw_1.getrow(),'fd_type'))=0 or &
	    isnull(dw_1.getitemstring(dw_1.getrow(),'fd_labour_id')) or  len(dw_1.getitemstring(dw_1.getrow(),'fd_labour_id'))=0 or &
	    isnull(dw_1.getitemstring(dw_1.getrow(),'fd_desc')) or len(dw_1.getitemstring(dw_1.getrow(),'fd_desc'))=0 or &
	    isnull(dw_1.getitemdatetime(dw_1.getrow(),'fd_period_fr')) or  isnull(dw_1.getitemdatetime(dw_1.getrow(),'fd_period_to'))) then
		messagebox('Warning:','One Of The Fields (Labour Id, Type, Period From Date,Period To Date, Description) Are Blank : Please check !!!')
	    return -1
	end if
end if
return 1

	
end function

public function double wf_kamjari_rate (datetime fd_date, string fs_labourid, string fs_kamid);select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0))
into :ll_adoleage, :ll_child
from fb_param_detail 
where pd_doc_type in ('CHILDAGE','ADOLEAGE') and
		 trunc(:fd_date) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));

if sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
	return -1
end if;


select emp.emp_dob labdob, ((:fd_date - emp_dob) /365) into :ld_dob, :ll_labage
  from fb_employee emp
 where emp.emp_id= :fs_labourid;

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Labour Age Detail',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if

select kam.kamsub_afrate afrate, kam.kamsub_adfrate adfrate, kam.kamsub_cfrate cfrate
   into :ld_afrate, :ld_adfrate, :ld_cfrate
 from fb_kamsubhead kam
where trim(kam.kamsub_id) = :fs_kamid and trunc(:fd_date) between trunc(KAMSUB_FRDT) and trunc(nvl(KAMSUB_TODT,sysdate));

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Labour Kamjari Rate Detail',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if

If ll_labage <= ll_child Then //(144 months=12 years)
		 ld_rate = ld_cFrate
 ElseIf ll_labage > ll_child And ll_labage < ll_adoleage Then
		 ld_rate = ld_adfrate
 ElseIf ll_labage >= ll_adoleage Then
		 ld_rate = ld_afrate
End If

return ld_rate
end function

public function integer wf_check_duplicate_rec (string fs_con_id, datetime fd_con_dt, datetime fd_con_dt2);long fl_row
string ls_con_id1
datetime ld_run_dt1, ld_run_dt2

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_con_id1 = dw_1.getitemstring(fl_row,'fd_labour_id')
		ld_run_dt1 = dw_1.getitemdatetime(fl_row,'fd_period_fr')
		ld_run_dt2 = dw_1.getitemdatetime(fl_row,'fd_period_to')
							
		if (ls_con_id1 = fs_con_id  and ld_run_dt1 = fd_con_dt and ld_run_dt2 = fd_con_dt2) then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		elseif (ls_con_id1 = fs_con_id and (fd_con_dt >= ld_run_dt1 and fd_con_dt <= ld_run_dt2))  then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","From Date Should Not Be Between From & To Date Of Other Record, Please Check Row : "+string(fl_row))
			return -1
		elseif   (ls_con_id1 = fs_con_id and (fd_con_dt2 >= ld_run_dt1 and fd_con_dt2 <= ld_run_dt2)) then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","To Date Should Not Be Between From & To Date Of Other Record, Please Check Row : "+string(fl_row))
			return -1
		end if		
	next 
end if 

return 1


end function

on w_gtelaf028.create
this.dp_2=create dp_2
this.dp_1=create dp_1
this.dw_2=create dw_2
this.rb_1=create rb_1
this.rb_2=create rb_2
this.st_3=create st_3
this.st_6=create st_6
this.st_7=create st_7
this.em_1=create em_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.dp_2,&
this.dp_1,&
this.dw_2,&
this.rb_1,&
this.rb_2,&
this.st_3,&
this.st_6,&
this.st_7,&
this.em_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.gb_1}
end on

on w_gtelaf028.destroy
destroy(this.dp_2)
destroy(this.dp_1)
destroy(this.dw_2)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.st_3)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.em_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
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
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if

dw_2.modify("t_co.text = '"+gs_co_name+"'")

this.tag = Message.StringParm
ll_user_level = long(this.tag)

dw_1.hide()
dw_2.show()




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

type dp_2 from datepicker within w_gtelaf028
integer x = 1687
integer y = 32
integer width = 370
integer height = 92
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2014-07-10"), Time("11:09:42.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_1 from datepicker within w_gtelaf028
integer x = 1106
integer y = 32
integer width = 370
integer height = 92
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2014-07-10"), Time("11:09:42.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dw_2 from datawindow within w_gtelaf028
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 9
integer y = 136
integer width = 2478
integer height = 1908
string dataobject = "dw_gtelaf029"
boolean hscrollbar = true
end type

event itemchanged;if lb_query = false then

	if dwo.name = 'fd_labour_id' then
		ls_emp_id=data
		ld_frdate=dw_2.getitemdatetime(row,'fd_period_fr') 
		ld_todate=dw_2.getitemdatetime(row,'fd_period_to') 
		
		if isnull(ls_emp_id)= true or len(ls_emp_id) = 0 then	
			messagebox('Warning!','Please select  a valid labour id')
			rollback using sqlca;
			return 1
		end if
		
		if  wf_check_duplicate_rec(ls_emp_id,ld_frdate,ld_todate) = -1 then return 1
	end if
	
	cb_3.enabled = true
end if
end event

type rb_1 from radiobutton within w_gtelaf028
integer x = 37
integer y = 44
integer width = 411
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Absenteeism"
boolean checked = true
end type

event clicked;dw_1.hide()
dw_2.show()

end event

type rb_2 from radiobutton within w_gtelaf028
integer x = 453
integer y = 44
integer width = 361
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Disciplinary"
end type

event clicked;dw_2.hide()
dw_1.show()
end event

type st_3 from statictext within w_gtelaf028
integer x = 2071
integer y = 44
integer width = 448
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "No of Days Absent"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_6 from statictext within w_gtelaf028
integer x = 850
integer y = 44
integer width = 274
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From Date"
boolean focusrectangle = false
end type

type st_7 from statictext within w_gtelaf028
integer x = 1486
integer y = 44
integer width = 201
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To Date"
boolean focusrectangle = false
end type

type em_1 from editmask within w_gtelaf028
integer x = 2537
integer y = 44
integer width = 320
integer height = 76
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "########"
end type

type cb_4 from commandbutton within w_gtelaf028
integer x = 3689
integer y = 28
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

type cb_3 from commandbutton within w_gtelaf028
integer x = 3424
integer y = 28
integer width = 265
integer height = 100
integer taborder = 70
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
if dw_1.visible = true then
	IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'fd_labour_id')) or len(dw_1.getitemstring(dw_1.rowcount(),'fd_labour_id'))=0) THEN
		 dw_1.deleterow(dw_1.rowcount())
	END IF
	
	IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
		for ll_ctr = dw_1.rowcount() to 1 step -1
			if dw_1.getitemstring(ll_ctr,'del_flag') = 'Y' and isnull(dw_1.getitemdatetime(ll_ctr,'fd_print_dt'))   then
				dw_1.deleterow(ll_ctr)
			end if
		next	
		if dw_1.rowcount( ) > 0  then
			if (isnull(dw_1.getitemstring(dw_1.getrow(),'fd_type')) or len(dw_1.getitemstring(dw_1.getrow(),'fd_type'))=0 or &
				 isnull(dw_1.getitemstring(dw_1.getrow(),'fd_labour_id')) or len(dw_1.getitemstring(dw_1.getrow(),'fd_labour_id'))=0 or &
				 isnull(dw_1.getitemstring(dw_1.getrow(),'fd_desc')) or len(dw_1.getitemstring(dw_1.getrow(),'fd_desc'))=0 or &
				 isnull(dw_1.getitemdatetime(dw_1.getrow(),'fd_period_fr')) or  isnull(dw_1.getitemdatetime(dw_1.getrow(),'fd_period_to'))) then
				messagebox('Warning:','One Of The Fields (Labour Id, Type, Period From Date,Period To Date, Description) Are Blank : Please check !!!')
				dw_1.setfocus()
				dw_1.setcolumn('fd_labour_id')
				return
			end if
		end if
		  
		if lb_neworder = true then
			ll_last =0
			if ll_last=0 then
				select nvl(MAX(substr(FD_ID,5,10)),0) into :ll_last from fb_disciplinary;
			end if
			for ll_ctr = dw_1.rowcount() to 1 step -1
				ld_frdate = dw_1.getitemdatetime(ll_ctr,'fd_period_fr') 			
				ls_emp_id = dw_1.getitemstring(ll_ctr,'fd_labour_id')
				ld_todate = dw_1.getitemdatetime(ll_ctr,'fd_period_to') 		
				
				select distinct 'x' into :ls_temp  from FB_DISCIPLINARY	
				where FD_LABOUR_ID=:ls_emp_id and ((trunc(:ld_frdate) between trunc(FD_PERIOD_FR) and trunc(FD_PERIOD_TO)) or 
						(trunc(:ld_todate) between trunc(FD_PERIOD_FR) and trunc(FD_PERIOD_TO)));
				if sqlca.sqlcode = -1 then 
						messagebox('Sql Error','Error During Getting Labour Id  : '+sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
				elseif sqlca.sqlcode = 0 then 
					  messagebox('Error','Disciplinary Entry Already Done For This Employee For This Duration, Please Check !!!')
					rollback using sqlca;
					return 1
				end if;		
				ll_last = ll_last + 1
				ls_tmp_id = 'LDID'+string(ll_last,'0000000000') 
				dw_1.setitem(ll_ctr,'fd_id',ls_tmp_id)	
				dw_1.setitem(ll_ctr,'fd_date',datetime(today()))	
			next
		end if
				
		if dw_1.update(true,false) = 1  then
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
elseif dw_2.visible = true then
	IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
		if lb_neworder = true and dw_2.rowcount() > 0 then
			for ll_ctr = dw_2.rowcount() to 1 step -1
				if dw_2.getitemstring(ll_ctr,'del_flag') = 'N' then
					dw_2.deleterow(ll_ctr)
				end if
			next	
			
			ll_last=0
			if ll_last=0 then
				select nvl(MAX(substr(FD_ID,5,10)),0) into :ll_last from fb_disciplinary;
			end if
		
			for ll_ctr = 1 to dw_2.rowcount()
				ll_last = ll_last + 1
						
				LS_ID = 'LDID'+string(ll_last,'0000000000')
				LS_TYPE = 'A'
				LS_DESC='Absenteeism Reason' 
				LS_ENTRY_BY=gs_user
				LS_LABOUR_ID= dw_2.getitemstring(ll_ctr,'lab_id') 
				LD_DATE=date(today())
				Ls_PERIOD_FR=string(dw_2.getitemdatetime(ll_ctr,'FROM_DT'),'dd/mm/yyyy') 
				Ls_PERIOD_TO=string(dw_2.getitemdatetime(ll_ctr,'TO_DT'),'dd/mm/yyyy') 
				Ls_dt = dw_2.getitemstring(ll_ctr,'absent_dates')
				ld_absent = dw_2.getitemnumber(ll_ctr,'absent_days')
				LD_ENTRY_DT=date(today())
						
				//ls_cnclty = dw_2.getitemstring(ll_ctr,'cncl_type')
				insert into fb_disciplinary( FD_ID, FD_DATE, FD_TYPE, FD_PERIOD_FR, FD_PERIOD_TO, FD_DESC, FD_ENTRY_BY, FD_ENTRY_DT, FD_LABOUR_ID,fd_absdays,fd_absdates)
					values(:LS_ID,to_date(:LD_DATE,'dd/mm/yyyy'),:LS_TYPE,to_date(:Ls_PERIOD_FR,'dd/mm/yyyy'),to_date(:Ls_PERIOD_TO,'dd/mm/yyyy'),:LS_DESC,:LS_ENTRY_BY ,to_date(:LD_ENTRY_DT,'dd/mm/yyyy'),:LS_LABOUR_ID,:ld_absent,:Ls_dt);
						
					if sqlca.sqlcode = -1 then
						messagebox('Sql Error During insert in master : ',sqlca.sqlerrtext);
						return 1;
					end if;						
				next
		end if		
		
		commit using sqlca;
		cb_3.enabled = false
		cb_2.enabled = true
		dw_2.reset()		
	else
		return
	end if 
end if

rb_1.enabled = true
rb_2.enabled = true

end event

type cb_2 from commandbutton within w_gtelaf028
integer x = 3159
integer y = 28
integer width = 265
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Query"
end type

event clicked;rb_1.enabled = true
rb_2.enabled = true
if cb_2.text = "&Query" then
	if dw_1.modifiedcount() > 0 or dw_2.modifiedcount() > 0  then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	lb_query = true
	lb_neworder = true
	if rb_2.checked then
		dw_1.reset()
		dw_1.modify("datawindow.queryclear= yes")
		dw_1.Object.datawindow.querymode= 'yes'
		dw_1.SetFocus ()
		dw_1.setcolumn('fd_labour_id')
	else
		dw_2.reset()
		dw_2.modify("datawindow.queryclear= yes")
		dw_2.Object.datawindow.querymode= 'yes'
		dw_2.SetFocus ()
	end if
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_query = false
	if rb_2.checked then
		dw_1.settransobject(sqlca)
		dw_1.SetRedraw (FALSE)
		dw_1.Object.datawindow.querymode = 'no'
		dw_1.Retrieve(gs_user)
		dw_1.TriggerEvent(rowfocuschanged!)
		dw_1.SetRedraw (TRUE)		
	else
		dw_2.settransobject(sqlca)
		dw_2.SetRedraw (FALSE)
		dw_2.Object.datawindow.querymode = 'no'
		dw_2.Retrieve()
		dw_2.TriggerEvent(rowfocuschanged!)
		dw_2.SetRedraw (TRUE)
	end if
	cb_2.text = "&Query"
	cb_1.enabled = true
end if
lb_neworder = false



end event

type cb_1 from commandbutton within w_gtelaf028
integer x = 2894
integer y = 28
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&New"
end type

event clicked;long  count1,ll_abdays
double abs_days
string old_labid,ls_firstread ,ls_labid,ls_name,ls_kamid,old_name
date ld_frdt,ld_todt ,old_dt

if rb_2.checked then
	// Disciplinary 
	if lb_neworder = false then
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
		dw_1.setitem(dw_1.getrow(),'fd_entry_by',gs_user)
		dw_1.setitem(dw_1.getrow(),'fd_entry_dt',datetime(today()))	
		dw_1.setitem(dw_1.getrow(),'fd_type','D')
		dw_1.setcolumn('fd_labour_id')
	else
		IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
			return 1
		END IF
		dw_1.scrolltorow(dw_1.insertrow(0))
		dw_1.setfocus()
		dw_1.setitem(dw_1.getrow(),'fd_entry_by',gs_user)
		dw_1.setitem(dw_1.getrow(),'fd_entry_dt',datetime(today()))
		dw_1.setitem(dw_1.getrow(),'fd_type','D')
		dw_1.setcolumn('fd_labour_id')
	end if
	// Disciplinary 
elseif rb_1.checked then
	dw_2.settransobject(sqlca)
	lb_neworder = true
	lb_query = false
	dw_2.reset()
	
	if isnull(dp_1.text) or len(dp_1.text) <1 then 
		messagebox('Warning','From Date Should be Enter') 
		return  1
	end if
	if isnull(dp_2.text) or len(dp_2.text) <1 then 
		messagebox('Warning','To Date Should be Enter') 
		return  1
	end if
		
	if isnull(em_1.text) or len(em_1.text) = 0 then 
		messagebox('Warning ','Please Select a Valid Absent Days ...!') 
		return  1
	end if
	setpointer(hourglass!)
	
	delete from temp_attn;
	if sqlca.sqlcode = -1 then
		messagebox('SQL Error : During Delete',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if;	
		
	ll_abdays = long(em_1.text);
	ld_frdt=date(dp_1.text);
	ld_todt=date(dp_2.text);
	count1 = 0 ;abs_days= 0;
	ls_firstread = 'Y';setnull(ls_dt);
	
	declare c1 cursor for 
	select LDA_DATE,LABOUR_ID,EMP_NAME,KAMSUB_NAME
	  from FB_LABOURDAILYATTENDANCE a,FB_KAMSUBHEAD b,fb_employee c
	where a.KAMSUB_ID=b.KAMSUB_ID and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and a.LABOUR_ID = c.EMP_ID and
			 a.LDA_DATE between :ld_frdt AND :ld_todt
	order by 2,1;
	
	open c1;   
	
	if sqlca.sqlcode = -1 then 
		messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
		rollback using sqlca; 
		return 1; 
	else 
		setnull(ls_labid);setnull(ls_name);setnull(ls_kamid);setnull(ld_date);
	
		fetch c1 into :ld_date,:ls_labid,:ls_name,:ls_kamid;
		if sqlca.sqlcode = -1 then 
			messagebox('Error','Error During Fetching Data'+sqlca.sqlerrtext);
			return 1
		end if;
		do while sqlca.sqlcode <> 100     
				 if ls_firstread = 'Y' then
					old_labid = ls_labid; 
					old_name = ls_name;				
					old_dt = ld_date ;		 
					ls_firstread = 'N';
					setnull(ls_dt)
				end if;
				
			if  (ls_labid = old_labid) and (ld_date = ld_frdt or RelativeDate(old_dt,1) = ld_date)  then 
				  if ls_kamid='AB' then
					 count1 = count1 + 1;
					 if isnull(ls_dt) then
						ls_dt = string(ld_date,'dd/mm/yyyy')
					 else
					 	ls_dt = ls_dt + ', '+ string(ld_date,'dd/mm/yyyy')
					end if
				  //else
					  //abs_days = count1;
					// count1 = 0;	 
				  end if;		
				  abs_days = count1;
				  //messagebox('ab=',ls_labid+'  '+ls_kamid+' '+string(count1) + ls_dt)
				  old_dt = ld_date ;		
			elseif (ls_labid <> old_labid) then
					//messagebox('a=',old_labid+'  '+string(abs_days))
					if abs_days>= ll_abdays then
						insert into temp_attn(LAB_ID,lab_name,absent_days,FROM_DT, TO_DT,absent_dates) values(:old_labid,:old_name,:abs_days,:ld_frdt,:ld_todt,:ls_dt);
							if sqlca.sqlcode = -1 then
							messagebox('SQL Error : During insert',sqlca.sqlerrtext)
							rollback using sqlca;
							return 1
						end if;	  
					end if;	
					old_labid = ls_labid; 
					old_name = ls_name;
					old_dt = ld_date ;
					count1 = 0;	
					setnull(ls_dt)
					
					 if ls_kamid='AB' then
					 	count1 = count1 + 1;
						ls_dt = string(ld_date,'dd/mm/yyyy')
				 	 end if;		
				  	abs_days = count1;
			 end if;
			  //end if;
		  setnull(ls_labid);setnull(ls_name);setnull(ls_kamid);setnull(ld_date);
		fetch c1 into :ld_date,:ls_labid,:ls_name,:ls_kamid;
			  
	  loop;
	  if abs_days>=ll_abdays then
		 insert into temp_attn(LAB_ID,lab_name,absent_days,FROM_DT, TO_DT,absent_dates) values(:old_labid,:old_name,:abs_days,:ld_frdt,:ld_todt,:ls_dt);
				if sqlca.sqlcode = -1 then
				messagebox('SQL Error : During insert',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			end if;	
		end if;				
	close c1;
	commit using sqlca;	  
	end if;	
	
	dw_2.retrieve(gs_user)
	setpointer(arrow!)
	cb_3.enabled = true
end if
rb_1.enabled = false
rb_2.enabled = false
end event

type dw_1 from datawindow within w_gtelaf028
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 9
integer y = 136
integer width = 4558
integer height = 1908
string dataobject = "dw_gtelaf028"
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
		dw_1.setitem(newrow,'fd_entry_by',gs_user)
		dw_1.setitem(newrow,'fd_entry_dt',datetime(today()))
		dw_1.setitem(newrow,'fd_type',dw_1.getitemstring(currentrow,'fd_type'))
		dw_1.setcolumn('fd_labour_id')
	end if
 end if
end if

end event

event ue_tab_to_enter;//Send(Handle(this),256,9,Long(0,0))
//return 1

end event

event itemchanged;if lb_query = false then

	if dwo.name = 'fd_labour_id' then
		ls_emp_id=data
		ld_frdate=dw_1.getitemdatetime(row,'fd_period_fr') 
		ld_todate=dw_1.getitemdatetime(row,'fd_period_to') 
		
		if isnull(ls_emp_id)= true or len(ls_emp_id) = 0 then	
			messagebox('Warning!','Please select  a valid labour id')
			rollback using sqlca;
			return 1
		end if
		
		if  wf_check_duplicate_rec(ls_emp_id,ld_frdate,ld_todate) = -1 then return 1
	end if
	
	if dwo.name = 'fd_period_fr' then
		ld_frdate=datetime(data)
		ls_emp_id = dw_1.getitemstring(row,'fd_labour_id')
		ld_todate=dw_1.getitemdatetime(row,'fd_period_to') 		
		if  isnull(ld_frdate)  then
			messagebox('Warning!','Period From Date Should Not Be Blank, Please Check !!!')
			rollback using sqlca;
			return 1
		end if
		
		if ld_todate < ld_frdate then
			messagebox('Warning!','Period From Date Should Be Less than To Date, Please Check !!!')
			rollback using sqlca;
			return 1
		end if 
		if  wf_check_duplicate_rec(ls_emp_id,ld_frdate,ld_todate) = -1 then return 1
		
		select distinct 'x' into :ls_temp  from FB_DISCIPLINARY	
		where FD_LABOUR_ID=:ls_emp_id and trunc(:ld_frdate) between trunc(FD_PERIOD_FR) and trunc(FD_PERIOD_TO);
		if sqlca.sqlcode = -1 then 
				messagebox('Sql Error','Error During Getting Labour Id  : '+sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
		elseif sqlca.sqlcode = 0 then 
			  messagebox('Error','Disciplinary Entry Already Done For This Employee For This Duration, Please Check !!!')
			rollback using sqlca;
			return 1
		end if;				
	end if
	
	if dwo.name = 'fd_period_to' then
		
		ld_todate=datetime(data)
		ls_emp_id = dw_1.getitemstring(row,'fd_labour_id')
		ld_frdate=dw_1.getitemdatetime(row,'fd_period_fr') 
		
		if  isnull(ld_todate)  then
			messagebox('Warning!','Period To Date Should Not Be Blank, Please Check !!!')
			rollback using sqlca;
			return 1
		end if
	
		if ld_todate < ld_frdate then
			messagebox('Warning!','Period To Date Should Be Greater than From Date, Please Check !!!')
			rollback using sqlca;
			return 1
		end if
		
		setnull(ls_temp)				
		if  wf_check_duplicate_rec(ls_emp_id,ld_frdate,ld_todate) = -1 then return 1
		
		///check duplicate from table
		
		select distinct 'x' into :ls_temp  from FB_DISCIPLINARY	
		where FD_LABOUR_ID=:ls_emp_id and ((trunc(:ld_frdate) between trunc(FD_PERIOD_FR) and trunc(FD_PERIOD_TO)) or 
				(trunc(:ld_todate) between trunc(FD_PERIOD_FR) and trunc(FD_PERIOD_TO)));
		
		if sqlca.sqlcode = -1 then 
				messagebox('Sql Error','Error During Getting Labour Id  : '+sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
		elseif sqlca.sqlcode = 0 then 
			  messagebox('Error','Disciplinary Entry Already Done For This Employee For This Duration, Please Check !!!')
			rollback using sqlca;
			return 1
		end if;		
	end if
	
		
	if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
		dw_1.insertrow(0)
	end if
	
	dw_1.setitem(row,'fd_entry_by',gs_user)
	dw_1.setitem(row,'fd_entry_dt',datetime(today()))
	
	cb_3.enabled = true
end if
end event

type gb_1 from groupbox within w_gtelaf028
integer x = 9
integer width = 837
integer height = 136
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

