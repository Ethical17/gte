$PBExportHeader$w_gtelaf039.srw
forward
global type w_gtelaf039 from window
end type
type em_10 from editmask within w_gtelaf039
end type
type em_9 from editmask within w_gtelaf039
end type
type em_8 from editmask within w_gtelaf039
end type
type em_1 from editmask within w_gtelaf039
end type
type st_1 from statictext within w_gtelaf039
end type
type cb_5 from commandbutton within w_gtelaf039
end type
type em_2 from editmask within w_gtelaf039
end type
type em_3 from editmask within w_gtelaf039
end type
type em_4 from editmask within w_gtelaf039
end type
type em_5 from editmask within w_gtelaf039
end type
type em_6 from editmask within w_gtelaf039
end type
type em_7 from editmask within w_gtelaf039
end type
type cb_4 from commandbutton within w_gtelaf039
end type
type cb_3 from commandbutton within w_gtelaf039
end type
type cb_2 from commandbutton within w_gtelaf039
end type
type cb_1 from commandbutton within w_gtelaf039
end type
type dw_1 from datawindow within w_gtelaf039
end type
end forward

global type w_gtelaf039 from window
integer width = 5051
integer height = 2276
boolean titlebar = true
string title = "(w_gtelaf039) Kamjari Task"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
em_10 em_10
em_9 em_9
em_8 em_8
em_1 em_1
st_1 st_1
cb_5 cb_5
em_2 em_2
em_3 em_3
em_4 em_4
em_5 em_5
em_6 em_6
em_7 em_7
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtelaf039 w_gtelaf039

type variables
long ll_ctr, ll_cnt, ll_year, ll_last,ll_user_level, ll_pay
string ls_temp,ls_name,ls_last,ls_kam,ls_type, ls_lbtype, ls_avglwind, ls_avgupind, ls_unit, ls_prun
boolean lb_neworder, lb_query
datetime ld_frdt, ld_todt,ld_dt
double ld_afrate, ld_adfrate, ld_cfrate,ld_rate , ld_cp1, ld_rcp1, ld_rcp2 , ld_rcp3 , ld_lwrt1 , ld_lwrt2 , ld_lwrt3 ,ld_uprt1 , ld_uprt2, ld_uprt3

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_kam, string fs_lbtype, long fl_pay, string fs_type, datetime fd_dt, datetime fd_todt)
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
	if (isnull(dw_1.getitemstring(fl_row,'task_id')) or  len(dw_1.getitemstring(fl_row,'task_id'))=0 or &
		 isnull(dw_1.getitemstring(fl_row,'task_type')) or  len(dw_1.getitemstring(fl_row,'task_type'))=0 or &
		 isnull(dw_1.getitemdatetime(fl_row,'task_dt_from')) or &
		 isnull(dw_1.getitemdatetime(fl_row,'task_dt_to')) or &
		 isnull(dw_1.getitemstring(fl_row,'task_emptype')) or  len(dw_1.getitemstring(fl_row,'task_emptype'))=0 or &
		 isnull(dw_1.getitemnumber(fl_row,'task_paybook')) or  len(string(dw_1.getitemnumber(fl_row,'task_paybook'))) =0 or &
		 isnull(dw_1.getitemnumber(fl_row,'task_changepoint')) or  dw_1.getitemnumber(fl_row,'task_changepoint')=0 or &
		 isnull(dw_1.getitemnumber(fl_row,'task_changepoint2')) or  dw_1.getitemnumber(fl_row,'task_changepoint2')=0 or &
		 isnull(dw_1.getitemnumber(fl_row,'task_ratelower'))  or &
		 isnull(dw_1.getitemnumber(fl_row,'task_rateupper'))  or &
		 isnull(dw_1.getitemnumber(fl_row,'task_rateupper2'))  or &
		 isnull(dw_1.getitemstring(fl_row,'task_unit')) or  len(dw_1.getitemstring(fl_row,'task_unit'))=0) then
	    messagebox('Warning: One Of The Following Fields Are Blank', 'Task ID, Labour Type, Pay Book, Type, From date, To Date, ChangePoint 1, ChangePoint 2, Rate Lower1,Rate Lower2, Rate Upper1, Rate Upper2, Please Check !!!')
		 return -1
	end if
