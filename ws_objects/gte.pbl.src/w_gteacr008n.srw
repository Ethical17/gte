$PBExportHeader$w_gteacr008n.srw
forward
global type w_gteacr008n from window
end type
type st_2 from statictext within w_gteacr008n
end type
type dp_2 from datepicker within w_gteacr008n
end type
type dp_1 from datepicker within w_gteacr008n
end type
type rb_2 from radiobutton within w_gteacr008n
end type
type rb_1 from radiobutton within w_gteacr008n
end type
type st_1 from statictext within w_gteacr008n
end type
type cb_2 from commandbutton within w_gteacr008n
end type
type cb_1 from commandbutton within w_gteacr008n
end type
type gb_1 from groupbox within w_gteacr008n
end type
type dw_1 from datawindow within w_gteacr008n
end type
type dw_2 from datawindow within w_gteacr008n
end type
end forward

global type w_gteacr008n from window
integer width = 5125
integer height = 2584
boolean titlebar = true
string title = "(W_gteacr008) MES Detail"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_2 st_2
dp_2 dp_2
dp_1 dp_1
rb_2 rb_2
rb_1 rb_1
st_1 st_1
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
end type
global w_gteacr008n w_gteacr008n

type variables
string ls_item_ty, ls_dt, ls_edt
n_cst_powerfilter iu_powerfilter
long ll_user_level
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
elseif rb_2.checked then
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

on w_gteacr008n.create
this.st_2=create st_2
this.dp_2=create dp_2
this.dp_1=create dp_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.st_2,&
this.dp_2,&
this.dp_1,&
this.rb_2,&
this.rb_1,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.gb_1,&
this.dw_1,&
this.dw_2}
end on

