$PBExportHeader$w_gtelaf051.srw
forward
global type w_gtelaf051 from window
end type
type st_2 from statictext within w_gtelaf051
end type
type st_1 from statictext within w_gtelaf051
end type
type ddlb_1 from dropdownlistbox within w_gtelaf051
end type
type cb_2 from commandbutton within w_gtelaf051
end type
type cb_1 from commandbutton within w_gtelaf051
end type
end forward

global type w_gtelaf051 from window
integer width = 1810
integer height = 1272
boolean titlebar = true
string title = "(w_gtelaf051) Process-Arrear"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
boolean center = true
st_2 st_2
st_1 st_1
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
end type
global w_gtelaf051 w_gtelaf051

type variables
string ls_labourid, ls_afs_id,ls_ap_id,ls_frdt, ls_todt, ls_temp, ls_temp_ind, ls_temp_check
double ld_totamt, ld_pf,ld_fpf, ld_workdays, ld_matdays, ld_sickwagesdays, ld_hajiradays, ld_holidaypaydays,ld_fpfrate,ld_pfrate
long ll_user_level, ll_adoleage, ll_child
end variables

on w_gtelaf051.create
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_2,&
this.st_1,&
this.ddlb_1,&
this.cb_2,&
this.cb_1}
end on

on w_gtelaf051.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;
if date(gd_dt) <> today() then
	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
	return 1
end if

declare c1 cursor for
select to_char(ap_startdate,'dd/mm/yyyy')||' - '|| to_char(ap_ENDDATE,'dd/mm/yyyy')||'   '||ap_id 
from fb_arrearperiod where nvl(ap_confirm, '0') = '0'
order by  ap_startdate desc;

open c1;

if sqlca.sqlcode = -1 then 
	messagebox('Error At Cursor','Error During Opening Cursor');
	return 1;
else
	setnull(ls_frdt);
	fetch c1 into :ls_frdt;	
	do while sqlca.sqlcode <> 100 
	
		ddlb_1.additem(ls_frdt);
	
		setnull(ls_frdt);
		fetch c1 into :ls_frdt;	
	loop
	close c1;
end if;

this.tag = Message.StringParm
ll_user_level = long(this.tag)

if ll_user_level = 3 then
	cb_1.enabled = false
end if

end event

type st_2 from statictext within w_gtelaf051
integer x = 581
integer y = 132
integer width = 517
integer height = 60
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Process Arrear"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_gtelaf051
integer x = 82
integer y = 420
integer width = 402
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Arrear Period : "
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gtelaf051
integer x = 489
integer y = 404
integer width = 1166
integer height = 368
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
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_gtelaf051
integer x = 987
integer y = 612
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

type cb_1 from commandbutton within w_gtelaf051
integer x = 471
integer y = 612
integer width = 485
integer height = 112
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Calculate Arrear"
boolean default = true
end type

event clicked;ls_frdt = left(ddlb_1.text,10)
ls_todt = mid(ddlb_1.text,14,10) 
ls_temp =  right(ddlb_1.text,12)

if isnull(ls_frdt) then 
	messagebox('Error At Date','Period Start Date Should Be Entered, Please Check !!!')
	return 1
end if;

select ap_confirm into :ls_temp_ind from fb_arrearperiod where ap_id = :ls_temp;
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while checking Arrear Period Details')
	return 1;
elseif sqlca.sqlcode = 100 then
	messagebox('Warning','No such period found')
	return 1;
end if 

select distinct 'x' into :ls_temp_check from fb_arrearforsheet where ap_id = :ls_temp;
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while checking Arrear Rate Details')
	return 1;
elseif sqlca.sqlcode = 100 then
	messagebox('Warning','Rate not found in master, Kindly enter rate in Arrear rate Master')
	return 1;
end if
 ld_fpfrate =0
 select PD_VALUE into :ld_fpfrate from fb_param_detail where PD_DOC_TYPE in ('PFFPFRT') and  PD_PERIOD_TO is null and PD_DESC ='FPF RATE';
 if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while checking FPF RATE from Parameter Master')
	return 1;
elseif sqlca.sqlcode = 100 then
	messagebox('Warning','Rate not found in master, Kindly enter FPF rate in Parameter Master')
	return 1;
end if

select PD_VALUE into :ld_pfrate from fb_param_detail where PD_DOC_TYPE in ('PFFPFRT') and  PD_PERIOD_TO is null and PD_DESC ='PF RATE';
 if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while checking PF RATE from Parameter Master')
	return 1;
elseif sqlca.sqlcode = 100 then
	messagebox('Warning','Rate not found in master, Kindly enter PF rate in Parameter Master')
	return 1;
end if
 
