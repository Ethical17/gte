$PBExportHeader$w_gteflr005.srw
forward
global type w_gteflr005 from window
end type
type em_2 from editmask within w_gteflr005
end type
type st_3 from statictext within w_gteflr005
end type
type st_2 from statictext within w_gteflr005
end type
type ddlb_1 from dropdownlistbox within w_gteflr005
end type
type cb_2 from commandbutton within w_gteflr005
end type
type cb_1 from commandbutton within w_gteflr005
end type
type st_1 from statictext within w_gteflr005
end type
type dp_1 from datepicker within w_gteflr005
end type
type dw_1 from datawindow within w_gteflr005
end type
end forward

global type w_gteflr005 from window
integer width = 4818
integer height = 2392
boolean titlebar = true
string title = "(Gteflr005) - Daily Plucking"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
em_2 em_2
st_3 st_3
st_2 st_2
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
st_1 st_1
dp_1 dp_1
dw_1 dw_1
end type
global w_gteflr005 w_gteflr005

type variables
n_cst_powerfilter iu_powerfilter
string ls_division
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

on w_gteflr005.create
this.em_2=create em_2
this.st_3=create st_3
this.st_2=create st_2
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.dp_1=create dp_1
this.dw_1=create dw_1
this.Control[]={this.em_2,&
this.st_3,&
this.st_2,&
this.ddlb_1,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.dp_1,&
this.dw_1}
end on

on w_gteflr005.destroy
destroy(this.em_2)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.dp_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")


ddlb_1.reset()
ddlb_1.additem('ALL')

declare c2 cursor for
select FIELD_NAME||' ('||FIELD_ID||')' from FB_FIELD where nvl(FIELD_ACTIVE_IND,'Y') = 'Y' order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ls_division;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_division)
		fetch c2 into:ls_division;
	loop
	close c2;
end if

ddlb_1.text = 'ALL'
setpointer(arrow!)

em_2.text = right(string(today()),4)
end event

type em_2 from editmask within w_gteflr005
integer x = 2766
integer y = 16
integer width = 247
integer height = 88
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "0000"
boolean spin = true
string displaydata = "~t/"
double increment = 1
string minmax = "2000~~2999"
end type

type st_3 from statictext within w_gteflr005
integer x = 2295
integer y = 28
integer width = 494
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Prunning Season : "
boolean focusrectangle = false
end type

type st_2 from statictext within w_gteflr005
integer x = 23
integer y = 32
integer width = 215
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Division"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gteflr005
integer x = 242
integer y = 20
integer width = 1179
integer height = 608
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
end type

type cb_2 from commandbutton within w_gteflr005
integer x = 3291
integer y = 8
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_gteflr005
integer x = 3026
integer y = 8
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
boolean default = true
end type

event clicked;dw_1.settransobject(sqlca)

setpointer(hourglass!)

if isnull(dp_1.text) or dp_1.text='00/00/0000' then
	messagebox('Warning','Please Enter The "From" Date !!!')
	return 
end if

string ls_year_ind,ls_frdt,ls_todt,ls_ysdt,ls_ly_frdt,ls_ly_todt,ls_ly_ysdt

ls_frdt = dp_1.text 
ls_year_ind='C'

select decode(:ls_year_ind,'C','01/01/'||to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'),to_char(to_date((decode(sign(to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy')))||'0401'),'yyyymmdd'),'dd/mm/yyyy')),
		decode(substr(:ls_frdt,1,5),'29/02',('28/02/'||(to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1)), (to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'dd/mm/')||(to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1))),
		decode(:ls_year_ind,'C','01/01/'||to_char((to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1)),to_char(to_date((decode(sign(to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-2,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1)||'0401'),'yyyymmdd'),'dd/mm/yyyy'))
  into :ls_ysdt,:ls_ly_frdt,:ls_ly_ysdt from dual;

ls_division = left(right(ddlb_1.text,6),5)

dw_1.retrieve(ls_division,ls_frdt,ls_ysdt,ls_ly_frdt,ls_ly_ysdt, long(em_2.text))

setpointer(arrow!)

end event

type st_1 from statictext within w_gteflr005
integer x = 1449
integer y = 28
integer width = 421
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Plucking Date : "
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gteflr005
integer x = 1883
integer y = 12
integer width = 389
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2016-03-01"), Time("12:48:37.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dw_1 from datawindow within w_gteflr005
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 120
integer width = 4485
integer height = 2088
string dataobject = "dw_gteflr005"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
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