on w_gteacr008n.destroy
destroy(this.st_2)
destroy(this.dp_2)
destroy(this.dp_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_2.modify("t_co.text = '"+gs_co_name+"'")
dw_2.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_2.hide()

//cb_1.of_VGradient(TRUE)
//THIS.of_HGradient(FALSE)
//THIS.of_BackColor(12615935)
//THIS.of_BackColor2(16711808)

STRING LS_TEXT

LS_TEXT	= "create OR REPLACE view FB_MONTHLYEXPENSEBUDGET_vw as "&
	+ " (select ind meb_type , (case when b.rowno IN (1,2,3) then (MOB_YEAR + 1) ELSE MOB_YEAR end) MEB_YEAR, "&
	+ " 							(case when b.rowno = 1 then 1 when b.rowno = 2 then 2 when b.rowno = 3 then 3 when b.rowno = 4 then 4 when b.rowno = 5 then 5 "&
	+ "             when b.rowno = 6 then 6 when b.rowno = 7 then 7 when b.rowno = 8 then 8 when b.rowno = 9 then 9 when b.rowno = 10 then 10 when b.rowno = 11 then 11 "&
	+ "             when b.rowno = 12 then 12 end) MEB_MONTH, EACSUBHEAD_ID , "&
     	+ "  SUM(case when b.rowno = 1 then NVL(MOB_JANPRICE,0) when b.rowno = 2 then NVL(MOB_FEBPRICE,0) when b.rowno = 3 then NVL(MOB_MARPRICE,0) "&
	+ "             when b.rowno = 4 then NVL(MOB_APRPRICE,0) when b.rowno = 5 then NVL(MOB_MAYPRICE,0) when b.rowno = 6 then NVL(MOB_JUNPRICE,0) "&
	+ "             when b.rowno = 7 then NVL(MOB_JULPRICE,0) when b.rowno = 8 then NVL(MOB_AUGPRICE,0) when b.rowno = 9 then NVL(MOB_SEPPRICE,0) "&
	+ "             when b.rowno = 10 then NVL(MOB_OCTPRICE,0) when b.rowno = 11 then NVL(MOB_NOVPRICE,0) when b.rowno = 12 then NVL(MOB_DECPRICE,0) end)  bg_amt "&
	+ "   from (select MOB_YEAR,'O' ind, EACSUBHEAD_ID, MOB_JANPRICE, MOB_FEBPRICE, MOB_MARPRICE, MOB_APRPRICE, MOB_MAYPRICE, MOB_JUNPRICE, MOB_JULPRICE, "&
	+ "              MOB_AUGPRICE, MOB_SEPPRICE, MOB_OCTPRICE, MOB_NOVPRICE, MOB_DECPRICE from fb_monthlyothersbudget union all "&
	+ "         select MWB_YEAR,'W', EACSUBHEAD_ID,(nvl(MWB_JANRATE,0) * nvl(MWB_JANMANDAYS,0)) jan, "&
	+ "                (nvl(MWB_FEBRATE,0) * nvl(MWB_FEBMANDAYS,0)), (nvl(MWB_MARRATE,0) * nvl(MWB_MARMANDAYS,0)), "&
	+ "                 (nvl(MWB_APRRATE,0) * nvl(MWB_APRMANDAYS,0)),(nvl(MWB_MAYRATE,0) * nvl(MWB_MAYMANDAYS,0)), "&
	+ "                 (nvl(MWB_JUNRATE,0) * nvl(MWB_JUNMANDAYS,0)),(nvl(MWB_JULRATE,0) * nvl(MWB_JULMANDAYS,0)), "&
	+ "                 (nvl(MWB_AUGRATE,0) * nvl(MWB_AUGMANDAYS,0)),(nvl(MWB_SEPRATE,0) * nvl(MWB_SEPMANDAYS,0)), "&
	+ "                 (nvl(MWB_OCTRATE,0) * nvl(MWB_OCTMANDAYS,0)),(nvl(MWB_NOVRATE,0) * nvl(MWB_NOVMANDAYS,0)), "&
	+ "                 (nvl(MWB_DECRATE,0) * nvl(MWB_DECMANDAYS,0)) from FB_MONTHLYWAGESBUDGET  union all "&
	+ "         select MSB_YEAR,'T', EACSUBHEAD_ID, MSB_JANPRICE, MSB_FEBPRICE, MSB_MARPRICE, MSB_APRPRICE, MSB_MAYPRICE, MSB_JUNPRICE, MSB_JULPRICE, MSB_AUGPRICE, MSB_SEPPRICE, MSB_OCTPRICE, MSB_NOVPRICE, MSB_DECPRICE from FB_MONTHLYSTOREBUDGET union all "&
	+ "         select MSAB_YEAR,'S', EACSUBHEAD_ID, MSAB_JANSALARY, MSAB_FEBSALARY, MSAB_MARSALARY, MSAB_APRSALARY, MSAB_MAYSALARY, MSAB_JUNSALARY, MSAB_JULSALARY, MSAB_AUGSALARY, MSAB_SEPSALARY, MSAB_OCTSALARY, MSAB_NOVSALARY, MSAB_DECSALARY from fb_monthlysalarybudget) a, "&
	+ "  (select rownum rowno from dual connect by level <= 12) b "&
	+ " group by ind  , (case when b.rowno IN (1,2,3) then (MOB_YEAR + 1) ELSE MOB_YEAR end) , "&
	+ " 							(case when b.rowno = 1 then 1 when b.rowno = 2 then 2 when b.rowno = 3 then 3 when b.rowno = 4 then 4 when b.rowno = 5 then 5 "&
	+ "             when b.rowno = 6 then 6 when b.rowno = 7 then 7 when b.rowno = 8 then 8 when b.rowno = 9 then 9 when b.rowno = 10 then 10 when b.rowno = 11 then 11 "&
	+ "             when b.rowno = 12 then 12 end ), EACSUBHEAD_ID ) "
		 
//LS_TEXT	= "create OR REPLACE view FB_MONTHLYEXPENSEBUDGET_vw as "&
//	+ "(select 'O' meb_type ,MOB_YEAR +1 MEB_YEAR, 1 MEB_MONTH,EACSUBHEAD_ID,MOB_JANPRICE bg_amt from fb_monthlyothersbudget union all "&
//	+ " select 'O' meb_type ,MOB_YEAR +1 MEB_YEAR, 2 MEB_MONTH,EACSUBHEAD_ID,MOB_FEBPRICE bg_amt from fb_monthlyothersbudget union all "&
//	+ " select 'O' meb_type ,MOB_YEAR +1 MEB_YEAR, 3 MEB_MONTH,EACSUBHEAD_ID,MOB_MARPRICE bg_amt from fb_monthlyothersbudget union all "&
//	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 4 MEB_MONTH,EACSUBHEAD_ID,MOB_APRPRICE bg_amt from fb_monthlyothersbudget union all  "&
//	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 5 MEB_MONTH,EACSUBHEAD_ID,MOB_MAYPRICE bg_amt from fb_monthlyothersbudget union all "&
//	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 6 MEB_MONTH,EACSUBHEAD_ID,MOB_JUNPRICE bg_amt from fb_monthlyothersbudget union all  "&
//	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 7 MEB_MONTH,EACSUBHEAD_ID,MOB_JULPRICE bg_amt from fb_monthlyothersbudget union all  "&
//	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 8 MEB_MONTH,EACSUBHEAD_ID,MOB_AUGPRICE bg_amt from fb_monthlyothersbudget union all  "&
//	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 9 MEB_MONTH,EACSUBHEAD_ID,MOB_SEPPRICE bg_amt from fb_monthlyothersbudget union all  "&
//	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 10 MEB_MONTH,EACSUBHEAD_ID,MOB_OCTPRICE bg_amt from fb_monthlyothersbudget union all  "&
//	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 11 MEB_MONTH,EACSUBHEAD_ID,MOB_NOVPRICE bg_amt from fb_monthlyothersbudget union all  "&
//	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 12 MEB_MONTH,EACSUBHEAD_ID,MOB_DECPRICE bg_amt from fb_monthlyothersbudget union all "&
//	+ " select 'W' meb_type ,MWB_YEAR +1 MEB_YEAR, 1 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_JANMANDAYS,0) * NVL(MWB_JANRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR +1, 1,EACSUBHEAD_ID union all "&
//	+ " select 'W' meb_type ,MWB_YEAR +1 MEB_YEAR, 2 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_FEBMANDAYS,0) * NVL(MWB_FEBRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR +1, 2,EACSUBHEAD_ID union all "&
//	+ " select 'W' meb_type ,MWB_YEAR +1 MEB_YEAR, 3 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_MARMANDAYS,0) * NVL(MWB_MARRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR +1, 3,EACSUBHEAD_ID union all "&
//	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 4 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_APRMANDAYS,0) * NVL(MWB_APRRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 4,EACSUBHEAD_ID union all "&
//	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 5 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_MAYMANDAYS,0) * NVL(MWB_MAYRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 5,EACSUBHEAD_ID union all "&
//	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 6 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_JUNMANDAYS,0) * NVL(MWB_JUNRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 6,EACSUBHEAD_ID union all "&
//	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 7 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_JULMANDAYS,0) * NVL(MWB_JULRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 7,EACSUBHEAD_ID union all "&
//	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 8 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_AUGMANDAYS,0) * NVL(MWB_AUGRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 8,EACSUBHEAD_ID union all "&
//	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 9 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_SEPMANDAYS,0) * NVL(MWB_SEPRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 9,EACSUBHEAD_ID union all "&
//	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 10 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_OCTMANDAYS,0) * NVL(MWB_OCTRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 10,EACSUBHEAD_ID union all "&
//	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 11 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_NOVMANDAYS,0) * NVL(MWB_NOVRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 11,EACSUBHEAD_ID union all "&
//	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 12 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_DECMANDAYS,0) * NVL(MWB_DECRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 12,EACSUBHEAD_ID union all "&
//	+ " select 'T' meb_type ,MSB_YEAR +1 MEB_YEAR, 1 MEB_MONTH,EACSUBHEAD_ID,MSB_JANPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all "&
//	+ " select 'T' meb_type ,MSB_YEAR +1 MEB_YEAR, 2 MEB_MONTH,EACSUBHEAD_ID,MSB_FEBPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all "&
//	+ " select 'T' meb_type ,MSB_YEAR +1 MEB_YEAR, 3 MEB_MONTH,EACSUBHEAD_ID,MSB_MARPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all "&
//	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 4 MEB_MONTH,EACSUBHEAD_ID,MSB_APRPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all  "&
//	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 5 MEB_MONTH,EACSUBHEAD_ID,MSB_MAYPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all "&
//	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 6 MEB_MONTH,EACSUBHEAD_ID,MSB_JUNPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all  "&
//	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 7 MEB_MONTH,EACSUBHEAD_ID,MSB_JULPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all  "&
//	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 8 MEB_MONTH,EACSUBHEAD_ID,MSB_AUGPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all  "&
//	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 9 MEB_MONTH,EACSUBHEAD_ID,MSB_SEPPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all  "&
//	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 10 MEB_MONTH,EACSUBHEAD_ID,MSB_OCTPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all  "&
//	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 11 MEB_MONTH,EACSUBHEAD_ID,MSB_NOVPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all  "&
//	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 12 MEB_MONTH,EACSUBHEAD_ID,MSB_DECPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all "&
//	+ " select 'S' meb_type ,MSAB_YEAR +1 MEB_YEAR, 1 MEB_MONTH,EACSUBHEAD_ID,MSAB_JANSALARY bg_amt from fb_monthlysalarybudget union all "&
//	+ " select 'S' meb_type ,MSAB_YEAR +1 MEB_YEAR, 2 MEB_MONTH,EACSUBHEAD_ID,MSAB_FEBSALARY bg_amt from fb_monthlysalarybudget union all "&
//	+ " select 'S' meb_type ,MSAB_YEAR +1 MEB_YEAR, 3 MEB_MONTH,EACSUBHEAD_ID,MSAB_MARSALARY bg_amt from fb_monthlysalarybudget union all "&
//	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 4 MEB_MONTH,EACSUBHEAD_ID,MSAB_APRSALARY bg_amt from fb_monthlysalarybudget union all  "&
//	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 5 MEB_MONTH,EACSUBHEAD_ID,MSAB_MAYSALARY bg_amt from fb_monthlysalarybudget union all "&
//	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 6 MEB_MONTH,EACSUBHEAD_ID,MSAB_JUNSALARY bg_amt from fb_monthlysalarybudget union all  "&
//	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 7 MEB_MONTH,EACSUBHEAD_ID,MSAB_JULSALARY bg_amt from fb_monthlysalarybudget union all  "&
//	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 8 MEB_MONTH,EACSUBHEAD_ID,MSAB_AUGSALARY bg_amt from fb_monthlysalarybudget union all  "&
//	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 9 MEB_MONTH,EACSUBHEAD_ID,MSAB_SEPSALARY bg_amt from fb_monthlysalarybudget union all  "&
//	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 10 MEB_MONTH,EACSUBHEAD_ID,MSAB_OCTSALARY bg_amt from fb_monthlysalarybudget union all  "&
//	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 11 MEB_MONTH,EACSUBHEAD_ID,MSAB_NOVSALARY bg_amt from fb_monthlysalarybudget union all  "&
//	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 12 MEB_MONTH,EACSUBHEAD_ID,MSAB_DECSALARY bg_amt from fb_monthlysalarybudget) "


EXECUTE IMMEDIATE :LS_TEXT USING SQLCA;


LS_TEXT	= "create OR REPLACE view FB_TMBUDGET_vw as " &
	+ " (select 'WCWF' tmb_type, (MTMB_YEAR + 1) tmb_year, 1 tmb_month, nvl(MTMB_JANTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCWF' tmb_type, (MTMB_YEAR + 1) tmb_year, 2 tmb_month, nvl(MTMB_FEBTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCWF' tmb_type, (MTMB_YEAR + 1) tmb_year, 3 tmb_month, nvl(MTMB_MARTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCWF' tmb_type, (MTMB_YEAR) tmb_year, 4 tmb_month, nvl(MTMB_APRTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCWF' tmb_type, (MTMB_YEAR) tmb_year, 5 tmb_month, nvl(MTMB_MAYTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCWF' tmb_type, (MTMB_YEAR) tmb_year, 6 tmb_month, nvl(MTMB_JUNTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCWF' tmb_type, (MTMB_YEAR) tmb_year, 7 tmb_month, nvl(MTMB_JULTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCWF' tmb_type, (MTMB_YEAR) tmb_year, 8 tmb_month, nvl(MTMB_AUGTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCWF' tmb_type, (MTMB_YEAR) tmb_year, 9 tmb_month, nvl(MTMB_SEPTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCWF' tmb_type, (MTMB_YEAR) tmb_year, 10 tmb_month, nvl(MTMB_OCTTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCWF' tmb_type, (MTMB_YEAR) tmb_year, 11 tmb_month, nvl(MTMB_NOVTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCWF' tmb_type, (MTMB_YEAR) tmb_year, 12 tmb_month, nvl(MTMB_DECTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR + 1) tmb_year, 1 tmb_month, nvl(MTMB_JANTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR + 1) tmb_year, 2 tmb_month, nvl(MTMB_FEBTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR + 1) tmb_year, 3 tmb_month, nvl(MTMB_MARTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR) tmb_year, 4 tmb_month, nvl(MTMB_APRTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR) tmb_year, 5 tmb_month, nvl(MTMB_MAYTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR) tmb_year, 6 tmb_month, nvl(MTMB_JUNTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR) tmb_year, 7 tmb_month, nvl(MTMB_JULTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR) tmb_year, 8 tmb_month, nvl(MTMB_AUGTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR) tmb_year, 9 tmb_month, nvl(MTMB_SEPTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR) tmb_year, 10 tmb_month, nvl(MTMB_OCTTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR) tmb_year, 11 tmb_month, nvl(MTMB_NOVTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR) tmb_year, 12 tmb_month, nvl(MTMB_DECTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR + 1) tmb_year, 1 tmb_month, nvl(MTMB_JANTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR + 1) tmb_year, 2 tmb_month, nvl(MTMB_FEBTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR + 1) tmb_year, 3 tmb_month, nvl(MTMB_MARTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR) tmb_year, 4 tmb_month, nvl(MTMB_APRTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR) tmb_year, 5 tmb_month, nvl(MTMB_MAYTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR) tmb_year, 6 tmb_month, nvl(MTMB_JUNTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR) tmb_year, 7 tmb_month, nvl(MTMB_JULTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR) tmb_year, 8 tmb_month, nvl(MTMB_AUGTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR) tmb_year, 9 tmb_month, nvl(MTMB_SEPTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR) tmb_year, 10 tmb_month, nvl(MTMB_OCTTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR) tmb_year, 11 tmb_month, nvl(MTMB_NOVTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR) tmb_year, 12 tmb_month, nvl(MTMB_DECTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR + 1) tmb_year, 1 tmb_month, nvl(MTMB_JANTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR + 1) tmb_year, 2 tmb_month, nvl(MTMB_FEBTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR + 1) tmb_year, 3 tmb_month, nvl(MTMB_MARTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR) tmb_year, 4 tmb_month, nvl(MTMB_APRTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR) tmb_year, 5 tmb_month, nvl(MTMB_MAYTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR) tmb_year, 6 tmb_month, nvl(MTMB_JUNTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR) tmb_year, 7 tmb_month, nvl(MTMB_JULTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR) tmb_year, 8 tmb_month, nvl(MTMB_AUGTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR) tmb_year, 9 tmb_month, nvl(MTMB_SEPTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR) tmb_year, 10 tmb_month, nvl(MTMB_OCTTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR) tmb_year, 11 tmb_month, nvl(MTMB_NOVTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR) tmb_year, 12 tmb_month, nvl(MTMB_DECTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET) " &
 
 EXECUTE IMMEDIATE :LS_TEXT USING SQLCA;
 
 
 select pfa_permission into :ll_user_level from fb_pf_access where pfa_user_id=:gs_user and nvl(pfa_active,'N')='Y';
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Access',sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 100 then
	messagebox('Warning : NO access Provided',sqlca.sqlerrtext)
	return 1
end if	
 
end event

type st_2 from statictext within w_gteacr008n
integer x = 1938
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

type dp_2 from datepicker within w_gteacr008n
integer x = 2121
integer y = 16
integer width = 393
integer height = 100
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2024-07-23"), Time("08:48:39.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_1 from datepicker within w_gteacr008n
integer x = 1522
integer y = 16
integer width = 393
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2024-07-23"), Time("08:48:39.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

event valuechanged;if gs_garden_snm = 'KG' then
	ls_dt = dp_1.text
	select to_char(last_day(to_date(:ls_dt,'dd/mm/yyyy')),'dd/mm/yyyy') into :ls_edt from dual;
	
	dp_2.value = datetime(ls_edt)
end if
end event

type rb_2 from radiobutton within w_gteacr008n
integer x = 512
integer y = 32
integer width = 475
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "MES Summary"
end type

event clicked;dw_1.hide()
dw_2.show()



end event

type rb_1 from radiobutton within w_gteacr008n
integer x = 55
integer y = 32
integer width = 443
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "MES Detail"
boolean checked = true
end type

event clicked;dw_1.show()
dw_2.hide()



end event

type st_1 from statictext within w_gteacr008n
integer x = 1061
integer y = 32
integer width = 443
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

type cb_2 from commandbutton within w_gteacr008n
integer x = 2807
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
boolean cancel = true
end type

event clicked;Close(parent)
end event

type cb_1 from commandbutton within w_gteacr008n
integer x = 2542
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
string text = "&Run"
end type

event clicked;double ld_actcrop_tot_tp,ld_actcrop_tot,ld_lyrcrop_tot,ld_actcrop_pur_tp,ld_actcrop_pur,ld_lyrcrop_pur,ld_actcrop_sal_tp,ld_actcrop_sal,ld_lyrcrop_sal,ld_budcrop_own,ld_budcrop_own_tot,ld_budcrop_pur,ld_budcrop_pur_tot, ld_budcrop_sale,ld_budcrop_sale_tot
string ls_frdt,ls_todt



setpointer(hourglass!)

if date(dp_1.text) > date(dp_2.text) then 
	messagebox('Error At Date','The "From" Date Must be More than "TO" date, Please check..!')
	return 1
end if;

ls_frdt = dp_1.text 
ls_todt = dp_2.text

ld_budcrop_own = 0;ld_budcrop_pur = 0
ld_budcrop_own_tot = 0;ld_budcrop_pur_tot = 0
ld_actcrop_pur_tp=0;ld_actcrop_pur=0;ld_lyrcrop_pur=0;
ld_actcrop_tot_tp=0;ld_actcrop_tot=0;ld_lyrcrop_tot=0;
ld_actcrop_sal_tp=0;ld_actcrop_sal=0;ld_lyrcrop_sal=0;

if left(ls_todt,5) = '29/02' then

	select sum(decode(sign(GLFP_pluckingdate - to_date(:ls_frdt,'dd/mm/yyyy')),-1,0,decode(sign(GLFP_pluckingdate - to_date(:ls_todt,'dd/mm/yyyy')),1,0,GWTM_TEAMADE))) TODAYTY, 
				sum(decode(decode(sign(to_number(to_char(GLFP_pluckingdate,'mm')) - 4),-1,to_number(to_char(GLFP_pluckingdate,'yyyy'))-1,to_number(to_char(GLFP_pluckingdate,'yyyy'))),decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))),nvl(GWTM_TEAMADE,0),0)) todate,
				sum(decode(decode(sign(to_number(to_char(GLFP_pluckingdate,'mm')) - 4),-1,to_number(to_char(GLFP_pluckingdate,'yyyy'))-1,to_number(to_char(GLFP_pluckingdate,'yyyy'))),decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-2,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1),nvl(GWTM_TEAMADE,0),0)) ltotaltodate
		 into :ld_actcrop_pur_tp,:ld_actcrop_pur,:ld_lyrcrop_pur
		from fb_GLFORPRODUCTION,FB_GARDENWISETEAMADE,FB_SUPPLIER 
	where  fb_GLFORPRODUCTION.GLFP_PK=FB_GARDENWISETEAMADE.GLFP_PK AND fb_GLFORPRODUCTION.SUP_ID=FB_SUPPLIER.SUP_ID AND 
			 FB_SUPPLIER.SUP_TYPE NOT IN ('OWN') AND GWTM_TYPE NOT IN ('O') AND 
				((GLFP_pluckingdate between to_date((decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-2,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1)||'0401'),'yyyymmdd') AND to_date(((to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1)||'0228'),'yyyymmdd') ) or
				 (GLFP_pluckingdate between to_date((decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy')))||'0401'),'yyyymmdd') AND to_date(:ls_todt,'dd/mm/yyyy')));
	
	if sqlca.sqlcode =-1 then
		messagebox('SQL Error: During Purchase Crop Select',sqlca.sqlerrtext)
		return 1
	end if
	
	select sum(decode(sign(GLFP_pluckingdate - to_date(:ls_frdt,'dd/mm/yyyy')),-1,0,decode(sign(GLFP_pluckingdate - to_date(:ls_todt,'dd/mm/yyyy')),1,0,GWTM_TEAMADE))) TODAYTY, 
				sum(decode(decode(sign(to_number(to_char(GLFP_pluckingdate,'mm')) - 4),-1,to_number(to_char(GLFP_pluckingdate,'yyyy'))-1,to_number(to_char(GLFP_pluckingdate,'yyyy'))),decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))),nvl(GWTM_TEAMADE,0),0)) todate,
				sum(decode(decode(sign(to_number(to_char(GLFP_pluckingdate,'mm')) - 4),-1,to_number(to_char(GLFP_pluckingdate,'yyyy'))-1,to_number(to_char(GLFP_pluckingdate,'yyyy'))),decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-2,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1),nvl(GWTM_TEAMADE,0),0)) ltotaltodate
		 into :ld_actcrop_sal_tp,:ld_actcrop_sal,:ld_lyrcrop_sal
		from fb_GLFORPRODUCTION,FB_GARDENWISETEAMADE,FB_SUPPLIER 
	where  fb_GLFORPRODUCTION.GLFP_PK=FB_GARDENWISETEAMADE.GLFP_PK AND fb_GLFORPRODUCTION.SUP_ID=FB_SUPPLIER.SUP_ID AND 
			 GWTM_TYPE IN ('O') AND 
				((GLFP_pluckingdate between to_date((decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-2,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1)||'0401'),'yyyymmdd') AND to_date(((to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1)||'0228'),'yyyymmdd') ) or
				 (GLFP_pluckingdate between to_date((decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy')))||'0401'),'yyyymmdd') AND to_date(:ls_todt,'dd/mm/yyyy')));
	
	if sqlca.sqlcode =-1 then
		messagebox('SQL Error: During SALE Crop Select',sqlca.sqlerrtext)
		return 1
	end if
	
	select sum(decode(sign(dDp_dt - to_date(:ls_frdt,'dd/mm/yyyy')),-1,0,decode(sign(dDp_dt - to_date(:ls_todt,'dd/mm/yyyy')),1,0,DDU_QUANTITY))) TODAYTY, 
				sum(decode(decode(sign(to_number(to_char(dDp_dt,'mm')) - 4),-1,to_number(to_char(dDp_dt,'yyyy'))-1,to_number(to_char(dDp_dt,'yyyy'))),decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))),nvl(DDU_QUANTITY,0),0)) todate,
				sum(decode(decode(sign(to_number(to_char(dDp_dt,'mm')) - 4),-1,to_number(to_char(dDp_dt,'yyyy'))-1,to_number(to_char(dDp_dt,'yyyy'))),decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-2,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1),nvl(DDU_QUANTITY,0),0)) ltotaltodate
		into :ld_actcrop_tot_tp,:ld_actcrop_tot,:ld_lyrcrop_tot
	 From fb_DAILYDRYERunsorted,FB_DAILYDRYERPRODUCT 
	where fb_DAILYDRYERunsorted.DDP_PK=FB_DAILYDRYERPRODUCT.DDP_PK(+) and nvl(ddp_type,'a') not in ('P','R') and 
				((dDp_dt between to_date((decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-2,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1)||'0401'),'yyyymmdd') AND to_date(((to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1)||'0228'),'yyyymmdd') ) or
				 (dDp_dt between to_date((decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy')))||'0401'),'yyyymmdd') AND to_date(:ls_todt,'dd/mm/yyyy')));
	
	if sqlca.sqlcode =-1 then
		messagebox('SQL Error: During Total Crop Select',sqlca.sqlerrtext)
		return 1
	end if
else
	select sum(decode(sign(GLFP_pluckingdate - to_date(:ls_frdt,'dd/mm/yyyy')),-1,0,decode(sign(GLFP_pluckingdate - to_date(:ls_todt,'dd/mm/yyyy')),1,0,GWTM_TEAMADE))) TODAYTY, 
				sum(decode(decode(sign(to_number(to_char(GLFP_pluckingdate,'mm')) - 4),-1,to_number(to_char(GLFP_pluckingdate,'yyyy'))-1,to_number(to_char(GLFP_pluckingdate,'yyyy'))),decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))),nvl(GWTM_TEAMADE,0),0)) todate,
				sum(decode(decode(sign(to_number(to_char(GLFP_pluckingdate,'mm')) - 4),-1,to_number(to_char(GLFP_pluckingdate,'yyyy'))-1,to_number(to_char(GLFP_pluckingdate,'yyyy'))),decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-2,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1),nvl(GWTM_TEAMADE,0),0)) ltotaltodate
		 into :ld_actcrop_pur_tp,:ld_actcrop_pur,:ld_lyrcrop_pur
		from fb_GLFORPRODUCTION,FB_GARDENWISETEAMADE,FB_SUPPLIER 
	where  fb_GLFORPRODUCTION.GLFP_PK=FB_GARDENWISETEAMADE.GLFP_PK AND fb_GLFORPRODUCTION.SUP_ID=FB_SUPPLIER.SUP_ID AND 
			 FB_SUPPLIER.SUP_TYPE NOT IN ('OWN') AND GWTM_TYPE NOT IN ('O') AND 
				((GLFP_pluckingdate between to_date((decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-2,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1)||'0401'),'yyyymmdd') AND to_date(((to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1)||to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mmdd')),'yyyymmdd') ) or
				 (GLFP_pluckingdate between to_date((decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy')))||'0401'),'yyyymmdd') AND to_date(:ls_todt,'dd/mm/yyyy')));
	
	if sqlca.sqlcode =-1 then
		messagebox('SQL Error: During Purchase Crop Select',sqlca.sqlerrtext)
		return 1
	end if
	
	select sum(decode(sign(GLFP_pluckingdate - to_date(:ls_frdt,'dd/mm/yyyy')),-1,0,decode(sign(GLFP_pluckingdate - to_date(:ls_todt,'dd/mm/yyyy')),1,0,GWTM_TEAMADE))) TODAYTY, 
				sum(decode(decode(sign(to_number(to_char(GLFP_pluckingdate,'mm')) - 4),-1,to_number(to_char(GLFP_pluckingdate,'yyyy'))-1,to_number(to_char(GLFP_pluckingdate,'yyyy'))),decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))),nvl(GWTM_TEAMADE,0),0)) todate,
				sum(decode(decode(sign(to_number(to_char(GLFP_pluckingdate,'mm')) - 4),-1,to_number(to_char(GLFP_pluckingdate,'yyyy'))-1,to_number(to_char(GLFP_pluckingdate,'yyyy'))),decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-2,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1),nvl(GWTM_TEAMADE,0),0)) ltotaltodate
		 into :ld_actcrop_sal_tp,:ld_actcrop_sal,:ld_lyrcrop_sal
		from fb_GLFORPRODUCTION,FB_GARDENWISETEAMADE,FB_SUPPLIER 
	where  fb_GLFORPRODUCTION.GLFP_PK=FB_GARDENWISETEAMADE.GLFP_PK AND fb_GLFORPRODUCTION.SUP_ID=FB_SUPPLIER.SUP_ID AND 
			 GWTM_TYPE IN ('O') AND 
				((GLFP_pluckingdate between to_date((decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-2,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1)||'0401'),'yyyymmdd') AND to_date(((to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1)||to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mmdd')),'yyyymmdd') ) or
				 (GLFP_pluckingdate between to_date((decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy')))||'0401'),'yyyymmdd') AND to_date(:ls_todt,'dd/mm/yyyy')));
	
	if sqlca.sqlcode =-1 then
		messagebox('SQL Error: During SALE Crop Select',sqlca.sqlerrtext)
		return 1
	end if
	
	select sum(decode(sign(dDp_dt - to_date(:ls_frdt,'dd/mm/yyyy')),-1,0,decode(sign(dDp_dt - to_date(:ls_todt,'dd/mm/yyyy')),1,0,DDU_QUANTITY))) TODAYTY, 
				sum(decode(decode(sign(to_number(to_char(dDp_dt,'mm')) - 4),-1,to_number(to_char(dDp_dt,'yyyy'))-1,to_number(to_char(dDp_dt,'yyyy'))),decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))),nvl(DDU_QUANTITY,0),0)) todate,
				sum(decode(decode(sign(to_number(to_char(dDp_dt,'mm')) - 4),-1,to_number(to_char(dDp_dt,'yyyy'))-1,to_number(to_char(dDp_dt,'yyyy'))),decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-2,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1),nvl(DDU_QUANTITY,0),0)) ltotaltodate
		into :ld_actcrop_tot_tp,:ld_actcrop_tot,:ld_lyrcrop_tot
	 From fb_DAILYDRYERunsorted,FB_DAILYDRYERPRODUCT 
	where fb_DAILYDRYERunsorted.DDP_PK=FB_DAILYDRYERPRODUCT.DDP_PK(+) and nvl(ddp_type,'a') not in ('P','R') and 
				((dDp_dt between to_date((decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-2,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1)||'0401'),'yyyymmdd') AND to_date(((to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1)||to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mmdd')),'yyyymmdd') ) or
				 (dDp_dt between to_date((decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy')))||'0401'),'yyyymmdd') AND to_date(:ls_todt,'dd/mm/yyyy')));
	
	if sqlca.sqlcode =-1 then
		messagebox('SQL Error: During Total Crop Select',sqlca.sqlerrtext)
		return 1
	end if
end if

string ls_ysdt,ls_yedt 

select to_char(to_date((decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy')))||'0401'),'yyyymmdd'),'dd/mm/yyyy'),
		to_char(to_date((decode(sign(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy')),to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))+1)||'0331'),'yyyymmdd'),'dd/mm/yyyy')
  into :ls_ysdt,:ls_yedt from dual;

if sqlca.sqlcode =-1 then
	messagebox('SQL Error During Date Select',sqlca.sqlerrtext)
	return 1
end if


select sum(decode(tmb_type,'WCWF',1,'WCOF',1,0) * decode(sign( ((TMB_YEAR * 100) + TMB_MONTH) - to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyymm') ),1,0, nvl(BG_QTY,0)) ) TODAYTY, 
		sum(decode(tmb_type,'WCWF',1,'WCOF',1,0) * nvl(BG_QTY,0)) TODAte, 
		sum(decode(tmb_type,'WCWF',0,'WCOF',0,1) * decode(sign( ((TMB_YEAR * 100) + TMB_MONTH) - to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyymm') ),1,0, nvl(BG_QTY,0)) ) TODAYTY, 
		sum(decode(tmb_type,'WCWF',0,'WCOF',0,1) * nvl(BG_QTY,0)) TODAte,
		sum(decode(tmb_type,'WCWF',0,'WCOF',1,0) * decode(sign( ((TMB_YEAR * 100) + TMB_MONTH) - to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyymm') ),1,0, nvl(BG_QTY,0)) ) TODAYTY, 
		sum(decode(tmb_type,'WCWF',0,'WCOF',1,0) * nvl(BG_QTY,0)) TODAte
  into :ld_budcrop_own,:ld_budcrop_own_tot,:ld_budcrop_pur,:ld_budcrop_pur_tot, :ld_budcrop_sale,:ld_budcrop_sale_tot
 from FB_TMBUDGET_vw
where ((TMB_YEAR * 100) + TMB_MONTH) between to_char(to_date(:ls_ysdt,'dd/mm/yyyy'),'yyyymm') and to_char(to_date(:ls_yedt,'dd/mm/yyyy'),'yyyymm')  ;
		
if sqlca.sqlcode =-1 then
	messagebox('SQL Error: During Total Budget Select',sqlca.sqlerrtext)
	return 1
end if

if isnull(ld_actcrop_tot_tp) then ld_actcrop_tot_tp=0 
if isnull(ld_actcrop_pur_tp) then ld_actcrop_pur_tp=0
if isnull(ld_actcrop_tot) then ld_actcrop_tot=0
if isnull(ld_actcrop_pur) then ld_actcrop_pur=0
if isnull(ld_lyrcrop_tot) then ld_lyrcrop_tot=0
if isnull(ld_lyrcrop_pur) then ld_lyrcrop_pur=0
if isnull(ld_budcrop_own) then ld_budcrop_own=0
if isnull(ld_budcrop_own_tot) then ld_budcrop_own_tot=0
if isnull(ld_budcrop_pur) then ld_budcrop_pur=0
if isnull(ld_budcrop_pur_tot) then ld_budcrop_pur_tot=0
if isnull(ld_actcrop_sal_tp) then ld_actcrop_sal_tp=0
if isnull(ld_actcrop_sal) then ld_actcrop_sal=0
if isnull(ld_lyrcrop_sal) then ld_lyrcrop_sal=0
if isnull(ld_budcrop_sale) then ld_budcrop_sale=0
if isnull(ld_budcrop_sale_tot) then ld_budcrop_sale_tot=0

if rb_1.checked then
	dw_2.hide()
	dw_1.show()
	dw_1.settransobject(sqlca)
	dw_1.retrieve(dp_1.text,dp_2.text,ld_actcrop_tot_tp,ld_actcrop_pur_tp,ld_actcrop_tot,ld_actcrop_pur,ld_lyrcrop_tot,ld_lyrcrop_pur,ld_budcrop_own,ld_budcrop_own_tot,ld_budcrop_pur,ld_budcrop_pur_tot,ld_actcrop_sal_tp,ld_actcrop_sal,ld_lyrcrop_sal,ld_budcrop_sale,ld_budcrop_sale_tot)
elseif rb_2.checked then
	dw_1.hide()
	dw_2.show()
	dw_2.settransobject(sqlca)
	dw_2.retrieve(dp_1.text,dp_2.text,ld_actcrop_tot_tp,ld_actcrop_pur_tp,ld_actcrop_tot,ld_actcrop_pur,ld_lyrcrop_tot,ld_lyrcrop_pur,ld_budcrop_own,ld_budcrop_own_tot,ld_budcrop_pur,ld_budcrop_pur_tot,ld_actcrop_sal_tp,ld_actcrop_sal,ld_lyrcrop_sal,ld_budcrop_sale,ld_budcrop_sale_tot)
end if

setpointer(arrow!)
end event

type gb_1 from groupbox within w_gteacr008n
integer x = 41
integer width = 1019
integer height = 120
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

type dw_1 from datawindow within w_gteacr008n
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 4471
integer height = 2248
string dataobject = "dw_gteacr008n"
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

type dw_2 from datawindow within w_gteacr008n
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 3950
integer height = 2100
string dataobject = "dw_gteacr008an"
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