end if
return 1
end function

public function integer wf_check_duplicate_rec (string fs_kam, string fs_lbtype, long fl_pay, string fs_type, datetime fd_dt, datetime fd_todt);long fl_row,ll_pay1
string ls_kam1,ls_type1,ls_lbtype1
datetime ld_dt1,ld_tdt1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_kam1 = dw_1.getitemstring(fl_row,'task_id')
		
		ls_type1 = dw_1.getitemstring(fl_row,'task_type')
		ld_dt1 = dw_1.getitemdatetime(fl_row,'task_dt_from')
		ld_tdt1 = dw_1.getitemdatetime(fl_row,'task_dt_to')
		ls_lbtype1 = dw_1.getitemstring(fl_row,'task_emptype')
		ll_pay1 = dw_1.getitemnumber(fl_row,'task_paybook')
		
		if ls_kam1 = fs_kam and ls_lbtype1 = fs_lbtype and ll_pay1 = fl_pay and ls_type1 = fs_type and ld_dt1 = fd_dt and ld_tdt1 = fd_todt then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtelaf039.create
this.em_10=create em_10
this.em_9=create em_9
this.em_8=create em_8
this.em_1=create em_1
this.st_1=create st_1
this.cb_5=create cb_5
this.em_2=create em_2
this.em_3=create em_3
this.em_4=create em_4
this.em_5=create em_5
this.em_6=create em_6
this.em_7=create em_7
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.em_10,&
this.em_9,&
this.em_8,&
this.em_1,&
this.st_1,&
this.cb_5,&
this.em_2,&
this.em_3,&
this.em_4,&
this.em_5,&
this.em_6,&
this.em_7,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtelaf039.destroy
destroy(this.em_10)
destroy(this.em_9)
destroy(this.em_8)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.cb_5)
destroy(this.em_2)
destroy(this.em_3)
destroy(this.em_4)
destroy(this.em_5)
destroy(this.em_6)
destroy(this.em_7)
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
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if

this.tag = Message.StringParm
ll_user_level = long(this.tag)

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

type em_10 from editmask within w_gtelaf039
integer x = 4343
integer y = 16
integer width = 210
integer height = 88
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##.000"
end type

type em_9 from editmask within w_gtelaf039
integer x = 4101
integer y = 16
integer width = 215
integer height = 88
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##.000"
end type

type em_8 from editmask within w_gtelaf039
integer x = 2917
integer y = 16
integer width = 210
integer height = 88
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##.000"
end type

type em_1 from editmask within w_gtelaf039
integer x = 2158
integer y = 20
integer width = 302
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
end type

event modified;if isnull(em_1.text) then
	messagebox('Warning!','Please Enter Valid Date !!!')
	return 1
else
	if ll_user_level = 1 then
		cb_5.enabled = true
	end if
end if
end event

type st_1 from statictext within w_gtelaf039
integer x = 1934
integer y = 32
integer width = 206
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Date :"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_5 from commandbutton within w_gtelaf039
integer x = 4594
integer y = 8
integer width = 370
integer height = 100
integer taborder = 130
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Replicate Data"
end type

event clicked;if isnull(em_1.text) then
	messagebox('Warning!','Please Enter Valid Date !!!')
	return 1
end if

if isnull(em_2.text) then
	messagebox('Warning!','Please Enter Valid Date !!!')
	return 1
end if

if isnull(em_3.text) then
	messagebox('Warning!','Please Enter Valid Date !!!')
	return 1
end if

if isnull(em_4.text) then
	messagebox('Warning!','Please Enter Valid Date !!!')
	return 1
end if

if isnull(em_5.text) then
	messagebox('Warning!','Please Enter Valid Date !!!')
	return 1
end if

if isnull(em_6.text) then
	messagebox('Warning!','Please Enter Valid Date !!!')
	return 1
end if

if isnull(em_1.text) then
	messagebox('Warning!','Please Enter Valid Date !!!')
	return 1
end if


ld_dt = datetime(em_1.text)

