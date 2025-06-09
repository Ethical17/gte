$PBExportHeader$w_gtelar039.srw
forward
global type w_gtelar039 from window
end type
type st_3 from statictext within w_gtelar039
end type
type st_1 from statictext within w_gtelar039
end type
type cb_2 from commandbutton within w_gtelar039
end type
type cb_1 from commandbutton within w_gtelar039
end type
type ddlb_2 from dropdownlistbox within w_gtelar039
end type
type ddlb_1 from dropdownlistbox within w_gtelar039
end type
type dw_1 from datawindow within w_gtelar039
end type
end forward

global type w_gtelar039 from window
integer width = 4009
integer height = 2468
boolean titlebar = true
string title = "(Gtelar039) - Ration Slip"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_3 st_3
st_1 st_1
cb_2 cb_2
cb_1 cb_1
ddlb_2 ddlb_2
ddlb_1 ddlb_1
dw_1 dw_1
end type
global w_gtelar039 w_gtelar039

type variables
string ls_LWW_ID 
long ll_si,ll_pbno
n_cst_powerfilter iu_powerfilter
end variables

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
	case "SFILTER"
			iu_powerfilter.checked = NOT iu_powerfilter.checked
			iu_powerfilter.event ue_clicked()
			m_main.m_file.m_filter.checked = iu_powerfilter.checked			
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

on w_gtelar039.create
this.st_3=create st_3
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.ddlb_2=create ddlb_2
this.ddlb_1=create ddlb_1
this.dw_1=create dw_1
this.Control[]={this.st_3,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.ddlb_2,&
this.ddlb_1,&
this.dw_1}
end on

on w_gtelar039.destroy
destroy(this.st_3)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.ddlb_2)
destroy(this.ddlb_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dw_1.settransobject(sqlca)

setpointer(hourglass!)
string ls_dt, ls_period
ddlb_1.reset()

declare c1 cursor for
select distinct (to_char(RPFW_STARTDATE,'dd/mm/yyyy')||' - '||to_char(RPFW_ENDDATE,'dd/mm/yyyy')||' ('||RPFW_ID||')') lww_id,rpfw_startdate
   from fb_labourweeklyration a, fb_rationperiodforweek b 
   where a.LRW_ID = b.RPFW_ID
 order by rpfw_startdate desc;

open c1;
IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ls_period,:ls_dt;
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_period)
		setnull(ls_period);setnull(ls_dt)
		fetch c1 into :ls_period,:ls_dt;
	loop
close c1;
end if


ddlb_2.reset( )

ddlb_2.additem('00-ALL')

declare c2 cursor for
select distinct LS_ID from fb_laboursheet order by 1;

open c2;
IF sqlca.sqlcode = 0 THEN 
		fetch c2 into :ll_si;
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(string(ll_si))
		setnull(ll_si);
		fetch c2 into :ll_si;
	loop
	close c2;
end if
setpointer(arrow!)

end event

type st_3 from statictext within w_gtelar039
integer x = 27
integer width = 233
integer height = 116
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Labour Weeks"
boolean focusrectangle = false
end type

type st_1 from statictext within w_gtelar039
integer x = 1449
integer y = 24
integer width = 343
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pay Book No:"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gtelar039
integer x = 2395
integer y = 12
integer width = 256
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Close"
end type

event clicked;Close(parent)
end event

type cb_1 from commandbutton within w_gtelar039
integer x = 2139
integer y = 12
integer width = 256
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "OK"
end type

event clicked;dw_1.settransobject(sqlca)
dw_1.retrieve(left(right(ddlb_1.text,15),14),long(left(ddlb_2.text,2)))
if dw_1.rowcount() = 0 then
	messagebox('Information!','No data Found !!!')
	return 1
end if

end event

type ddlb_2 from dropdownlistbox within w_gtelar039
integer x = 1792
integer y = 20
integer width = 334
integer height = 1104
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type ddlb_1 from dropdownlistbox within w_gtelar039
integer x = 274
integer y = 16
integer width = 1147
integer height = 1104
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;
setpointer(hourglass!)
setnull(ls_LWW_ID)

ls_LWW_ID = left(right(ddlb_1.text,15),14)

ddlb_2.reset( )

ddlb_2.additem('00-ALL')

declare c2 cursor for
select distinct a.ls_id
   from FB_EMPLOYEE a, fb_labourweeklyration c 
   where a.emp_id = c.LABOUR_ID and c.LRW_ID = :ls_LWW_ID
 order by 1;

open c2;
IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ll_pbno;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(string(ll_pbno))
		fetch c2 into:ll_pbno;
	loop
	close c2;
end if

setpointer(arrow!)

end event

type dw_1 from datawindow within w_gtelar039
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 116
integer width = 3849
integer height = 1924
string dataobject = "dw_gtelar039"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF
end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

