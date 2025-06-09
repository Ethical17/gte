$PBExportHeader$w_gtelaf068.srw
forward
global type w_gtelaf068 from window
end type
type cbx_1 from checkbox within w_gtelaf068
end type
type cb_2 from commandbutton within w_gtelaf068
end type
type cb_1 from commandbutton within w_gtelaf068
end type
type cb_4 from commandbutton within w_gtelaf068
end type
type cb_3 from commandbutton within w_gtelaf068
end type
type dw_1 from datawindow within w_gtelaf068
end type
end forward

global type w_gtelaf068 from window
integer width = 4667
integer height = 3124
boolean titlebar = true
string title = "(w_gtelaf068) Labour Mobile Attendance Correction"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cbx_1 cbx_1
cb_2 cb_2
cb_1 cb_1
cb_4 cb_4
cb_3 cb_3
dw_1 dw_1
end type
global w_gtelaf068 w_gtelaf068

type variables
long ll_ctr, ll_cnt,l_ctr,ll_paybook,ll_temp,ll_user_level,ll_last,ll_retage,ll_year,ll_adoleage, ll_child,ll_round,ll_row,Net
string ls_temp,ls_del_ind,ls_labour_id,ls_tmp_id,ls_entry_user,ls_last,ls_count,ls_emp_name,ls_paybook,ls_lwwid,ls_kam_id, ls_protect_flg,ls_dt,ls_task_ind, ls_prorata_ind
string ls_kam_id_old, ls_holidayflg,ls_prevatd,ls_nextatd, ls_emp_ty, ls_sex, ls_cam_ind, ls_sec1,ls_sec2,ls_sec3, ls_sec1_old,ls_sec2_old,ls_sec3_old, ls_secind,ls_measureind,ls_ccind, ls_lwwind,ls_div,ls_kamtype
string ls_nkam_type,ls_kam_sname,ls_JUNGLIFOOT_ind,ls_emptype,ls_gsnm, ls_daily_rate,ls_paidfg, ls_calfg,ls_pwvn, ls_nature, ls_date,ls_latta, ls_covid
boolean lb_neworder, lb_query
datetime ld_dt,ld_rundt,ld_stdt,ldenddt,ld_dob, ld_pwlastday
double ld_measure, ld_rate,ld_afrate, ld_ahrate, ld_adfrate, ld_adhrate, ld_cfrate,ld_chrate, ld_status, ld_wages,ld_lwwopn,ld_lwwavail,ld_sick, ld_mat, ld_covidsl
double ld_wages_old,ld_rtcp1,ld_rtcp2,ld_rtcp3,ld_rtlo1,ld_rtlo2,ld_rtlo3,ld_rtup1,ld_rtup2,ld_rtup3,ld_wagrtn,ld_exshwages,ld_labage,ld_elp, ld_kincentive,ld_sl, ld_m1,ld_m2,ld_m3,ld_m4,ld_rcp_diff
datawindowchild dwc_section1,dwc_section2,dwc_section3
n_cst_powerfilter iu_powerfilter
string ls_job_id,ls_section1,ls_section2,ls_section3,ls_appr_ind,ls_entry_by
double ld_status_old,ld_mf_count1,ld_mf_count2,ld_mf_count3,ld_updated_wage,ld_updated_status
end variables

forward prototypes
public function double wf_kamjari_rate (datetime fd_date, string fs_labourid, string fs_kamid, double fd_attendance, long fl_row)
public function integer wf_cal_wages (double ld_measure1, double ld_measure2, double ld_measure3, long fl_row, double ld_status1)
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

public function double wf_kamjari_rate (datetime fd_date, string fs_labourid, string fs_kamid, double fd_attendance, long fl_row);select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0))
into :ll_adoleage, :ll_child
from fb_param_detail 
where pd_doc_type in ('CHILDAGE','ADOLEAGE') and
		 trunc(:fd_date) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));

if sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
	return -1
end if;


//select ((:fd_date - emp_dob) /365),EMP_TYPE  into :ld_labage, :ls_emptype  from fb_employee emp  where emp.emp_id= :ls_labour_id;