select distinct 'x' into :ls_temp from fb_task_fulbari where trunc(TASK_DT_TO) >= trunc(:ld_dt);
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Details',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode  = 0 then
	messagebox('Warning!','Record Already Exists For This Date, Please Enter A Future Date!!!')
	return 1
end if

dw_1.settransobject(sqlca)
dw_1.reset()

//		ls_kam = dw_1.getitemstring(row,'task_id')
//		ls_type = dw_1.getitemstring(row,'task_type')
//		ld_todt = dw_1.getitemdatetime(row,'task_dt_to')
//		ls_lbtype = dw_1.getitemstring(row,'task_emptype')
//		ll_pay = dw_1.getitemnumber(row,'task_paybook')


setnull(ls_kam); setnull(ls_type); setnull(ld_todt); setnull(ls_lbtype); setnull(ld_frdt);ll_pay = 0; ld_rcp1 = 0; ld_rcp2 = 0;  ld_rcp3 = 0; ld_lwrt1 = 0; ld_lwrt2 = 0; ld_lwrt3 = 0; ld_uprt1 = 0; ld_uprt2 = 0;  ld_uprt3 = 0;
setnull(ls_avglwind); setnull(ls_avgupind); setnull(ls_unit); setnull(ls_prun);

ld_rcp1 = double(em_2.text); 	ld_rcp2= double(em_3.text); ld_rcp3= double(em_8.text); 
ld_lwrt1= double(em_4.text);   ld_lwrt2= double(em_5.text); ld_lwrt3= double(em_9.text); ld_uprt1= double(em_6.text); 	ld_uprt2= double(em_7.text); ld_uprt3= double(em_10.text);

declare c1 cursor for
select TASK_ID, TASK_EMPTYPE, TASK_PAYBOOK,TASK_TYPE, TASK_DT_FROM , TASK_DT_TO, 
       TASK_AVGRT_LOWER,TASK_AVGRT_UPPER, TASK_UNIT, TASK_PRUNTYPE  
from fb_task_fulbari a 
where (TASK_ID, TASK_EMPTYPE, TASK_PAYBOOK,TASK_TYPE,TASK_DT_TO) in 
        (select TASK_ID,TASK_EMPTYPE,TASK_PAYBOOK,TASK_TYPE, max(TASK_DT_TO) from fb_task_fulbari 
                            group by TASK_ID,TASK_EMPTYPE,TASK_PAYBOOK,TASK_TYPE)
order by TASK_PAYBOOK, TASK_ID, TASK_EMPTYPE;
//	
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_kam,:ls_lbtype,:ll_pay,:ls_type,:ld_frdt, :ld_todt, :ls_avglwind, :ls_avgupind, :ls_unit, :ls_prun;
	
	do while sqlca.sqlcode <> 100
		dw_1.scrolltorow(dw_1.insertrow(0))
		dw_1.setitem(dw_1.getrow(),'task_id',ls_kam)
		dw_1.setitem(dw_1.getrow(),'task_emptype',ls_lbtype)
		dw_1.setitem(dw_1.getrow(),'task_paybook',ll_pay)
		dw_1.setitem(dw_1.getrow(),'task_type',ls_type)
		dw_1.setitem(dw_1.getrow(),'task_dt_from',ld_dt)
		dw_1.setitem(dw_1.getrow(),'task_dt_to',ld_dt)
		dw_1.setitem(dw_1.getrow(),'task_avgrt_lower',ls_avglwind)
		dw_1.setitem(dw_1.getrow(),'task_avgrt_upper',ls_avgupind)
		dw_1.setitem(dw_1.getrow(),'task_changepoint',ld_rcp1)
		dw_1.setitem(dw_1.getrow(),'task_changepoint2',ld_rcp2)
		dw_1.setitem(dw_1.getrow(),'task_changepoint3',ld_rcp3)
		dw_1.setitem(dw_1.getrow(),'task_ratelower',ld_lwrt1)
		dw_1.setitem(dw_1.getrow(),'task_ratelower2',ld_lwrt2)
		dw_1.setitem(dw_1.getrow(),'task_ratelower3',ld_lwrt3)
		dw_1.setitem(dw_1.getrow(),'task_rateupper',ld_uprt1)
		dw_1.setitem(dw_1.getrow(),'task_rateupper2',ld_uprt2)
		dw_1.setitem(dw_1.getrow(),'task_rateupper3',ld_uprt3)
		dw_1.setitem(dw_1.getrow(),'task_active_ind','Y')
		dw_1.setitem(dw_1.getrow(),'task_entry_by',gs_user)
		dw_1.setitem(dw_1.getrow(),'task_entry_dt',ld_dt)

		
