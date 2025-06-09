$PBExportHeader$w_gtelar049_mt.srw
forward
global type w_gtelar049_mt from window
end type
type st_1 from statictext within w_gtelar049_mt
end type
type ddlb_3 from dropdownlistbox within w_gtelar049_mt
end type
type st_3 from statictext within w_gtelar049_mt
end type
type em_1 from editmask within w_gtelar049_mt
end type
type ddlb_2 from dropdownlistbox within w_gtelar049_mt
end type
type st_2 from statictext within w_gtelar049_mt
end type
type cb_1 from commandbutton within w_gtelar049_mt
end type
type cb_2 from commandbutton within w_gtelar049_mt
end type
type dw_1 from datawindow within w_gtelar049_mt
end type
end forward

global type w_gtelar049_mt from window
integer width = 3867
integer height = 2604
boolean titlebar = true
string title = "(Gtelar049) - LWW Bank Sheet"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_1 st_1
ddlb_3 ddlb_3
st_3 st_3
em_1 em_1
ddlb_2 ddlb_2
st_2 st_2
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_gtelar049_mt w_gtelar049_mt

type variables
long ll_pbno
string ls_temp, ls_dt,ls_labid,ls_measure,ls_measure1,ls_first_read,ls_old_labour, ls_type,ls_bank,ls_emptype
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

on w_gtelar049_mt.create
this.st_1=create st_1
this.ddlb_3=create ddlb_3
this.st_3=create st_3
this.em_1=create em_1
this.ddlb_2=create ddlb_2
this.st_2=create st_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.ddlb_3,&
this.st_3,&
this.em_1,&
this.ddlb_2,&
this.st_2,&
this.cb_1,&
this.cb_2,&
this.dw_1}
end on

on w_gtelar049_mt.destroy
destroy(this.st_1)
destroy(this.ddlb_3)
destroy(this.st_3)
destroy(this.em_1)
destroy(this.ddlb_2)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

//em_1.text = '01'+right(string(today(),'dd/mm/yyyy'),8)
setpointer(hourglass!)

em_1.text = string(today(),'yyyy')

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

setpointer(Arrow!)
end event

type st_1 from statictext within w_gtelar049_mt
integer x = 2222
integer y = 28
integer width = 370
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Labour Type : "
boolean focusrectangle = false
end type

type ddlb_3 from dropdownlistbox within w_gtelar049_mt
integer x = 2610
integer y = 20
integer width = 590
integer height = 608
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"ALL","Permanent","Temporary","Outsider"}
end type

type st_3 from statictext within w_gtelar049_mt
integer x = 46
integer y = 28
integer width = 224
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year : "
boolean focusrectangle = false
end type

type em_1 from editmask within w_gtelar049_mt
integer x = 279
integer y = 16
integer width = 242
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy"
end type

type ddlb_2 from dropdownlistbox within w_gtelar049_mt
integer x = 731
integer y = 20
integer width = 1422
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

type st_2 from statictext within w_gtelar049_mt
integer x = 553
integer y = 28
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

type cb_1 from commandbutton within w_gtelar049_mt
integer x = 3232
integer y = 12
integer width = 265
integer height = 100
integer taborder = 30
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

if isnull(em_1.text) or em_1.text='0000' then
	messagebox('Warning','Please Enter The Season')
	return 
end if

if long(em_1.text) > long(string(today(),'yyyy'))  then
	messagebox('Alert!','Season Should Not Be > Current Season, Please Check !!!')
	return 1
end if

if isnull(ddlb_2.text)  then
	messagebox('Warning','Please Select Bank !!!')
	return 
end if

if isnull(ddlb_3.text)  then
	messagebox('Warning','Please Select Labour Type !!!')
	return 
end if

ls_bank = ddlb_2.text

if ddlb_3.text = 'Permanent' then
	ls_emptype = 'LP'
elseif ddlb_3.text = 'Temporary' then
	ls_emptype = 'LT'
elseif ddlb_3.text = 'Outsider' then	
	ls_emptype = 'LO'
elseif ddlb_3.text = 'ALL' then
	ls_emptype = 'ALL'
end if


ls_type = ddlb_2.text


dw_1.retrieve(em_1.text,ls_type,ls_emptype)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if
setpointer(Arrow!)
end event

type cb_2 from commandbutton within w_gtelar049_mt
integer x = 3497
integer y = 12
integer width = 265
integer height = 100
integer taborder = 40
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

type dw_1 from datawindow within w_gtelar049_mt
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 3826
integer height = 2372
string dataobject = "dw_gtelar049_mt"
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

