$PBExportHeader$w_gteacr035.srw
forward
global type w_gteacr035 from window
end type
type cb_3 from commandbutton within w_gteacr035
end type
type ddlb_1 from dropdownlistbox within w_gteacr035
end type
type st_4 from statictext within w_gteacr035
end type
type st_6 from statictext within w_gteacr035
end type
type dp_1 from datepicker within w_gteacr035
end type
type st_1 from statictext within w_gteacr035
end type
type dp_2 from datepicker within w_gteacr035
end type
type st_2 from statictext within w_gteacr035
end type
type em_3 from editmask within w_gteacr035
end type
type cb_2 from commandbutton within w_gteacr035
end type
type cb_1 from commandbutton within w_gteacr035
end type
type dw_1 from datawindow within w_gteacr035
end type
end forward

global type w_gteacr035 from window
integer width = 3863
integer height = 2484
boolean titlebar = true
string title = "(W_gteacr005) General Ledger"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_3 cb_3
ddlb_1 ddlb_1
st_4 st_4
st_6 st_6
dp_1 dp_1
st_1 st_1
dp_2 dp_2
st_2 st_2
em_3 em_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteacr035 w_gteacr035

type variables
string ls_gl,ls_frym,ls_toym
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

on w_gteacr035.create
this.cb_3=create cb_3
this.ddlb_1=create ddlb_1
this.st_4=create st_4
this.st_6=create st_6
this.dp_1=create dp_1
this.st_1=create st_1
this.dp_2=create dp_2
this.st_2=create st_2
this.em_3=create em_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_3,&
this.ddlb_1,&
this.st_4,&
this.st_6,&
this.dp_1,&
this.st_1,&
this.dp_2,&
this.st_2,&
this.em_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteacr035.destroy
destroy(this.cb_3)
destroy(this.ddlb_1)
destroy(this.st_4)
destroy(this.st_6)
destroy(this.dp_1)
destroy(this.st_1)
destroy(this.dp_2)
destroy(this.st_2)
destroy(this.em_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_1.settransobject( sqlca);
em_3.text=gs_garden_snm

ddlb_1.reset()
ddlb_1.additem('ALL')
declare c1 cursor for
select distinct LM_HOLEDGER from fb_acledger order by 1;
		
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_gl;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_gl)
		fetch c1 into :ls_gl;
	loop
	close c1;
end if

ddlb_1.text='ALL'


setpointer(arrow!)







end event

type cb_3 from commandbutton within w_gteacr035
integer x = 2441
integer y = 108
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Search"
end type

event clicked;SetPointer (HourGlass!)											
OpenwithParm (w_search,dw_1)
SetPointer (Arrow!)			
end event

type ddlb_1 from dropdownlistbox within w_gteacr035
integer x = 873
integer y = 20
integer width = 1083
integer height = 672
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_gteacr035
integer x = 539
integer y = 28
integer width = 311
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ledger Code"
boolean focusrectangle = false
end type

type st_6 from statictext within w_gteacr035
integer x = 1970
integer y = 24
integer width = 393
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Period From :"
alignment alignment = center!
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gteacr035
integer x = 2363
integer y = 8
integer width = 370
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2025-01-31"), Time("09:10:00.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_1 from statictext within w_gteacr035
integer x = 2743
integer y = 32
integer width = 151
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To :"
alignment alignment = center!
boolean focusrectangle = false
end type

type dp_2 from datepicker within w_gteacr035
integer x = 2898
integer y = 8
integer width = 366
integer height = 100
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2025-01-31"), Time("09:10:00.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_2 from statictext within w_gteacr035
integer x = 23
integer y = 24
integer width = 256
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Unit Code"
boolean focusrectangle = false
end type

type em_3 from editmask within w_gteacr035
integer x = 279
integer y = 20
integer width = 261
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean enabled = false
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string minmax = "~~"
end type

type cb_2 from commandbutton within w_gteacr035
integer x = 3552
integer y = 8
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

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_gteacr035
integer x = 3287
integer y = 8
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;if isnull(dp_1.text) or dp_1.text='00/00/0000' then
	messagebox('Warning','Please Enter The "From" Date !!!')
	return 
end if

if isnull(dp_2.text) or dp_2.text='00/00/0000' then
	messagebox('Warning','Please Enter The "To" Date !!!')
	return 
end if

if date(dp_1.text) > date(dp_2.text)  then
	messagebox('Warning ','The From Date Should be <= TO Date , Please check ...!')
	return 1
end if


ls_frym =dp_1.text
ls_toym =dp_2.text

if isnull(ddlb_1.text) or len(ddlb_1.text) <1 then 
	messagebox('Error :','Please Select a Valid Ledger Id Should be Enter') 
end if


date  ld_st_year,ld_end_year
setnull(ls_gl)

if(ddlb_1.text='ALL') then 
	ls_gl='ALL'
else
	ls_gl=ddlb_1.text;	
end if

select to_date('31/03'||decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-4),-1,decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-3),1,0,to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY'))-1),to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY'))),'dd/mm/yyyy')+1 fy_stdt ,
		to_date('31/03'||(decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-4),-1,decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-3),1,0,to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY'))-1),to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY')))+1),'dd/mm/yyyy')fy_enddt 
		into :ld_st_year,:ld_end_year
  from dual;
  
dw_1.show()
dw_1.settransobject(sqlca)
dw_1.retrieve(ls_gl,ls_frym,ls_toym,string(ld_st_year))

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found')
	return 1
end if




end event

type dw_1 from datawindow within w_gteacr035
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 228
integer width = 3781
integer height = 2228
string dataobject = "dw_gteacr035"
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

