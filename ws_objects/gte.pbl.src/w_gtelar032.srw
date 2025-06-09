$PBExportHeader$w_gtelar032.srw
forward
global type w_gtelar032 from window
end type
type rb_2 from radiobutton within w_gtelar032
end type
type rb_1 from radiobutton within w_gtelar032
end type
type st_1 from statictext within w_gtelar032
end type
type ddlb_1 from dropdownlistbox within w_gtelar032
end type
type cb_3 from commandbutton within w_gtelar032
end type
type ddlb_2 from dropdownlistbox within w_gtelar032
end type
type st_2 from statictext within w_gtelar032
end type
type cb_1 from commandbutton within w_gtelar032
end type
type cb_2 from commandbutton within w_gtelar032
end type
type dw_1 from datawindow within w_gtelar032
end type
type gb_3 from groupbox within w_gtelar032
end type
type dw_2 from datawindow within w_gtelar032
end type
end forward

global type w_gtelar032 from window
integer width = 3511
integer height = 2784
boolean titlebar = true
string title = "(w_gtelar032) Extra Leaf Pice Register"
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
st_1 st_1
ddlb_1 ddlb_1
cb_3 cb_3
ddlb_2 ddlb_2
st_2 st_2
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
gb_3 gb_3
dw_2 dw_2
end type
global w_gtelar032 w_gtelar032

type variables
string  ls_yrmn,ls_dt,ls_lrw_id,ls_cal_flag,ls_fr_dt,ls_to_dt,ls_labour
n_cst_powerfilter iu_powerfilter
long ll_pbno,ll_user_level
double  id_elp_cf ,id_elp,id_penalty,id_elp_bf,id_netpayable,ld_workdaysration,ld_glt, ld_taskt
end variables

forward prototypes
public function integer wf_inquiry (long fl_year)
public function integer wf_elpcal (string fs_labour_id, string fs_fr_dt, string fs_to_dt, string fs_lrw_id)
end prototypes

event ue_option();if dw_1.visible = true then
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
		case "PDF"
				this.dw_1.saveas("C:\reports\Gtelar031.pdf",pdf!,true)
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
elseif dw_2.visible = true then
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
	case "PDF"
			this.dw_2.saveas("C:\reports\Gtelar031.pdf",pdf!,true)
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

public function integer wf_inquiry (long fl_year);dw_1.settransobject(sqlca)
dw_1.retrieve(gs_user,fl_year)
return 1
end function

public function integer wf_elpcal (string fs_labour_id, string fs_fr_dt, string fs_to_dt, string fs_lrw_id);long ll_labage,ll_roundoff
string ls_elpdet
double ld_gl, ld_task

setnull(id_elp_cf );setnull(id_elp);setnull(id_penalty);setnull(id_elp_bf)

select lwr_coinbf into :id_elp_bf from FB_LABELPDETAILS 
where (labour_id,lrw_id) in (select labour_id,max(lrw_id) from FB_LABELPDETAILS 
							         where labour_id=:fs_labour_id and lrw_id<:fs_lrw_id group by labour_id);
										