select get_diff(:fd_date,emp_dob,'B'),EMP_TYPE  into :ld_labage, :ls_emptype  from fb_employee emp  where emp.emp_id= :ls_labour_id;
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Labour Age Detail',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if
// trunc(:ld_dt) between KAMSUB_FRDT and nvl(KAMSUB_TODT,sysdate) 
	select kam.kamsub_afrate afrate, kam.kamsub_ahrate ahrate, kam.kamsub_adfrate adfrate, kam.kamsub_adhrate adhrate, kam.kamsub_cfrate cfrate,kam.kamsub_chrate chrate 
		into :ld_afrate, :ld_ahrate, :ld_adfrate, :ld_adhrate, :ld_cfrate,:ld_chrate 
	 from fb_kamsubhead kam
	where trim(kam.kamsub_id) = :fs_kamid and trunc(:fd_date) between trunc(KAMSUB_FRDT) and trunc(nvl(KAMSUB_TODT,sysdate));
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Labour Kamjari Rate Detail',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if


	If ld_labage <= ll_child Then //(144 months=12 years)
			 If fd_attendance = 1 Then
				 ld_rate = ld_cFrate
			elseIf fd_attendance = 0.5 Then
				 ld_rate = ld_cHrate
			else
				 ld_rate = ld_cFrate * fd_attendance
			 End If
		
		 ElseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
			 If fd_attendance = 1 Then
				 ld_rate = ld_adfrate
			elseIf fd_attendance = 0.5 Then
				 ld_rate = ld_adhrate
			else
				 ld_rate = ld_adfrate * fd_attendance
			 End If
		 ElseIf ld_labage > ll_adoleage Then
			 If fd_attendance = 1 Then
				 ld_rate = ld_afrate
			elseIf fd_attendance = 0.5 Then
				 ld_rate = ld_ahrate
			else
				 ld_rate = ld_afrate * fd_attendance
			 End If
		End If


return ld_rate
end function

public function integer wf_cal_wages (double ld_measure1, double ld_measure2, double ld_measure3, long fl_row, double ld_status1);
	ld_wages = 0;	ld_exshwages = 0;ld_rtcp1=0;ld_rtcp2=0;ld_rtlo1=0;ld_rtlo2=0;ld_rtup1=0;ld_rtup2=0
 
		if isnull(ld_measure1) then ld_measure1 = 0;
		if isnull(ld_measure2) then ld_measure2 = 0;
		if isnull(ld_measure3) then ld_measure3 = 0;
		
		ld_measure =  ld_measure1 + ld_measure2 + ld_measure3


		ls_kam_id = dw_1.getitemstring(fl_row,'kamsub_id')
		ls_labour_id = dw_1.getitemstring(fl_row,'labour_id')
		ld_dt = dw_1.getitemdatetime(fl_row,'lda_date')
		
		select emp.emp_dob labdob, get_diff(:ld_dt,emp_dob,'B'), emp_type, ls_id,field_id into :ld_dob, :ld_labage, :ls_emptype, :ll_paybook,:ls_div//, ((:ld_dt - emp_dob) /365)
		  from fb_employee emp
		 where emp.emp_id= :ls_labour_id;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Labour Age Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		
		
		select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0))
		into :ll_adoleage, :ll_child
		from fb_param_detail 
		where pd_doc_type in ('CHILDAGE','ADOLEAGE') and
				 trunc(:ld_dt) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));
	
		if sqlca.sqlcode = -1 then
			messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
			return -1
		end if;
 		if gs_garden_snm = 'FB' or gs_garden_snm = 'MK' or gs_garden_snm = 'ME' or gs_garden_snm = 'KG' or gs_garden_snm = 'BE' or gs_garden_snm = 'MV' or gs_garden_snm = 'SP' then
			If ld_labage <= ll_child Then //(144 months=12 years)
	
				select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0) , nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
				into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
				from fb_task_fulbari 
				where TASK_EMPTYPE = :ls_emptype and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'CHILD' ;
						
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			elseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
				select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0) , nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
				into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
				from fb_task_fulbari 
				where TASK_EMPTYPE = :ls_emptype and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADOLE' ;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if 		
			elseIf ld_labage > ll_adoleage then
				select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0) , nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
				into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
				from fb_task_fulbari 
				where TASK_EMPTYPE = :ls_emptype and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADULT'  ;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if 
			end if
		else
			If ld_labage <= ll_child Then //(144 months=12 years)
	
				select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0), nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
				into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
				from fb_task 
				where TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'CHILD'; //and
						//(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N')));
						
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			elseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
				select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0), nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
				into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
				from fb_task 
				where TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADOLE';// and
						//(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N'))) ;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if 		
			elseIf ld_labage > ll_adoleage then
				select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0), nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
				into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
				from fb_task 
				where TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADULT';// and
						//(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N'))) ;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if 
			end if	
		end if		
		ld_wagrtn = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status1,fl_row)
		
