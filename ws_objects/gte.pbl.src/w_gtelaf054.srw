$PBExportHeader$w_gtelaf054.srw
forward
global type w_gtelaf054 from window
end type
type st_4 from statictext within w_gtelaf054
end type
type st_3 from statictext within w_gtelaf054
end type
type st_2 from statictext within w_gtelaf054
end type
type dp_2 from datepicker within w_gtelaf054
end type
type dp_1 from datepicker within w_gtelaf054
end type
type cb_2 from commandbutton within w_gtelaf054
end type
type cb_1 from commandbutton within w_gtelaf054
end type
type st_1 from statictext within w_gtelaf054
end type
end forward

global type w_gtelaf054 from window
integer width = 1810
integer height = 1272
boolean titlebar = true
string title = "(w_gtelaf004) Process-Holiday"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
boolean center = true
st_4 st_4
st_3 st_3
st_2 st_2
dp_2 dp_2
dp_1 dp_1
cb_2 cb_2
cb_1 cb_1
st_1 st_1
end type
global w_gtelaf054 w_gtelaf054

type variables
//string ls_temp,ls_temp1,ls_frdt,ls_chklwf, ls_lwwid,ls_emp_id, ls_kam,ls_abkam
string ls_hd_dt,ls_hd_pdt,ls_hd_ndt,ls_hp_paidind,ls_lwwid,ls_labour_id,ls_div,ls_emp_ty,ls_sex,ls_cam_ind,ls_count,ls_jobid,ls_kam_id,ls_kamtype,ls_sec1,ls_pwkdt,ls_nwkdt
string ls_temp,ls_pb,ls_pb2
//double ld_lwf, ld_subs
long ll_user_level,ll_child,ll_adoleage,ll_payid, i
double ld_labage,ld_wages, ld_tot,ld_tot1, ld_nodays
date ld_frdt, ld_todt,ld_hd_dt
end variables

forward prototypes
public function integer wf_saveactivitydaily (string fs_date, string fs_labourid, string fd_kamid, string fs_secid, double fd_mandays, double fd_wages, double fd_measure, string fs_oldnew_ind, string fs_cam_ind, string fs_emp_ty, string fs_sex)
public function double wf_kamjari_rate (string fs_kamid, string fs_emp_age, string fs_date)
end prototypes

public function integer wf_saveactivitydaily (string fs_date, string fs_labourid, string fd_kamid, string fs_secid, double fd_mandays, double fd_wages, double fd_measure, string fs_oldnew_ind, string fs_cam_ind, string fs_emp_ty, string fs_sex);long ll_last
string ls_taskdate_id
ll_last=0

