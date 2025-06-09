$PBExportHeader$w_gtelaf025.srw
forward
global type w_gtelaf025 from window
end type
type cb_6 from commandbutton within w_gtelaf025
end type
type cb_2 from commandbutton within w_gtelaf025
end type
type em_2 from editmask within w_gtelaf025
end type
type em_3 from editmask within w_gtelaf025
end type
type em_4 from editmask within w_gtelaf025
end type
type em_5 from editmask within w_gtelaf025
end type
type em_6 from editmask within w_gtelaf025
end type
type cb_1 from commandbutton within w_gtelaf025
end type
type st_1 from statictext within w_gtelaf025
end type
type ddlb_1 from dropdownlistbox within w_gtelaf025
end type
type cb_5 from commandbutton within w_gtelaf025
end type
type cb_4 from commandbutton within w_gtelaf025
end type
type cb_3 from commandbutton within w_gtelaf025
end type
type dw_1 from datawindow within w_gtelaf025
end type
end forward

global type w_gtelaf025 from window
integer width = 5239
integer height = 2280
boolean titlebar = true
string title = "(w_gtelaf025) Bonus process "
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_6 cb_6
cb_2 cb_2
em_2 em_2
em_3 em_3
em_4 em_4
em_5 em_5
em_6 em_6
cb_1 cb_1
st_1 st_1
ddlb_1 ddlb_1
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
dw_1 dw_1
end type
global w_gtelaf025 w_gtelaf025

type variables
long ll_ctr,ll_cnt, ll_year, ll_last, ll_st_year, ll_end_year,ll_user_level,ll_id
string ls_temp,ls_name,ls_last,ls_type,ls_tmp_id,ls_count,ls_bonusid,ls_emp_type,ls_lwwpaidflag
boolean lb_neworder, lb_query
datetime ld_frdt, ld_todt,ld_otodt,ld_ofrdt
string ls_frdt, ls_todt
double ld_boper,ld_puper,ld_paper,la_faper,ld_minday
long ll_user_level_pf


end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (datetime fd_frdt, datetime fd_todt)
public function integer wf_fill_ddlb ()
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
		ld_fdt1 = dw_1.getitemdatetime(fl_row,'lbs_startdate')
		ld_todt1 = dw_1.getitemdatetime(fl_row,'lbs_enddate')
		
		if ld_fdt1 = fd_frdt and ld_todt1 = fd_todt then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_fill_ddlb ();ddlb_1.reset()

date ld_dt
declare c1 cursor for
select to_char(lbs_STARTDATE,'dd/mm/yyyy')||'-'||to_char(lbs_ENDDATE,'dd/mm/yyyy')||' ('||lbs_ID||') - '||lbs_CONFIRM||' ('||LBS_EMP_TYPE||')',lbs_STARTDATE
  from fb_labbonusseason  where LBS_EMP_TYPE in ('LP','LT','LO')
order by lbs_STARTDATE desc;

open c1;

IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ls_bonusid,:ld_dt;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_bonusid)
		fetch c1 into:ls_bonusid,:ld_dt;
	loop
	close c1;
end if

return 1
end function

on w_gtelaf025.create
this.cb_6=create cb_6
this.cb_2=create cb_2
this.em_2=create em_2
this.em_3=create em_3
this.em_4=create em_4
this.em_5=create em_5
this.em_6=create em_6
this.cb_1=create cb_1
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.dw_1=create dw_1
this.Control[]={this.cb_6,&
this.cb_2,&
this.em_2,&
this.em_3,&
this.em_4,&
this.em_5,&
this.em_6,&
this.cb_1,&
this.st_1,&
this.ddlb_1,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.dw_1}
end on

on w_gtelaf025.destroy
destroy(this.cb_6)
destroy(this.cb_2)
destroy(this.em_2)
destroy(this.em_3)
destroy(this.em_4)
destroy(this.em_5)
destroy(this.em_6)
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

wf_fill_ddlb()

this.tag = Message.StringParm
ll_user_level = long(this.tag)



if ll_user_level <>1 then
	cb_1.enabled = false
	cb_3.enabled= false
end if



//insert into fb_labbonus(LBP_ID,LABOUR_ID,LB_WORKDAYS,LB_GREARN,LB_BONUSAMO,LB_DED,LB_EARN_AMT,LB_LWW_AMT,LB_ARR_AMT,LB_ATNINC_AMT)
//                            select :ls_LBP_ID,labour_id, sum(nvl(workdays,0)) workdays,sum(nvl(lda_wages,0)) grearn,
//                                               round(sum(nvl(lda_wages,0))* decode(sign(sum(nvl(workdays,0))-nvl(:Ld_MINWDAYS,0)),-1,0, (0.01*nvl(:ld_BONUSPER,0))) ,2) bonusamo,0,
//                                                sum(decode(recty,'A',nvl(lda_wages,0),0)) earn, sum(decode(recty,'B',nvl(lda_wages,0),0)) lww,
//                                                sum(decode(recty,'C',nvl(lda_wages,0),0)) arr, sum(decode(recty,'D',nvl(lda_wages,0),0)) attninc
//                             from (SELECT  'A' recty,lda.labour_id,
//                               sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',lda.lda_status,'HOLIDAYPAY',lda.lda_status,'MATERNITY',lda.lda_status,'SICKALLOWANCE',lda.lda_status,0)) workdays,
//                               sum(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) lda_wages
//                        from fb_labourdailyattendance lda,fb_employee l,(select distinct KAMSUB_ID, KAMSUB_NKAMTYPE,KAMSUB_FRDT, nvl(KAMSUB_TODT,SYSDATE) KAMSUB_TODT from fb_kamsubhead where nvl(kamsub_active_ind,'N') = 'Y') kam,
//                             (select LABOUR_ID, x.LWW_ID
//                               from FB_LABOURWEEKLYWAGES x
//                               where nvl(LABOUR_PF, 0) > 0 and x.LWW_ID in (SELECT DISTINCT LWW_ID
//                                                    FROM fb_labourwagesweek 
//                                                    WHERE (LWW_STARTDATE BETWEEN to_date(:ls_start_dt,'dd/mm/yyyy')  and to_date(:ls_end_dt, 'dd/mm/yyyy')) or
//                                                       (LWW_ENDDATE BETWEEN to_date(:ls_start_dt,'dd/mm/yyyy')  and to_date(:ls_end_dt, 'dd/mm/yyyy')) or
//                                                       (LWW_STARTDATE BETWEEN to_date(:ls_start_dt,'dd/mm/yyyy')  and to_date(:ls_end_dt, 'dd/mm/yyyy')) or
//                                                       (LWW_ENDDATE BETWEEN to_date(:ls_start_dt,'dd/mm/yyyy')  and to_date(:ls_end_dt, 'dd/mm/yyyy'))))  w
//                     where l.emp_id=lda.labour_id and kam.kamsub_id=lda.kamsub_id and l.ls_id=:ls_ID and
//                               lda.labour_id = w.LABOUR_ID and lda.LWW_ID=w.Lww_id and
//                               lda_date between to_date(:ls_start_dt,'dd/mm/yyyy')  and to_date(:ls_end_dt, 'dd/mm/yyyy') and
//                              not exists (select em_lsid from fb_exemptmaster
//                                              where lda.lda_date between EM_FROMDT and EM_TODT and EM_BONUSIND='Y' and EM_LSID = l.ls_id) and
//                              (decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) > 0
//                    group by  lda.labour_id
//                    union all
//					SELECT  'B',llw.labour_id,  sum(decode(:gs_garden_snm,'ME',nvl(LWW_DAYS,0),0)) ,sum(llw.lww_earn)
//					FROM fb_lablwwseason lls, fb_lablwwperiod llp, fb_lablww llw
//					 where lls.lls_id = llp.lls_id AND llp.llp_id = llw.llp_id  AND llw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
//                       LLS_PDATE between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and
//                       :Ls_LWW_IND='Y'
//                       group by 'B',llw.labour_id
//                       UNION ALL
//                        SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) *(AP_PAYPER_1/100)
//                        FROM fb_labourarrear lar,fb_arrearperiod arp
//					 WHERE lar.ap_id = arp.ap_id AND
//					 lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
//					 AP_PAYDT_1 between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and :Ls_ARR_IND='Y'
//					group by 'C', lar.labour_id,AP_PAYPER_1
//					union all
//					SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) *(AP_PAYPER_2/100)
//					FROM fb_labourarrear lar,fb_arrearperiod arp
//					WHERE lar.ap_id = arp.ap_id AND
//					lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
//					AP_PAYDT_2 between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and
//					:Ls_ARR_IND='Y'
//					group by 'C', lar.labour_id,AP_PAYPER_2
//					union all
//					SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) *(AP_PAYPER_3/100)
//					FROM fb_labourarrear lar,fb_arrearperiod arp
//					WHERE lar.ap_id = arp.ap_id AND
//					lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
//										AP_PAYDT_3 between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and
//											:Ls_ARR_IND='Y'
//											group by 'C', lar.labour_id,AP_PAYPER_3
//											union all
//											select 'D',labour_id,0,sum(nvl(LABOUR_ATTN_INC,0))
//											from fb_labourweeklywages lw,fb_labourwagesweek lww
//											where lw.lww_id =  lww.lww_id and lw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
//											lww.lww_startdate between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and
//											:Ls_ATNINC_IND='Y' and nvl(LABOUR_ATTN_INC,0) > 0
//											group by  'D',labour_id)	
//                             group by :ls_LBP_ID,labour_id;

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

type cb_6 from commandbutton within w_gtelaf025
boolean visible = false
integer x = 3822
integer y = 12
integer width = 485
integer height = 100
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Duplicate Process"
end type

event clicked;if ll_user_level <> 1 then
	messagebox('Warning!','You Are Not Authorized To Run The Process !!!')
	return 1
end if

if  len(trim(ddlb_1.text)) = 0 or isnull(ddlb_1.text) then
	messagebox ('Warning','Please Select the Bonus Period.')
	return 1
end if;

//ls_frdt = left(ddlb_1.text,10)
//ls_todt = left(right(ddlb_1.text,21),10)
//ls_bonusid=left(right(ddlb_1.text,13),8)