if gs_garden_snm = 'FB' then
	ls_sec1 = dw_1.getitemstring(fl_row,'lda_sectionid1')
	if not isnull(ls_sec1) or len(ls_sec1) > 0  then
		select max(nvl(SPR_ROUND,0)) into :ll_round from fb_sectionpluckinground where SECTION_ID = :ls_sec1 and trunc(SPR_DATE) = trunc(:ld_dt);
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Round Days ',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 100 then
			ll_round = 0
		end if
		if isnull(ll_round) then ll_round = 0;
		if ll_round > 0 and ll_round <= 5 then
			ld_rcp_diff = ld_rtcp2 - ld_rtcp1
			ld_rtcp1 = round((ld_rtcp1 * (100 - 40) / 100),0)
			ld_rtcp2 = ld_rtcp1 + ld_rcp_diff
		elseif ll_round = 6 then
			ld_rcp_diff = ld_rtcp2 - ld_rtcp1
			ld_rtcp1 = round((ld_rtcp1 * (100 - 30) / 100),0)
			ld_rtcp2 = ld_rtcp1 + ld_rcp_diff
		elseif ll_round = 7 or ll_round = 8 then
			ld_rcp_diff = ld_rtcp2 - ld_rtcp1
			ld_rtcp1 = round((ld_rtcp1 * (100 - 15) / 100),0)
			ld_rtcp2 = ld_rtcp1 + ld_rcp_diff			
		end if
	end if
end if //gs_garden_snm = 'FB' then

if isnull(ld_rtcp3) then ld_rtcp3 = 0
if ld_rtcp3 = 0 then		
	if ld_measure = ld_rtcp1 then
		ld_wages = ld_wagrtn
	elseif ld_measure > ld_rtcp1 and ld_measure <= ld_rtcp2 then
		ld_wages = ld_wagrtn + ((ld_measure - ld_rtcp1) * ld_rtup1)
		ld_exshwages = ((ld_measure - ld_rtcp1) * ld_rtup1)
	elseif ld_measure > ld_rtcp2 then
		ld_wages = ld_wagrtn + ((ld_rtcp2 - ld_rtcp1) * ld_rtup1) + ((ld_measure - ld_rtcp2) * ld_rtup2)
		ld_exshwages = ((ld_rtcp2 - ld_rtcp1) * ld_rtup1) + ((ld_measure - ld_rtcp2) * ld_rtup2)
	elseif ld_measure >= (ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) and ld_measure < ld_rtcp1 then
		ld_wages = ld_wagrtn - ((ld_rtcp1 - ld_measure) * ld_rtlo1)
		ld_exshwages =  (-1) * ((ld_rtcp1 - ld_measure) * ld_rtlo1)
	elseif ld_measure < (ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) then
		if ld_rtlo2 > 0 then
			ld_wages = ld_wagrtn - ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) - ld_measure) * ld_rtlo2) )
			ld_exshwages =  (-1) * ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) - ld_measure) * ld_rtlo2) )
		elseif ld_rtlo2 = 0 then
			ld_wages = ld_wagrtn - ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) - ld_measure) * ld_rtlo1) )
			ld_exshwages =  (-1) * ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) - ld_measure) * ld_rtlo1) )
		end if
	end if
