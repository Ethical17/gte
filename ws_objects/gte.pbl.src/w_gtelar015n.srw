$PBExportHeader$w_gtelar015n.srw
forward
global type w_gtelar015n from window
end type
type rb_2 from radiobutton within w_gtelar015n
end type
type rb_1 from radiobutton within w_gtelar015n
end type
type ddlb_3 from dropdownlistbox within w_gtelar015n
end type
type st_1 from statictext within w_gtelar015n
end type
type st_3 from statictext within w_gtelar015n
end type
type em_1 from editmask within w_gtelar015n
end type
type cb_1 from commandbutton within w_gtelar015n
end type
type cb_2 from commandbutton within w_gtelar015n
end type
type gb_1 from groupbox within w_gtelar015n
end type
type dw_1 from datawindow within w_gtelar015n
end type
type dw_2 from datawindow within w_gtelar015n
end type
end forward

global type w_gtelar015n from window
integer width = 4786
integer height = 2440
boolean titlebar = true
string title = "(Gtelar015) - LWW Register"
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
ddlb_3 ddlb_3
st_1 st_1
st_3 st_3
em_1 em_1
cb_1 cb_1
cb_2 cb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
end type
global w_gtelar015n w_gtelar015n

type variables
long ll_pbno,ll_user_level
n_cst_powerfilter iu_powerfilter
end variables

event ue_option();if rb_1.checked then
	choose case gs_ueoption
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
else
	choose case gs_ueoption
		case "PRINT"
				OpenWithParm(w_print,this.dw_2)
		case "PRINTPREVIEW"
				this.dw_2.modify("datawindow.print.preview = yes")
		case "RESETPREVIEW"
				this.dw_2.modify("datawindow.print.preview = no")
	case "ZOOM"
			SetPointer (HourGlass!)											
			OpenwithParm (w_zoom,dw_2)
			SetPointer (Arrow!)						
		case "SAVEAS"
				this.dw_2.saveas()
		case "SFILTER"
				iu_powerfilter.checked = NOT iu_powerfilter.checked
				iu_powerfilter.event ue_clicked()
				m_main.m_file.m_filter.checked = iu_powerfilter.checked				
		case "FILTER"
				setnull(gs_filtertext)
				this.dw_2.setredraw(false)
				this.dw_2.setfilter(gs_filtertext)
				this.dw_2.filter()
				this.dw_2.groupcalc()
				if this.dw_2.rowcount() > 0 then;
					this.dw_2.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
		case "SORT"
				setnull(gs_sorttext)
				this.dw_2.setredraw(false)
				this.dw_2.setsort(gs_sorttext)
				this.dw_2.sort()
				this.dw_2.groupcalc()
				if this.dw_2.rowcount() > 0 then;
					this.dw_2.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
	end choose	
end if
end event

on w_gtelar015n.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.ddlb_3=create ddlb_3
this.st_1=create st_1
this.st_3=create st_3
this.em_1=create em_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.rb_2,&
this.rb_1,&
this.ddlb_3,&
this.st_1,&
this.st_3,&
this.em_1,&
this.cb_1,&
this.cb_2,&
this.gb_1,&
this.dw_1,&
this.dw_2}
end on

on w_gtelar015n.destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.ddlb_3)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.em_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dw_2.modify("t_co.text = '"+gs_co_name+"'")
dw_2.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

em_1.text = string(today(),'yyyy')
dw_1.settransobject(sqlca)

ddlb_3.reset()
ddlb_3.additem('ALL')

declare c2 cursor for
select distinct b.ls_id from FB_EMPLOYEE a,FB_LABOURSHEET b 
where a.ls_id = b.ls_id and b.ls_id is not null 
order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ll_pbno;
	do while sqlca.sqlcode <> 100
		ddlb_3.additem(string(ll_pbno))
		fetch c2 into:ll_pbno;
	loop
	close c2;
end if

ddlb_3.text = 'ALL'


select pfa_permission into :ll_user_level from fb_pf_access where pfa_user_id=:gs_user and nvl(pfa_active,'N')='Y';
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Access',sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 100 then
	messagebox('Warning : NO access Provided',sqlca.sqlerrtext)
	return 1
end if	
setpointer(arrow!)
end event

type rb_2 from radiobutton within w_gtelar015n
integer x = 1591
integer y = 44
integer width = 311
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Summary"
end type

event clicked;dw_1.hide()
dw_2.show()
end event

type rb_1 from radiobutton within w_gtelar015n
integer x = 1280
integer y = 44
integer width = 279
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detail"
boolean checked = true
end type

event clicked;dw_2.hide()
dw_1.show()
end event

type ddlb_3 from dropdownlistbox within w_gtelar015n
integer x = 855
integer y = 28
integer width = 297
integer height = 636
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
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

type st_1 from statictext within w_gtelar015n
integer x = 498
integer y = 40
integer width = 347
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pay Book No."
boolean focusrectangle = false
end type

type st_3 from statictext within w_gtelar015n
integer x = 9
integer y = 32
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

type em_1 from editmask within w_gtelar015n
integer x = 242
integer y = 20
integer width = 242
integer height = 92
integer taborder = 10
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

type cb_1 from commandbutton within w_gtelar015n
integer x = 1966
integer y = 28
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
dw_2.settransobject(sqlca)

setpointer(hourglass!)

if isnull(em_1.text) or em_1.text='0000' then
	messagebox('Warning','Please Enter The Season')
	return 
end if

if long(em_1.text) > long(string(today(),'yyyy'))  then
	messagebox('Alert!','Year Should Not Be > Current Year, Please Check !!!')
	return 1
end if

if ll_user_level<>0 then
	if rb_1.checked then
		dw_1.show()
		dw_2.hide()
		dw_1.retrieve(em_1.text,long(ddlb_3.text),ll_user_level)
		if dw_1.rowcount() = 0 then
			messagebox('Alert!','No Data Found !!!')
			return 1
		end if
	else
		dw_1.hide()
		dw_2.show()
		dw_2.retrieve(em_1.text,long(ddlb_3.text),ll_user_level)
		if dw_2.rowcount() = 0 then
			messagebox('Alert!','No Data Found !!!')
			return 1
		end if
	end if	
else 
	messagebox('Information!','No Access !!!')
	return 1
end if
setpointer(arrow!)

end event

type cb_2 from commandbutton within w_gtelar015n
integer x = 2231
integer y = 28
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

type gb_1 from groupbox within w_gtelar015n
integer x = 1253
integer width = 686
integer height = 128
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_1 from datawindow within w_gtelar015n
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 140
integer width = 4453
integer height = 2184
string dataobject = "dw_gtelar015n"
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

type dw_2 from datawindow within w_gtelar015n
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 140
integer width = 4745
integer height = 2184
integer taborder = 40
string dataobject = "dw_gtelar015sn"
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