setpointer(hourglass!)
ls_frdt=left(ddlb_1.text,10)
ls_todt=mid(ddlb_1.text,12,10)
ls_bonusid = mid(ddlb_1.text,24,8)

for ll_cnt = 1 to dw_1.rowcount( ) 
	if isnull(dw_1.getitemstring(ll_cnt,'lbp_id')) or len(dw_1.getitemstring(ll_cnt,'lbp_id')) = 0 then
		messagebox('Warning!','First Save The Record Then Click On Process Button !!!')
		return 1
	end if
next

//if right(ddlb_1.text,1) = '1' then

//	fb_labbonusseason set LBS_CONFIRM = 1 where LBS_ID = :ls_bonusid
//	
//	MessageBox('Bonus Calculation Error','Bonus Already calculateed for the period : '+ ls_frdt+' to '+ls_todt+',  Please Check..!',information!)
//	return 1
//end if
//
//if MessageBox('Confirmation: Bonus Calculation','Do you want to calculate Bonus for the period : '+ ls_frdt+' to '+ls_todt,Question!,yesno!,1 )=2 then
//	return 1
//end if

select distinct LBS_CONFIRM into :ls_lwwpaidflag from fb_labbonusseason where LBS_ID = :ls_bonusid;

if sqlca.sqlcode =100 then
	messagebox('Bonus Week Select ','Either the there is no such week or the Bonus against this week has been paid, Please Check...!')
	return 1
elseif sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Bonus Week Select ',sqlca.sqlerrtext)
	return 1
end if;	
	
if ls_lwwpaidflag = '1' then
	if ll_user_level = 1 then	
		if messagebox('Bonus Week Select ','The Bonus against this week has been already calculated, Would You Like to Recalculate the Wages',question!,yesno!,1) = 1 then
			update fb_labbonusseason set LBS_CONFIRM='0' where LBS_ID = :ls_bonusid;
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error : During Labour Bonus Week (Update) ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return 1; 
			end if
			
			delete from fb_labbonus where LBP_ID in (select LBP_ID from fb_labbonusperiod where  LBS_ID = :ls_bonusid);
			
			if sqlca.sqlcode = -1 then
				messagebox('Sql Err: During Delete Of Labour Bonus', sqlca.sqlerrtext)
				return 1
			end if
		else
			return 1
		end if
	else
		messagebox('Bonus Week Select ','The Bonus against this week has been already Calculated, You can not Recalculate the Wages, Please Contact "Admin User"',information!)
		return 1
	end if
end if	


string ls_LBP_ID ,ls_start_dt,ls_end_dt,ls_ID,ls_LTYPE,ls_OTYPE,Ls_LWW_IND,Ls_ARR_IND,Ls_ATNINC_IND
double ld_BONUSPER,Ld_MINWDAYS
//select LBP_ID ,to_char(LBP_STARTDATE,'dd/mm/yyyy'),to_char(LBP_ENDDATE,'dd/mm/yyyy'),
//		a.LS_ID,LBP_PAIDFLAG,LBP_BONUSPER,LBS_ID,LBP_PUJAPER,LBP_PAUSPER,LBP_FAGUAPER,LBP_MINWDAYS,LBP_PERORNOT,
//		LS_LABOURTYPE,LS_OUTSIDERTYPE,LBP_LWW_IND,LBP_ARR_IND,LBP_ATNINC_IND
//  from fb_labbonusperiod a,( select distinct LS_ID,LS_LABOURTYPE,LS_OUTSIDERTYPE from fb_LABOURSHEET where LS_ACTIVE_IND = 'Y') b
//where LBS_ID = :ls_bonusid and a.LS_ID = b.ls_id;


declare c1 cursor for
select LBP_ID ,to_char(LBP_STARTDATE,'dd/mm/yyyy'),to_char(LBP_ENDDATE,'dd/mm/yyyy'),
		a.LS_ID,LBP_BONUSPER,LBP_MINWDAYS,LS_LABOURTYPE,LS_OUTSIDERTYPE,LBP_LWW_IND,LBP_ARR_IND,LBP_ATNINC_IND
  from fb_labbonusperiod a,( select distinct LS_ID,LS_LABOURTYPE,LS_OUTSIDERTYPE from fb_LABOURSHEET where LS_ACTIVE_IND = 'Y') b
where LBS_ID = :ls_bonusid and a.LS_ID = b.ls_id;

open c1;
if sqlca.sqlcode = -1 then
	messagebox('SQL Error: During C1 Cursor',sqlca.sqlerrtext)
	return 1
end if
		setnull(ls_LBP_ID);setnull(ls_start_dt);setnull(ls_end_dt);setnull(ls_ID);setnull(ls_LTYPE);setnull(ls_OTYPE);setnull(Ls_LWW_IND);setnull(Ls_ARR_IND);setnull(Ls_ATNINC_IND)
		ld_BONUSPER=0;Ld_MINWDAYS=0;

 	fetch c1 into :ls_LBP_ID ,:ls_start_dt,:ls_end_dt,:ls_ID,:ld_BONUSPER,:Ld_MINWDAYS,:ls_LTYPE,:ls_OTYPE,:Ls_LWW_IND,:Ls_ARR_IND,:Ls_ATNINC_IND;
	do while sqlca.sqlcode <> 100
    