if sqlca.sqlcode = -1 then
	messagebox('Sql Error : During Labour ELP BF (Select of Labour '+fs_labour_id +'-' +fs_lrw_id+') ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
end if

if isnull(id_elp_bf) then id_elp_bf=0

 select sum(decode(sign(LDA_ELP),-1,0,nvl(LDA_ELP,0))),sum(decode(sign(LDA_ELP),-1,nvl(LDA_ELP,0),0)) into :id_elp ,:id_penalty
 from fb_labourdailyattendance lda
 where lda.labour_id = :fs_labour_id and lda.lda_date between to_date(:fs_fr_dt,'dd/mm/yyyy') and  to_date(:fs_to_dt,'dd/mm/yyyy') and
           nvl(LDA_ELP,0) != 0;

if sqlca.sqlcode = -1 then
	messagebox('Sql Error : During Labour ELP (Select) ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
end if

if isnull(id_elp) then id_elp=0


 select pd_value into :ll_roundoff from fb_param_detail  
 where PD_DOC_TYPE='ROUNDOFF' and to_date(:fs_fr_dt,'dd/mm/yyyy') between PD_PERIOD_from and nvl(PD_PERIOD_to,trunc(sysdate));
 
 if sqlca.sqlcode = -1 then
	messagebox('Sql Error : During Labour ELP (Select) ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
end if

if isnull(ll_roundoff) then ll_roundoff=0

id_elp_cf = Mod((id_elp + id_elp_bf),ll_roundoff) 
id_netpayable = (id_elp + id_elp_bf) - id_elp_cf

ld_glt = 0; ld_taskt = 0; 

declare c2 cursor for 
select ROUND(lda.LDA_TASK,0) TASK,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) glcount 
from fb_labourdailyattendance lda
where lda.labour_id = :fs_labour_id and lda.lda_date between to_date(:fs_fr_dt,'dd/mm/yyyy') and  to_date(:fs_to_dt,'dd/mm/yyyy') and
           nvl(LDA_ELP,0) > 0 order by lda.lda_date;

open c2; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor c2 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 

	ld_gl= 0; ld_task= 0; ls_elpdet=""

	fetch c2 into :ld_task,:ld_gl;
	do while sqlca.sqlcode <> 100 
		ls_elpdet = ls_elpdet + "   " +  string(ld_gl, "00") + "   " + string(ld_task, "00")
		ld_glt = ld_glt + ld_gl
		ld_taskt = ld_taskt + ld_task
		
		ld_gl= 0; ld_task= 0; 
		fetch c2 into :ld_task,:ld_gl;
	loop
	close c2;
	if ls_elpdet <> ""   then
	end if

	INSERT INTO FB_LABELPDETAILS (LRW_ID,LABOUR_ID,ELP_DETAILS,ELP_STATUS,LWR_ELP,LWR_COINBF,LWR_LASTCOINBF,LWR_NETELP,LWR_PENALTY,LRW_GL,LRW_TASKGL) 
	VALUES (:fs_lrw_id,:fs_labour_id,:ls_elpdet,'WEEKLY',:id_elp,:id_elp_cf,:id_elp_bf,:id_netpayable,:id_penalty,:ld_glt,:ld_taskt);
	
	if sqlca.sqlcode = -1 then
		messagebox('Sql Error : During Labour ELP Detail (Insert) ',sqlca.sqlerrtext); 
		rollback using sqlca; 
		return -1; 
	end if
	ld_glt = 0; ld_taskt = 0; 
end if;	

return 1
		
end function

on w_gtelar032.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.cb_3=create cb_3
this.ddlb_2=create ddlb_2
this.st_2=create st_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.gb_3=create gb_3
this.dw_2=create dw_2
this.Control[]={this.rb_2,&
this.rb_1,&
this.st_1,&
this.ddlb_1,&
this.cb_3,&
this.ddlb_2,&
this.st_2,&
this.cb_1,&
this.cb_2,&
this.dw_1,&
this.gb_3,&
this.dw_2}
end on

on w_gtelar032.destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.cb_3)
destroy(this.ddlb_2)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.gb_3)
destroy(this.dw_2)
end on

