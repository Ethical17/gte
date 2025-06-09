$PBExportHeader$w_gteacr027.srw
forward
global type w_gteacr027 from window
end type
type rb_2 from radiobutton within w_gteacr027
end type
type rb_1 from radiobutton within w_gteacr027
end type
type dp_1 from datepicker within w_gteacr027
end type
type st_1 from statictext within w_gteacr027
end type
type cb_2 from commandbutton within w_gteacr027
end type
type cb_1 from commandbutton within w_gteacr027
end type
type gb_1 from groupbox within w_gteacr027
end type
type dw_1 from datawindow within w_gteacr027
end type
end forward

global type w_gteacr027 from window
integer width = 4338
integer height = 2468
boolean titlebar = true
string title = "(w_gteacr027) Garden Cost"
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
dp_1 dp_1
st_1 st_1
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
dw_1 dw_1
end type
global w_gteacr027 w_gteacr027

type variables
string ls_gl,ls_frym, ls_toym,ls_ason
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

on w_gteacr027.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dp_1=create dp_1
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.dw_1=create dw_1
this.Control[]={this.rb_2,&
this.rb_1,&
this.dp_1,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.gb_1,&
this.dw_1}
end on

on w_gteacr027.destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dp_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
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

type rb_2 from radiobutton within w_gteacr027
integer x = 928
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
boolean checked = true
end type

type rb_1 from radiobutton within w_gteacr027
integer x = 1271
integer y = 44
integer width = 251
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
end type

type dp_1 from datepicker within w_gteacr027
integer x = 384
integer y = 36
integer width = 393
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2021-04-23"), Time("17:40:29.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_1 from statictext within w_gteacr027
integer x = 18
integer y = 52
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

type cb_2 from commandbutton within w_gteacr027
integer x = 1842
integer y = 32
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

type cb_1 from commandbutton within w_gteacr027
integer x = 1582
integer y = 32
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

ls_ason =dp_1.text

//date  ld_st_year,ld_end_year

//select to_date('01/04'||decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-4),-1,decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-3),1,0,to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY'))-1),to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY'))),'dd/mm/yyyy') fy_stdt ,
//		to_date('31/03'||(decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-4),-1,decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-3),1,0,to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY'))-1),to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY')))+1),'dd/mm/yyyy')fy_enddt 
//		into :ld_st_year,:ld_end_year
//  from dual;
  

 EXECUTE immediate "truncate table fb_gardenexp_realloc";
 
 
 insert into fb_gardenexp_realloc
SELECT initcap(ACSUBLEDGER_NAME) EACHEAD_NAME, d.EACSUBHEAD_NAME,d.EACSUBHEAD_ID, a.ACSUBLEDGER_ID,  
       sum(nvl(e.DE_SALARYtodate,0)) DE_SALARYtodate, sum(nvl(e.DE_WAGEStodate,0)) DE_WAGEStodate, 
       sum(nvl(e.DE_STOREStodate,0)) DE_STOREStodate, sum(nvl(e.DE_OTHERStodate,0)) DE_OTHERStodate, 
       sum(nvl(e.totaltodate,0)) totaltodate
FROM   FB_ACSUBLEDGER a, FB_ACLEDGER c, FB_EXPENSEACSUBHEAD d, 
        (SELECT eacsubhead_id, 
                    sum(decode(decode(sign(to_number(to_char(DE_DATE,'mm')) - 4),-1,to_number(to_char(DE_DATE,'yyyy'))-1,to_number(to_char(DE_DATE,'yyyy'))),decode(sign(to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'yyyy'))),nvl(DE_SALARYTODAYTY,0),0)) DE_SALARYtodate,
                     sum(decode(decode(sign(to_number(to_char(DE_DATE,'mm')) - 4),-1,to_number(to_char(DE_DATE,'yyyy'))-1,to_number(to_char(DE_DATE,'yyyy'))),decode(sign(to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'yyyy'))),nvl(DE_WAGESTODAYTY,0),0)) DE_WAGEStodate,
                     sum(decode(decode(sign(to_number(to_char(DE_DATE,'mm')) - 4),-1,to_number(to_char(DE_DATE,'yyyy'))-1,to_number(to_char(DE_DATE,'yyyy'))),decode(sign(to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'yyyy'))),nvl(DE_STORESTODAYTY,0),0)) DE_STOREStodate, 
                     sum(decode(decode(sign(to_number(to_char(DE_DATE,'mm')) - 4),-1,to_number(to_char(DE_DATE,'yyyy'))-1,to_number(to_char(DE_DATE,'yyyy'))),decode(sign(to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'yyyy'))),nvl(DE_OTHERSTODAYTY,0),0)) DE_OTHERStodate, 
                     sum(decode(decode(sign(to_number(to_char(DE_DATE,'mm')) - 4),-1,to_number(to_char(DE_DATE,'yyyy'))-1,to_number(to_char(DE_DATE,'yyyy'))),decode(sign(to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'yyyy'))),(nvl(DE_SALARYTODAYTY,0) + nvl(DE_WAGESTODAYTY,0) + nvl(DE_STORESTODAYTY,0) + nvl(DE_OTHERSTODAYTY,0)),0)) totaltodate 
            From fb_dailyexpense 
            where ((DE_DATE between to_date((decode(sign(to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'yyyy'))-2,to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'yyyy'))-1)||'0401'),'yyyymmdd') AND decode(substr(:ls_ason,1,5),'29/02',to_date(((to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'yyyy'))-1)||'0228'),'yyyymmdd'),to_date(((to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'yyyy'))-1)||to_char(to_date(:ls_ason,'dd/mm/yyyy'),'mmdd')),'yyyymmdd')) ) or
                     (DE_DATE between to_date((decode(sign(to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_ason,'dd/mm/yyyy'),'yyyy')))||'0401'),'yyyymmdd') AND to_date(:ls_ason,'dd/mm/yyyy')))
            group by eacsubhead_id) e
WHERE a.ACLEDGER_ID = c.ACLEDGER_ID AND a.ACSUBLEDGER_ID = d.EACHEAD_ID AND d.EACSUBHEAD_ID = e.EACSUBHEAD_ID and initcap(c.ACLEDGER_LEDGERTYPE) = 'Revenueexpenditure'
group by initcap(ACSUBLEDGER_NAME), d.EACSUBHEAD_NAME, a.ACSUBLEDGER_ID, d.EACSUBHEAD_ID, ACSUBLEDGER_DIVISIONTYPE, ACSUBLEDGER_ADDINTOTAL, ACSUBLEDGER_ADDINCOSTPERKG
order by 1;
								  
dw_1.show()

//dw_1.retrieve(ls_frym, string(ld_st_year,'dd/mm/yyyy'),string(ld_end_year,'dd/mm/yyyy'),gs_garden_snm)
if rb_2.checked then
	dw_1.dataobject="dw_gteacr027"
else
	dw_1.dataobject="dw_gteacr027d"
end if

dw_1.settransobject(sqlca)
dw_1.retrieve(ls_ason)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found')
	return 1
end if

end event

type gb_1 from groupbox within w_gteacr027
integer x = 905
integer width = 635
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

type dw_1 from datawindow within w_gteacr027
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 9
integer y = 144
integer width = 4210
integer height = 2228
string dataobject = "dw_gteacr027"
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