//		If (ls_LTYPE = 'LP' Or ls_LTYPE = 'LT' Or (ls_LTYPE = 'LO' And ls_OTYPE = 'FACTORY')) Then
		if gs_garden_snm ='MT' then
			if right(ls_start_dt,4) <> '2014' then
				insert into fb_labbonus(LBP_ID,LABOUR_ID,LB_WORKDAYS,LB_GREARN,LB_BONUSAMO,LB_DED,LB_EARN_AMT,LB_LWW_AMT,LB_ARR_AMT,LB_ATNINC_AMT)
				select :ls_LBP_ID,labour_id, sum(nvl(workdays,0)) workdays,sum(nvl(lda_wages,0)) grearn,
						round(sum(nvl(lda_wages,0))*decode(sign(sum(nvl(workdays,0))-nvl(:Ld_MINWDAYS,0)),-1,0, (0.01*nvl(:ld_BONUSPER,0))),2) bonusamo,0,
						sum(decode(recty,'A',nvl(lda_wages,0),0)) earn, sum(decode(recty,'B',nvl(lda_wages,0),0)) lww,
						sum(decode(recty,'C',nvl(lda_wages,0),0)) arr, sum(decode(recty,'D',nvl(lda_wages,0),0)) attninc
				from (SELECT  'A' recty,labour_id, 
									sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',lda.lda_status,'HOLIDAYPAY',lda.lda_status,'MATERNITY',lda.lda_status,'SICKALLOWANCE',lda.lda_status,0)) workdays,
									sum(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) lda_wages
							 from fb_labourdailyattendance lda,fb_employee l,(select distinct KAMSUB_ID, KAMSUB_NKAMTYPE from fb_kamsubhead) kam 
						 where l.emp_id=lda.labour_id and kam.kamsub_id=lda.kamsub_id and l.ls_id=:ls_ID and 
								  lda_date between to_date(:ls_start_dt,'dd/mm/yyyy')  and to_date(:ls_end_dt, 'dd/mm/yyyy') and
								  not exists (select em_lsid from fb_exemptmaster 
												where lda.lda_date between EM_FROMDT and EM_TODT and EM_BONUSIND='Y' and EM_LSID = l.ls_id) and
								  (decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) > 0 
						group by  labour_id
						union all 
						SELECT 'A',lwr.labour_id,0,sum(nvl(lwr.lwr_netelp,0) + nvl(lwr.lwr_penalty,0))  
						FROM fb_labourweeklyration lwr, fb_labourrationweek lrw,fb_labourwagesweek lww 
						WHERE lrw.lrw_id = lwr.lrw_id AND lrw.lww_id = lww.lww_id and
									 lwr.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
									lww.lww_startdate between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy')  
						group by 'A',lwr.labour_id
						union all
						 SELECT  'B',llw.labour_id, 0 ,sum(llw.lww_earn)
						 FROM fb_lablwwseason lls, fb_lablwwperiod llp, fb_lablww llw
						 where lls.lls_id = llp.lls_id AND llp.llp_id = llw.llp_id  AND llw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
								  LLS_PDATE between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and
								 :Ls_LWW_IND='Y'
						group by 'B',llw.labour_id
						 UNION ALL 
						 SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) 
							FROM fb_labourarrear lar,fb_arrearperiod arp,fb_labourwagesweek lww 
						 WHERE lar.ap_id = arp.ap_id AND arp.LWW_ID =lww.lww_id and
									lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
									LWW_STARTDATE between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
									:Ls_ARR_IND='Y'
						group by 'C', lar.labour_id
						union all
						select 'D',labour_id,0,sum(nvl(LABOUR_ATTN_INC,0))
							 from fb_labourweeklywages lw,fb_labourwagesweek lww 
						 where lw.lww_id =  lww.lww_id and lw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
								 lww.lww_startdate between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
								 :Ls_ATNINC_IND='Y' and nvl(LABOUR_ATTN_INC,0) > 0
						group by  'D',labour_id)
				group by :ls_LBP_ID,labour_id;	
			elseif right(ls_start_dt,4) = '2014' then
				insert into fb_labbonus(LBP_ID,LABOUR_ID,LB_WORKDAYS,LB_GREARN,LB_BONUSAMO,LB_DED,LB_EARN_AMT,LB_LWW_AMT,LB_ARR_AMT,LB_ATNINC_AMT)
				select :ls_LBP_ID,labour_id, sum(nvl(workdays,0)) workdays,sum(nvl(lda_wages,0)) grearn,
						round(sum(nvl(lda_wages,0))*decode(sign(sum(nvl(workdays,0))-nvl(:Ld_MINWDAYS,0)),-1,0, (0.01*nvl(:ld_BONUSPER,0))),2) bonusamo,0,
						sum(decode(recty,'A',nvl(lda_wages,0),0)) earn, sum(decode(recty,'B',nvl(lda_wages,0),0)) lww,
						sum(decode(recty,'C',nvl(lda_wages,0),0)) arr, sum(decode(recty,'D',nvl(lda_wages,0),0)) attninc
				from (SELECT  'A' recty,labour_id, 
									sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',lda.lda_status,'HOLIDAYPAY',lda.lda_status,'MATERNITY',lda.lda_status,'SICKALLOWANCE',lda.lda_status,0)) workdays,
									sum(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) lda_wages
							 from fb_labourdailyattendance lda,fb_employee l,(select distinct KAMSUB_ID, KAMSUB_NKAMTYPE from fb_kamsubhead) kam 
						 where l.emp_id=lda.labour_id and kam.kamsub_id=lda.kamsub_id and l.ls_id=:ls_ID and 
								  lda_date between to_date(:ls_start_dt,'dd/mm/yyyy')  and to_date(:ls_end_dt, 'dd/mm/yyyy') and
								  not exists (select em_lsid from fb_exemptmaster 
												where lda.lda_date between EM_FROMDT and EM_TODT and EM_BONUSIND='Y' and EM_LSID = l.ls_id) and
								  (decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) > 0 
						group by  labour_id
						union all 
						SELECT 'A',lwr.labour_id,0,sum(nvl(lwr.lwr_netelp,0) + nvl(lwr.lwr_penalty,0))  
						FROM fb_labourweeklyration lwr, fb_labourrationweek lrw,fb_labourwagesweek lww 
						WHERE lrw.lrw_id = lwr.lrw_id AND lrw.lww_id = lww.lww_id and
									 lwr.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
									lww.lww_startdate between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy')  
						group by 'A',lwr.labour_id
						union all
						 SELECT  'B',llw.labour_id, 0 ,sum(llw.lww_earn)
						 FROM fb_lablwwseason lls, fb_lablwwperiod llp, fb_lablww llw
						 where lls.lls_id = llp.lls_id AND llp.llp_id = llw.llp_id  AND llw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
								  LLS_PDATE between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and
								 :Ls_LWW_IND='Y'
						group by 'B',llw.labour_id
						 UNION ALL 
						 SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) * (2/3)
							FROM fb_labourarrear lar,fb_arrearperiod arp,fb_labourwagesweek lww 
						 WHERE lar.ap_id = arp.ap_id AND arp.LWW_ID =lww.lww_id and
									lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
									LWW_STARTDATE between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
									:Ls_ARR_IND='Y'
						group by 'C', lar.labour_id
						union all
						select 'D',labour_id,0,sum(nvl(LABOUR_ATTN_INC,0))
							 from fb_labourweeklywages lw,fb_labourwagesweek lww 
						 where lw.lww_id =  lww.lww_id and lw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
								 lww.lww_startdate between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
								 :Ls_ATNINC_IND='Y' and nvl(LABOUR_ATTN_INC,0) > 0
						group by  'D',labour_id)
				group by :ls_LBP_ID,labour_id;					
			elseif right(ls_start_dt,4) = '2012' then
				insert into fb_labbonus(LBP_ID,LABOUR_ID,LB_WORKDAYS,LB_GREARN,LB_BONUSAMO,LB_DED,LB_EARN_AMT,LB_LWW_AMT,LB_ARR_AMT,LB_ATNINC_AMT)
				select :ls_LBP_ID,labour_id, sum(nvl(workdays,0)) workdays,sum(nvl(lda_wages,0)) grearn,
							 round(sum(nvl(lda_wages,0))*decode(sign(sum(nvl(workdays,0))-nvl(:Ld_MINWDAYS,0)),-1,0, (0.01*nvl(:ld_BONUSPER,0))),2) bonusamo,0,
						  sum(decode(recty,'A',nvl(lda_wages,0),0)) earn, sum(decode(recty,'B',nvl(lda_wages,0),0)) lww,
						  sum(decode(recty,'C',nvl(lda_wages,0),0)) arr, sum(decode(recty,'D',nvl(lda_wages,0),0)) attninc
				from (SELECT  'A' recty,lda.labour_id, 
										 nvl(workdays,0) workdays,
										 sum(nvl(LABOUR_WAGES,0) + nvl(LABOUR_MATERNITYEARN,0) + nvl(LABOUR_SICKEARN,0) + nvl(LABOUR_OTHEREARN,0) + nvl(LABOUR_ELPEARN,0) - decode(sign(nvl(LABOUR_PENALTY,0)),-1,(-1) * nvl(LABOUR_PENALTY,0) ,nvl(LABOUR_PENALTY,0))) lda_wages
								from fb_labourweeklywages lda,fb_employee l, fb_labourwagesweek a,
									  ( SELECT  labour_id, 
														 sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',lda.lda_status,'HOLIDAYPAY',lda.lda_status,'MATERNITY',lda.lda_status,'SICKALLOWANCE',lda.lda_status,0)) workdays
												from fb_labourdailyattendance lda,fb_employee l,(select distinct KAMSUB_ID, KAMSUB_NKAMTYPE from fb_kamsubhead) kam 
											where l.emp_id=lda.labour_id and kam.kamsub_id=lda.kamsub_id and  l.ls_id=:ls_ID and 
														 lda_date between to_date(:ls_start_dt,'dd/mm/yyyy')  and to_date(:ls_end_dt, 'dd/mm/yyyy') and
														(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) > 0 
										  group by  labour_id) b
							where l.emp_id=lda.labour_id and l.ls_id=:ls_ID and lda.LWW_ID = a.lww_id and lda.labour_id = b.labour_id (+) and 
										 LWW_STARTDATE between to_date(:ls_start_dt,'dd/mm/yyyy')  and to_date(:ls_end_dt, 'dd/mm/yyyy') and
										(nvl(LABOUR_WAGES,0) + nvl(LABOUR_MATERNITYEARN,0) + nvl(LABOUR_SICKEARN,0) + nvl(LABOUR_OTHEREARN,0) + nvl(LABOUR_ELPEARN,0) - nvl(LABOUR_PENALTY,0)) > 0 
						  group by  lda.labour_id , nvl(workdays,0)
						  union all
						  SELECT  'B',llw.labour_id, 0 ,sum(llw.lww_earn)
							FROM fb_lablwwseason lls, fb_lablwwperiod llp, fb_lablww llw
							where lls.lls_id = llp.lls_id AND llp.llp_id = llw.llp_id  AND llw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
										 LLS_PDATE between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and
									  :Ls_LWW_IND='Y'
						  group by 'B',llw.labour_id
							UNION ALL 
							SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) 
								 FROM fb_labourarrear lar,fb_arrearforsheet afs,fb_arrearperiod arp,fb_labourwagesweek lww 
							WHERE lar.afs_id = afs.afs_id AND afs.ap_id = arp.ap_id AND arp.LWW_ID =lww.lww_id and
											lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
											LWW_STARTDATE between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
										  :Ls_ARR_IND='Y'
						  group by 'C', lar.labour_id
						  union all
						  select 'D',labour_id,0,sum(nvl(LABOUR_ATTN_INC,0))
								from fb_labourweeklywages lw,fb_labourwagesweek lww 
							where lw.lww_id =  lww.lww_id and lw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
									  lww.lww_startdate between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
									  :Ls_ATNINC_IND='Y' and nvl(LABOUR_ATTN_INC,0) > 0
						  group by  'D',labour_id)
				group by :ls_LBP_ID,labour_id;
			end if
		elseif gs_garden_snm ='MK' then
			if right(ls_start_dt,4) = '2014' then
				insert into fb_labbonus(LBP_ID,LABOUR_ID,LB_WORKDAYS,LB_GREARN,LB_BONUSAMO,LB_DED,LB_EARN_AMT,LB_LWW_AMT,LB_ARR_AMT,LB_ATNINC_AMT)
				select :ls_LBP_ID,labour_id, sum(nvl(workdays,0)) workdays,sum(nvl(lda_wages,0)) grearn,
						round(sum(nvl(lda_wages,0))* decode(sign(sum(nvl(workdays,0))-nvl(:Ld_MINWDAYS,0)),-1,0, (0.01*nvl(:ld_BONUSPER,0))) ,2) bonusamo,0,
						sum(decode(recty,'A',nvl(lda_wages,0),0)) earn, sum(decode(recty,'B',nvl(lda_wages,0),0)) lww,
						sum(decode(recty,'C',nvl(lda_wages,0),0)) arr, sum(decode(recty,'D',nvl(lda_wages,0),0)) attninc
				from (SELECT  'A' recty,labour_id, 
									sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',lda.lda_status,'HOLIDAYPAY',lda.lda_status,'MATERNITY',lda.lda_status,'SICKALLOWANCE',lda.lda_status,0)) workdays,
									sum(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) lda_wages
							 from fb_labourdailyattendance lda,fb_employee l,(select distinct KAMSUB_ID, KAMSUB_NKAMTYPE from fb_kamsubhead) kam 
						 where l.emp_id=lda.labour_id and kam.kamsub_id=lda.kamsub_id and l.ls_id=:ls_ID and 
								  lda_date between to_date(:ls_start_dt,'dd/mm/yyyy')  and to_date(:ls_end_dt, 'dd/mm/yyyy') and
								  not exists (select em_lsid from fb_exemptmaster 
												where lda.lda_date between EM_FROMDT and EM_TODT and EM_BONUSIND='Y' and EM_LSID = l.ls_id) and
								  (decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) > 0 
						group by  labour_id
						union all
						 SELECT  'B',llw.labour_id,  sum(decode(:gs_garden_snm,'ME',nvl(LWW_DAYS,0),0)) ,sum(llw.lww_earn)
						 FROM fb_lablwwseason lls, fb_lablwwperiod llp, fb_lablww llw
						 where lls.lls_id = llp.lls_id AND llp.llp_id = llw.llp_id  AND llw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
								  LLS_PDATE between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and
								 :Ls_LWW_IND='Y'
						group by 'B',llw.labour_id
						 UNION ALL 
						 SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) * (1/3)
							FROM fb_labourarrear lar,fb_arrearperiod arp
						 WHERE lar.ap_id = arp.ap_id AND 
									lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
									AP_ENDDATE between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
									:Ls_ARR_IND='Y'
						group by 'C', lar.labour_id
						union all
						select 'D',labour_id,0,sum(nvl(LABOUR_ATTN_INC,0))
							 from fb_labourweeklywages lw,fb_labourwagesweek lww 
						 where lw.lww_id =  lww.lww_id and lw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
								 lww.lww_startdate between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
								 :Ls_ATNINC_IND='Y' and nvl(LABOUR_ATTN_INC,0) > 0
						group by  'D',labour_id)
				group by :ls_LBP_ID,labour_id;
			else
				insert into fb_labbonus(LBP_ID,LABOUR_ID,LB_WORKDAYS,LB_GREARN,LB_BONUSAMO,LB_DED,LB_EARN_AMT,LB_LWW_AMT,LB_ARR_AMT,LB_ATNINC_AMT)
				select :ls_LBP_ID,labour_id, sum(nvl(workdays,0)) workdays,sum(nvl(lda_wages,0)) grearn,
						round(sum(nvl(lda_wages,0))* decode(sign(sum(nvl(workdays,0))-nvl(:Ld_MINWDAYS,0)),-1,0, (0.01*nvl(:ld_BONUSPER,0))) ,2) bonusamo,0,
						sum(decode(recty,'A',nvl(lda_wages,0),0)) earn, sum(decode(recty,'B',nvl(lda_wages,0),0)) lww,
						sum(decode(recty,'C',nvl(lda_wages,0),0)) arr, sum(decode(recty,'D',nvl(lda_wages,0),0)) attninc
				from (SELECT  'A' recty,labour_id, 
									sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',lda.lda_status,'HOLIDAYPAY',lda.lda_status,'MATERNITY',lda.lda_status,'SICKALLOWANCE',lda.lda_status,0)) workdays,
									sum(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) lda_wages
							 from fb_labourdailyattendance lda,fb_employee l,(select distinct KAMSUB_ID, KAMSUB_NKAMTYPE from fb_kamsubhead) kam 
						 where l.emp_id=lda.labour_id and kam.kamsub_id=lda.kamsub_id and l.ls_id=:ls_ID and 
								  lda_date between to_date(:ls_start_dt,'dd/mm/yyyy')  and to_date(:ls_end_dt, 'dd/mm/yyyy') and
								  not exists (select em_lsid from fb_exemptmaster 
												where lda.lda_date between EM_FROMDT and EM_TODT and EM_BONUSIND='Y' and EM_LSID = l.ls_id) and
								  (decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) > 0 
						group by  labour_id
						union all
						 SELECT  'B',llw.labour_id,  sum(decode(:gs_garden_snm,'ME',nvl(LWW_DAYS,0),0)) ,sum(llw.lww_earn)
						 FROM fb_lablwwseason lls, fb_lablwwperiod llp, fb_lablww llw
						 where lls.lls_id = llp.lls_id AND llp.llp_id = llw.llp_id  AND llw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
								  LLS_PDATE between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and
								 :Ls_LWW_IND='Y'
						group by 'B',llw.labour_id
						 UNION ALL 
						 SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) 
							FROM fb_labourarrear lar,fb_arrearperiod arp
						 WHERE lar.ap_id = arp.ap_id AND 
									lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
									AP_ENDDATE between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
									:Ls_ARR_IND='Y'
						group by 'C', lar.labour_id
						union all
						select 'D',labour_id,0,sum(nvl(LABOUR_ATTN_INC,0))
							 from fb_labourweeklywages lw,fb_labourwagesweek lww 
						 where lw.lww_id =  lww.lww_id and lw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
								 lww.lww_startdate between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
								 :Ls_ATNINC_IND='Y' and nvl(LABOUR_ATTN_INC,0) > 0
						group by  'D',labour_id)
				group by :ls_LBP_ID,labour_id;
			end if
		else
			insert into fb_labbonus(LBP_ID,LABOUR_ID,LB_WORKDAYS,LB_GREARN,LB_BONUSAMO,LB_DED,LB_EARN_AMT,LB_LWW_AMT,LB_ARR_AMT,LB_ATNINC_AMT)
	 		select :ls_LBP_ID,labour_id, sum(nvl(workdays,0)) workdays,sum(nvl(lda_wages,0)) grearn,
	 		 		round(sum(nvl(lda_wages,0))* decode(sign(sum(nvl(workdays,0))-nvl(:Ld_MINWDAYS,0)),-1,0, (0.01*nvl(:ld_BONUSPER,0))) ,2) bonusamo,0,
					sum(decode(recty,'A',nvl(lda_wages,0),0)) earn, sum(decode(recty,'B',nvl(lda_wages,0),0)) lww,
					sum(decode(recty,'C',nvl(lda_wages,0),0)) arr, sum(decode(recty,'D',nvl(lda_wages,0),0)) attninc
			from (SELECT  'A' recty,labour_id, 
							   sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',lda.lda_status,'HOLIDAYPAY',lda.lda_status,'MATERNITY',lda.lda_status,'SICKALLOWANCE',lda.lda_status,0)) workdays,
							   sum(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) lda_wages
					    from fb_labourdailyattendance lda,fb_employee l,(select distinct KAMSUB_ID, KAMSUB_NKAMTYPE from fb_kamsubhead) kam 
					 where l.emp_id=lda.labour_id and kam.kamsub_id=lda.kamsub_id and l.ls_id=:ls_ID and 
					 		  lda_date between to_date(:ls_start_dt,'dd/mm/yyyy')  and to_date(:ls_end_dt, 'dd/mm/yyyy') and
							  not exists (select em_lsid from fb_exemptmaster 
							  				where lda.lda_date between EM_FROMDT and EM_TODT and EM_BONUSIND='Y' and EM_LSID = l.ls_id) and
							  (decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) > 0 
					group by  labour_id
					union all
				    SELECT  'B',llw.labour_id,  sum(decode(:gs_garden_snm,'ME',nvl(LWW_DAYS,0),0)) ,sum(llw.lww_earn)
					 FROM fb_lablwwseason lls, fb_lablwwperiod llp, fb_lablww llw
					 where lls.lls_id = llp.lls_id AND llp.llp_id = llw.llp_id  AND llw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
					 		  LLS_PDATE between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and
							 :Ls_LWW_IND='Y'
					group by 'B',llw.labour_id
					 UNION ALL 
					 SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) 
				  	   FROM fb_labourarrear lar,fb_arrearperiod arp
					 WHERE lar.ap_id = arp.ap_id AND 
					 			lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
					 			AP_ENDDATE between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
								:Ls_ARR_IND='Y'
					group by 'C', lar.labour_id
					union all
					select 'D',labour_id,0,sum(nvl(LABOUR_ATTN_INC,0))
					    from fb_labourweeklywages lw,fb_labourwagesweek lww 
					 where lw.lww_id =  lww.lww_id and lw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
							 lww.lww_startdate between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
							 :Ls_ATNINC_IND='Y' and nvl(LABOUR_ATTN_INC,0) > 0
					group by  'D',labour_id)
			group by :ls_LBP_ID,labour_id;			
    		End If

			if sqlca.sqlcode = -1 then
				messagebox('Sql Err: During Insert Of Labour Bonus', sqlca.sqlerrtext)
				return 1
			end if

		setnull(ls_LBP_ID);setnull(ls_start_dt);setnull(ls_end_dt);setnull(ls_ID);setnull(ls_LTYPE);setnull(ls_OTYPE);setnull(Ls_LWW_IND);setnull(Ls_ARR_IND);setnull(Ls_ATNINC_IND)
		ld_BONUSPER=0;Ld_MINWDAYS=0;

 	fetch c1 into :ls_LBP_ID ,:ls_start_dt,:ls_end_dt,:ls_ID,:ld_BONUSPER,:Ld_MINWDAYS,:ls_LTYPE,:ls_OTYPE,:Ls_LWW_IND,:Ls_ARR_IND,:Ls_ATNINC_IND;
