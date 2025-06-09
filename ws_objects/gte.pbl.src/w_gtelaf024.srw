$PBExportHeader$w_gtelaf024.srw
forward
global type w_gtelaf024 from window
end type
type cb_1 from commandbutton within w_gtelaf024
end type
type st_1 from statictext within w_gtelaf024
end type
type ddlb_1 from dropdownlistbox within w_gtelaf024
end type
type cb_5 from commandbutton within w_gtelaf024
end type
type cb_4 from commandbutton within w_gtelaf024
end type
type cb_3 from commandbutton within w_gtelaf024
end type
type dw_1 from datawindow within w_gtelaf024
end type
end forward

global type w_gtelaf024 from window
integer width = 4594
integer height = 2284
boolean titlebar = true
string title = "(w_gtelaf024) LWW process "
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_1 cb_1
st_1 st_1
ddlb_1 ddlb_1
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
dw_1 dw_1
end type
global w_gtelaf024 w_gtelaf024

type variables
long ll_ctr,ll_cnt, ll_year, ll_last, ll_st_year, ll_end_year,ll_user_level,ll_id
string ls_temp,ls_name,ls_last,ls_type,ls_tmp_id,ls_count,ls_lwwid
boolean lb_neworder, lb_query
datetime ld_frdt, ld_todt,ld_otodt,ld_ofrdt
string ls_frdt, ls_todt

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (datetime fd_frdt, datetime fd_todt)
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
//	if (isnull(dw_1.getitemdatetime(fl_row,'lbp_startdate')) or isnull(dw_1.getitemdatetime(fl_row,'lbp_enddate')) then
//	    messagebox('Warning: One Of The Following Fields Are Blank', 'Season Start Date, Season End Date,Bonus Per,min Working Days.  Please Check !!!')
//		 return -1
//	end if
end if
return 1
end function

public function integer wf_check_duplicate_rec (datetime fd_frdt, datetime fd_todt);long fl_row
datetime ld_fdt1, ld_todt1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ld_fdt1 = dw_1.getitemdatetime(fl_row,'lls_startdate')
		ld_todt1 = dw_1.getitemdatetime(fl_row,'lls_enddate')
		
		if ld_fdt1 = fd_frdt and ld_todt1 = fd_todt then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtelaf024.create
this.cb_1=create cb_1
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.st_1,&
this.ddlb_1,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.dw_1}
end on

on w_gtelaf024.destroy
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.dw_1)
end on

event open;
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if

dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false

date ld_dt
declare c1 cursor for
select to_char(lls_STARTDATE,'dd/mm/yyyy')||'-'||to_char(lls_ENDDATE,'dd/mm/yyyy')||' ('||lls_ID||') - '||lls_CONFIRM,lls_STARTDATE
  from fb_lablwwseason    
order by lls_STARTDATE desc;

open c1;

IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ls_lwwid,:ld_dt;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_lwwid)
		fetch c1 into:ls_lwwid,:ld_dt;
	loop
	close c1;
end if

this.tag = Message.StringParm
ll_user_level = long(this.tag)

if ll_user_level <> 1 then
	cb_1.enabled = false
	cb_3.enabled= false
end if

end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if
IF KeyDown(KeyF1!) THEN
	cb_1.triggerevent(clicked!)
end if
IF KeyDown(KeyF3!) THEN
	if dw_1.rowcount() > 0  then
		cb_3.triggerevent(clicked!)
	end if
end if
end event

type cb_1 from commandbutton within w_gtelaf024
integer x = 2487
integer y = 16
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Process"
end type

event clicked;if ll_user_level <> 1 then
	messagebox('Warning!','You Are Not Authorized To Run The Process !!!')
	return 1
end if

if  len(trim(ddlb_1.text)) = 0 or isnull(ddlb_1.text) then
	messagebox ('Warning','Please Select the Bonus Period.')
	return 1
end if;

ls_frdt=left(ddlb_1.text,10)
ls_todt=left(right(ddlb_1.text,25),10)
ls_lwwid=left(right(ddlb_1.text,13),8)

if right(ddlb_1.text,1) = '1' then
	if ll_user_level = 1 then	
		if messagebox('LWW Select ','The LWW against this Period has been already Calculated, Would You Like to Recalculate the LWW',question!,yesno!,1) = 1 then
			update fb_lablwwseason set LLS_CONFIRM = '0'  where LLS_ID = :ls_lwwid ;
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error : During Labour LWW period (Update) ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return 1; 
			end if

			update fb_lablwwperiod set llp_paidflag='0'  where LLS_ID = :ls_lwwid ;
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error : During Labour LWW period (Update) ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return 1; 
			end if
			
			delete from fb_lablww where llp_id in (select LLP_ID  from fb_lablwwperiod where LLS_ID  = :ls_lwwid);
			
			if sqlca.sqlcode = -1 then
				messagebox('SQL ERROR: During LWW Delete',sqlca.sqlerrtext)
				return 1
			end if;	
		else
			return 1
		end if
	else
		messagebox('Wages Week Select ','The LWW against this Period has been already paid, You can not Recalculate the LWW, Please Contact "Admin User"',information!)
		return 1
	end if