elseif ld_rtcp3 > 0 then	
	if ld_measure = ld_rtcp1 then
		ld_wages = ld_wagrtn
	elseif ld_measure > ld_rtcp1 and ld_measure <= ld_rtcp2 then
		ld_wages = ld_wagrtn + ((ld_measure - ld_rtcp1) * ld_rtup1)
		ld_exshwages = ((ld_measure - ld_rtcp1) * ld_rtup1)
	elseif ld_measure > ld_rtcp2 and ld_measure <= ld_rtcp3 then
		ld_wages = ld_wagrtn + ((ld_rtcp2 - ld_rtcp1) * ld_rtup1) + ((ld_measure - ld_rtcp2) * ld_rtup2)
		ld_exshwages = ((ld_rtcp2 - ld_rtcp1) * ld_rtup1) + ((ld_measure - ld_rtcp2) * ld_rtup2)
	elseif ld_measure > ld_rtcp3 and ld_rtcp3 > 0 then
		ld_wages = ld_wagrtn + ((ld_rtcp2 - ld_rtcp1) * ld_rtup1) + ((ld_rtcp3 - ld_rtcp2) * ld_rtup2) + ((ld_measure - ld_rtcp3) * ld_rtup3)
		ld_exshwages = ((ld_rtcp2 - ld_rtcp1) * ld_rtup1) + ((ld_rtcp3 - ld_rtcp2) * ld_rtup2) + ((ld_measure - ld_rtcp3) * ld_rtup3)
	elseif ld_measure >= (ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) and ld_measure < ld_rtcp1 then
		ld_wages = ld_wagrtn - ((ld_rtcp1 - ld_measure) * ld_rtlo1)
		ld_exshwages =  (-1) * ((ld_rtcp1 - ld_measure) * ld_rtlo1)
	elseif ld_measure >= (ld_rtcp1 - (ld_rtcp2 - ld_rtcp1) - (ld_rtcp3 - ld_rtcp2)) and ld_measure < (ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) then
		if ld_rtlo2 > 0 then
			ld_wages = ld_wagrtn - ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) - ld_measure) * ld_rtlo2) )
			ld_exshwages =  (-1) * ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) - ld_measure) * ld_rtlo2) )
		elseif ld_rtlo2 = 0 then
			ld_wages = ld_wagrtn - ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) - ld_measure) * ld_rtlo1) )
			ld_exshwages =  (-1) * ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) - ld_measure) * ld_rtlo1) )
		end if
	elseif ld_measure < (ld_rtcp1 - (ld_rtcp2 - ld_rtcp1) - (ld_rtcp3 - ld_rtcp2)) then
		if ld_rtlo3 > 0 then
			ld_wages = ld_wagrtn - ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp3 - (ld_rtcp2 - ld_rtcp1)) - ld_rtcp1) * ld_rtlo2) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1) - (ld_rtcp3 - ld_rtcp2)) - ld_measure) * ld_rtlo3) )
			ld_exshwages =  (-1) * ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp3 - (ld_rtcp2 - ld_rtcp1)) - ld_rtcp1) * ld_rtlo2) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1) - (ld_rtcp3 - ld_rtcp2)) - ld_measure) * ld_rtlo3) )
		elseif ld_rtlo3 = 0 then
			ld_wages = ld_wagrtn - ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp3 - (ld_rtcp2 - ld_rtcp1)) - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1) - (ld_rtcp3 - ld_rtcp2)) - ld_measure) * ld_rtlo1) )
			ld_exshwages =  (-1) * ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp3 - (ld_rtcp2 - ld_rtcp1)) - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1) - (ld_rtcp3 - ld_rtcp2)) - ld_measure) * ld_rtlo1) )
		end if	
	end if