loop

close c1;

update fb_labbonusseason set LBS_CONFIRM = 1 where LBS_ID = :ls_bonusid;
if sqlca.sqlcode = -1 then
	messagebox('Sql Err: During Updating labbonusseason', sqlca.sqlerrtext)
	return 1
end if

commit using sqlca;
setpointer(arrow!)

MessageBox("Bonus Calculation",'Bonus during the period : '+ ls_frdt+' to '+ls_todt+' has been calculated successfully...!')
wf_fill_ddlb()

end event

type cb_2 from commandbutton within w_gtelaf025
boolean visible = false
integer x = 3744
integer y = 16
integer width = 411
integer height = 100
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Replicate Data"
end type

event clicked;if isnull(em_2.text) or long(em_2.text) = 0 or isnull(em_3.text) or long(em_3.text) = 0 or isnull(em_4.text) or long(em_4.text) = 0 or isnull(em_5.text) or long(em_5.text) = 0 or isnull(em_6.text) or long(em_6.text) = 0 then
	messagebox('Warning!','Please Enter Valid Data !!!')
	return 1
elseif long(em_2.text) > 100 then
	messagebox('Warning!','Bonus % Should Not Be > 100, Please Check !!!')
	return 1	
end if

if long(em_3.text) > 100 then
	messagebox('Warning!','Pooja % Should Not Be > 100, Please Check !!!')
	return 1	
end if

if long(em_3.text) + long(em_4.text) + long(em_5.text) <> long(em_2.text) then
	messagebox('Warning!','Bonus % Should Be Equal To (Pooja + Paus + Fagua) %, Please Check !!!')
	return 1	
end if

if long(em_4.text) > 100 then
	messagebox('Warning!','Paus % Should Not Be > 100, Please Check !!!')
	return 1	
end if

if long(em_5.text) > 100 then
	messagebox('Warning!','Fagua % Should Not Be > 100, Please Check !!!')
	return 1	
end if

ld_boper = double(em_2.text);ld_puper= double(em_3.text); 	ld_paper= double(em_4.text);
la_faper= double(em_5.text); ld_minday= double(em_6.text)

for ll_cnt = 1 to dw_1.rowcount() 
		dw_1.setitem(ll_cnt,'lbp_bonusper',ld_boper)
		dw_1.setitem(ll_cnt,'lbp_pujaper',ld_puper)
		dw_1.setitem(ll_cnt,'lbp_pausper',ld_paper)
		dw_1.setitem(ll_cnt,'lbp_faguaper',la_faper)
		dw_1.setitem(ll_cnt,'lbp_minwdays',ld_minday)		
next
dw_1.scrolltorow(1)

end event

type em_2 from editmask within w_gtelaf025
boolean visible = false
integer x = 2816
integer y = 24
integer width = 155
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0.0"
string minmax = "~~"
end type