end if	


if MessageBox('Confirmation: LWW Calculation','Do you want to calculate LWW for the period : '+ ls_frdt+' to '+ls_todt,Question!,yesno!,1 )=2 then
	return 1
end if

setpointer(hourglass!)

string ls_LBP_ID ,ls_start_dt,ls_end_dt,ls_ID,ls_PFFLAG,ls_AVERAGEFLAG,ls_DAYSROUND,ls_LTYPE,ls_OTYPE,ls_PAIDHOLIDAY,ls_MATERNITY,ls_SICKALLOWANCE,Ls_PFROUND,Ls_NETROUND
double ld_LWWRATE,Ld_MINWDAYS,ld_FOODCONC,ld_tpf_rt,ld_pf_rt,ld_fpf_rt
long ll_WDAYSDIVIDEBY
string ls_sql,ls_wdays,ls_wagesamo,ls_days,ls_earn,ls_fdconc,ls_pf,ls_fpf,ls_net,ls_rate

select sum(decode(pd_doc_type,'PFFPFRT',decode(pd_code,'1',pd_value,0),0)),
		sum(decode(pd_doc_type,'PFFPFRT',decode(pd_code,'2',pd_value,0),0)),
		sum(decode(pd_doc_type,'PFFPFRT',decode(pd_code,'3',pd_value,0),0))
into :ld_tpf_rt,:ld_pf_rt,:ld_fpf_rt
from fb_param_detail 
where pd_doc_type = 'PFFPFRT' and PD_PERIOD_TO is null;

if sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
	return 1
end if;

declare c1 cursor for
select LLP_ID ,to_char(LLP_STARTDATE,'dd/mm/yyyy'),to_char(LLP_ENDDATE,'dd/mm/yyyy'),a.LS_ID,LLP_PFFLAG,
		LLP_WDAYSDIVIDEBY,LLP_AVERAGEFLAG,LLP_LWWRATE,LLP_DAYSROUND,LLP_FOODCONC,LLP_PAIDHOLIDAY,LLP_MATERNITY,
		LLP_SICKALLOWANCE,LLP_MINWDAYS,LLP_PFROUND,LLP_NETROUND,LS_LABOURTYPE,LS_OUTSIDERTYPE
  from fb_lablwwperiod a,( select distinct LS_ID,LS_LABOURTYPE,LS_OUTSIDERTYPE from fb_LABOURSHEET where LS_ACTIVE_IND = 'Y') b
 where LLS_ID = :ls_lwwid and a.LS_ID = b.ls_id 
 order by 1;

open c1;
if sqlca.sqlcode = -1 then
	messagebox('SQL Error: During C1 Cursor',sqlca.sqlerrtext)
	return 1