setnull(ls_kam); setnull(ls_type); setnull(ld_todt); setnull(ls_lbtype); setnull(ld_frdt);ll_pay = 0;
setnull(ls_avglwind); setnull(ls_avgupind); setnull(ls_unit); setnull(ls_prun);
		
		fetch c1 into :ls_kam,:ls_lbtype,:ll_pay,:ls_type,:ld_frdt, :ld_todt, :ls_avglwind, :ls_avgupind, :ls_unit, :ls_prun;
	loop
	close c1;
	dw_1.scrolltorow(1)
	cb_3.enabled = true
end if
end event

type em_2 from editmask within w_gtelaf039
integer x = 2505
integer y = 16
integer width = 206
integer height = 88
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##.000"
end type

type em_3 from editmask within w_gtelaf039
integer x = 2720
integer y = 16
integer width = 192
integer height = 88
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##.000"
end type

type em_4 from editmask within w_gtelaf039
integer x = 3159
integer y = 16
integer width = 206
integer height = 88
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##.000"
end type

type em_5 from editmask within w_gtelaf039
integer x = 3369
integer y = 16
integer width = 201
integer height = 88
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##.000"
end type

type em_6 from editmask within w_gtelaf039
integer x = 3602
integer y = 16
integer width = 215
integer height = 88
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##.000"
end type

type em_7 from editmask within w_gtelaf039
integer x = 3845
integer y = 16
integer width = 210
integer height = 88
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##.000"
end type

type cb_4 from commandbutton within w_gtelaf039
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

type cb_3 from commandbutton within w_gtelaf039
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

IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'task_id')) or len(dw_1.getitemstring(dw_1.rowcount(),'task_id'))=0) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF  MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	if dw_1.rowcount() > 0 then
		IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
			return 1
		END IF

		for ll_ctr = 1 to dw_1.rowcount( ) 
			ld_frdt = dw_1.getitemdatetime(ll_ctr,'task_dt_from')
			ld_todt = dw_1.getitemdatetime(ll_ctr,'task_dt_to')
			ls_kam = dw_1.getitemstring(ll_ctr,'task_id')
			ls_type = dw_1.getitemstring(ll_ctr,'task_type')
			ls_lbtype = dw_1.getitemstring(ll_ctr,'task_emptype')
			ll_pay = dw_1.getitemnumber(ll_ctr,'task_paybook')
					
			if lb_neworder = true then
				select distinct 'x' into :ls_temp from fb_task_fulbari
				where task_id = :ls_kam and task_emptype = :ls_lbtype and task_paybook = :ll_pay and task_type = :ls_type and trunc(:ld_frdt) between trunc(TASK_dt_from) and trunc(task_dt_to);
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Payment Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode  = 0 then
					messagebox('Warning!','Period From Of New Record Should Be > Period From & To Of Existing Recors, Please Check !!!')
					return 1
				end if	
					
				select distinct 'x' into :ls_temp from fb_task_fulbari
				where task_id = :ls_kam and task_emptype = :ls_lbtype and task_paybook = :ll_pay and task_type = :ls_type and trunc(TASK_dt_from)= trunc(:ld_frdt) and trunc(TASK_dt_to) = trunc(:ld_todt);
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Rate Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode  = 0 then
					messagebox("Warning!","Record Already Exists, Please Check !!!")
					return 1
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

type cb_2 from commandbutton within w_gtelaf039
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
	dw_1.setcolumn('task_id')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_garden_snm)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtelaf039
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

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'TASK_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'TASK_entry_dt',datetime(today()))
	dw_1.setcolumn('task_id')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'TASK_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'TASK_entry_dt',datetime(today()))
	dw_1.setcolumn('task_id')
end if


end event