event modified;if isnull(em_2.text) or long(em_2.text) = 0 then
	messagebox('Warning!','Please Enter Valid Data !!!')
	return 1
elseif long(em_2.text) > 100 then
	messagebox('Warning!','Bonus % Should Not Be > 100, Please Check !!!')
	return 1
	cb_2.enabled = false	
else
	
	if ll_user_level <> 1 then
		cb_2.enabled = false
	else
		cb_2.enabled = true
	end if
	
	
end if
end event

type em_3 from editmask within w_gtelaf025
boolean visible = false
integer x = 2990
integer y = 24
integer width = 155
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0.0"
end type

event modified;if isnull(em_3.text) or long(em_3.text) = 0 then
	messagebox('Warning!','Please Enter Valid Data !!!')
	return 1
end if
//if long(em_3.text) + long(em_4.text) + long(em_5.text) <> long(em_2.text) then
//	messagebox('Warning!','Bonus % Should Be Equal To (Pooja + Paus + Fagua) %, Please Check !!!')
//	return 1	
//end if
if long(em_3.text) > 100 then
	messagebox('Warning!','Pooja % Should Not Be > 100, Please Check !!!')
	return 1	
	cb_2.enabled = false
else
		if ll_user_level <> 1 then
		cb_2.enabled = false
	else
		cb_2.enabled = true
	end if
end if
end event

type em_4 from editmask within w_gtelaf025
boolean visible = false
integer x = 3163
integer y = 24
integer width = 155
integer height = 88
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0.0"
end type

event modified;//if isnull(em_4.text) or long(em_4.text) = 0 then
//	messagebox('Warning!','Please Enter Valid Data !!!')
//	return 1
//end if
//if long(em_3.text) + long(em_4.text) + long(em_5.text) <> long(em_2.text) then
//	messagebox('Warning!','Bonus % Should Be Equal To (Pooja + Paus + Fagua) %, Please Check !!!')
//	return 1	
//end if
if long(em_4.text) > 100 then
	messagebox('Warning!','Paus % Should Not Be > 100, Please Check !!!')
	return 1
	cb_2.enabled = false
else
	if ll_user_level <> 1 then
		cb_2.enabled = false
	else
		cb_2.enabled = true
	end if
end if
end event

type em_5 from editmask within w_gtelaf025
boolean visible = false
integer x = 3328
integer y = 24
integer width = 155
integer height = 88
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0.0"
end type

event modified;//if isnull(em_5.text) or long(em_5.text) = 0 then
//	messagebox('Warning!','Please Enter Valid Data !!!')
//	return 1
//end if
if long(em_3.text) + long(em_4.text) + long(em_5.text) <> long(em_2.text) then
	messagebox('Warning!','Bonus % Should Be Equal To (Pooja + Paus + Fagua) %, Please Check !!!')
	return 1
	cb_2.enabled = false
else
	cb_2.enabled = true	
end if
if long(em_5.text) > 100 then
	messagebox('Warning!','Fagua % Should Not Be > 100, Please Check !!!')
	return 1
	cb_2.enabled = false
else
	if ll_user_level <> 1 then
		cb_2.enabled = false
	else
		cb_2.enabled = true
	end if	
end if
end event

type em_6 from editmask within w_gtelaf025
boolean visible = false
integer x = 3493
integer y = 24
integer width = 155
integer height = 88
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0.0"
end type

event modified;//if isnull(em_6.text) or long(em_6.text) = 0 then
//	messagebox('Warning!','Please Enter Valid Data !!!')
//	return 1
////elseif long(em_6.text) > 100 then
////	messagebox('Warning!','Bonus % Should Not Be > 100, Please Check !!!')
////	return 1	
//else
//	cb_2.enabled = true
//end if
end event

type cb_1 from commandbutton within w_gtelaf025
integer x = 2510
integer y = 8
integer width = 265
integer height = 100
integer taborder = 110
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
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

//ls_frdt = left(ddlb_1.text,10)
//ls_todt = left(right(ddlb_1.text,21),10)
//ls_bonusid=left(right(ddlb_1.text,13),8)

setpointer(hourglass!)
ls_frdt=left(ddlb_1.text,10)
ls_todt=mid(ddlb_1.text,12,10)
ls_bonusid = mid(ddlb_1.text,24,8)

for ll_cnt = 1 to dw_1.rowcount( ) 
	if isnull(dw_1.getitemstring(ll_cnt,'lbp_id')) or len(dw_1.getitemstring(ll_cnt,'lbp_id')) = 0 then
		messagebox('Warning!','First Save The Record Then Click On Process Button !!!')
		return 1
	end if
next


select distinct LBS_CONFIRM into :ls_lwwpaidflag from fb_labbonusseason where LBS_ID = :ls_bonusid;

if sqlca.sqlcode =100 then
	messagebox('Bonus Week Select ','Either the there is no such week or the Bonus against this week has been paid, Please Check...!')
	return 1
elseif sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Bonus Week Select ',sqlca.sqlerrtext)
	return 1
end if;	
	
if ls_lwwpaidflag = '1' then
	if ll_user_level = 1 then	
		if messagebox('Bonus Week Select ','The Bonus against this week has been already calculated, Would You Like to Recalculate the Wages',question!,yesno!,1) = 1 then
			update fb_labbonusseason set LBS_CONFIRM='0' where LBS_ID = :ls_bonusid;
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error : During Labour Bonus Week (Update) ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return 1; 
			end if
			
			delete from fb_labbonus where LBP_ID in (select LBP_ID from fb_labbonusperiod where  LBS_ID = :ls_bonusid);
			
			if sqlca.sqlcode = -1 then
				messagebox('Sql Err: During Delete Of Labour Bonus', sqlca.sqlerrtext)
				return 1
			end if
		else
			return 1
		end if
	else
		messagebox('Bonus Week Select ','The Bonus against this week has been already Calculated, You can not Recalculate the Wages, Please Contact "Admin User"',information!)
		return 1
	end if
end if	

select distinct 'x' into :ls_temp from fb_labbonus where LBP_ID in (select LBP_ID from fb_labbonusperiod where  LBS_ID = :ls_bonusid); 
if sqlca.sqlcode = 0 then
	delete from fb_labbonus where LBP_ID in (select LBP_ID from fb_labbonusperiod where  LBS_ID = :ls_bonusid); 
elseif sqlca.sqlcode = -1 then
	messagebox('Sql Err: During Delete Of Labour Bonus', sqlca.sqlerrtext)
	return 1
end if



string ls_LBP_ID ,ls_start_dt,ls_end_dt,ls_ID,ls_LTYPE,ls_OTYPE,Ls_LWW_IND,Ls_ARR_IND,Ls_ATNINC_IND
double ld_BONUSPER,Ld_MINWDAYS

declare c1 cursor for
select LBP_ID ,to_char(LBP_STARTDATE,'dd/mm/yyyy'),to_char(LBP_ENDDATE,'dd/mm/yyyy'),
		a.LS_ID,LBP_BONUSPER,LBP_MINWDAYS,LS_LABOURTYPE,LS_OUTSIDERTYPE,LBP_LWW_IND,LBP_ARR_IND,LBP_ATNINC_IND
  from fb_labbonusperiod a,( select distinct LS_ID,LS_LABOURTYPE,LS_OUTSIDERTYPE from fb_LABOURSHEET where LS_ACTIVE_IND = 'Y') b
where LBS_ID = :ls_bonusid and a.LS_ID = b.ls_id;

open c1;
if sqlca.sqlcode = -1 then
	messagebox('SQL Error: During C1 Cursor',sqlca.sqlerrtext)
	return 1