end if
		setnull(ls_LBP_ID);setnull(ls_start_dt);setnull(ls_end_dt);setnull(ls_ID);setnull(ls_PFFLAG);setnull(ls_AVERAGEFLAG);setnull(Ls_PFROUND);setnull(Ls_NETROUND)
		setnull(ls_DAYSROUND);setnull(ls_PAIDHOLIDAY);setnull(ls_MATERNITY);setnull(ls_SICKALLOWANCE);setnull(ls_LTYPE);setnull(ls_OTYPE)
		setnull(ls_sql);setnull(ls_wdays);setnull(ls_wagesamo);setnull(ls_days);setnull(ls_earn);setnull(ls_fdconc);setnull(ls_pf);setnull(ls_fpf);setnull(ls_net);setnull(ls_rate)
		ld_LWWRATE=0;ld_FOODCONC=0;ll_WDAYSDIVIDEBY=0;Ld_MINWDAYS=0;

 	fetch c1 into :ls_LBP_ID ,:ls_start_dt,:ls_end_dt,:ls_ID,:ls_PFFLAG,:ll_WDAYSDIVIDEBY,:ls_AVERAGEFLAG,:ld_LWWRATE,:ls_DAYSROUND,
	 				:ld_FOODCONC,:ls_PAIDHOLIDAY,:ls_MATERNITY,:ls_SICKALLOWANCE,:Ld_MINWDAYS,:Ls_PFROUND,:Ls_NETROUND,:ls_LTYPE,:ls_OTYPE;
					 
	do while sqlca.sqlcode <> 100
			setmicrohelp('ls_LBP_ID: ' + ls_LBP_ID)
    
		If (ls_LTYPE = 'LP' Or ls_LTYPE = 'LT' Or (ls_LTYPE = 'LO' And (ls_OTYPE = 'FACTORY' or ((gs_garden_snm = 'MV' or gs_garden_snm = 'PC' or gs_garden_snm = 'JP')  and  ls_OTYPE = 'OTHER')))) Then
			
			 ls_wdays = "(SUM (lda.lda_status))"
			 If ls_DAYSROUND = '1' Then
					ls_days = "(round(SUM (lda.lda_status)/" + string(ll_WDAYSDIVIDEBY) + ",0))"
			 Else
					ls_days = "(round(SUM (lda.lda_status)/" + string(ll_WDAYSDIVIDEBY)  + ",2))"
			 End If
			
			 ls_wagesamo = "(round(SUM(nvl(lda.lda_wages,0)),2))"
			 If ls_AVERAGEFLAG = '1' Then				
				 ls_rate = "(ROUND(" + ls_wagesamo + " / " + ls_wdays + ",2))"
				 ls_earn = "(round(decode(nvl("+ls_wdays+",0),0,0,(" + ls_days + " * " + ls_rate + ")) ,2))"
			 Else
					ls_rate = "(" + string(ld_LWWRATE) + ")"
					ls_earn = "(round(" + ls_days + " * " + ls_rate + " ,2))"
			 End If
			
			 If ls_PFFLAG = '1' Then
					ls_fdconc = "(decode(nvl(emp.emp_pfdedcode,0),0,0,round(" +ls_days + " * " + string(ld_FOODCONC) + " ,2)))"
					If ls_PFROUND = '1' Then
						ls_pf = "(decode(nvl(emp.emp_pfdedcode,0),1,round((" + ls_earn + " + " + ls_fdconc + ")*" +string(ld_tpf_rt/100) +",0),2,round((" + ls_earn + " + " + ls_fdconc + ")*" + string(ld_pf_rt/100) + ",0),0))"
						ls_fpf = "(decode(nvl(emp.emp_pfdedcode,0),1,0,2,round((" + ls_earn + " + " + ls_fdconc + ")* " + string(ld_fpf_rt/100) + ",0),0))"
				  Else
						ls_pf = "(decode(nvl(emp.emp_pfdedcode,0),1,round((" + ls_earn + " + " + ls_fdconc + ")* " +string(ld_tpf_rt/100) + ",2),2,round((" + ls_earn + " + " + ls_fdconc + ")* " + string(ld_pf_rt/100) + ",2),0))"
						ls_fpf = "(decode(nvl(emp.emp_pfdedcode,0),1,0,2,round((" + ls_earn + " + " + ls_fdconc + ")* " +string(ld_fpf_rt/100) + ",2),0))"
					End If
			 Else
				ls_fdconc = "0"
				ls_pf = "0"
				ls_fpf = "0"
			 End If
			 
			 If ls_NETROUND = '1' Then
				  ls_net = "Round((" + ls_earn + " - " + ls_pf + " - " + ls_fpf + "), 0)"
			 Else
				  ls_net = "Round((" + ls_earn + " - " + ls_pf + " - " + ls_fpf + "), 2)"
			 End If
			 