end if
		

		//dw_1.setitem(fl_row,'lda_task',ld_rtcp1)
		//dw_1.setitem(fl_row,'lda_elp',ld_exshwages)
		ls_kam_id = dw_1.getitemstring(fl_row,'kamsub_id')
		//ls_daily_rate = dw_1.getitemstring(fl_row,'lda_daily_rateind')
		
		ld_dt = dw_1.getitemdatetime(fl_row,'lda_date')
		
		if gs_garden_snm='FB' and ls_emptype = 'LO' then
			ld_wages = ld_measure * ld_wagrtn
			dw_1.setitem(fl_row,'lda_wages',ld_wages)
		elseif gs_garden_snm='FB' and ls_daily_rate = 'Y' then
			
			select kam.kamsub_afrate afrate into :ld_afrate from fb_kamsubhead kam
			where trim(kam.kamsub_id) = :ls_kam_id and trunc(:ld_dt) between KAMSUB_FRDT and nvl(KAMSUB_TODT,sysdate) ;
			
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Labour Kamjari Rate Detail',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			end if	
			if isnull(ld_afrate) then ld_afrate = 0;			
			ld_wages = ld_afrate
			dw_1.setitem(fl_row,'lda_wages',ld_wages)
			dw_1.setitem(fl_row,'lda_elp',0)
		else
			select nvl(INC_AMTPERDAY,0) into :ld_kincentive from fb_incentive 
			where INC_REC_TYPE = 'K' and KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(INC_FRDT) and nvl(trunc(INC_TODT),trunc(sysdate));
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Kamjari Incentive Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 100 then
				if gs_garden_state = '03' and ld_measure >= ld_rtcp1 then
					if ls_kam_id = 'ESUB0163' then // changed on 13012014 as per issue no C0001277
						dw_1.setitem(fl_row,'lda_wages',ld_wages + 0.6)
						//dw_1.setitem(fl_row,'lda_elp',ld_exshwages + 0.6)
					else
						dw_1.setitem(fl_row,'lda_wages',ld_wages)
						//dw_1.setitem(fl_row,'lda_elp',ld_exshwages)						
					end if
				else
					dw_1.setitem(fl_row,'lda_wages',ld_wages)
				end if
			elseif sqlca.sqlcode = 0 then
				if isnull(ld_kincentive) then ld_kincentive = 0;
				ld_wages = ld_wages + ld_kincentive
				dw_1.setitem(fl_row,'lda_wages',ld_wages)
				//dw_1.setitem(fl_row,'lda_latta',ld_kincentive) 
			end if
		end if
end function

on w_gtelaf068.create
this.cbx_1=create cbx_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.dw_1=create dw_1
this.Control[]={this.cbx_1,&
this.cb_2,&
this.cb_1,&
this.cb_4,&
this.cb_3,&
this.dw_1}
end on

on w_gtelaf068.destroy
destroy(this.cbx_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false
//dw_1.modify("t_co.text = '"+gs_co_name+"'")
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if

this.tag = Message.StringParm
ll_user_level = long(this.tag)



end event

event key;//IF KeyDown(KeyEscape!) THEN
//	cb_4.triggerevent(clicked!)
//end if
IF KeyDown(KeyF1!) THEN
	cb_1.triggerevent(clicked!)
end if
IF KeyDown(KeyF2!) THEN
	cb_2.triggerevent(clicked!)
end if
IF KeyDown(KeyF3!) THEN
	if dw_1.rowcount() > 0  then
		cb_3.triggerevent(clicked!)
	end if
end if
end event

type cbx_1 from checkbox within w_gtelaf068
integer x = 293
integer y = 40
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "UnApprove"
boolean checked = true
end type

type cb_2 from commandbutton within w_gtelaf068
integer x = 709
integer y = 28
integer width = 215
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;if cbx_1.checked then
	ls_appr_ind = 'Y';
else
	ls_appr_ind = 'N';
end if





if cb_2.text = "&Query" then
	lb_neworder = true
	if dw_1.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	dw_1.reset()
	dw_1.settaborder('lda_date',5)
	lb_query = true
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('lda_date')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.settaborder('lda_date',1)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(ls_appr_ind,ll_user_level)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtelaf068
integer x = 50
integer y = 32
integer width = 215
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&New"
end type

event clicked;dw_1.insertrow(0)
end event

type cb_4 from commandbutton within w_gtelaf068
integer x = 1129
integer y = 28
integer width = 215
integer height = 100
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;if dw_1.modifiedcount() > 0 or dw_1.deletedcount() > 0 then
	IF MessageBox("Exit Alert", 'Do You Want To Exit....?' ,Exclamation!, YesNo!, 1) = 1 THEN
		close(parent)
	else
		return
	end if
else
	close(parent)
end if
end event

type cb_3 from commandbutton within w_gtelaf068
integer x = 919
integer y = 28
integer width = 215
integer height = 100
integer taborder = 80
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

IF (isnull(dw_1.getitemdatetime(dw_1.rowcount(),'lda_date'))) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

Net = MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1)