end if
		setnull(ls_LBP_ID);setnull(ls_start_dt);setnull(ls_end_dt);setnull(ls_ID);setnull(ls_LTYPE);setnull(ls_OTYPE);setnull(Ls_LWW_IND);setnull(Ls_ARR_IND);setnull(Ls_ATNINC_IND)
		ld_BONUSPER=0;Ld_MINWDAYS=0;

 	fetch c1 into :ls_LBP_ID ,:ls_start_dt,:ls_end_dt,:ls_ID,:ld_BONUSPER,:Ld_MINWDAYS,:ls_LTYPE,:ls_OTYPE,:Ls_LWW_IND,:Ls_ARR_IND,:Ls_ATNINC_IND;
	do while sqlca.sqlcode <> 100
    
	if gs_garden_snm ='UB' then
			insert into fb_labbonus(LBP_ID,LABOUR_ID,LB_WORKDAYS,LB_GREARN,LB_BONUSAMO,LB_DED,LB_EARN_AMT,LB_LWW_AMT,LB_ARR_AMT,LB_ATNINC_AMT)
			select :ls_LBP_ID,labour_id, sum(nvl(workdays,0)) workdays,sum(nvl(lda_wages,0)) grearn,
                             round(sum(nvl(lda_wages,0))* 
                                            decode(:ls_LTYPE,'LP',
                                            decode(sign(sum(nvl(workdays,0)) - 30),-1,0,decode(sign(sum(nvl(workdays,0)) - 81),-1,(0.01 * 8.33),
                                            decode(sign(sum(nvl(workdays,0)) - 131),-1,(0.01 * 10),
                                            decode(sign(sum(nvl(workdays,0)) - 181),-1,(0.01 * 14),
                                            decode(sign(sum(nvl(workdays,0)) - 231),-1,(0.01 * 16),(0.01 * 20)))))),
                                            decode(sign(sum(nvl(workdays,0)) - 30),-1,0,decode(sign(sum(nvl(workdays,0)) - 61),-1,(0.01 * 8.33),
                                            decode(sign(sum(nvl(workdays,0)) - 121),-1,(0.01 * 10),
                                            decode(sign(sum(nvl(workdays,0)) - 161),-1,(0.01 * 14),
                                            decode(sign(sum(nvl(workdays,0)) - 211),-1,(0.01 * 16),(0.01 * 20))))))
                                            ) ,2) bonusamo,0,
                          sum(decode(recty,'A',nvl(lda_wages,0),0)) earn, sum(decode(recty,'B',nvl(lda_wages,0),0)) lww,
                          sum(decode(recty,'C',nvl(lda_wages,0),0)) arr, sum(decode(recty,'D',nvl(lda_wages,0),0)) attninc
                from (SELECT  'A' recty,labour_id, 
                                         sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',lda.lda_status,'HOLIDAYPAY',lda.lda_status,'MATERNITY',lda.lda_status,'SICKALLOWANCE',lda.lda_status,0)) workdays,
                                         sum(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) lda_wages
                                from fb_labourdailyattendance lda,fb_employee l,(select distinct KAMSUB_ID, KAMSUB_NKAMTYPE,KAMSUB_FRDT, nvl(KAMSUB_TODT,SYSDATE) KAMSUB_TODT  from fb_kamsubhead) kam 
                            where l.emp_id=lda.labour_id and kam.kamsub_id=lda.kamsub_id and l.ls_id=:ls_ID and 
									 lda_date between KAMSUB_FRDT and KAMSUB_TODT and
                                         lda_date between to_date(:ls_start_dt,'dd/mm/yyyy')  and to_date(:ls_end_dt, 'dd/mm/yyyy') and
                                        not exists (select em_lsid from fb_exemptmaster 
                                                             where lda.lda_date between EM_FROMDT and EM_TODT and EM_BONUSIND='Y' and EM_LSID = l.ls_id) and
                                        (decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) > 0 
                          group by  labour_id
                          union all
                          SELECT  'B',llw.labour_id,  sum(decode(:gs_garden_snm,'ME',nvl(LWW_DAYS,0),0)) ,sum(llw.lww_earn)
                            FROM fb_lablwwseason lls, fb_lablwwperiod llp, fb_lablww llw
                            where lls.lls_id = llp.lls_id AND llp.llp_id = llw.llp_id  AND llw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
                                         LLS_PDATE between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and
                                      :Ls_LWW_IND='Y'
                          group by 'B',llw.labour_id
                            UNION ALL 
						SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) *(AP_PAYPER_1/100)
						FROM fb_labourarrear lar,fb_arrearperiod arp
						WHERE lar.ap_id = arp.ap_id AND 
								lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
								AP_PAYDT_1 between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
								:Ls_ARR_IND='Y'
						group by 'C', lar.labour_id,AP_PAYPER_1
						union all
						SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) *(AP_PAYPER_2/100)
						FROM fb_labourarrear lar,fb_arrearperiod arp
						WHERE lar.ap_id = arp.ap_id AND 
								lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
								AP_PAYDT_2 between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
								:Ls_ARR_IND='Y'
						group by 'C', lar.labour_id,AP_PAYPER_2
						union all
						SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) *(AP_PAYPER_3/100)
						FROM fb_labourarrear lar,fb_arrearperiod arp
						WHERE lar.ap_id = arp.ap_id AND 
								lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
								AP_PAYDT_3 between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
								:Ls_ARR_IND='Y'
						group by 'C', lar.labour_id,AP_PAYPER_3
                          union all
                          select 'D',labour_id,0,sum(nvl(LABOUR_ATTN_INC,0))
                                from fb_labourweeklywages lw,fb_labourwagesweek lww 
							where lw.lww_id =  lww.lww_id and lw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
									  lww.lww_startdate between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
									  :Ls_ATNINC_IND='Y' and nvl(LABOUR_ATTN_INC,0) > 0
						  group by  'D',labour_id)
				group by :ls_LBP_ID,labour_id;	
	elseif gs_garden_snm ='JP' then
			insert into fb_labbonus(LBP_ID,LABOUR_ID,LB_WORKDAYS,LB_GREARN,LB_BONUSAMO,LB_DED,LB_EARN_AMT,LB_LWW_AMT,LB_ARR_AMT,LB_ATNINC_AMT)
			select :ls_LBP_ID,labour_id, sum(nvl(workdays,0)) workdays,sum(nvl(lda_wages,0)) grearn,
						round(sum(nvl(lda_wages,0))* 
											decode(sign(sum(nvl(workdays,0)) - 30),-1,0,decode(sign(sum(nvl(workdays,0)) - 116),-1,(0.01 * 10),
											decode(sign(sum(nvl(workdays,0)) - 151),-1,(0.01 * 15),
											decode(sign(sum(nvl(workdays,0)) - 215),-1,(0.01 * 17),(0.01 * 20))))),2) bonusamo,0,
					sum(decode(recty,'A',nvl(lda_wages,0),0)) earn, sum(decode(recty,'B',nvl(lda_wages,0),0)) lww,
					sum(decode(recty,'C',nvl(lda_wages,0),0)) arr, sum(decode(recty,'D',nvl(lda_wages,0),0)) attninc
			from (SELECT  'A' recty,labour_id, 
										sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',lda.lda_status,'HOLIDAYPAY',lda.lda_status,'MATERNITY',lda.lda_status,'SICKALLOWANCE',lda.lda_status,0)) workdays,
										sum(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) lda_wages
							from fb_labourdailyattendance lda,fb_employee l,(select distinct KAMSUB_ID, KAMSUB_NKAMTYPE,KAMSUB_FRDT, nvl(KAMSUB_TODT,SYSDATE) KAMSUB_TODT from fb_kamsubhead) kam 
					  where l.emp_id=lda.labour_id and kam.kamsub_id=lda.kamsub_id and l.ls_id=:ls_ID and 
					  					lda_date between KAMSUB_FRDT and KAMSUB_TODT and
										lda_date between to_date(:ls_start_dt,'dd/mm/yyyy')  and to_date(:ls_end_dt, 'dd/mm/yyyy') and
									  not exists (select em_lsid from fb_exemptmaster 
																  where lda.lda_date between EM_FROMDT and EM_TODT and EM_BONUSIND='Y' and EM_LSID = l.ls_id) and
									  (decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) > 0 
					group by  labour_id
					union all
					SELECT  'B',llw.labour_id,  sum(decode(:gs_garden_snm,'ME',nvl(LWW_DAYS,0),0)) ,sum(llw.lww_earn)
					  FROM fb_lablwwseason lls, fb_lablwwperiod llp, fb_lablww llw
					  where lls.lls_id = llp.lls_id AND llp.llp_id = llw.llp_id  AND llw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
										LLS_PDATE between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and
									:Ls_LWW_IND='Y'
					group by 'B',llw.labour_id
					  UNION ALL 
					SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) *(AP_PAYPER_1/100)
					FROM fb_labourarrear lar,fb_arrearperiod arp
					WHERE lar.ap_id = arp.ap_id AND 
							lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
							AP_PAYDT_1 between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
							:Ls_ARR_IND='Y'
					group by 'C', lar.labour_id,AP_PAYPER_1
					union all
					SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) *(AP_PAYPER_2/100)
					FROM fb_labourarrear lar,fb_arrearperiod arp
					WHERE lar.ap_id = arp.ap_id AND 
							lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
							AP_PAYDT_2 between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
							:Ls_ARR_IND='Y'
					group by 'C', lar.labour_id,AP_PAYPER_2
					union all
					SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) *(AP_PAYPER_3/100)
					FROM fb_labourarrear lar,fb_arrearperiod arp
					WHERE lar.ap_id = arp.ap_id AND 
							lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
							AP_PAYDT_3 between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
							:Ls_ARR_IND='Y'
					group by 'C', lar.labour_id,AP_PAYPER_3
					union all
					select 'D',labour_id,0,sum(nvl(LABOUR_ATTN_INC,0))
							from fb_labourweeklywages lw,fb_labourwagesweek lww 
					  where lw.lww_id =  lww.lww_id and lw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
									lww.lww_startdate between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
									:Ls_ATNINC_IND='Y' and nvl(LABOUR_ATTN_INC,0) > 0
					group by  'D',labour_id)
			group by :ls_LBP_ID,labour_id;					
		elseif (gs_garden_snm = 'MV' or gs_garden_snm = 'PC') then
				insert into fb_labbonus(LBP_ID,LABOUR_ID,LB_WORKDAYS,LB_GREARN,LB_BONUSAMO,LB_DED,LB_EARN_AMT,LB_LWW_AMT,LB_ARR_AMT,LB_ATNINC_AMT)
				select :ls_LBP_ID,labour_id, sum(nvl(workdays,0)) workdays,sum(nvl(lda_wages,0)) grearn,
							round(sum(nvl(lda_wages,0))* 
												decode(sign(sum(nvl(workdays,0)) - 30),-1,0,decode(sign(sum(nvl(workdays,0)) - 126),-1,(0.01 * 10),
												decode(sign(sum(nvl(workdays,0)) - 151),-1,(0.01 * 15),
												decode(sign(sum(nvl(workdays,0)) - 206),-1,(0.01 * 17),(0.01 * 20))))),2) bonusamo,0,
						sum(decode(recty,'A',nvl(lda_wages,0),0)) earn, sum(decode(recty,'B',nvl(lda_wages,0),0)) lww,
						sum(decode(recty,'C',nvl(lda_wages,0),0)) arr, sum(decode(recty,'D',nvl(lda_wages,0),0)) attninc
				from (SELECT  'A' recty,labour_id, 
											sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',lda.lda_status,'HOLIDAYPAY',lda.lda_status,'MATERNITY',lda.lda_status,'SICKALLOWANCE',lda.lda_status,0)) workdays,
											sum(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) lda_wages
								from fb_labourdailyattendance lda,fb_employee l,(select distinct KAMSUB_ID, KAMSUB_NKAMTYPE,KAMSUB_FRDT, nvl(KAMSUB_TODT,SYSDATE) KAMSUB_TODT from fb_kamsubhead) kam 
						  where l.emp_id=lda.labour_id and kam.kamsub_id=lda.kamsub_id and l.ls_id=:ls_ID and 
						  					lda_date between KAMSUB_FRDT and KAMSUB_TODT and
											lda_date between to_date(:ls_start_dt,'dd/mm/yyyy')  and to_date(:ls_end_dt, 'dd/mm/yyyy') and
										  not exists (select em_lsid from fb_exemptmaster 
																	  where lda.lda_date between EM_FROMDT and EM_TODT and EM_BONUSIND='Y' and EM_LSID = l.ls_id) and
										  (decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) > 0 
						group by  labour_id
						union all
						SELECT  'B',llw.labour_id,  sum(decode(:gs_garden_snm,'ME',nvl(LWW_DAYS,0),0)) ,sum(llw.lww_earn)
						  FROM fb_lablwwseason lls, fb_lablwwperiod llp, fb_lablww llw
						  where lls.lls_id = llp.lls_id AND llp.llp_id = llw.llp_id  AND llw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
											LLS_PDATE between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and
										:Ls_LWW_IND='Y'
						group by 'B',llw.labour_id
						  UNION ALL 
						SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) *(AP_PAYPER_1/100)
						FROM fb_labourarrear lar,fb_arrearperiod arp
						WHERE lar.ap_id = arp.ap_id AND 
								lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
								AP_PAYDT_1 between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
								:Ls_ARR_IND='Y'
						group by 'C', lar.labour_id,AP_PAYPER_1
						union all
						SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) *(AP_PAYPER_2/100)
						FROM fb_labourarrear lar,fb_arrearperiod arp
						WHERE lar.ap_id = arp.ap_id AND 
								lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
								AP_PAYDT_2 between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
								:Ls_ARR_IND='Y'
						group by 'C', lar.labour_id,AP_PAYPER_2
						union all
						SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) *(AP_PAYPER_3/100)
						FROM fb_labourarrear lar,fb_arrearperiod arp
						WHERE lar.ap_id = arp.ap_id AND
								lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
								AP_PAYDT_3 between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
								:Ls_ARR_IND='Y'
						group by 'C', lar.labour_id,AP_PAYPER_3
						union all
						select 'D',labour_id,0,sum(nvl(LABOUR_ATTN_INC,0))
								from fb_labourweeklywages lw,fb_labourwagesweek lww 
						  where lw.lww_id =  lww.lww_id and lw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
										lww.lww_startdate between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
										:Ls_ATNINC_IND='Y' and nvl(LABOUR_ATTN_INC,0) > 0
						group by  'D',labour_id)
				group by :ls_LBP_ID,labour_id;	
		