if fs_oldnew_ind = 'O' then
		select distinct 'x' into :ls_temp from fb_taskactivedaily where TASK_ID = :fd_kamid and TASK_DATE = to_date(:fs_date,'dd/mm/yyyy') and SECTION_ID = :fs_secid;
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting taskactivedaily Detail',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
		update fb_taskactivedaily set TASK_PMATODAYTY = nvl(TASK_PMATODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_PFATODAYTY = nvl(TASK_PFATODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_TMATODAYTY = nvl(TASK_TMATODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_TFATODAYTY = nvl(TASK_TFATODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_OMATODAYTY = nvl(TASK_OMATODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_OFATODAYTY = nvl(TASK_OFATODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_PMADTODAYTY = nvl(TASK_PMADTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_PFADTODAYTY = nvl(TASK_PFADTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_TMADTODAYTY = nvl(TASK_TMADTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_TFADTODAYTY = nvl(TASK_TFADTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_OMADTODAYTY = nvl(TASK_OMADTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_OFADTODAYTY = nvl(TASK_OFADTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_PMCTODAYTY = nvl(TASK_PMCTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_PFCTODAYTY = nvl(TASK_PFCTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_TMCTODAYTY = nvl(TASK_TMCTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_TFCTODAYTY = nvl(TASK_TFCTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_OMCTODAYTY = nvl(TASK_OMCTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_OFCTODAYTY = nvl(TASK_OFCTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_PMAWTODAYTY = nvl(TASK_PMAWTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0),
											  TASK_PFAWTODAYTY = nvl(TASK_PFAWTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_PMADWTODAYTY = nvl(TASK_PMADWTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0),
											  TASK_PFADWTODAYTY = nvl(TASK_PFADWTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
											  TASK_PMCWTODAYTY = nvl(TASK_PMCWTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0), 
											  TASK_PFCWTODAYTY = nvl(TASK_PFCWTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0), 
											  TASK_TMAWTODAYTY = nvl(TASK_TMAWTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_TFAWTODAYTY = nvl(TASK_TFAWTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_TMADWTODAYTY = nvl(TASK_TMADWTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
											  TASK_TFADWTODAYTY = nvl(TASK_TFADWTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
											  TASK_TMCWTODAYTY = nvl(TASK_TMCWTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0), 
											  TASK_TFCWTODAYTY = nvl(TASK_TFCWTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0), 
											  TASK_OMAWTODAYTY = nvl(TASK_OMAWTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_OFAWTODAYTY = nvl(TASK_OFAWTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_OMADWTODAYTY = nvl(TASK_OMADWTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
											  TASK_OFADWTODAYTY = nvl(TASK_OFADWTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0),  
											  TASK_OMCWTODAYTY = nvl(TASK_OMCWTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0),   
											  TASK_OFCWTODAYTY = nvl(TASK_OFCWTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0),
											  TASK_TOTWAGESTODAYTY = nvl(TASK_TOTWAGESTODAYTY,0) - nvl(:fd_wages,0)
		where TASK_ID = :fd_kamid and TASK_DATE = to_date(:fs_date,'dd/mm/yyyy') and SECTION_ID = :fs_secid;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Updating taskactivedaily Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		
		update fb_taskactivemeasurement set 	 TASK_PMACOUNTTODAYTY = nvl(TASK_PMACOUNTTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
															 TASK_PFACOUNTTODAYTY = nvl(TASK_PFACOUNTTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_TMACOUNTTODAYTY = nvl(TASK_TMACOUNTTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
															 TASK_TFACOUNTTODAYTY = nvl(TASK_TFACOUNTTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_OMACOUNTTODAYTY = nvl(TASK_OMACOUNTTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_OFACOUNTTODAYTY = nvl(TASK_OFACOUNTTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_PMADCOUNTTODAYTY = nvl(TASK_PMADCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_PFADCOUNTTODAYTY = nvl(TASK_PFADCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_TMADCOUNTTODAYTY = nvl(TASK_TMADCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_TFADCOUNTTODAYTY = nvl(TASK_TFADCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
															 TASK_OMADCOUNTTODAYTY = nvl(TASK_OMADCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
															 TASK_OFADCOUNTTODAYTY = nvl(TASK_OFADCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_PMCCOUNTTODAYTY = nvl(TASK_PMCCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
															 TASK_PFCCOUNTTODAYTY = nvl(TASK_PFCCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0),
															 TASK_TMCCOUNTTODAYTY = nvl(TASK_TMCCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
															 TASK_TFCCOUNTTODAYTY = nvl(TASK_TFCCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
															 TASK_OMCCOUNTTODAYTY = nvl(TASK_OMCCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0),
															 TASK_OFCCOUNTTODAYTY  = nvl(TASK_OFCCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0)
		where TASKSECTION_ID = (select TASKDATE_ID from fb_taskactivedaily where TASK_ID = :fd_kamid and TASK_DATE = to_date(:fs_date,'dd/mm/yyyy') and SECTION_ID = :fs_secid);
	
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Updating taskactivemeasurement Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	end if	
	
elseif fs_oldnew_ind = 'N' then
	select distinct 'x' into :ls_temp from fb_taskactivedaily where TASK_ID = :fd_kamid and TASK_DATE = to_date(:fs_date,'dd/mm/yyyy') and SECTION_ID = :fs_secid;
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting taskactivedaily Detail',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
			
		update fb_taskactivedaily set TASK_PMATODAYTY = nvl(TASK_PMATODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_PFATODAYTY = nvl(TASK_PFATODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_TMATODAYTY = nvl(TASK_TMATODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_TFATODAYTY = nvl(TASK_TFATODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_OMATODAYTY = nvl(TASK_OMATODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_OFATODAYTY = nvl(TASK_OFATODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_PMADTODAYTY = nvl(TASK_PMADTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_PFADTODAYTY = nvl(TASK_PFADTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_TMADTODAYTY = nvl(TASK_TMADTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_TFADTODAYTY = nvl(TASK_TFADTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_OMADTODAYTY = nvl(TASK_OMADTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_OFADTODAYTY = nvl(TASK_OFADTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_PMCTODAYTY = nvl(TASK_PMCTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_PFCTODAYTY = nvl(TASK_PFCTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_TMCTODAYTY = nvl(TASK_TMCTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_TFCTODAYTY = nvl(TASK_TFCTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_OMCTODAYTY = nvl(TASK_OMCTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_OFCTODAYTY = nvl(TASK_OFCTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_PMAWTODAYTY = nvl(TASK_PMAWTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0),
											  TASK_PFAWTODAYTY = nvl(TASK_PFAWTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_PMADWTODAYTY = nvl(TASK_PMADWTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0),
											  TASK_PFADWTODAYTY = nvl(TASK_PFADWTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
											  TASK_PMCWTODAYTY = nvl(TASK_PMCWTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0), 
											  TASK_PFCWTODAYTY = nvl(TASK_PFCWTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0), 
											  TASK_TMAWTODAYTY = nvl(TASK_TMAWTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_TFAWTODAYTY = nvl(TASK_TFAWTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_TMADWTODAYTY = nvl(TASK_TMADWTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
											  TASK_TFADWTODAYTY = nvl(TASK_TFADWTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
											  TASK_TMCWTODAYTY = nvl(TASK_TMCWTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0), 
											  TASK_TFCWTODAYTY = nvl(TASK_TFCWTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0), 
											  TASK_OMAWTODAYTY = nvl(TASK_OMAWTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_OFAWTODAYTY = nvl(TASK_OFAWTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_OMADWTODAYTY = nvl(TASK_OMADWTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
											  TASK_OFADWTODAYTY = nvl(TASK_OFADWTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0),  
											  TASK_OMCWTODAYTY = nvl(TASK_OMCWTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0),   
											  TASK_OFCWTODAYTY = nvl(TASK_OFCWTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0),
											  TASK_TOTWAGESTODAYTY = nvl(TASK_TOTWAGESTODAYTY,0) + nvl(:fd_wages,0)
		where TASK_ID = :fd_kamid and TASK_DATE = to_date(:fs_date,'dd/mm/yyyy') and SECTION_ID = :fs_secid;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Updating taskactivedaily Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		
		update fb_taskactivemeasurement set 	 TASK_PMACOUNTTODAYTY = nvl(TASK_PMACOUNTTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
															 TASK_PFACOUNTTODAYTY = nvl(TASK_PFACOUNTTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_TMACOUNTTODAYTY = nvl(TASK_TMACOUNTTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
															 TASK_TFACOUNTTODAYTY = nvl(TASK_TFACOUNTTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_OMACOUNTTODAYTY = nvl(TASK_OMACOUNTTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_OFACOUNTTODAYTY = nvl(TASK_OFACOUNTTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_PMADCOUNTTODAYTY = nvl(TASK_PMADCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_PFADCOUNTTODAYTY = nvl(TASK_PFADCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_TMADCOUNTTODAYTY = nvl(TASK_TMADCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_TFADCOUNTTODAYTY = nvl(TASK_TFADCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
															 TASK_OMADCOUNTTODAYTY = nvl(TASK_OMADCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
															 TASK_OFADCOUNTTODAYTY = nvl(TASK_OFADCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_PMCCOUNTTODAYTY = nvl(TASK_PMCCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
															 TASK_PFCCOUNTTODAYTY = nvl(TASK_PFCCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0),
															 TASK_TMCCOUNTTODAYTY = nvl(TASK_TMCCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
															 TASK_TFCCOUNTTODAYTY = nvl(TASK_TFCCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
															 TASK_OMCCOUNTTODAYTY = nvl(TASK_OMCCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0),
															 TASK_OFCCOUNTTODAYTY  = nvl(TASK_OFCCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0)
		where TASKSECTION_ID = (select TASKDATE_ID from fb_taskactivedaily where TASK_ID = :fd_kamid and TASK_DATE = to_date(:fs_date,'dd/mm/yyyy') and SECTION_ID = :fs_secid);
	
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Updating taskactivemeasurement Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	elseif sqlca.sqlcode = 100 then
			if ll_last=0 then
				select nvl(MAX(substr(TASKDATE_ID,9,10)),0) into :ll_last from fb_taskactivedaily;
			end if
			ll_last = ll_last + 1
			ls_taskdate_id = 'TASKDATE'+string(ll_last,'0000000000')
		
		insert into fb_taskactivedaily(TASK_ID, TASK_DATE, TASKDATE_ID, 
											 TASK_PMATODAYTY, TASK_PFATODAYTY, TASK_TMATODAYTY, TASK_TFATODAYTY, 
											 TASK_OMATODAYTY, TASK_OFATODAYTY, 
											 TASK_PMADTODAYTY, TASK_PFADTODAYTY, TASK_TMADTODAYTY, TASK_TFADTODAYTY, 
											 TASK_OMADTODAYTY, TASK_OFADTODAYTY, 
											 TASK_PMCTODAYTY, TASK_PFCTODAYTY, TASK_TMCTODAYTY, TASK_TFCTODAYTY, 
											 TASK_OMCTODAYTY, TASK_OFCTODAYTY, 
											 TASK_PMAWTODAYTY, TASK_PFAWTODAYTY, TASK_PMADWTODAYTY, TASK_PFADWTODAYTY, 
											 TASK_PMCWTODAYTY, TASK_PFCWTODAYTY, 
											 TASK_TMAWTODAYTY, TASK_TFAWTODAYTY, TASK_TMADWTODAYTY, TASK_TFADWTODAYTY,
											 TASK_TMCWTODAYTY, TASK_TFCWTODAYTY, 
											 TASK_OMAWTODAYTY, TASK_OFAWTODAYTY, TASK_OMADWTODAYTY,TASK_OFADWTODAYTY, 
											 TASK_OMCWTODAYTY, TASK_OFCWTODAYTY, 
											 TASK_TOTWAGESTODAYTY, SECTION_ID,
											 TASK_PMATODATETY, TASK_PFATODATETY, TASK_TMATODATETY, TASK_TFATODATETY, 
											 TASK_OMATODATETY, TASK_OFATODATETY, TASK_PMADTODATETY, TASK_PFADTODATETY, 
											 TASK_TMADTODATETY, TASK_TFADTODATETY, TASK_OMADTODATETY, TASK_OFADTODATETY, 
											 TASK_PMCTODATETY, TASK_PFCTODATETY, TASK_TMCTODATETY, TASK_TFCTODATETY, 
											 TASK_OMCTODATETY, TASK_OFCTODATETY, TASK_TOTWAGESTODATETY)
		values(:fd_kamid,to_date(:fs_date,'dd/mm/yyyy'),:ls_taskdate_id,
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
				  decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0), 
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0),  
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0),  
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0),   
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0),
				 nvl(:fd_wages,0),:fs_secid,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Inserting taskactivedaily Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	
		insert into fb_taskactivemeasurement (TASKSECTION_ID, TASK_PMACOUNTTODAYTY, TASK_PFACOUNTTODAYTY, TASK_TMACOUNTTODAYTY, 
															TASK_TFACOUNTTODAYTY, TASK_OMACOUNTTODAYTY, TASK_OFACOUNTTODAYTY, TASK_PMADCOUNTTODAYTY, 
															TASK_PFADCOUNTTODAYTY, TASK_TMADCOUNTTODAYTY, TASK_TFADCOUNTTODAYTY, 
															TASK_OMADCOUNTTODAYTY, TASK_OFADCOUNTTODAYTY, TASK_PMCCOUNTTODAYTY, TASK_PFCCOUNTTODAYTY, 
															TASK_TMCCOUNTTODAYTY, TASK_TFCCOUNTTODAYTY, TASK_OMCCOUNTTODAYTY, TASK_OFCCOUNTTODAYTY,
															TASK_PMACOUNTTODATETY, TASK_PFACOUNTTODATETY, TASK_TMACOUNTTODATETY, TASK_TFACOUNTTODATETY, 
															TASK_OMACOUNTTODATETY, TASK_OFACOUNTTODATETY, TASK_PMADCOUNTTODATETY, TASK_PFADCOUNTTODATETY, 
															TASK_TMADCOUNTTODATETY, TASK_TFADCOUNTTODATETY, TASK_OMADCOUNTTODATETY, 
															TASK_OFADCOUNTTODATETY, TASK_PMCCOUNTTODATETY, TASK_PFCCOUNTTODATETY, TASK_TMCCOUNTTODATETY, 
															TASK_TFCCOUNTTODATETY, TASK_OMCCOUNTTODATETY, TASK_OFCCOUNTTODATETY)
		values(:ls_taskdate_id,
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),  
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0),   
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0),
				 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
				 
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Inserting taskactivemeasurement Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		
	end if
//	commit using sqlca;
end if
return 1
end function

public function double wf_kamjari_rate (string fs_kamid, string fs_emp_age, string fs_date);double ld_rate

select nvl(decode(:fs_emp_age,'AA',kamsub_afrate,'AD',kamsub_adfrate,'CH',kamsub_cfrate,0),0) into :ld_rate 
 from fb_kamsubhead 
where trim(kamsub_id) = :fs_kamid and to_date(:fs_date,'dd/mm/yyyy') between trunc(KAMSUB_FRDT) and trunc(nvl(KAMSUB_TODT,sysdate));

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Labour Kamjari Rate Detail',sqlca.sqlerrtext)
	rollback using sqlca;
	return -1
elseif sqlca.sqlcode =100 then
	ld_rate=0
end if

if isnull(ld_rate) then ld_rate=0

return  ld_rate
end function

on w_gtelaf054.create
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.dp_2=create dp_2
this.dp_1=create dp_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.Control[]={this.st_4,&
this.st_3,&
this.st_2,&
this.dp_2,&
this.dp_1,&
this.cb_2,&
this.cb_1,&
this.st_1}
end on

on w_gtelaf054.destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dp_2)
destroy(this.dp_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
end on

event open;if date(gd_dt) <> today() then
	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
	return 1
end if

this.tag = Message.StringParm
ll_user_level = long(this.tag)


end event

type st_4 from statictext within w_gtelaf054
integer x = 5
integer y = 1124
integer width = 933
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean italic = true
long textcolor = 255
long backcolor = 67108864
string text = "* Processing will mark Holiday without Pay"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_gtelaf054
integer x = 379
integer y = 172
integer width = 951
integer height = 68
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Miscellaneous Holiday Process"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_gtelaf054
integer x = 841
integer y = 484
integer width = 247
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "To Date :"
alignment alignment = right!
boolean focusrectangle = false
end type

type dp_2 from datepicker within w_gtelaf054
integer x = 1097
integer y = 468
integer width = 361
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2020-04-20"), Time("10:07:26.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_1 from datepicker within w_gtelaf054
integer x = 475
integer y = 468
integer width = 361
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2020-04-20"), Time("10:07:26.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type cb_2 from commandbutton within w_gtelaf054
integer x = 901
integer y = 624
integer width = 311
integer height = 112
integer taborder = 40
integer textsize = -9
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

type cb_1 from commandbutton within w_gtelaf054
integer x = 581
integer y = 624
integer width = 311
integer height = 112
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Process"
boolean default = true
end type

event clicked;//ls_hd_dt = trim(ddlb_1.text)
ld_frdt = date(dp_1.text)
ld_todt = date(dp_2.text)

select distinct 'x' into :ls_temp from fb_labourwagesweek where :ld_frdt between lww_startdate and lww_enddate and :ld_todt between lww_startdate and lww_enddate;
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while cheching payment period : '+sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 100 then
	messagebox('Warning','Both From date and To date should belong to same payment period.')
	return 1
end if

select :ld_todt - :ld_frdt + 1 into :ld_nodays from dual ;
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occcured while checking number of days')
	return 1
end if 

//if isnull(ls_hd_dt) or len(ls_hd_dt) = 0  then 
//	messagebox('Error At Date','Please Select A Holiday Date, Please Check !!!')
//	return 1
//end if;

IF messagebox('Alert','Holiday is being processed for '+string(ld_nodays)+' days. Do you want to proceed ? ',Exclamation!, YesNo!, 1) = 1 THEN

  	SetPointer(Hourglass!);
	n_fames luo_fames
	luo_fames = Create n_fames
  
	string ls_last,ls_nkamtype
	long ll_cnt
	
	ll_adoleage = 0 ;ll_child=0
 
	select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0)) into :ll_adoleage, :ll_child
	from fb_param_detail 
	where pd_doc_type in ('CHILDAGE','ADOLEAGE') and :ld_frdt between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));
	
	if sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
		return 1
	end if;
	
	select nvl(MAX(JOB_ID),0) into :ls_last from fb_labourdailyattendance where JOB_ID like 'JOB%';
	ls_last = right(ls_last,10)
	ll_cnt = long(ls_last)
	
	select  lww_id into :ls_lwwid from fb_labourwagesweek 
	where :ld_frdt between trunc(lww_startdate) and trunc(lww_enddate) and lww_paidflag='0';
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Week Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 100 then
		messagebox('Warning!','The Entered Payment Either Not Found Or Wages Against This Week Has Been Paid, Please Check !!!')
		return 1
	end if	
		
	setnull(ls_labour_id);setnull(ls_div);setnull(ls_emp_ty);setnull(ls_sex)
	ld_labage=0;ld_wages=0;ll_payid=0
////////////////////////
	
	for i = 1 to ld_nodays 
		select to_char(:ld_frdt + (:i - 1),'dd/mm/yyyy') into :ls_hd_dt from dual ;
		if sqlca.sqlcode = -1 then
			messagebox('Error','Error occured while operating on dates : '+sqlca.sqlerrtext)
			return 1
		end if
	
			DECLARE c1 CURSOR FOR  
			select EMP_ID,a.FIELD_ID,a.ls_id, ((to_date(:ls_hd_dt,'dd/mm/yyyy') - emp_dob) /365) age, emp_type, emp_sex,'U'
			from (select * from fb_employee where EMP_JDATE <= to_date(:ls_hd_dt,'dd/mm/yyyy') - 1) a ,fb_laboursheet b
			where a.ls_id = b.ls_id and nvl(EMP_ACTIVE,'1') = '1' and emp_type in ('LP','LT','LO') and 
			not exists (select distinct labour_id from fb_labourdailyattendance b where trunc(lda_date) = to_date(:ls_hd_dt,'dd/mm/yyyy') and b.labour_id = a.emp_id) 
			order by emp_id;
			
			open c1;
			
			IF sqlca.sqlcode = 0 THEN
				fetch c1 into :ls_labour_id,:ls_div,:ll_payid,:ld_labage,:ls_emp_ty,:ls_sex,:ls_hp_paidind;
				
				do while sqlca.sqlcode <> 100
					
					If ld_labage <= ll_child Then
						ls_cam_ind = 'CH'
					ElseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
						ls_cam_ind = 'AD'
					ElseIf ld_labage > ll_adoleage Then
						ls_cam_ind = 'AA'
					End If	
				
		//			ls_cam_ind,ls_emp_ty,ls_sex
					ll_cnt = ll_cnt + 1
					select lpad(:ll_cnt,10,'0') into :ls_count from dual;
					ls_jobid = 'JOB'+ls_count
					
					select distinct 'x' into :ls_temp from fb_maternity
					 where mt_empid = :ls_labour_id and to_date(:ls_hd_dt,'dd/mm/yyyy') between trunc(mt_fromdt) and trunc(mt_todt);
					 
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					elseif sqlca.sqlcode = 0 then
						
						select distinct KAMSUB_ID, trim(KAMSUB_TYPE) into :ls_kam_id,:ls_kamtype from fb_kamsubhead where trim(kamsub_nkamtype)='MATERNITY';
						if sqlca.sqlcode = -1 then
							messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
							rollback using sqlca;
							return 1
						end if
						
						setnull(ls_sec1)
						select section_id into :ls_sec1 from fb_section
						where substr(SECTION_NAME,1,1)||'KAM' = :ls_kamtype and FIELD_ID=decode(:ls_kamtype,'FKAM','NA',:ls_div);
						
						if sqlca.sqlcode = -1 then
							messagebox('Error 1: While Getting Section From Section Master',sqlca.sqlerrtext)
							messagebox('Labour - Kamtype',ls_labour_id+'-'+ls_kamtype)
							rollback using sqlca;
							return 1
						end if		
						
						ld_wages = wf_kamjari_rate(ls_kam_id,ls_cam_ind,ls_hd_dt)
						
						if ld_wages < 0 then
							rollback using sqlca;
							return 1
						end if
						
						if isnull(ld_wages) then ; ld_wages=0; end if
						
					elseif sqlca.sqlcode = 100 then
						
						if ls_hp_paidind='P' then
							ls_nkamtype = 'HOLIDAYPAY'
						elseif ls_hp_paidind='U' then
							ls_nkamtype = 'HOLIDAYNOPAY'
						else
							ls_nkamtype = 'ABSENT'
						end if
						
						setnull(ls_temp) 
						
						select distinct KAMSUB_ID, trim(KAMSUB_TYPE) into :ls_kam_id,:ls_kamtype from fb_kamsubhead where trim(kamsub_nkamtype)=:ls_nkamtype;
						
						if sqlca.sqlcode = -1 then
							messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
							rollback using sqlca;
							return 1
						end if
						
						setnull(ls_sec1)
						select section_id into :ls_sec1 from fb_section
						where substr(SECTION_NAME,1,1)||'KAM' = :ls_kamtype and FIELD_ID=decode(:ls_kamtype,'FKAM','NA',:ls_div) and section_type='C';
						
						if sqlca.sqlcode = -1 then
							messagebox('Error 2: While Getting Section From Section Master',sqlca.sqlerrtext)
							messagebox('Labour - Kamtype',ls_labour_id+'-'+ls_kamtype)
							rollback using sqlca;
							return 1
						end if		
						
						ld_wages = wf_kamjari_rate(ls_kam_id,ls_cam_ind,ls_hd_dt)
						
						if ld_wages < 0 then
							rollback using sqlca;
							return 1
						end if
						
						if isnull(ld_wages) then ; ld_wages=0; end if
						
					end if	
					
				// Attendance Insert	
				
						insert into fb_labourdailyattendance(LDA_DATE, LABOUR_ID, KAMSUB_ID, LDA_WAGES, LDA_STATUS, JOB_ID, 
																		lda_sectionid1,LWW_ID, LDA_ELP, LDA_ENTRY_BY, LDA_ENTRY_DT)
						values(to_date(:ls_hd_dt,'dd/mm/yyyy'),:ls_labour_id,:ls_kam_id,:ld_wages,1,:ls_jobid,:ls_sec1,:ls_lwwid,0,:gs_user,sysdate);
						
						if sqlca.sqlcode = -1 then
							messagebox('Error : While Inserting Data Into Attendance Table : ',sqlca.sqlerrtext)
							rollback using sqlca;
							return 1
						end if
		
				// Start MES
						if ld_wages > 0 then 
							if luo_fames.wf_upd_mes(ls_hd_dt,ls_kam_id,ld_wages,'W','N') = -1 then 
								rollback using sqlca;
								return 1;
							end if
						end if
		//		// Start Task Activity
						
						if (not isnull(ls_sec1) or len(ls_sec1) > 0) then
							if wf_saveactivitydaily(ls_hd_dt,ls_labour_id,ls_kam_id,ls_sec1,1,ld_wages,1,'N',ls_cam_ind,ls_emp_ty,ls_sex) = -1 then 
								rollback using sqlca;
								return 1;
							end if
						end if
						
					fetch c1 into :ls_labour_id,:ls_div,:ll_payid,:ld_labage,:ls_emp_ty,:ls_sex,:ls_hp_paidind;
				loop
			END IF
		close c1;
	next
/////////////////////////
	

DESTROY n_fames

commit using sqlca;
setpointer(arrow!)	
Messagebox('Information !','Holiday Process Completed !!!')
end if


end event

type st_1 from statictext within w_gtelaf054
integer x = 146
integer y = 484
integer width = 311
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "From Date :"
alignment alignment = right!
boolean focusrectangle = false
end type