event open;dw_1.modify("t_co.text = '"+gs_CO_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_1.settransobject(sqlca)
dw_2.modify("t_co.text = '"+gs_CO_name+"'")
dw_2.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_2.settransobject(sqlca)


declare c3 cursor for
select to_char(elw_STARTDATE,'dd/mm/yyyy')||' - '|| to_char(elw_ENDDATE,'dd/mm/yyyy')||' ('||elw_ID||')'
from fb_elpperiod	 
order by  elw_STARTDATE desc;
//where nvl(elw_PAIDFLAG,'0')='0'

open c3;

if sqlca.sqlcode = -1 then 
	messagebox('Error At Cursor','Error During Opening Cursor c3');
	return 1;
else
	setnull(ls_dt);
	fetch c3 into :ls_dt;	
	do while sqlca.sqlcode <> 100 
	
		ddlb_1.additem(ls_dt);
	
		setnull(ls_dt);
		fetch c3 into :ls_dt;	
	loop
	close c3;
end if;

setpointer(hourglass!)

ddlb_2.reset()
ddlb_2.additem('00')

declare c4 cursor for
select distinct ls_id from FB_LABOURSHEET 
where ls_id is not null order by 1;

open c4;

IF sqlca.sqlcode = 0 THEN 
	fetch c4 into :ll_pbno;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(string(ll_pbno))
		fetch c4 into:ll_pbno;
	loop
	close c4;
end if

ddlb_2.text = '00'
setpointer(arrow!)

this.tag = Message.StringParm
ll_user_level = long(this.tag)

end event

type rb_2 from radiobutton within w_gtelar032
integer x = 526
integer y = 144
integer width = 389
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "ELP Detail"
end type

event clicked;dw_1.visible=false
dw_2.visible=true

end event

type rb_1 from radiobutton within w_gtelar032
integer x = 59
integer y = 144
integer width = 389
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "ELP Register"
boolean checked = true
end type

event clicked;dw_1.visible=true
dw_2.visible=false
end event

type st_1 from statictext within w_gtelar032
integer x = 14
integer y = 40
integer width = 274
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "ELP Period"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gtelar032
integer x = 288
integer y = 20
integer width = 1243
integer height = 480
integer taborder = 50
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

type cb_3 from commandbutton within w_gtelar032
integer x = 1541
integer y = 16
integer width = 393
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Process ELP"
boolean default = true
end type

event clicked;ls_dt = left(ddlb_1.text,10)
ls_lrw_id = left(right(ddlb_1.text,9),8)

if isnull(ls_dt) then 
	messagebox('Error At Date','Wages Start Date Should Be Entered, Please Check !!!')
	return 1
end if;

select elw_ID,elw_CALFLAG,to_char(elw_STARTDATE,'dd/mm/yyyy'),to_char(elw_ENDDATE,'dd/mm/yyyy')
    into :ls_lrw_id,:ls_cal_flag,:ls_fr_dt,:ls_to_dt
  from fb_elpperiod 
where elw_STARTDATE = to_date(:ls_dt,'dd/mm/yyyy') and elw_PAIDFLAG ='0' and elw_ID = :ls_lrw_id;

if sqlca.sqlcode =100 then
	messagebox('Wages Week Select ','Either the there is no such week or the elp against this week has been paid, Please Check...!')
	return 1
elseif sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Wages Week Select ',sqlca.sqlerrtext)
	return 1
end if;

if Ls_cal_flag='1' then
	if ll_user_level = 1 then
		if messagebox("Warning","The ration/ELP against this week has been calculated, Do you want to re-calculate",question!,yesno!)=1 then
			
			delete from FB_LABELPDETAILS where lrw_id = :ls_lrw_id;
        		if sqlca.sqlcode = -1 then
				messagebox('SQL ERROR: During Ration (Delete)',sqlca.sqlerrtext)
				return 1
			end if;
			
			update fb_elpperiod set elw_CALFLAG ='0'	where elw_ID = :ls_lrw_id;
			
			if sqlca.sqlcode = -1 then
				messagebox('SQL ERROR: During Ration Period (Update)',sqlca.sqlerrtext)
				return 1
			end if;
			
			commit using sqlca;

		else
			return 1
		end if	
	else
		messagebox("Warning","The ration/ELP against this week has not been calculated, You Can not re-calculate",information!)
		return 1
	end if
	
end if


declare c1 cursor for 
SELECT   emp.emp_id labour_id, nvl(no_workdays,0) no_workdays
  FROM fb_employee emp, 
  			( select lda.labour_id labour_id ,count(lda_status) no_workdays from fb_labourdailyattendance lda ,fb_kamsubhead kam 
			  WHERE lda.kamsub_id = kam.kamsub_id AND nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and lda.lda_date between to_date(:ls_fr_dt,'dd/mm/yyyy') and  to_date(:ls_to_dt,'dd/mm/yyyy') and 
						lda.lda_elp > 0 
			group by lda.labour_id ) lda
 WHERE lda.labour_id(+) = emp.emp_id; //and EMP_ACTIVE='1'// and emp.emp_id ='LB00026'

open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return 1; 
else 

		ld_workdaysration= 0; 
		setnull(ls_labour);
				  
		fetch c1 into :ls_labour,:ld_workdaysration;
		do while sqlca.sqlcode <> 100 
		
		   if wf_elpcal(ls_labour,ls_fr_dt,ls_to_dt,ls_lrw_id) = - 1 then
				return 1
		   end if

			setnull(ls_labour);
			fetch c1 into :ls_labour,:ld_workdaysration;
		loop;
	close c1;
end if

update fb_elpperiod set elw_CALFLAG ='1'	where elw_ID = :ls_lrw_id;
if sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Calflag Period (Update)',sqlca.sqlerrtext)
	return 1
end if;

//update fb_elpperiod set elw_PAIDFLAG ='1'	where elw_ID = :ls_lrw_id;
//if sqlca.sqlcode = -1 then
//	messagebox('SQL ERROR: During Paidflag Period (Update)',sqlca.sqlerrtext)
//	return 1
//end if;


commit using sqlca;
messagebox('Confirmation','The ELP Has Been Sucessfully Calculate, Please Check....!',information!)

end event

type ddlb_2 from dropdownlistbox within w_gtelar032
integer x = 1545
integer y = 136
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

type st_2 from statictext within w_gtelar032
integer x = 992
integer y = 152
integer width = 544
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pay Book (00 For All)"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtelar032
integer x = 1934
integer y = 132
integer width = 265
integer height = 100
integer taborder = 40
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
string ls_ind
setpointer(hourglass!)

ls_dt = left(ddlb_1.text,10)
ls_lrw_id = left(right(ddlb_1.text,9),8)

if isnull(ls_dt) then 
	messagebox('Error At Date','Wages Start Date Should Be Entered, Please Check !!!')
	return 1
end if;

select to_char(elw_STARTDATE,'dd/mm/yyyy'),to_char(elw_ENDDATE,'dd/mm/yyyy')
    into :ls_fr_dt,:ls_to_dt
  from fb_elpperiod 
where elw_STARTDATE = to_date(:ls_dt,'dd/mm/yyyy') and elw_ID = :ls_lrw_id;

if sqlca.sqlcode =100 then
	messagebox('Wages Week Select ','Either the there is no such week or the elp against this week has been paid, Please Check...!')
	return 1
elseif sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Wages Week Select ',sqlca.sqlerrtext)
	return 1
end if;

if rb_1.checked then
	dw_1.retrieve(long(ddlb_2.text), ls_fr_dt,ls_to_dt)
elseif  rb_2.checked then
	dw_2.retrieve(long(ddlb_2.text), ls_fr_dt,ls_to_dt)
end if
setpointer(arrow!)
if dw_1.rowcount() = 0 and dw_2.rowcount() = 0 then
	messagebox('Alert!','No data found between the entered dates !!!')
	return 1
end if


end event

type cb_2 from commandbutton within w_gtelar032
integer x = 2199
integer y = 132
integer width = 265
integer height = 100
integer taborder = 50
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

type dw_1 from datawindow within w_gtelar032
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 14
integer y = 240
integer width = 3319
integer height = 2308
string dataobject = "dw_gtelar032"
boolean vscrollbar = true
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

type gb_3 from groupbox within w_gtelar032
integer x = 27
integer y = 108
integer width = 923
integer height = 120
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_2 from datawindow within w_gtelar032
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
boolean visible = false
integer x = 14
integer y = 240
integer width = 3319
integer height = 2308
integer taborder = 60
string dataobject = "dw_gtelar032a"
boolean vscrollbar = true
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