IF Net = 1 THEN
	
	select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0)) into :ll_adoleage, :ll_child
	from fb_param_detail 
	where pd_doc_type in ('CHILDAGE','ADOLEAGE') and trunc(sysdate) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));
	if sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
		return 1
	end if;
	
	for ll_ctr = 1 to dw_1.rowcount( ) 
		
		if dw_1.getitemstring(ll_ctr,'appr_ind') ='Y' then
			ls_kam_id = dw_1.getitemstring(ll_ctr,'kamsub_id')
			ls_labour_id = dw_1.getitemstring(ll_ctr,'labour_id')
			ld_dt = dw_1.getitemdatetime(ll_ctr,'lda_date')
			ld_status_old =dw_1.getitemnumber(ll_ctr,'lda_old_status')
			ld_wages_old =dw_1.getitemnumber(ll_ctr,'lda_old_wages')
			ld_status =dw_1.getitemnumber(ll_ctr,'lda_status')
			ld_wages =dw_1.getitemnumber(ll_ctr,'lda_wages')
			
			select lww_startdate,lww_enddate,lww_id into :ld_stdt, :ldenddt, :ls_lwwid from fb_labourwagesweek 
			where trunc(:ld_dt) between trunc(lww_startdate) and trunc(lww_enddate) and lww_paidflag='0'; 
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 100 then
				messagebox('Warning!','The Entered Attendance Either Not Found Or Wages Against This Week Has Been Paid, Please Check !!!')
				return 1
			end if	
			
			
			select get_diff(trunc(:ld_dt),emp_dob,'B'), EMP_SEX,EMP_TYPE,
					LDA_MFJ_COUNT1, LDA_MFJ_COUNT2, LDA_MFJ_COUNT3, 
					LDA_SECTIONID1, LDA_SECTIONID2, LDA_SECTIONID3
			into :ld_labage,:ls_sex,:ls_emp_ty,
				  :ld_mf_count1,:ld_mf_count2,:ld_mf_count3,
				  :ls_section1,:ls_section2,:ls_section3
			from fb_labourdailyattendance,fb_employee 
 			where labour_id=emp_id and trunc(lda_date)=trunc(:ld_dt) and labour_id=:ls_labour_id;
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error: During Checking Of employee',sqlca.sqlerrtext)					
				return 1
			end if
			
			If ld_labage <= ll_child Then
					ls_cam_ind = 'CH'
			ElseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
					ls_cam_ind = 'AD'
			ElseIf ld_labage > ll_adoleage Then
					ls_cam_ind = 'AA'
			End If
			
			
			update fb_labourdailyattendance set lda_wages=:ld_wages,lda_status=:ld_status where trunc(lda_date)=trunc(:ld_dt) and labour_id=:ls_labour_id;
			
			ld_updated_wage=ld_wages - ld_wages_old
			ld_updated_status=ld_status - ld_status_old
			
			declare p1 procedure for up_upd_mes (to_char(:ld_dt,'dd/mm/yyyy'),:ls_kam_id,:ld_updated_wage,'W','N');
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error: During Procedure Declare of up_upd_mes',sqlca.sqlerrtext)					
				return 1
			end if

			execute p1;
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error: During Procedure Execute of up_upd_mes',sqlca.sqlerrtext)
				return 1
			end if
			
			declare p2 procedure for  up_save_activity_daily (trunc(:ld_dt),:ls_labour_id,:ls_kam_id, :ls_section1 ,:ld_updated_status,:ld_updated_wage,0, 'N',:ls_cam_ind,:ls_emp_ty,:ls_sex); 
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error: During Procedure Declare of up_save_activity_daily',sqlca.sqlerrtext)					
				return 1
			end if

			execute p2;
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error: During Procedure Execute of up_save_activity_daily',sqlca.sqlerrtext)
				return 1
			end if		
		end if
	next
	
	
	
	if dw_1.rowcount() > 0 then
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
	end if
end if
end event

type dw_1 from datawindow within w_gtelaf068
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
event ue_dwnkey pbm_dwnkey
event ue_kewdwn pbm_keydown
integer x = 9
integer y = 160
integer width = 4599
integer height = 2052
integer taborder = 100
string dataobject = "dw_gtelaf068"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

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