type dw_1 from datawindow within w_gtelaf039
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 14
integer y = 116
integer width = 4987
integer height = 2052
integer taborder = 30
string dataobject = "dw_gtelaf039"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'task_entry_by',gs_user)
		dw_1.setitem(newrow,'task_entry_dt',datetime(today()))
		dw_1.setitem(newrow,'task_id',dw_1.getitemstring(currentrow,'task_id'))		
		dw_1.setitem(newrow,'task_emptype',dw_1.getitemstring(currentrow,'task_emptype'))
		dw_1.setcolumn('task_paybook')
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
	if dwo.name = 'task_dt_from'  then
		ld_frdt = datetime(data)
		ls_kam = dw_1.getitemstring(row,'task_id')
		ls_type = dw_1.getitemstring(row,'task_type')
		ld_todt = dw_1.getitemdatetime(row,'task_dt_to')
		ls_lbtype = dw_1.getitemstring(row,'task_emptype')
		ll_pay = dw_1.getitemnumber(row,'task_paybook')

		
//		if date(ld_frdt) < today() then
//			messagebox('Warning','From Date Should Not Be < Current Date !!!')
//			return 1
//		end if
				
		if isnull(data) or data = '00/00/0000'  then
			messagebox('Warning!','From Date Should Not Be Blank, Please Check !!!')
			return 1
		end if
		
		if string(ld_todt,'dd/mm/yyyy') <> '00/00/0000'  then
			if date(ld_todt) < date(ld_frdt) then
				messagebox('Warning!','From Date Should Be < To Date, Please Check !!!')
				return 1
			end if
		end if
		
		if  wf_check_duplicate_rec(ls_kam,ls_lbtype,ll_pay,ls_type,ld_frdt, ld_todt) = -1 then return 1
				
		select distinct 'x' into :ls_temp from fb_task_fulbari
		where task_id = :ls_kam and task_emptype = :ls_lbtype and task_paybook = :ll_pay and task_type = :ls_type and trunc(:ld_frdt) between trunc(TASK_dt_from) and trunc(task_dt_to);
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Payment Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox('Warning!','Period From Of New Record Should Be > Period From & To Of Existing Recors, Please Check !!!')
			return 1
		end if	
	else
			ld_frdt = dw_1.getitemdatetime(row,'task_dt_from')
	end if
	
	if dwo.name = 'task_dt_to'  then
		ld_todt = datetime(data)
		ls_kam = dw_1.getitemstring(row,'task_id')
		ls_type = dw_1.getitemstring(row,'task_type')
		ls_lbtype = dw_1.getitemstring(row,'task_emptype')
		ll_pay = dw_1.getitemnumber(row,'task_paybook')
		