//	elseif  (gs_garden_snm = 'AD' ) then
//		 insert into fb_labbonus(LBP_ID,LABOUR_ID,LB_WORKDAYS,LB_GREARN,LB_BONUSAMO,LB_DED,LB_EARN_AMT,LB_LWW_AMT,LB_ARR_AMT,LB_ATNINC_AMT)
//	 		select :ls_LBP_ID,labour_id, sum(nvl(workdays,0)) workdays,sum(nvl(lda_wages,0)) grearn,
//	 		 		round(sum(nvl(lda_wages,0))* decode(sign(sum(nvl(workdays,0))-nvl(:Ld_MINWDAYS,0)),-1,0, (0.01*nvl(:ld_BONUSPER,0))) ,2) bonusamo,0,
//					sum(decode(recty,'A',nvl(lda_wages,0),0)) earn, sum(decode(recty,'B',nvl(lda_wages,0),0)) lww,
//					sum(decode(recty,'C',nvl(lda_wages,0),0)) arr, sum(decode(recty,'D',nvl(lda_wages,0),0)) attninc
//			from (SELECT  'A' recty,labour_id, 
//							   sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',lda.lda_status,'HOLIDAYPAY',lda.lda_status,'MATERNITY',lda.lda_status,'SICKALLOWANCE',lda.lda_status,0)) workdays,
//							   sum(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) lda_wages
//					    from fb_labourdailyattendance lda,fb_employee l,(select distinct KAMSUB_ID, KAMSUB_NKAMTYPE,KAMSUB_FRDT, nvl(KAMSUB_TODT,SYSDATE) KAMSUB_TODT from fb_kamsubhead where nvl(kamsub_active_ind,'N') = 'Y') kam 
//					 where l.emp_id=lda.labour_id and kam.kamsub_id=lda.kamsub_id and l.ls_id=:ls_ID and 
//					 		  //lda_date between KAMSUB_FRDT and KAMSUB_TODT and
//					 		  lda_date between to_date(:ls_start_dt,'dd/mm/yyyy')  and to_date(:ls_end_dt, 'dd/mm/yyyy') and
//							  not exists (select em_lsid from fb_exemptmaster 
//							  				where lda.lda_date between EM_FROMDT and EM_TODT and EM_BONUSIND='Y' and EM_LSID = l.ls_id) and
//							  (decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) > 0 
//					group by  labour_id
//					union all
//				    SELECT  'B',llw.labour_id,  sum(decode(:gs_garden_snm,'ME',nvl(LWW_DAYS,0),0)) ,sum(llw.lww_earn)
//					 FROM fb_lablwwseason lls, fb_lablwwperiod llp, fb_lablww llw
//					 where lls.lls_id = llp.lls_id AND llp.llp_id = llw.llp_id  AND llw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
//					 		  LLS_PDATE between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and
//							 :Ls_LWW_IND='Y'
//					group by 'B',llw.labour_id
//					 UNION ALL 
//                        SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) *(AP_PAYPER_1/100)
//					FROM fb_labourarrear lar,fb_arrearperiod arp
//					WHERE lar.ap_id = arp.ap_id AND 
//							lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
//							AP_PAYDT_1 between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
//							:Ls_ARR_IND='Y'
//					group by 'C', lar.labour_id,AP_PAYPER_1
//					union all
//					SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) *(AP_PAYPER_2/100)
//					FROM fb_labourarrear lar,fb_arrearperiod arp
//					WHERE lar.ap_id = arp.ap_id AND 
//							lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
//							AP_PAYDT_2 between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
//							:Ls_ARR_IND='Y'
//					group by 'C', lar.labour_id,AP_PAYPER_2
//					union all
//					SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) *(AP_PAYPER_3/100)
//					FROM fb_labourarrear lar,fb_arrearperiod arp
//					WHERE lar.ap_id = arp.ap_id AND
//							lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
//							AP_PAYDT_3 between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
//							:Ls_ARR_IND='Y'
//					group by 'C', lar.labour_id,AP_PAYPER_3
//					union all
//					select 'D',labour_id,0,sum(nvl(LABOUR_ATTN_INC,0))
//					    from fb_labourweeklywages lw,fb_labourwagesweek lww 
//					 where lw.lww_id =  lww.lww_id and lw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
//							 lww.lww_startdate between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
//							 :Ls_ATNINC_IND='Y' and nvl(LABOUR_ATTN_INC,0) > 0
//					group by  'D',labour_id)
//			group by :ls_LBP_ID,labour_id;		
		else //others
			insert into fb_labbonus(LBP_ID,LABOUR_ID,LB_WORKDAYS,LB_GREARN,LB_BONUSAMO,LB_DED,LB_EARN_AMT,LB_LWW_AMT,LB_ARR_AMT,LB_ATNINC_AMT)
	 		select :ls_LBP_ID,labour_id, sum(nvl(workdays,0)) workdays,sum(nvl(lda_wages,0)) grearn,
	 		 		round(sum(nvl(lda_wages,0))* decode(sign(sum(nvl(workdays,0))-nvl(:Ld_MINWDAYS,0)),-1,0, (0.01*nvl(:ld_BONUSPER,0))) ,2) bonusamo,0,
					sum(decode(recty,'A',nvl(lda_wages,0),0)) earn, sum(decode(recty,'B',nvl(lda_wages,0),0)) lww,
					sum(decode(recty,'C',nvl(lda_wages,0),0)) arr, sum(decode(recty,'D',nvl(lda_wages,0),0)) attninc
			from (SELECT  'A' recty,labour_id, 
							   sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',lda.lda_status,'HOLIDAYPAY',lda.lda_status,'MATERNITY',lda.lda_status,'SICKALLOWANCE',lda.lda_status,0)) workdays,
							   sum(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) lda_wages
					    from fb_labourdailyattendance lda,fb_employee l,(select distinct KAMSUB_ID, KAMSUB_NKAMTYPE,KAMSUB_FRDT, nvl(KAMSUB_TODT,SYSDATE) KAMSUB_TODT from fb_kamsubhead where nvl(kamsub_active_ind,'N') = 'Y') kam 
					 where l.emp_id=lda.labour_id and kam.kamsub_id=lda.kamsub_id and l.ls_id=:ls_ID and 
					 		  //lda_date between KAMSUB_FRDT and KAMSUB_TODT and
					 		  lda_date between to_date(:ls_start_dt,'dd/mm/yyyy')  and to_date(:ls_end_dt, 'dd/mm/yyyy') and
							  not exists (select em_lsid from fb_exemptmaster 
							  				where lda.lda_date between EM_FROMDT and EM_TODT and EM_BONUSIND='Y' and EM_LSID = l.ls_id) and
							  (decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) > 0 
					group by  labour_id
					union all
				    SELECT  'B',llw.labour_id,  sum(decode(:gs_garden_snm,'ME',nvl(LWW_DAYS,0),0)) ,sum(llw.lww_earn)
					 FROM fb_lablwwseason lls, fb_lablwwperiod llp, fb_lablww llw
					 where lls.lls_id = llp.lls_id AND llp.llp_id = llw.llp_id  AND llw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
					 		  LLS_PDATE between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and
							 :Ls_LWW_IND='Y'
					group by 'B',llw.labour_id
					 UNION ALL 
                        SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) *(AP_PAYPER_1/100)
					FROM fb_labourarrear lar,fb_arrearperiod arp
					WHERE lar.ap_id = arp.ap_id AND 
							lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
							AP_PAYDT_1 between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
							:Ls_ARR_IND='Y'
					group by 'C', lar.labour_id,AP_PAYPER_1
					union all
					SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) *(AP_PAYPER_2/100)
					FROM fb_labourarrear lar,fb_arrearperiod arp
					WHERE lar.ap_id = arp.ap_id AND 
							lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
							AP_PAYDT_2 between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
							:Ls_ARR_IND='Y'
					group by 'C', lar.labour_id,AP_PAYPER_2
					union all
					SELECT 'C', lar.labour_id, 0,sum(lar.la_amount) *(AP_PAYPER_3/100)
					FROM fb_labourarrear lar,fb_arrearperiod arp
					WHERE lar.ap_id = arp.ap_id AND
							lar.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
							AP_PAYDT_3 between  to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
							:Ls_ARR_IND='Y'
					group by 'C', lar.labour_id,AP_PAYPER_3
					union all
					select 'D',labour_id,0,sum(nvl(LABOUR_ATTN_INC,0))
					    from fb_labourweeklywages lw,fb_labourwagesweek lww 
					 where lw.lww_id =  lww.lww_id and lw.labour_id in (select emp_id from fb_employee where ls_id=:ls_ID) and
							 lww.lww_startdate between to_date(:ls_start_dt,'dd/mm/yyyy') and to_date(:ls_end_dt, 'dd/mm/yyyy') and 
							 :Ls_ATNINC_IND='Y' and nvl(LABOUR_ATTN_INC,0) > 0
					group by  'D',labour_id)
			group by :ls_LBP_ID,labour_id;			
    		End If

			if sqlca.sqlcode = -1 then
				messagebox('Sql Err: During Insert Of Labour Bonus', sqlca.sqlerrtext)
				return 1
			end if

		setnull(ls_LBP_ID);setnull(ls_start_dt);setnull(ls_end_dt);setnull(ls_ID);setnull(ls_LTYPE);setnull(ls_OTYPE);setnull(Ls_LWW_IND);setnull(Ls_ARR_IND);setnull(Ls_ATNINC_IND)
		ld_BONUSPER=0;Ld_MINWDAYS=0;

 	fetch c1 into :ls_LBP_ID ,:ls_start_dt,:ls_end_dt,:ls_ID,:ld_BONUSPER,:Ld_MINWDAYS,:ls_LTYPE,:ls_OTYPE,:Ls_LWW_IND,:Ls_ARR_IND,:Ls_ATNINC_IND;
