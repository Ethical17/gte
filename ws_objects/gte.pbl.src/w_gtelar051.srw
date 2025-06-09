$PBExportHeader$w_gtelar051.srw
forward
global type w_gtelar051 from window
end type
type ddlb_3 from dropdownlistbox within w_gtelar051
end type
type st_3 from statictext within w_gtelar051
end type
type ddlb_2 from dropdownlistbox within w_gtelar051
end type
type cb_1 from commandbutton within w_gtelar051
end type
type cb_2 from commandbutton within w_gtelar051
end type
type st_2 from statictext within w_gtelar051
end type
type dw_1 from datawindow within w_gtelar051
end type
end forward

global type w_gtelar051 from window
integer width = 4453
integer height = 2604
boolean titlebar = true
string title = "(Gtelar051) - Worker Bank Details"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
ddlb_3 ddlb_3
st_3 st_3
ddlb_2 ddlb_2
cb_1 cb_1
cb_2 cb_2
st_2 st_2
dw_1 dw_1
end type
global w_gtelar051 w_gtelar051

type variables
long ll_pbno
string ls_temp, ls_dt,ls_labid,ls_measure,ls_measure1,ls_first_read,ls_old_labour, ls_type, ls_bank
datetime ld_dt
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

on w_gtelar051.create
this.ddlb_3=create ddlb_3
this.st_3=create st_3
this.ddlb_2=create ddlb_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.dw_1=create dw_1
this.Control[]={this.ddlb_3,&
this.st_3,&
this.ddlb_2,&
this.cb_1,&
this.cb_2,&
this.st_2,&
this.dw_1}
end on

on w_gtelar051.destroy
destroy(this.ddlb_3)
destroy(this.st_3)
destroy(this.ddlb_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

//em_1.text = '01'+right(string(today(),'dd/mm/yyyy'),8)
setpointer(hourglass!)
//declare c1 cursor for
//select distinct to_char(LWW_STARTDATE,'dd/mm/yyyy')||'-'||to_char(LWW_ENDDATE,'dd/mm/yyyy'),LWW_STARTDATE
//  from FB_LABOURWEEKLYWAGES a, fb_LABOURWAGESWEEK b
//  where a.LWW_ID=b.LWW_ID
//order by LWW_STARTDATE desc;
//
//open c1;
//
//IF sqlca.sqlcode = 0 THEN 
//	fetch c1 into :ls_dt,:ld_dt;
//	
//	do while sqlca.sqlcode <> 100
//		ddlb_1.additem(ls_dt)
//		fetch c1 into:ls_dt,:ld_dt;
//	loop
//	close c1;
//end if

ddlb_2.additem('ALL')

declare c2 cursor for
select distinct EMP_BANK_NAME from FB_employee order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ls_bank;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(ls_bank)
		setnull(ls_bank);
		fetch c2 into :ls_bank;
	loop
	close c2;
end if

ddlb_2.text = 'ALL'


ddlb_3.reset()
ddlb_3.additem('0')

declare c3 cursor for
select distinct ls_id from FB_EMPLOYEE  order by 1;

open c3;

IF sqlca.sqlcode = 0 THEN 
	fetch c3 into :ll_pbno;
	
	do while sqlca.sqlcode <> 100
		ddlb_3.additem(string(ll_pbno))
		fetch c3 into:ll_pbno;
	loop
	close c3;
end if

ddlb_3.text = '0'
setpointer(arrow!)
end event

type ddlb_3 from dropdownlistbox within w_gtelar051
integer x = 2258
integer y = 8
integer width = 325
integer height = 608
integer taborder = 30
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

type st_3 from statictext within w_gtelar051
integer x = 1664
integer y = 20
integer width = 562
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pay Book No. (0-ALL)"
boolean focusrectangle = false
end type

type ddlb_2 from dropdownlistbox within w_gtelar051
integer x = 187
integer y = 8
integer width = 1408
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

type cb_1 from commandbutton within w_gtelar051
integer x = 2624
integer y = 8
integer width = 265
integer height = 100
integer taborder = 40
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


if isnull(ddlb_2.text)  then
	messagebox('Warning','Please Select Bank !!!')
	return 
end if


string ls_fr_dt

//ls_fr_dt = left(ddlb_1.text,10)

ls_bank = ddlb_2.text

dw_1.retrieve(ls_bank,gs_garden_snm,long(ddlb_3.text))

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if
setpointer(Arrow!)
end event

type cb_2 from commandbutton within w_gtelar051
integer x = 2894
integer y = 8
integer width = 265
integer height = 100
integer taborder = 50
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

type st_2 from statictext within w_gtelar051
integer x = 18
integer y = 20
integer width = 169
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bank"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gtelar051
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 128
integer width = 4398
integer height = 2368
string dataobject = "dw_gtelar051"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
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