//		if date(ld_frdt) < today() then
//			messagebox('Warning','From Date Should Not Be < Current Date !!!')
//			return 1
//		end if

		if isnull(data) or isnull(ld_frdt) or data = '00/00/0000' or string(ld_frdt) = '00/00/0000' then
			messagebox('Warning!','From & To Date Should Not Be Blank, Please Check !!!')
			return 1
		end if		
		if date(ld_todt) < date(ld_frdt) then
			messagebox('Warning!','To Date Should Be > From Date, Please Check !!!')
			return 1
		end if
		
		if  wf_check_duplicate_rec(ls_kam,ls_lbtype,ll_pay,ls_type,ld_frdt,ld_todt) = -1 then return 1
		
		select distinct 'x' into :ls_temp from fb_task_fulbari
		where task_id = :ls_kam and task_emptype = :ls_lbtype and task_paybook = :ll_pay and task_type = :ls_type and trunc(TASK_dt_from) = trunc(:ld_frdt) and trunc(TASK_dt_to) = trunc(:ld_todt);
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Rate Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox("Warning!","Record Already Exists, Please Check !!!")
			return 1
		end if
	end if
    if dwo.name = 'task_avgrt_lower' then
		if data = 'Y' then
			ls_kam = dw_1.getitemstring(row,'task_id')
			ls_type = dw_1.getitemstring(row,'task_type')
			ld_cp1 = dw_1.getitemnumber(row,'task_changepoint')
			
			select kam.kamsub_afrate afrate, kam.kamsub_adfrate adfrate, kam.kamsub_cfrate cfrate
				into :ld_afrate, :ld_adfrate, :ld_cfrate 
			 from fb_kamsubhead kam
			where trim(kam.kamsub_id) = :ls_kam and KAMSUB_TODT is null;
			
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Labour Kamjari Rate Detail',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			end if
			if isnull(ld_cFrate) then ld_cFrate = 0
			if isnull(ld_adfrate) then ld_adfrate = 0
			if isnull(ld_afrate) then ld_afrate = 0
			if isnull(ld_cp1) then ld_cp1 = 0
			If ls_type = 'CHILD' Then
				if ld_cFrate = 0 then
					ld_rate =0
				else
					ld_rate = ld_cFrate / ld_cp1
				end if
				if isnull(ld_rate) then ld_rate = 0
				dw_1.setitem(row,'task_ratelower',ld_rate)
			 ElseIf ls_type = 'ADOLE' Then
				if ld_adfrate = 0 then
					ld_rate =0
				else
					ld_rate = ld_adfrate / ld_cp1
				end if
				if isnull(ld_rate) then ld_rate = 0
				dw_1.setitem(row,'task_ratelower',ld_rate)					 
			 ElseIf ls_type = 'ADULT' Then
				if ld_afrate = 0 then
					ld_rate =0
				else
					ld_rate = ld_afrate / ld_cp1
				end if
				if isnull(ld_rate) then ld_rate = 0
				dw_1.setitem(row,'task_ratelower',ld_rate)					 
			End If			
			
		end if
	end if
	
    if dwo.name = 'task_avgrt_upper' then
		if data = 'Y' then
			ls_kam = dw_1.getitemstring(row,'task_id')
			ls_type = dw_1.getitemstring(row,'task_type')
			ld_cp1 = dw_1.getitemnumber(row,'task_changepoint')
			
			select kam.kamsub_afrate afrate, kam.kamsub_adfrate adfrate, kam.kamsub_cfrate cfrate
				into :ld_afrate, :ld_adfrate, :ld_cfrate 
			 from fb_kamsubhead kam
			where trim(kam.kamsub_id) = :ls_kam and KAMSUB_TODT is null;
			
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Labour Kamjari Rate Detail',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			end if
			if isnull(ld_cFrate) then ld_cFrate = 0
			if isnull(ld_adfrate) then ld_adfrate = 0
			if isnull(ld_afrate) then ld_afrate = 0
			if isnull(ld_cp1) then ld_cp1 = 0
			If ls_type = 'CHILD' Then
				if ld_cFrate = 0 then
					ld_rate =0
				else
					ld_rate = ld_cFrate / ld_cp1
				end if
				if isnull(ld_rate) then ld_rate = 0
				dw_1.setitem(row,'task_rateupper',ld_rate)
			 ElseIf ls_type = 'ADOLE' Then
				if ld_adfrate = 0 then
					ld_rate =0
				else		
					 ld_rate = ld_adfrate / ld_cp1
				end if
				if isnull(ld_rate) then ld_rate = 0
				dw_1.setitem(row,'task_rateupper',ld_rate)					 
			 ElseIf ls_type = 'ADULT' Then
				if ld_afrate = 0 then
					ld_rate =0
				else						
					 ld_rate = ld_afrate / ld_cp1
				end if
				if isnull(ld_rate) then ld_rate = 0
				dw_1.setitem(row,'task_rateupper',ld_rate)					 
			End If			
			
		end if
	end if	
	if dwo.name = 'task_changepoint'  then
		dw_1.setitem(row,'task_changepoint2',double(data))
		//dw_1.setfocus (row,'task_rateupper')
	end if
	
	if dwo.name = 'task_rateupper'  then
		dw_1.setitem(row,'task_ratelower',double(data))
		dw_1.setitem(row,'task_rateupper2',double(data))
	end if

	
	dw_1.setitem(row,'task_entry_by',gs_user)
	dw_1.setitem(row,'task_entry_dt',datetime(today()))

cb_3.enabled = true
end if

if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if


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

SELECT COLUMN_ID,COLUMN_Name FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_task_fulbari');

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
												('fb_task_fulbari',:ls_unique_id,'U',:ls_columnname,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
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