loop

close c1;

if ls_lwwpaidflag = '0' then
	if messagebox('Bonus Processing ','Is this final processing?',question!,yesno!,1) = 1 then
		update fb_labbonusseason set LBS_CONFIRM = 1 where LBS_ID = :ls_bonusid;
		if sqlca.sqlcode = -1 then
			messagebox('Sql Err: During Updating labbonusseason', sqlca.sqlerrtext)
			return 1
		end if
	end if
else
	update fb_labbonusseason set LBS_CONFIRM = 1 where LBS_ID = :ls_bonusid;
	if sqlca.sqlcode = -1 then
		messagebox('Sql Err: During Updating labbonusseason', sqlca.sqlerrtext)
		return 1
	end if
end if 

commit using sqlca;
setpointer(arrow!)

MessageBox("Bonus Calculation",'Bonus during the period : '+ ls_frdt+' to '+ls_todt+' has been calculated successfully...!')
wf_fill_ddlb()

end event

type st_1 from statictext within w_gtelaf025
integer x = 18
integer y = 32
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
string text = "Bonus Period Id"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gtelaf025
integer x = 411
integer y = 16
integer width = 1266
integer height = 444
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

type cb_5 from commandbutton within w_gtelaf025
integer x = 1691
integer y = 8
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

if  len(trim(ddlb_1.text)) = 0 or isnull(ddlb_1.text) then
	messagebox ('Error:','Please Select the Bonus Id.')
	return 1
end if;

dw_1.reset()
string ls_ind

ls_frdt=left(ddlb_1.text,10)
ls_todt=mid(ddlb_1.text,12,10)
ls_bonusid = mid(ddlb_1.text,24,8)
ls_emp_type = left(right(ddlb_1.text,3),2)
ls_ind = left(right(ddlb_1.text,6),1)

cb_1.enabled = false

dw_1.settransobject(sqlca);
dw_1.retrieve(ls_bonusid,long(ls_ind)) 

//if ls_ind = '0' and ll_user_level = 1 then
	cb_1.enabled = true
//else
//	cb_1.enabled = false
//end if

if dw_1.rowcount() = 0 then
	
	DECLARE c1 CURSOR FOR  
	select distinct LS_ID from fb_laboursheet where nvl(LS_ACTIVE_IND,'N')='Y' and LS_LABOURTYPE = :ls_emp_type order by 1;		

	open c1;
	
	IF sqlca.sqlcode = 0 THEN
		fetch c1 into :ll_id;
		
		do while sqlca.sqlcode <> 100
			dw_1.scrolltorow(dw_1.insertrow(0))
			dw_1.setitem(dw_1.getrow(),'lbs_id',ls_bonusid)
			dw_1.setitem(dw_1.getrow(),'lbp_startdate',datetime(ls_frdt))
			dw_1.setitem(dw_1.getrow(),'lbp_enddate',datetime(ls_todt))
			dw_1.setitem(dw_1.getrow(),'ls_id',ll_id)
			dw_1.setitem(dw_1.getrow(),'lbp_pausper',11.67)
			dw_1.setitem(dw_1.getrow(),'lbp_entry_by',gs_user)
			dw_1.setitem(dw_1.getrow(),'lbp_entry_dt',datetime(today()))
			dw_1.setitem(dw_1.getrow(),'lbp_paidflag','0')
			dw_1.setitem(dw_1.getrow(),'lbp_lww_ind','Y')
			dw_1.setitem(dw_1.getrow(),'lbp_arr_ind','Y')
			dw_1.setitem(dw_1.getrow(),'lbp_atninc_ind','N')
			fetch c1 into :ll_id;
		loop
	END IF
	close c1;
	dw_1.setfocus()
	dw_1.scrolltorow(1)
	dw_1.setcolumn('lbp_bonusper')
	lb_neworder = true
	lb_query = false
//else
//	dw_1.settransobject(sqlca);
//	dw_1.retrieve(ls_bonusid);
end if

end event

type cb_4 from commandbutton within w_gtelaf025
integer x = 2245
integer y = 8
integer width = 265
integer height = 100
integer taborder = 100
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

type cb_3 from commandbutton within w_gtelaf025
integer x = 1979
integer y = 8
integer width = 265
integer height = 100
integer taborder = 90
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

IF (isnull(dw_1.getitemdatetime(dw_1.rowcount(),'lbp_startdate')) ) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	if dw_1.getitemnumber(dw_1.getrow(),'lbp_bonusper') <> dw_1.getitemnumber(dw_1.getrow(),'lbp_pujaper') + dw_1.getitemnumber(dw_1.getrow(),'lbp_faguaper')  then
		messagebox('Warning','Total bonus % should be equal to Split 1 % + Split 2 %')
		return 1;
	end if
	
	if lb_neworder = true then
		select nvl(MAX(LBP_ID),0) into :ls_last from fb_labbonusperiod;
		ls_last = right(ls_last,5)
		ll_cnt = long(ls_last)
	end if

	if dw_1.rowcount() > 0 then
		for ll_ctr = 1 to dw_1.rowcount( ) 
			
			if lb_neworder = true then
				ll_cnt = ll_cnt + 1
				select lpad(:ll_cnt,5,'0') into :ls_count from dual;
				ls_tmp_id = 'LBP'+ls_count
				dw_1.setitem(ll_ctr,'lbp_id',ls_tmp_id)
			end if

		next	
	end if

	if dw_1.update(true,false) = 1 then
		dw_1.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
//		dw_1.reset()
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
else
	return
end if 
end event

type dw_1 from datawindow within w_gtelaf025
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 120
integer width = 4832
integer height = 2052
string dataobject = "dw_gtelaf025"
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
	if currentrow >= 1 and dw_1.rowcount() >= 1 then
			if dw_1.getitemnumber(currentrow,'lbp_bonusper') <> dw_1.getitemnumber(currentrow,'lbp_pujaper') + dw_1.getitemnumber(currentrow,'lbp_faguaper')  then
				messagebox('Warning','Total bonus % should be equal to Split 1 % + Split 2 %')
				return 1;
			end if
	end if
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'lbp_entry_by',gs_user)
		dw_1.setitem(newrow,'lbp_entry_dt',datetime(today()))
		dw_1.setcolumn('lbp_bonusper')
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
	if dwo.name = 'lbp_pujaper' then
		if dw_1.getitemnumber(row,'lbp_bonusper') = 0 or isnull(dw_1.getitemnumber(row,'lbp_bonusper')) then
			messagebox('Warning!','Kindly enter total bonus % first !!!')
			return 1
		end if
	end if
	
	if dwo.name = 'lbp_faguaper' then
		if dw_1.getitemnumber(row,'lbp_bonusper') = 0  or isnull(dw_1.getitemnumber(row,'lbp_bonusper')) then
			messagebox('Warning!','Kindly enter total bonus % first !!!')
			return 1
		end if
		
		if dw_1.getitemnumber(row,'lbp_pujaper') = 0  or isnull(dw_1.getitemnumber(row,'lbp_pujaper')) then
			messagebox('Warning!','Kindly enter total Split 1 % first !!!')
			return 1
		end if
		
		if double(data) + dw_1.getitemnumber(row,'lbp_pujaper') <> dw_1.getitemnumber(row,'lbp_bonusper') then
			messagebox('Warning!','Bonus % Should Be Equal To (Split 1 and Split 2) %, Please Check !!!')
			return 1
		end if
	end if
	
	if dwo.name = 'lbp_bonusper' then
		dw_1.setitem(row,'lbp_pujaper',0)
		dw_1.setitem(row,'lbp_faguaper',0)
	end if
//	if dwo.name = 'lbp_pausper' then
//		if double(data) + dw_1.getitemnumber(row,'lbp_pujaper') + dw_1.getitemnumber(row,'lbp_faguaper') <> dw_1.getitemnumber(row,'lbp_bonusper') then
//			messagebox('Warning!','Bonus % Should Be Equal To (Pooja + Paus + Fagua) %, Please Check !!!')
//			return 1
//		end if		
//	end if
//	if dwo.name = 'lbp_faguaper' then
//		if double(data) + dw_1.getitemnumber(row,'lbp_pausper') + dw_1.getitemnumber(row,'lbp_pujaper') <> dw_1.getitemnumber(row,'lbp_bonusper') then
//			messagebox('Warning!','Bonus % Should Be Equal To (Pooja + Paus + Fagua) %, Please Check !!!')
//			return 1
//		end if		
//	end if	
	dw_1.setitem(row,'lbp_entry_by',gs_user)
	dw_1.setitem(row,'lbp_entry_dt',datetime(today()))
	
	if ll_user_level <> 1 then
		cb_3.enabled= false
		cb_1.enabled= false
	else
		cb_3.enabled = true
		cb_1.enabled= true
	end if
	
	
end if

//if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
//	dw_1.insertrow(0)
//end if


end event