//	if gs_garden_snm='MT' then
//		
//			ls_sql = "insert into fb_lablww (llp_id,labour_id,lww_wdays,lww_wagesamo,lww_days,lww_earn,lww_foodconc,lww_pf,lww_fpf,lww_netamo) " 
//			 ls_sql = ls_sql + " SELECT   '" +ls_LBP_ID+"', emp.emp_id labid, "
//			 ls_sql = ls_sql + "         " + ls_wdays + " wdays,"
//			 ls_sql = ls_sql + "        " + ls_wagesamo + " wagesamo,"
//			 ls_sql = ls_sql + "         " + ls_days + " days,"
//			 ls_sql = ls_sql + "         " + ls_earn + " earn,"
//			 ls_sql = ls_sql + "         " + ls_fdconc + " fdconc,"
//			 ls_sql = ls_sql + "         " + ls_pf + " pf,"
//			 ls_sql = ls_sql + "        " + ls_fpf + " fpf,"
//			 ls_sql = ls_sql + "         " + ls_net + " net"
//			 ls_sql = ls_sql + "    FROM (select 'A' ,labour_id,sum(lda_status) lda_status,"
//			 ls_sql = ls_sql + " 					 SUM(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) lda_wages "
//			 ls_sql = ls_sql + " 			  from fb_labourdailyattendance lda, fb_employee emp "
//			 ls_sql = ls_sql + "   WHERE emp.emp_id = lda.labour_id "
//			 ls_sql = ls_sql + "     AND emp.ls_id = '" + ls_id +"' "
//			 ls_sql = ls_sql + "     AND not exists (select em_lsid from fb_exemptmaster where lda.lda_date between EM_FROMDT and EM_TODT and EM_LWWIND='Y' and EM_LSID = emp.ls_id) "
//			 ls_sql = ls_sql + "  and not exists (select kam.kamsub_id from fb_kamsubhead kam  where nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and kam.kamsub_id = lda.kamsub_id and trim(kam.kamsub_nkamtype) in (decode('"+ls_PAIDHOLIDAY+"','0','HOLIDAYPAY',' '),decode('"+ls_MATERNITY+"','0','MATERNITY',' '), decode('"+ls_SICKALLOWANCE+"','0','SICKALLOWANCE',' '))) "
//			 ls_sql = ls_sql + "     AND decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0)) > 0 "
//			 ls_sql = ls_sql + "     AND lda.lda_date between to_date('" +ls_start_dt+"','DD/MM/YYYY') and to_date('" +ls_end_dt+"','DD/MM/YYYY') group by labour_id "
//			 ls_sql = ls_sql + "	union select 'C',lar.labour_id, 0,sum(lar.la_amount)  FROM fb_labourarrear lar,fb_arrearforsheet afs,fb_arrearperiod arp "
//			 ls_sql = ls_sql + "			WHERE lar.afs_id = afs.afs_id AND afs.ap_id = arp.ap_id AND "
//		 	 ls_sql = ls_sql + "     AP_ENDDATE between to_date('" +ls_start_dt+"','DD/MM/YYYY') and to_date('" +ls_end_dt+"','DD/MM/YYYY')  "
//			 ls_sql = ls_sql + "		group by 'C', lar.labour_id "
//			 ls_sql = ls_sql + "	union select 'B',a.LABOUR_ID, 0,sum(nvl(a.LWR_ELP,0) + nvl(LWR_PENALTY,0))  FROM FB_LABELPDETAILS a,fb_rationperiodforweek b "
//			 ls_sql = ls_sql + "			 where a.LRW_ID=b.RPFW_ID and  RPFW_STARTDATE between to_date('" +ls_start_dt+"','DD/MM/YYYY') and to_date('" +ls_end_dt+"','DD/MM/YYYY')  "
//			 ls_sql = ls_sql + "		group by 'B', a.labour_id "
//			 ls_sql = ls_sql + "		) lda, fb_employee emp "
//			 ls_sql = ls_sql + "   WHERE emp.emp_id = lda.labour_id "
//			 ls_sql = ls_sql + "     AND emp.ls_id = '" + ls_id +"' "
//			 ls_sql = ls_sql + "     GROUP BY emp.emp_id,nvl(emp.emp_pfdedcode,0)"
//			 
//	else
//			ls_sql = "insert into fb_lablww (llp_id,labour_id,lww_wdays,lww_wagesamo,lww_days,lww_earn,lww_foodconc,lww_pf,lww_fpf,lww_netamo) " 
//			 ls_sql = ls_sql + " SELECT   '" +ls_LBP_ID+"', emp.emp_id labid, "
//			 ls_sql = ls_sql + "         " + ls_wdays + " wdays,"
//			 ls_sql = ls_sql + "        " + ls_wagesamo + " wagesamo,"
//			 ls_sql = ls_sql + "         " + ls_days + " days,"
//			 ls_sql = ls_sql + "         " + ls_earn + " earn,"
//			 ls_sql = ls_sql + "         " + ls_fdconc + " fdconc,"
//			 ls_sql = ls_sql + "         " + ls_pf + " pf,"
//			 ls_sql = ls_sql + "        " + ls_fpf + " fpf,"
//			 ls_sql = ls_sql + "         " + ls_net + " net"
//			 ls_sql = ls_sql + "    FROM (select 'A' ,labour_id,sum(lda_status) lda_status,"
//			 ls_sql = ls_sql + " 					 SUM(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) lda_wages "
//			 ls_sql = ls_sql + " 			  from fb_labourdailyattendance lda, fb_employee emp "
//			 ls_sql = ls_sql + "   WHERE emp.emp_id = lda.labour_id "
//			 ls_sql = ls_sql + "     AND emp.ls_id = '" + ls_id +"' "
//			 ls_sql = ls_sql + "     AND not exists (select em_lsid from fb_exemptmaster where lda.lda_date between EM_FROMDT and EM_TODT and EM_LWWIND='Y' and EM_LSID = emp.ls_id) "
//			 ls_sql = ls_sql + "  and not exists (select kam.kamsub_id from fb_kamsubhead kam  where nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and kam.kamsub_id = lda.kamsub_id and trim(kam.kamsub_nkamtype) in (decode('"+ls_PAIDHOLIDAY+"','0','HOLIDAYPAY',' '),decode('"+ls_MATERNITY+"','0','MATERNITY',' '), decode('"+ls_SICKALLOWANCE+"','0','SICKALLOWANCE',' '))) "
//			 ls_sql = ls_sql + "     AND decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0)) > 0 "
//			 ls_sql = ls_sql + "     AND lda.lda_date between to_date('" +ls_start_dt+"','DD/MM/YYYY') and to_date('" +ls_end_dt+"','DD/MM/YYYY') group by labour_id "
//			 ls_sql = ls_sql + "	union select 'C',lar.labour_id, 0,sum(lar.la_amount)  FROM fb_labourarrear lar,fb_arrearforsheet afs,fb_arrearperiod arp "
//			 ls_sql = ls_sql + "			WHERE lar.afs_id = afs.afs_id AND afs.ap_id = arp.ap_id AND "
//		 	 ls_sql = ls_sql + "     AP_ENDDATE between to_date('" +ls_start_dt+"','DD/MM/YYYY') and to_date('" +ls_end_dt+"','DD/MM/YYYY')  "
//			 ls_sql = ls_sql + "		group by 'C', lar.labour_id) lda, fb_employee emp "
//			 ls_sql = ls_sql + "   WHERE emp.emp_id = lda.labour_id "
//			 ls_sql = ls_sql + "     AND emp.ls_id = '" + ls_id +"' "
//			 ls_sql = ls_sql + "     GROUP BY emp.emp_id,nvl(emp.emp_pfdedcode,0)"
//	end if

	if gs_garden_snm='MT' then
		
			ls_sql = "insert into fb_lablww (llp_id,labour_id,lww_wdays,lww_wagesamo,lww_days,lww_earn,lww_foodconc,lww_pf,lww_fpf,lww_netamo) " 
			 ls_sql = ls_sql + " SELECT   '" +ls_LBP_ID+"', emp.emp_id labid, "
			 ls_sql = ls_sql + "         " + ls_wdays + " wdays,"
			 ls_sql = ls_sql + "        " + ls_wagesamo + " wagesamo,"
			 ls_sql = ls_sql + "         " + ls_days + " days,"
			 ls_sql = ls_sql + "         " + ls_earn + " earn,"
			 ls_sql = ls_sql + "         " + ls_fdconc + " fdconc,"
			 ls_sql = ls_sql + "         " + ls_pf + " pf,"
			 ls_sql = ls_sql + "        " + ls_fpf + " fpf,"
			 ls_sql = ls_sql + "         " + ls_net + " net"
			 ls_sql = ls_sql + "    FROM (select 'A' ,labour_id,sum(lda_status) lda_status,"
			 ls_sql = ls_sql + " 					 SUM(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) lda_wages "
			 ls_sql = ls_sql + " 			  from fb_labourdailyattendance lda, fb_employee emp "
			 ls_sql = ls_sql + "   WHERE emp.emp_id = lda.labour_id "
			 ls_sql = ls_sql + "     AND emp.ls_id = '" + ls_id +"' "
			 ls_sql = ls_sql + "     AND not exists (select em_lsid from fb_exemptmaster where lda.lda_date between EM_FROMDT and EM_TODT and EM_LWWIND='Y' and EM_LSID = emp.ls_id) "
			 ls_sql = ls_sql + "  and not exists (select kam.kamsub_id from fb_kamsubhead kam  where nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and kam.kamsub_id = lda.kamsub_id and trim(kam.kamsub_nkamtype) in (decode('"+ls_PAIDHOLIDAY+"','0','HOLIDAYPAY',' '),decode('"+ls_MATERNITY+"','0','MATERNITY',' '), decode('"+ls_SICKALLOWANCE+"','0','SICKALLOWANCE',' '))) "
			 ls_sql = ls_sql + "     AND decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0)) > 0 "
			 ls_sql = ls_sql + "     AND lda.lda_date between to_date('" +ls_start_dt+"','DD/MM/YYYY') and to_date('" +ls_end_dt+"','DD/MM/YYYY') group by labour_id "
			 ls_sql = ls_sql + "	union select 'C',lar.labour_id, 0,sum(lar.la_amount)  FROM fb_labourarrear lar,fb_arrearperiod arp "
			 ls_sql = ls_sql + "			WHERE lar.ap_id = arp.ap_id AND "
		 	 ls_sql = ls_sql + "     AP_ENDDATE between to_date('" +ls_start_dt+"','DD/MM/YYYY') and to_date('" +ls_end_dt+"','DD/MM/YYYY')  "
			 ls_sql = ls_sql + "		group by 'C', lar.labour_id "
			 ls_sql = ls_sql + "	union select 'B',a.LABOUR_ID, 0,sum(nvl(a.LWR_ELP,0) + nvl(LWR_PENALTY,0))  FROM FB_LABELPDETAILS a,fb_rationperiodforweek b "
			 ls_sql = ls_sql + "			 where a.LRW_ID=b.RPFW_ID and  RPFW_STARTDATE between to_date('" +ls_start_dt+"','DD/MM/YYYY') and to_date('" +ls_end_dt+"','DD/MM/YYYY')  "
			 ls_sql = ls_sql + "		group by 'B', a.labour_id "
			 ls_sql = ls_sql + "		) lda, fb_employee emp "
			 ls_sql = ls_sql + "   WHERE emp.emp_id = lda.labour_id "
			 ls_sql = ls_sql + "     AND emp.ls_id = '" + ls_id +"' "
			 ls_sql = ls_sql + "     GROUP BY emp.emp_id,nvl(emp.emp_pfdedcode,0)"
		elseif gs_garden_snm = 'AB' or  gs_garden_snm = 'SP' or  gs_garden_snm = 'LP' or  gs_garden_snm = 'MR'  or gs_garden_snm = 'AD' or gs_garden_snm = 'MH' or gs_garden_snm = 'DR'  then
			ls_sql = "insert into fb_lablww (llp_id,labour_id,lww_wdays,lww_wagesamo,lww_days,lww_earn,lww_foodconc,lww_pf,lww_fpf,lww_netamo) " 
			 ls_sql = ls_sql + " SELECT   '" +ls_LBP_ID+"', emp.emp_id labid, "
			 ls_sql = ls_sql + "         " + ls_wdays + " wdays,"
			 ls_sql = ls_sql + "        " + ls_wagesamo + " wagesamo,"
			 ls_sql = ls_sql + "         " + ls_days + " days,"
			 ls_sql = ls_sql + "         " + ls_earn + " earn,"
			 ls_sql = ls_sql + "         " + ls_fdconc + " fdconc,"
			 ls_sql = ls_sql + "         " + ls_pf + " pf,"
			 ls_sql = ls_sql + "        " + ls_fpf + " fpf,"
			 ls_sql = ls_sql + "         " + ls_net + " net"
			 ls_sql = ls_sql + "    FROM (select 'A' ,labour_id,sum(lda_status) lda_status,"
			 ls_sql = ls_sql + " 					 SUM(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)),nvl(lda_wages,0))) lda_wages "
			 ls_sql = ls_sql + " 			  from fb_labourdailyattendance lda, fb_employee emp "
			 ls_sql = ls_sql + "   WHERE emp.emp_id = lda.labour_id "
			 ls_sql = ls_sql + "     AND emp.ls_id = '" + ls_id +"' "
			 ls_sql = ls_sql + "     AND not exists (select em_lsid from fb_exemptmaster where lda.lda_date between EM_FROMDT and EM_TODT and EM_LWWIND='Y' and EM_LSID = emp.ls_id) "
			 ls_sql = ls_sql + "  and not exists (select kam.kamsub_id from fb_kamsubhead kam  where nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and kam.kamsub_id = lda.kamsub_id and trim(kam.kamsub_nkamtype) in (decode('"+ls_PAIDHOLIDAY+"','0','HOLIDAYPAY',' '),decode('"+ls_MATERNITY+"','0','MATERNITY',' '), decode('"+ls_SICKALLOWANCE+"','0','SICKALLOWANCE',' '))) "
			 ls_sql = ls_sql + "     AND decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0)) > 0 "
			 ls_sql = ls_sql + "     AND lda.lda_date between to_date('" +ls_start_dt+"','DD/MM/YYYY') and to_date('" +ls_end_dt+"','DD/MM/YYYY') group by labour_id "
			 ls_sql = ls_sql + "	union select 'C',lar.labour_id, 0,sum(lar.la_amount)  FROM fb_labourarrear lar,fb_arrearperiod arp "
			 ls_sql = ls_sql + "			WHERE lar.ap_id = arp.ap_id AND "
		 	 ls_sql = ls_sql + "     AP_ENDDATE between to_date('" +ls_start_dt+"','DD/MM/YYYY') and to_date('" +ls_end_dt+"','DD/MM/YYYY')  "
			 ls_sql = ls_sql + "		group by 'C', lar.labour_id) lda, fb_employee emp "
			 ls_sql = ls_sql + "   WHERE emp.emp_id = lda.labour_id "
			 ls_sql = ls_sql + "     AND emp.ls_id = '" + ls_id +"' "
			 ls_sql = ls_sql + "     GROUP BY emp.emp_id,nvl(emp.emp_pfdedcode,0)"		 
	else
			ls_sql = "insert into fb_lablww (llp_id,labour_id,lww_wdays,lww_wagesamo,lww_days,lww_earn,lww_foodconc,lww_pf,lww_fpf,lww_netamo) " 
			 ls_sql = ls_sql + " SELECT   '" +ls_LBP_ID+"', emp.emp_id labid, "
			 ls_sql = ls_sql + "         " + ls_wdays + " wdays,"
			 ls_sql = ls_sql + "        " + ls_wagesamo + " wagesamo,"
			 ls_sql = ls_sql + "         " + ls_days + " days,"
			 ls_sql = ls_sql + "         " + ls_earn + " earn,"
			 ls_sql = ls_sql + "         " + ls_fdconc + " fdconc,"
			 ls_sql = ls_sql + "         " + ls_pf + " pf,"
			 ls_sql = ls_sql + "        " + ls_fpf + " fpf,"
			 ls_sql = ls_sql + "         " + ls_net + " net"
			 ls_sql = ls_sql + "    FROM (select 'A' ,labour_id,sum(lda_status) lda_status,"
			 ls_sql = ls_sql + " 					 SUM(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) lda_wages "
			 ls_sql = ls_sql + " 			  from fb_labourdailyattendance lda, fb_employee emp "
			 ls_sql = ls_sql + "   WHERE emp.emp_id = lda.labour_id "
			 ls_sql = ls_sql + "     AND emp.ls_id = '" + ls_id +"' "
			 ls_sql = ls_sql + "     AND not exists (select em_lsid from fb_exemptmaster where lda.lda_date between EM_FROMDT and EM_TODT and EM_LWWIND='Y' and EM_LSID = emp.ls_id) "
			 ls_sql = ls_sql + "  and not exists (select kam.kamsub_id from fb_kamsubhead kam  where nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and kam.kamsub_id = lda.kamsub_id and trim(kam.kamsub_nkamtype) in (decode('"+ls_PAIDHOLIDAY+"','0','HOLIDAYPAY',' '),decode('"+ls_MATERNITY+"','0','MATERNITY',' '), decode('"+ls_SICKALLOWANCE+"','0','SICKALLOWANCE',' '))) "
			 ls_sql = ls_sql + "     AND decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0)) > 0 "
			 ls_sql = ls_sql + "     AND lda.lda_date between to_date('" +ls_start_dt+"','DD/MM/YYYY') and to_date('" +ls_end_dt+"','DD/MM/YYYY') group by labour_id "
			 ls_sql = ls_sql + "	union select 'C',lar.labour_id, 0,sum(lar.la_amount)  FROM fb_labourarrear lar,fb_arrearperiod arp "
			 ls_sql = ls_sql + "			WHERE lar.ap_id = arp.ap_id AND "
		 	 ls_sql = ls_sql + "     AP_ENDDATE between to_date('" +ls_start_dt+"','DD/MM/YYYY') and to_date('" +ls_end_dt+"','DD/MM/YYYY')  "
			 ls_sql = ls_sql + "		group by 'C', lar.labour_id) lda, fb_employee emp "
			 ls_sql = ls_sql + "   WHERE emp.emp_id = lda.labour_id "
			 ls_sql = ls_sql + "     AND emp.ls_id = '" + ls_id +"' "
			 ls_sql = ls_sql + "     GROUP BY emp.emp_id,nvl(emp.emp_pfdedcode,0)"
	end if		
			execute immediate :ls_sql using sqlca;
			if sqlca.sqlcode =-1 then
				messagebox('SQL Error: During Insert ',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			end if

			update fb_lablww set lww_foodconc=0,lww_pf=0,lww_fpf=0,lww_netamo=lww_earn 
			where LLP_ID = :ls_LBP_ID and labour_id in (select emp_id from fb_employee where upper(EMP_INACTIVETYPE) in ('EXPIRED','RETIRE'));
			
			if sqlca.sqlcode =-1 then
				messagebox('SQL Error: During Update (Emp Leaving)',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			end if
			
			update fb_lablww set lww_days=0,lww_earn=0,lww_foodconc=0,lww_pf=0,lww_fpf=0,lww_netamo=0 
			where LLP_ID = :ls_LBP_ID and lww_wdays < :Ld_MINWDAYS;
			
			if sqlca.sqlcode =-1 then
				messagebox('SQL Error: During Update (Min Days)',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			end if

		end if		
			
		setnull(ls_LBP_ID);setnull(ls_start_dt);setnull(ls_end_dt);setnull(ls_ID);setnull(ls_PFFLAG);setnull(ls_AVERAGEFLAG);setnull(Ls_PFROUND);setnull(Ls_NETROUND)
		setnull(ls_DAYSROUND);setnull(ls_PAIDHOLIDAY);setnull(ls_MATERNITY);setnull(ls_SICKALLOWANCE);setnull(ls_LTYPE);setnull(ls_OTYPE)
		setnull(ls_sql);setnull(ls_wdays);setnull(ls_wagesamo);setnull(ls_days);setnull(ls_earn);setnull(ls_fdconc);setnull(ls_pf);setnull(ls_fpf);setnull(ls_net);setnull(ls_rate)
		ld_LWWRATE=0;ld_FOODCONC=0;ll_WDAYSDIVIDEBY=0;Ld_MINWDAYS=0;

 	fetch c1 into :ls_LBP_ID ,:ls_start_dt,:ls_end_dt,:ls_ID,:ls_PFFLAG,:ll_WDAYSDIVIDEBY,:ls_AVERAGEFLAG,:ld_LWWRATE,:ls_DAYSROUND,
	 				:ld_FOODCONC,:ls_PAIDHOLIDAY,:ls_MATERNITY,:ls_SICKALLOWANCE,:Ld_MINWDAYS,:Ls_PFROUND,:Ls_NETROUND,:ls_LTYPE,:ls_OTYPE;

loop

close c1;
commit using sqlca;

update fb_lablwwperiod set llp_paidflag='1'  where LLS_ID = :ls_lwwid ;

if sqlca.sqlcode =-1 then
	messagebox('SQL Error: During Update (Min Days)',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if 

update fb_lablwwseason set LLS_CONFIRM = '1'  where LLS_ID = :ls_lwwid ;

if sqlca.sqlcode =-1 then
	messagebox('SQL Error: During Update (Min Days)',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if 

commit using sqlca;
setpointer(Arrow!)

MessageBox("LWW Calculation",'LWW during the period : '+ ls_frdt+' to '+ls_todt+' has been calculated successfully...!')
end event

type st_1 from statictext within w_gtelaf024
integer x = 18
integer y = 36
integer width = 366
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "LWW Period Id"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gtelaf024
integer x = 411
integer y = 20
integer width = 1266
integer height = 376
integer taborder = 10
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

type cb_5 from commandbutton within w_gtelaf024
integer x = 1696
integer y = 16
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "OK"
boolean default = true
end type

event clicked;dw_1.settransobject(sqlca)
dw_1.reset()

if  len(trim(ddlb_1.text)) = 0 or isnull(ddlb_1.text) then
	messagebox ('Error:','Please Select the lww Id.')
	return 1
end if;

ls_frdt=left(ddlb_1.text,10)
ls_todt=left(right(ddlb_1.text,25),10)
ls_lwwid=left(right(ddlb_1.text,13),8)

select distinct LLS_EMP_TYPE into :ls_type from fb_lablwwseason where LLS_ID = :ls_lwwid;

IF sqlca.sqlcode = -1 THEN
	messagebox('SQL ERROR: During getting Paybook Details ',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if

if right(ddlb_1.text,1) = '0' then
	select distinct 'x' into :ls_temp from fb_lablwwperiod where LLS_ID = :ls_lwwid;
	IF sqlca.sqlcode = -1 THEN
		messagebox('SQL ERROR: During getting Paybook Details ',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 100 then		
		DECLARE c1 CURSOR FOR  
		select distinct LS_ID from fb_laboursheet where nvl(LS_ACTIVE_IND,'N')='Y' and LS_LABOURTYPE = :ls_type order by 1;		
	
		open c1;
		
		IF sqlca.sqlcode = 0 THEN
			fetch c1 into :ll_id;
			
			do while sqlca.sqlcode <> 100
				dw_1.scrolltorow(dw_1.insertrow(0))
				dw_1.setitem(dw_1.getrow(),'lls_id',ls_lwwid)
				dw_1.setitem(dw_1.getrow(),'llp_startdate',datetime(ls_frdt))
				dw_1.setitem(dw_1.getrow(),'llp_enddate',datetime(ls_todt))
				dw_1.setitem(dw_1.getrow(),'ls_id',ll_id)
				dw_1.setitem(dw_1.getrow(),'llp_entry_by',gs_user)
				dw_1.setitem(dw_1.getrow(),'llp_entry_dt',datetime(today()))
				dw_1.setitem(dw_1.getrow(),'llp_paidflag','0')
				dw_1.setitem(dw_1.getrow(),'llp_lwwrate',0)
				dw_1.setitem(dw_1.getrow(),'llp_foodconc',0)
				dw_1.setitem(dw_1.getrow(),'llp_paidholiday','0')
				dw_1.setitem(dw_1.getrow(),'llp_maternity','0')
				dw_1.setitem(dw_1.getrow(),'llp_averageflag','1')
				dw_1.setitem(dw_1.getrow(),'llp_daysround','1')
				dw_1.setitem(dw_1.getrow(),'llp_pfflag','1')
				dw_1.setitem(dw_1.getrow(),'llp_sickallowance','0')
				dw_1.setitem(dw_1.getrow(),'llp_minwdays',15)
				dw_1.setitem(dw_1.getrow(),'llp_wdaysdivideby',20)
				fetch c1 into :ll_id;
			loop
		END IF
		close c1;
		dw_1.setfocus()
		dw_1.scrolltorow(1)
		dw_1.setcolumn('llp_minwdays')
		lb_neworder = true
		lb_query = false
	else
		dw_1.settransobject(sqlca);
		dw_1.retrieve(ls_lwwid,long(right(ddlb_1.text,1)));		
	end if
else
	dw_1.settransobject(sqlca);
	dw_1.retrieve(ls_lwwid,long(right(ddlb_1.text,1)));
end if

end event

type cb_4 from commandbutton within w_gtelaf024
integer x = 2222
integer y = 16
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

event clicked;if dw_1.modifiedcount( ) > 0 or dw_1.deletedcount( ) > 0 then
	IF MessageBox("Exit Alert", 'Do You Want To Exit....?' ,Exclamation!, YesNo!, 1) = 1 THEN
		close(parent)
	else
		return
	end if
else
	close(parent)
end if
end event

type cb_3 from commandbutton within w_gtelaf024
integer x = 1957
integer y = 16
integer width = 265
integer height = 100
integer taborder = 30
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

IF (isnull(dw_1.getitemdatetime(dw_1.rowcount(),'llp_startdate')) or isnull(dw_1.getitemnumber(dw_1.rowcount(),'llp_wdaysdivideby')) or dw_1.getitemnumber(dw_1.rowcount(),'llp_wdaysdivideby') = 0) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	if lb_neworder = true then
		select nvl(MAX(LLP_ID),0) into :ls_last from fb_lablwwperiod;
		ls_last = right(ls_last,5)
		ll_cnt = long(ls_last)
	end if

	if dw_1.rowcount() > 0 then
		for ll_ctr = 1 to dw_1.rowcount( ) 
			
			if lb_neworder = true then
				ll_cnt = ll_cnt + 1
				ls_count =string(ll_cnt,'00000')
				ls_tmp_id = 'LLP'+ls_count
				dw_1.setitem(ll_ctr,'llp_id',ls_tmp_id)
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

type dw_1 from datawindow within w_gtelaf024
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 124
integer width = 4544
integer height = 2052
integer taborder = 40
string dataobject = "dw_gtelaf024"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'llp_entry_by',gs_user)
		dw_1.setitem(newrow,'llp_entry_dt',datetime(today()))
		dw_1.setcolumn('llp_minwdays')
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
		
	dw_1.setitem(row,'llp_entry_by',gs_user)
	dw_1.setitem(row,'llp_entry_dt',datetime(today()))
	
	if ll_user_level <> 1 then
		cb_1.enabled = false
		cb_3.enabled= false
	else
		cb_3.enabled = true
	end if
	
	
end if

if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if


end event