if ls_temp_ind = '1' then
	if ll_user_level = 1 then	
		if messagebox('Arrear Period Select ','The arrear against this period has been already calculated, Would You Like to Recalculate the Arrear',question!,yesno!,1) = 1 then
			update fb_arrearperiod set ap_confirm='0' where ap_id = :ls_temp;
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error : During Arrear Period (Update) ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return 1; 
			end if
			
			delete from fb_labourarrear where afs_id in (select afs_id from fb_arrearforsheet where ap_id = :ls_temp);
			
			if sqlca.sqlcode = -1 then
				messagebox('SQL ERROR: During Labour Arrear Delete',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			end if;	
		else
			return 1
		end if
	else
		messagebox('Arrear Period Select ','The arrear against this period has been already calculated, You can not Recalculate the Arrear, Please Contact "Admin User"',information!)
		return 1
	end if
end if 


SetPointer(HourGlass!);

select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0)) into :ll_adoleage, :ll_child
from fb_param_detail 
where pd_doc_type in ('CHILDAGE','ADOLEAGE') and trunc(sysdate) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));
	


declare c1 cursor for 
	select labourid, round((matarrear + SICKARREAR + HAJIRAARREAR + HOLIDAYPAYARREAR),2) tot_amt, round(decode(nvl(emp_pfno,'0'),'0',0,decode(nvl(emp_pfdedcode, '0'), '0', 0,  decode(nvl(emp_active, '0'), '0', 0,(round((matarrear + SICKARREAR + HAJIRAARREAR + HOLIDAYPAYARREAR),2)*(:ld_pfrate/100))))),0) pf, round(decode(nvl(emp_pfno,'0'),'0',0,decode(nvl(emp_pfdedcode, '0'), '0', 0,  decode(nvl(emp_active, '0'), '0', 0,(round((matarrear + SICKARREAR + HAJIRAARREAR + HOLIDAYPAYARREAR),2)*(:ld_fpfrate/100))))),0)fpf,
	afs_id, (matdays + sickwagesdays + hajiradays + holidaypayday) days_worked, ap_id, matdays, sickwagesdays, hajiradays, holidaypayday from 
	(select  lda.labour_id labourid,
					sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',decode(sign(((trunc(lda_date) - emp_dob) /365) - :ll_adoleage), 1, nvl(lda_status,0), nvl(lda_status,0)*0.5),0)) matdays,
					sum(decode(trim(kam.kamsub_nkamtype),'SICKALLOWANCE',decode(nvl(lda_wages,0),0,0,decode(sign(((trunc(lda_date) - emp_dob) /365) - :ll_adoleage), 1, nvl(lda_status,0), nvl(lda_status,0)*0.5)),0)) sickwagesdays,
					sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',decode(sign(((trunc(lda_date) - emp_dob) /365) - :ll_adoleage), 1, nvl(lda_status,0), nvl(lda_status,0)*0.5),0)) hajiradays,
					sum(decode(trim(kam.kamsub_nkamtype),'HOLIDAYPAY',decode(sign(((trunc(lda_date) - emp_dob) /365) - :ll_adoleage), 1, nvl(lda_status,0), nvl(lda_status,0)*0.5),0)) holidaypayday,
					sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',decode(sign(((trunc(lda_date) - emp_dob) /365) - :ll_adoleage), 1, nvl(lda_status,0), nvl(lda_status,0)*0.5),0) * afs_wageincrate) matarrear,
					sum(decode(trim(kam.kamsub_nkamtype),'SICKALLOWANCE',decode(nvl(lda_wages,0),0,0,decode(sign(((trunc(lda_date) - emp_dob) /365) - :ll_adoleage), 1, nvl(lda_status,0), nvl(lda_status,0)*0.5)),0) * afs_sickincrate) sickarrear,
					sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',decode(sign(((trunc(lda_date) - emp_dob) /365) - :ll_adoleage), 1, nvl(lda_status,0), nvl(lda_status,0)*0.5),0) * afs_wageincrate) hajiraarrear,
					sum(decode(trim(kam.kamsub_nkamtype),'HOLIDAYPAY',decode(sign(((trunc(lda_date) - emp_dob) /365) - :ll_adoleage), 1, nvl(lda_status,0), nvl(lda_status,0)*0.5),0) * afs_wageincrate) holidaypayarrear,afs_id, ap_id, emp_pfno, emp_pfdedcode, emp_active
	  from fb_labourdailyattendance lda,fb_kamsubhead kam,fb_employee emp , fb_arrearforsheet afs
	 where lda.kamsub_id=kam.kamsub_id and lda.labour_id = emp.emp_id and emp.ls_id= afs.ls_id and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and lda.lda_date between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy')
		 and ap_id = :ls_temp
	 group by lda.labour_id,afs_id, ap_id,emp_pfno, emp_pfdedcode, emp_active) where (matarrear + SICKARREAR + HAJIRAARREAR + HOLIDAYPAYARREAR) > 0 or (matdays + sickwagesdays + hajiradays + holidaypayday) > 0;
			

