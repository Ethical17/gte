$PBExportHeader$w_gteacr010.srw
forward
global type w_gteacr010 from window
end type
type dp_1 from datepicker within w_gteacr010
end type
type st_1 from statictext within w_gteacr010
end type
type cb_2 from commandbutton within w_gteacr010
end type
type cb_1 from commandbutton within w_gteacr010
end type
type dw_1 from datawindow within w_gteacr010
end type
end forward

global type w_gteacr010 from window
integer width = 4379
integer height = 2468
boolean titlebar = true
string title = "(W_gteacr010) Trial Balance"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
dp_1 dp_1
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteacr010 w_gteacr010

type variables
string ls_gl,ls_frym, ls_toym
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

on w_gteacr010.create
this.dp_1=create dp_1
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.dp_1,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteacr010.destroy
destroy(this.dp_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_1.settransobject( sqlca);

dp_1.setfocus()

//if gs_garden_snm = 'MV' or gs_garden_snm='GP' then
//	dw_1.dataobject="dw_gteacr010_mvgp"
//end if

//dp_1.text = string(today())
//dp_2.text = string(today())

//	        sum(decode(a.ACLEDGER_CUMLATIVE_IND,'C',decode(a.ACLEDGER_ACTYPE,'A',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),'E',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),0),
//				                                                         'H',decode(trunc(VH_VOU_DATE),to_date(:fy_end_dt,'dd/mm/yyyy'),0,decode(a.ACLEDGER_ACTYPE,'A',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),'E',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),0)),
//			                                                                  decode(sign(trunc(VH_VOU_DATE)- to_date(:fy_st_dt,'dd/mm/yyyy')),1,decode(a.ACLEDGER_ACTYPE,'A',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),'E',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),0)))) dr_cols,
//             sum(decode(a.ACLEDGER_CUMLATIVE_IND,'C',decode(a.ACLEDGER_ACTYPE,'L',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),'I',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),0),
//                                      	                                   'H',decode(trunc(VH_VOU_DATE),to_date(:fy_end_dt,'dd/mm/yyyy'),0,decode(a.ACLEDGER_ACTYPE,'L',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),'I',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),0)),
//			                                                                  decode(sign(trunc(VH_VOU_DATE) - to_date(:fy_st_dt,'dd/mm/yyyy')),1,decode(a.ACLEDGER_ACTYPE,'L',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),'I',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),0)))) cr_cols	

end event

type dp_1 from datepicker within w_gteacr010
integer x = 384
integer y = 4
integer width = 393
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2025-03-07"), Time("11:52:50.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_1 from statictext within w_gteacr010
integer x = 18
integer y = 20
integer width = 366
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "As On Date :"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gteacr010
integer x = 1079
integer y = 4
integer width = 265
integer height = 100
integer taborder = 40
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

type cb_1 from commandbutton within w_gteacr010
integer x = 818
integer y = 4
integer width = 265
integer height = 100
integer taborder = 30
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

ls_frym =dp_1.text

date  ld_st_year,ld_end_year

select to_date('01/04'||decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-4),-1,decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-3),1,0,to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY'))-1),to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY'))),'dd/mm/yyyy') fy_stdt ,
		to_date('31/03'||(decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-4),-1,decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-3),1,0,to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY'))-1),to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY')))+1),'dd/mm/yyyy')fy_enddt 
		into :ld_st_year,:ld_end_year
  from dual;
								  


dw_1.dataobject='dw_gteacr010'

dw_1.settransobject(sqlca)
dw_1.retrieve(ls_frym, string(ld_st_year,'dd/mm/yyyy'),string(ld_end_year,'dd/mm/yyyy'),gs_garden_snm)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found')
	return 1
end if

end event

type dw_1 from datawindow within w_gteacr010
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 3781
integer height = 2228
string dataobject = "dw_gteacr010"
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

event doubleclicked;date  ld_st_year,ld_end_year
string ls_gl_code,ls_dwName,ls_sgl_code,ls_data
	
ls_frym =dp_1.text
ls_dwName=dwo.name

integer li_row
li_row = this.GetRow()

		
select to_date('01/04'||decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-4),-1,decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-3),1,0,to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY'))-1),to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY'))),'dd/mm/yyyy') fy_stdt ,
		to_date('31/03'||(decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-4),-1,decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-3),1,0,to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY'))-1),to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY')))+1),'dd/mm/yyyy')fy_enddt 
		into :ld_st_year,:ld_end_year
from dual;


if ls_dwName='gl_desc' then
	if row > 0 then
		
		ls_gl_code = dw_1.getitemstring(row,'gl_code')
		if not isnull(ls_gl_code) then
			dw_1.dataobject='dw_gteacr005'
			dw_1.settransobject(sqlca)		
			dw_1.retrieve(ls_gl_code,string(ld_st_year),ls_frym,string(ld_st_year))
		end if
	end if
elseif ls_dwName='compute_12' then
	if dw_1.rowcount() > 0 then
		
		ls_gl_code = dw_1.getitemstring(row,'vd_gl_cd')
		ls_sgl_code = dw_1.getitemstring(row,'vd_sgl_cd')
		if not isnull(ls_gl_code) then
			dw_1.dataobject='dw_gteacr006'
			dw_1.settransobject(sqlca)		
			dw_1.retrieve(string(ld_st_year),ls_frym,ls_gl_code,ls_sgl_code)
		end if
	end if
end if 
end event