event itemchanged;if lb_query = false then
	
	if dwo.name='lda_date' then
		ld_dt=datetime(data)
		
		select lww_startdate,lww_enddate,lww_id into :ld_stdt, :ldenddt, :ls_lwwid from fb_labourwagesweek 
		where trunc(:ld_dt) between trunc(lww_startdate) and trunc(lww_enddate) and lww_paidflag='0'; 
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 100 then
			messagebox('Warning!','The Entered Attendance Either Not Found Or Wages Against This Week Has Been Paid, Please Check !!!')
			return 1
		end if	
		
	end if
	
	if dwo.name = 'lda_status'  then
		ld_status = double(data)
		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
		ls_labour_id = dw_1.getitemstring(row,'labour_id')
		ld_dt = dw_1.getitemdatetime(row,'lda_date')
		ls_labour_id = dw_1.getitemstring(row,'labour_id')
		
		if gs_garden_state = '03' then
			if double(data) <> 0 and double(data) <> 1  and double(data) <> 0.50 then
				messagebox('Invalid Status','Status Can Not Be (1/3, or 1/4), Please Check !!!')
				return 1
			end if
		end if		
		
		select nvl(INC_AMTPERDAY,0) into :ld_wages from fb_incentive 
		where INC_REC_TYPE = 'L' and KAMSUB_ID = :ls_labour_id and trunc(:ld_dt) between INC_FRDT and nvl(INC_TODT,trunc(sysdate));
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Labour Incentive Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 100 then
			ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
			
			select nvl(INC_AMTPERDAY,0) into :ld_kincentive from fb_incentive 
			where INC_REC_TYPE = 'K' and KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(INC_FRDT) and nvl(trunc(INC_TODT),trunc(sysdate));
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Kamjari Incentive Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 0 then
				if isnull(ld_kincentive) then ld_kincentive = 0;
				ld_wages = ld_wages + ld_kincentive
			end if				
			
		end if
		dw_1.setitem(row,'lda_wages',ld_wages) 
		if ld_mf_count1 > 0 then
				wf_cal_wages(ld_mf_count1,ld_mf_count2,ld_mf_count3,row,ld_status)
		end if
	else
		ld_status = getitemnumber(row,'lda_status')
	end if	
	
	if dwo.name = 'labour_id'  then
		ld_dt = dw_1.getitemdatetime(row,'lda_date')
		ls_labour_id = data
		
		if isnull(ld_dt) then
			messagebox('Error .!','Date needs to tbe fill')
			return
		end if
		
		select kamsub_id,lda_status,lda_elp,lww_id,job_id,lda_wages,LDA_MFJ_COUNT1, LDA_MFJ_COUNT2, LDA_MFJ_COUNT3, 
				LDA_SECTIONID1, LDA_SECTIONID2, LDA_SECTIONID3 into :ls_kam_id,:ld_status_old,:ld_elp,:ls_lwwid,:ls_job_id,:ld_wages_old,:ld_mf_count1,:ld_mf_count2,:ld_mf_count3,:ls_section1,:ls_section2,:ls_section3
		from fb_labourdailyattendance where trunc(lda_date)=trunc(:ld_dt) and labour_id=:ls_labour_id;
		if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Labour Attendance',sqlca.sqlerrtext)
				return 1
		elseif sqlca.sqlcode = 100 then
				messagebox('Warning :','No data found For Given Labour on date provided')				
				return 1
		elseif sqlca.sqlcode = 0 then
				dw_1.setitem(row,'kamsub_id',ls_kam_id)
				dw_1.setitem(row,'lda_old_wages',ld_wages_old)
				dw_1.setitem(row,'lda_old_status',ld_status_old)
				dw_1.setitem(row,'lda_wages',ld_wages_old)
				dw_1.setitem(row,'lda_status',ld_status_old)				
		end if		
		
	dw_1.insertrow(0)
	
	end if
	
	if dwo.name='appr_ind' then
	ls_appr_ind=data
	
	
	ls_entry_by=dw_1.getitemstring(row,'entry_by')
	
	if upper(trim(ls_entry_by))=upper(trim(gs_user)) then
		messagebox('Warning .. !','Entry By And approve BY cannot be same.')
		return 1;
	end if
	setnull(ld_rundt)
	if(ls_appr_ind='Y') then
		dw_1.setitem(row,'approve_by',gs_user)
		dw_1.setitem(row,'approve_dt',today())
	else
		dw_1.setitem(row,'approve_by','')
		dw_1.setitem(row,'approve_dt',ld_rundt)
	end if
	
	end if
	
	if (dwo.name <> 'appr_ind') then
		dw_1.setitem(row,'entry_by',gs_user)
		dw_1.setitem(row,'entry_dt',today())	
	end if
	
	cb_3.enabled=true
end if
end event