//change done on 05062021 on ghosh sir's advise to remove elp and maternity from calculation and floor the  total value
//    select labourid,floor(matarrear + SICKARREAR + HAJIRAARREAR + HOLIDAYPAYARREAR) tot_amt, decode(nvl(emp_pfno,'0'),'0',0,(floor(matarrear + SICKARREAR + HAJIRAARREAR + HOLIDAYPAYARREAR)*0.12)) pf, (floor(matarrear + SICKARREAR + HAJIRAARREAR + HOLIDAYPAYARREAR)*0) fpf,
//    afs_id, (0 + sickwagesdays + hajiradays + holidaypayday) days_worked, ap_id, matdays, sickwagesdays, hajiradays, holidaypayday from 
//        (select  lda.labour_id labourid,
//                    sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',nvl(lda_status,0),0)) matdays,
//                    sum(decode(trim(kam.kamsub_nkamtype),'SICKALLOWANCE',nvl(lda_status,0),0)) sickwagesdays,
//                    sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',nvl(lda_status,0),0)) hajiradays,
//                    sum(decode(trim(kam.kamsub_nkamtype),'HOLIDAYPAY',nvl(lda_status,0),0)) holidaypayday,
//                    round(sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',nvl(lda_wages,0),0) * (0/100)),2) matarrear,
//                    round(sum(decode(trim(kam.kamsub_nkamtype),'SICKALLOWANCE',nvl(lda_wages,0),0) * (afs_incpercent/100)),2) sickarrear,
//                    round(sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',nvl(lda_wages,0) - nvl(lda_elp,0),0) * (afs_incpercent/100)),2) hajiraarrear,
//                    round(sum(decode(trim(kam.kamsub_nkamtype),'HOLIDAYPAY',nvl(lda_wages,0),0) * (afs_incpercent/100)),2) holidaypayarrear,afs_id, ap_id, emp_pfno
//          from fb_labourdailyattendance lda,fb_kamsubhead kam,fb_employee emp , fb_arrearforsheet afs
//         where lda.kamsub_id=kam.kamsub_id and lda.labour_id = emp.emp_id and emp.ls_id= afs.ls_id and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and lda.lda_date between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy')
//            and ap_id = :ls_temp
//         group by lda.labour_id,afs_id, ap_id,emp_pfno) where (matarrear + SICKARREAR + HAJIRAARREAR + HOLIDAYPAYARREAR) > 0 or (matdays + sickwagesdays + hajiradays + holidaypayday) > 0;
//

open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
elseif sqlca.sqlcode = 100 then 
	messagebox('Warning','No Attendance records found for this period '); 
	return 1;
else
	setnull(ls_labourid); ld_totamt = 0;  ld_pf = 0; ld_fpf = 0; setnull(ls_afs_id); ld_workdays = 0; setnull(ls_ap_id);  ld_matdays = 0; ld_sickwagesdays = 0; ld_hajiradays = 0; ld_holidaypaydays = 0;
	
	fetch c1 into :ls_labourid, :ld_totamt, :ld_pf, :ld_fpf,:ls_afs_id , :ld_workdays, :ls_ap_id, :ld_matdays, :ld_sickwagesdays, :ld_hajiradays, :ld_holidaypaydays;
	
	do while sqlca.sqlcode <> 100 
		
		insert into fb_labourarrear(LABOUR_ID, LA_AMOUNT, LA_PF, LA_FPF, AFS_ID, LA_VOU_NO, LA_VOU_DT, LA_DAYSWORKED, AP_ID, LA_MATDAYS, LA_SICKDAYS, LA_HAJIRADAYS, LA_HOLIDAYPAYDAYS) 
		values(:ls_labourid,:ld_totamt,:ld_pf, :ld_fpf,:ls_afs_id,null, null, :ld_workdays, :ls_ap_id, :ld_matdays, :ld_sickwagesdays, :ld_hajiradays, :ld_holidaypaydays);
		if sqlca.sqlcode = -1 then
			messagebox('Error occured while inserting records',sqlca.sqlerrtext)
			rollback using sqlca ;
			return 1;
		end if 
		fetch c1 into :ls_labourid, :ld_totamt, :ld_pf, :ld_fpf,:ls_afs_id , :ld_workdays, :ls_ap_id, :ld_matdays, :ld_sickwagesdays, :ld_hajiradays, :ld_holidaypaydays;
			
	loop
	
	update fb_arrearperiod set ap_confirm = '1' where ap_id = :ls_temp;
	if sqlca.sqlcode = -1 then
		messagebox('Error occured while updating Arrear Period',sqlca.sqlerrtext)
		rollback using sqlca ;
		return 1;
	end if 
	
	commit using sqlca;
	
end if 
	
messagebox('Confirmation','The Arrear Has Been Sucessfully Calculated, Please Check....!',information!)

SetPointer(Arrow!);
end event

