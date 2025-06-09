$PBExportHeader$w_expmisdmp.srw
forward
global type w_expmisdmp from window
end type
type st_1 from statictext within w_expmisdmp
end type
type sle_1 from singlelineedit within w_expmisdmp
end type
type cb_3 from commandbutton within w_expmisdmp
end type
type cb_2 from commandbutton within w_expmisdmp
end type
type cb_1 from commandbutton within w_expmisdmp
end type
end forward

global type w_expmisdmp from window
integer width = 1289
integer height = 1204
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
boolean center = true
st_1 st_1
sle_1 sle_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_expmisdmp w_expmisdmp

type variables
string ls_path
end variables

on w_expmisdmp.create
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.sle_1,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_expmisdmp.destroy
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;ChangeDirectory("c:\")
if DirectoryExists("backupdb") = false then
	CreateDirectory ("backupdb")
end if
	ChangeDirectory("backupdb")

ls_path = getcurrentdirectory()+"\"
sle_1.text=ls_path
end event

type st_1 from statictext within w_expmisdmp
integer x = 23
integer y = 48
integer width = 1147
integer height = 84
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "File Will Backup in Following Folder:"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_expmisdmp
integer x = 69
integer y = 184
integer width = 978
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_expmisdmp
integer x = 1051
integer y = 184
integer width = 114
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "..."
end type

event clicked;integer li_result

li_result = GetFolder( "my targets", ls_path )

sle_1.text=ls_path +"\" 
ls_path = getcurrentdirectory()+"\"

end event

type cb_2 from commandbutton within w_expmisdmp
integer x = 361
integer y = 612
integer width = 585
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_expmisdmp
integer x = 361
integer y = 476
integer width = 585
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Backup Database"
end type

event clicked;long ll_fexit,ll_retun,ll_temp
string lf_fnamed,ls_snm,ls_username,ls_password,ls_filename,ls_text

if isnull(trim(sle_1.text)) or len(trim(sle_1.text))=0 then
	messagebox('Folder Not Selected','Please Select the Folder First')
	return 1
end if;

ls_path = sle_1.text

if DirectoryExists(ls_path) = false then
	CreateDirectory (ls_path)
end if
	ChangeDirectory(ls_path)
	
ls_USERNAME = lower(gs_garden_snm)+"ote"
ls_password = lower(gs_garden_snm)+"ote"
ls_filename = ls_USERNAME+"_"+string(today(),'yyyy_mm_dd')+string(now(),"_hh_mm")+".dmp"

if pos(ls_filename,ls_USERNAME) = 0 then
	if messagebox('Wrong DMP Selected','Please Make sure that we have selected the Correct DMP file, Want to Continue process',question!,yesno!,2)=2 then
		return
	end if
end if

//insert into FB_GARDEN_EXPENSE(GS_DATE, GS_UNITID, GS_RECTYPE, GS_ACSUBLEDGER_ID, GS_ACSUBLEDGERNAME, GS_EACSUBHEAD_ID, GS_EACSUBHEADNAME, GS_SALARY, GS_WAGES, GS_STORE, GS_OTHERS, GS_ENTRY_BY, GS_ENTRY_DT)
//select DE_DATE,upper(:gs_garden_snm)',IND,EACHEAD_ID,ACSUBLEDGER_NAME,c.EACSUBHEAD_ID, EACSUBHEAD_NAME,sum(DE_SALARYTODAYTY),sum(DE_WAGESTODAYTY),sum(DE_STORESTODAYTY),sum(DE_OTHERSTODAYTY),'PKT',sysdate
//from (SELECT decode(sign(to_number(to_char(DE_DATE,'dd'))-16),-1,to_date('15/'||to_char(DE_DATE,'mm/yyyy'),'dd/mm/yyyy'),last_day(DE_DATE)) DE_DATE,'A' IND,b.EACSUBHEAD_ID, 
//            SUM(NVL(DE_SALARYTODAYTY,0)) DE_SALARYTODAYTY, 
//            SUM(NVL(DE_WAGESTODAYTY,0)) DE_WAGESTODAYTY,  SUM(NVL(DE_STORESTODAYTY,0)) DE_STORESTODAYTY, 
//            SUM(NVL(DE_OTHERSTODAYTY,0)) DE_OTHERSTODAYTY
//        FROM  npote.FB_ACSUBLEDGER a, npote.FB_ACLEDGER c, npote.FB_EXPENSEACSUBHEAD d,npote.fb_dailyexpense b
//        where  a.ACLEDGER_ID=c.ACLEDGER_ID AND a.ACSUBLEDGER_ID=d.EACHEAD_ID and d.EACSUBHEAD_ID = b.EACSUBHEAD_ID and c.ACLEDGER_LEDGERTYPE = 'REVENUEEXPENDITURE'
//      GROUP BY decode(sign(to_number(to_char(DE_DATE,'dd'))-16),-1,to_date('15/'||to_char(DE_DATE,'mm/yyyy'),'dd/mm/yyyy'),last_day(DE_DATE))  , 'A',b.EACSUBHEAD_ID
//      UNION 
//select case when b.rowno = 1 then last_day(to_date((((MOB_YEAR + 1) * 100) + 1),'yyyymm'))
//            when b.rowno = 2 then last_day(to_date((((MOB_YEAR + 1) * 100) + 2),'yyyymm'))
//            when b.rowno = 3 then last_day(to_date((((MOB_YEAR + 1) * 100) + 3),'yyyymm'))
//            when b.rowno = 4 then last_day(to_date(((MOB_YEAR  * 100) + 4),'yyyymm'))
//            when b.rowno = 5 then last_day(to_date(((MOB_YEAR  * 100) + 5),'yyyymm'))
//            when b.rowno = 6 then last_day(to_date(((MOB_YEAR  * 100) + 6),'yyyymm'))
//            when b.rowno = 7 then last_day(to_date(((MOB_YEAR  * 100) + 7),'yyyymm'))
//            when b.rowno = 8 then last_day(to_date(((MOB_YEAR  * 100) + 8),'yyyymm'))
//            when b.rowno = 9 then last_day(to_date(((MOB_YEAR  * 100) + 9),'yyyymm'))
//            when b.rowno = 10 then last_day(to_date(((MOB_YEAR  * 100) + 10),'yyyymm'))
//            when b.rowno = 11 then last_day(to_date(((MOB_YEAR  * 100) + 11),'yyyymm'))
//            when b.rowno = 12 then last_day(to_date(((MOB_YEAR  * 100) + 12),'yyyymm'))
//       end dt,'P',
//       EACSUBHEAD_ID,
//      SUM(case when b.rowno = 1 then decode(ind,'S',MOB_JANPRICE,0)
//            when b.rowno = 2 then decode(ind,'S',MOB_FEBPRICE,0)
//            when b.rowno = 3 then decode(ind,'S',MOB_MARPRICE,0)
//            when b.rowno = 4 then decode(ind,'S',MOB_APRPRICE,0)
//            when b.rowno = 5 then decode(ind,'S',MOB_MAYPRICE,0)
//            when b.rowno = 6 then decode(ind,'S',MOB_JUNPRICE,0)
//            when b.rowno = 7 then decode(ind,'S',MOB_JULPRICE,0)
//            when b.rowno = 8 then decode(ind,'S',MOB_AUGPRICE,0)
//            when b.rowno = 9 then decode(ind,'S',MOB_SEPPRICE,0)
//            when b.rowno = 10 then decode(ind,'S',MOB_OCTPRICE,0)
//            when b.rowno = 11 then decode(ind,'S',MOB_NOVPRICE,0)
//            when b.rowno = 12 then decode(ind,'S',MOB_DECPRICE,0) end) sal,
//       SUM(case when b.rowno = 1 then decode(ind,'W',MOB_JANPRICE,0)
//            when b.rowno = 2 then decode(ind,'W',MOB_FEBPRICE,0)
//            when b.rowno = 3 then decode(ind,'W',MOB_MARPRICE,0)
//            when b.rowno = 4 then decode(ind,'W',MOB_APRPRICE,0)
//            when b.rowno = 5 then decode(ind,'W',MOB_MAYPRICE,0)
//            when b.rowno = 6 then decode(ind,'W',MOB_JUNPRICE,0)
//            when b.rowno = 7 then decode(ind,'W',MOB_JULPRICE,0)
//            when b.rowno = 8 then decode(ind,'W',MOB_AUGPRICE,0)
//            when b.rowno = 9 then decode(ind,'W',MOB_SEPPRICE,0)
//            when b.rowno = 10 then decode(ind,'W',MOB_OCTPRICE,0)
//            when b.rowno = 11 then decode(ind,'W',MOB_NOVPRICE,0)
//            when b.rowno = 12 then decode(ind,'W',MOB_DECPRICE,0) end) wage,     
//       SUM(case when b.rowno = 1 then decode(ind,'T',MOB_JANPRICE,0)
//            when b.rowno = 2 then decode(ind,'T',MOB_FEBPRICE,0)
//            when b.rowno = 3 then decode(ind,'T',MOB_MARPRICE,0)
//            when b.rowno = 4 then decode(ind,'T',MOB_APRPRICE,0)
//            when b.rowno = 5 then decode(ind,'T',MOB_MAYPRICE,0)
//            when b.rowno = 6 then decode(ind,'T',MOB_JUNPRICE,0)
//            when b.rowno = 7 then decode(ind,'T',MOB_JULPRICE,0)
//            when b.rowno = 8 then decode(ind,'T',MOB_AUGPRICE,0)
//            when b.rowno = 9 then decode(ind,'T',MOB_SEPPRICE,0)
//            when b.rowno = 10 then decode(ind,'T',MOB_OCTPRICE,0)
//            when b.rowno = 11 then decode(ind,'T',MOB_NOVPRICE,0)
//            when b.rowno = 12 then decode(ind,'T',MOB_DECPRICE,0) end) stre,
//       SUM(case when b.rowno = 1 then decode(ind,'O',MOB_JANPRICE,0)
//            when b.rowno = 2 then decode(ind,'O',MOB_FEBPRICE,0)
//            when b.rowno = 3 then decode(ind,'O',MOB_MARPRICE,0)
//            when b.rowno = 4 then decode(ind,'O',MOB_APRPRICE,0)
//            when b.rowno = 5 then decode(ind,'O',MOB_MAYPRICE,0)
//            when b.rowno = 6 then decode(ind,'O',MOB_JUNPRICE,0)
//            when b.rowno = 7 then decode(ind,'O',MOB_JULPRICE,0)
//            when b.rowno = 8 then decode(ind,'O',MOB_AUGPRICE,0)
//            when b.rowno = 9 then decode(ind,'O',MOB_SEPPRICE,0)
//            when b.rowno = 10 then decode(ind,'O',MOB_OCTPRICE,0)
//            when b.rowno = 11 then decode(ind,'O',MOB_NOVPRICE,0)
//            when b.rowno = 12 then decode(ind,'O',MOB_DECPRICE,0) end) OTH      
//  from (select MOB_YEAR,'O' ind, EACSUBHEAD_ID, MOB_JANPRICE, MOB_FEBPRICE, MOB_MARPRICE, MOB_APRPRICE, MOB_MAYPRICE, MOB_JUNPRICE, MOB_JULPRICE,
//             MOB_AUGPRICE, MOB_SEPPRICE, MOB_OCTPRICE, MOB_NOVPRICE, MOB_DECPRICE from npote.fb_monthlyothersbudget union all
//        select MWB_YEAR,'W', EACSUBHEAD_ID,(nvl(MWB_JANRATE,0) * nvl(MWB_JANMANDAYS,0)) jan,
//               (nvl(MWB_FEBRATE,0) * nvl(MWB_FEBMANDAYS,0)), (nvl(MWB_MARRATE,0) * nvl(MWB_MARMANDAYS,0)),
//                (nvl(MWB_APRRATE,0) * nvl(MWB_APRMANDAYS,0)),(nvl(MWB_MAYRATE,0) * nvl(MWB_MAYMANDAYS,0)),
//                (nvl(MWB_JUNRATE,0) * nvl(MWB_JUNMANDAYS,0)),(nvl(MWB_JULRATE,0) * nvl(MWB_JULMANDAYS,0)),
//                (nvl(MWB_AUGRATE,0) * nvl(MWB_AUGMANDAYS,0)),(nvl(MWB_SEPRATE,0) * nvl(MWB_SEPMANDAYS,0)),
//                (nvl(MWB_OCTRATE,0) * nvl(MWB_OCTMANDAYS,0)),(nvl(MWB_NOVRATE,0) * nvl(MWB_NOVMANDAYS,0)),
//                (nvl(MWB_DECRATE,0) * nvl(MWB_DECMANDAYS,0)) from npote.FB_MONTHLYWAGESBUDGET  union all
//        select MSB_YEAR,'T', EACSUBHEAD_ID, MSB_JANPRICE, MSB_FEBPRICE, MSB_MARPRICE, MSB_APRPRICE, MSB_MAYPRICE, MSB_JUNPRICE, MSB_JULPRICE, MSB_AUGPRICE, MSB_SEPPRICE, MSB_OCTPRICE, MSB_NOVPRICE, MSB_DECPRICE from npote.FB_MONTHLYSTOREBUDGET union all
//        select MSAB_YEAR,'S', EACSUBHEAD_ID, MSAB_JANSALARY, MSAB_FEBSALARY, MSAB_MARSALARY, MSAB_APRSALARY, MSAB_MAYSALARY, MSAB_JUNSALARY, MSAB_JULSALARY, MSAB_AUGSALARY, MSAB_SEPSALARY, MSAB_OCTSALARY, MSAB_NOVSALARY, MSAB_DECSALARY from npote.fb_monthlysalarybudget) a,
// (select rownum rowno from dual connect by level <= 12) b
//group by case when b.rowno = 1 then last_day(to_date((((MOB_YEAR + 1) * 100) + 1),'yyyymm'))
//            when b.rowno = 2 then last_day(to_date((((MOB_YEAR + 1) * 100) + 2),'yyyymm'))
//            when b.rowno = 3 then last_day(to_date((((MOB_YEAR + 1) * 100) + 3),'yyyymm'))
//            when b.rowno = 4 then last_day(to_date(((MOB_YEAR  * 100) + 4),'yyyymm'))
//            when b.rowno = 5 then last_day(to_date(((MOB_YEAR  * 100) + 5),'yyyymm'))
//            when b.rowno = 6 then last_day(to_date(((MOB_YEAR  * 100) + 6),'yyyymm'))
//            when b.rowno = 7 then last_day(to_date(((MOB_YEAR  * 100) + 7),'yyyymm'))
//            when b.rowno = 8 then last_day(to_date(((MOB_YEAR  * 100) + 8),'yyyymm'))
//            when b.rowno = 9 then last_day(to_date(((MOB_YEAR  * 100) + 9),'yyyymm'))
//            when b.rowno = 10 then last_day(to_date(((MOB_YEAR  * 100) + 10),'yyyymm'))
//            when b.rowno = 11 then last_day(to_date(((MOB_YEAR  * 100) + 11),'yyyymm'))
//            when b.rowno = 12 then last_day(to_date(((MOB_YEAR  * 100) + 12),'yyyymm'))
//       end ,'P',
//       EACSUBHEAD_ID) a,npote.fb_acsubledger b,npote.FB_EXPENSEACSUBHEAD c
//where a.EACSUBHEAD_ID = c.EACSUBHEAD_ID and EACHEAD_ID = b.ACSUBLEDGER_ID
//group by DE_DATE,upper(:gs_garden_snm)',IND,EACHEAD_ID,ACSUBLEDGER_NAME,c.EACSUBHEAD_ID, EACSUBHEAD_NAME;
//
//insert into fb_teamade (TM_DATE, TM_UNITID, TM_AP_IND, TM_RECTYPE, TM_DESC, TM_GL_QNTY, TM_TEAMADE, TM_PRICE, TM_ENTRY_BY, TM_ENTRY_DT)         
//select decode(sign(to_number(to_char(GT_DATE,'dd'))-16),-1,to_date('15/'||to_char(GT_DATE,'mm/yyyy'),'dd/mm/yyyy'),last_day(GT_DATE))  , upper(:gs_garden_snm)','A',decode(SUP_TYPE,'UNIT',decode(nvl(SUP_GROUPIND,'OTHER'),'OWN',decode(GT_TYPE,'PURCHASE','TRANSFERIN','BROUGHT','TRANSFERIN','SALE','TRANSFEROUT','TRANSFER','TRANSFEROUT',GT_TYPE),decode(GT_TYPE,'BROUGHT','TRANSFERIN',GT_TYPE)),GT_TYPE) TM_RECTYPE,decode(GT_TYPE,'OWNATTE','OWN','OWNUSER','OWN',initcap(b.sup_name)),sum(nvl(GT_QUANTITY,0)),0,sum(nvl(GT_NETAMOUNT,0) + nvl(GT_ADJAMT,0)),'PKT',sysdate
//from npote.fb_gltransaction a, npote.fb_supplier b
//where a.sup_id = b.sup_id     
//group by decode(sign(to_number(to_char(GT_DATE,'dd'))-16),-1,to_date('15/'||to_char(GT_DATE,'mm/yyyy'),'dd/mm/yyyy'),last_day(GT_DATE)), upper(:gs_garden_snm)','A',decode(SUP_TYPE,'UNIT',decode(nvl(SUP_GROUPIND,'OTHER'),'OWN',decode(GT_TYPE,'PURCHASE','TRANSFERIN','BROUGHT','TRANSFERIN','SALE','TRANSFEROUT','TRANSFER','TRANSFEROUT',GT_TYPE),decode(GT_TYPE,'BROUGHT','TRANSFERIN',GT_TYPE)),GT_TYPE),decode(GT_TYPE,'OWNATTE','OWN','OWNUSER','OWN',initcap(b.sup_name));
//
//
//insert into fb_teamade (TM_DATE, TM_UNITID, TM_AP_IND, TM_RECTYPE, TM_DESC, TM_GL_QNTY, TM_TEAMADE, TM_ENTRY_BY, TM_ENTRY_DT)
//select decode(sign(to_number(to_char(GLFP_pluckingdate,'dd'))-16),-1,to_date('15/'||to_char(GLFP_pluckingdate,'mm/yyyy'),'dd/mm/yyyy'),last_day(GLFP_pluckingdate)) , upper(:gs_garden_snm)', 'A',decode(GWTM_TYPE,'O','TRANSFEROUT',decode(SUP_TYPE,'OWN','OWNATTE','UNIT',decode(nvl(SUP_GROUPIND,'OTHER'),'OWN','TRANSFERIN','PURCHASE'),'PURCHASE')) ty, initcap(FB_SUPPLIER.sup_name),0,sum(nvl(GWTM_TEAMADE,0)) , 'PKT',sysdate
//from npote.fb_GLFORPRODUCTION,npote.FB_GARDENWISETEAMADE,npote.FB_SUPPLIER 
//where  fb_GLFORPRODUCTION.GLFP_PK=FB_GARDENWISETEAMADE.GLFP_PK AND fb_GLFORPRODUCTION.SUP_ID=FB_SUPPLIER.SUP_ID(+)
//group by decode(sign(to_number(to_char(GLFP_pluckingdate,'dd'))-16),-1,to_date('15/'||to_char(GLFP_pluckingdate,'mm/yyyy'),'dd/mm/yyyy'),last_day(GLFP_pluckingdate)) , upper(:gs_garden_snm)', 'A',decode(GWTM_TYPE,'O','TRANSFEROUT',decode(SUP_TYPE,'OWN','OWNATTE','UNIT',decode(nvl(SUP_GROUPIND,'OTHER'),'OWN','TRANSFERIN','PURCHASE'),'PURCHASE')),initcap(FB_SUPPLIER.sup_name); 
//
//
//insert into fb_teamade (TM_DATE, TM_UNITID, TM_AP_IND, TM_RECTYPE, TM_DESC, TM_GL_QNTY, TM_TEAMADE, TM_ENTRY_BY, TM_ENTRY_DT)
//select case when b.rowno = 1 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 1),'yyyymm'))
//            when b.rowno = 2 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 2),'yyyymm'))
//            when b.rowno = 3 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 3),'yyyymm'))
//            when b.rowno = 4 then last_day(to_date(((MTMB_YEAR  * 100) + 4),'yyyymm'))
//            when b.rowno = 5 then last_day(to_date(((MTMB_YEAR  * 100) + 5),'yyyymm'))
//            when b.rowno = 6 then last_day(to_date(((MTMB_YEAR  * 100) + 6),'yyyymm'))
//            when b.rowno = 7 then last_day(to_date(((MTMB_YEAR  * 100) + 7),'yyyymm'))
//            when b.rowno = 8 then last_day(to_date(((MTMB_YEAR  * 100) + 8),'yyyymm'))
//            when b.rowno = 9 then last_day(to_date(((MTMB_YEAR  * 100) + 9),'yyyymm'))
//            when b.rowno = 10 then last_day(to_date(((MTMB_YEAR  * 100) + 10),'yyyymm'))
//            when b.rowno = 11 then last_day(to_date(((MTMB_YEAR  * 100) + 11),'yyyymm'))
//            when b.rowno = 12 then last_day(to_date(((MTMB_YEAR  * 100) + 12),'yyyymm'))
//       end dt,upper(:gs_garden_snm)','P',rec_ty,'OWN' recdesc,0,
//      SUM(case when b.rowno = 1 then nvl(jantm,0)
//            when b.rowno = 2 then nvl(febtm,0)
//            when b.rowno = 3 then nvl(martm,0)
//            when b.rowno = 4 then nvl(aprtm,0)
//            when b.rowno = 5 then nvl(maytm,0)
//            when b.rowno = 6 then nvl(juntm,0)
//            when b.rowno = 7 then nvl(jultm,0)
//            when b.rowno = 8 then nvl(augtm,0)
//            when b.rowno = 9 then nvl(septm,0)
//            when b.rowno = 10 then nvl(octtm,0)
//            when b.rowno = 11 then nvl(novtm,0)
//            when b.rowno = 12 then nvl(dectm,0) end) tm, 'PKT',sysdate      
//  from (select MTMB_YEAR,'OWNATTE' rec_ty, (nvl(MTMB_JANTEAMADEOWN,0) + nvl(MTMB_JANTMOWN_OF,0)) jantm, 
//                              (nvl(MTMB_FEBTEAMADEOWN,0) + nvl(MTMB_FEBTMOWN_OF,0)) febtm, 
//                              (nvl(MTMB_MARTEAMADEOWN,0) + nvl(MTMB_MARTMOWN_OF,0)) martm, 
//                              (nvl(MTMB_APRTEAMADEOWN,0) + nvl(MTMB_APRTMOWN_OF,0)) aprtm, 
//                              (nvl(MTMB_MAYTEAMADEOWN,0) + nvl(MTMB_MAYTMOWN_OF,0)) maytm, 
//                              (nvl(MTMB_JUNTEAMADEOWN,0) + nvl(MTMB_JUNTMOWN_OF,0)) juntm, 
//                              (nvl(MTMB_JULTEAMADEOWN,0) + nvl(MTMB_JULTMOWN_OF,0)) jultm, 
//                              (nvl(MTMB_AUGTEAMADEOWN,0) + nvl(MTMB_AUGTMOWN_OF,0)) augtm, 
//                              (nvl(MTMB_SEPTEAMADEOWN,0) + nvl(MTMB_SEPTMOWN_OF,0)) septm, 
//                              (nvl(MTMB_OCTTEAMADEOWN,0) + nvl(MTMB_OCTTMOWN_OF,0)) octtm, 
//                              (nvl(MTMB_NOVTEAMADEOWN,0) + nvl(MTMB_NOVTMOWN_OF,0)) novtm, 
//                              (nvl(MTMB_DECTEAMADEOWN,0) + nvl(MTMB_DECTMOWN_OF,0)) dectm
//                             from npote.FB_MONTHLYTEAMADEBUDGET) a,
// (select rownum rowno from dual connect by level <= 12) b
//group by case when b.rowno = 1 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 1),'yyyymm'))
//            when b.rowno = 2 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 2),'yyyymm'))
//            when b.rowno = 3 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 3),'yyyymm'))
//            when b.rowno = 4 then last_day(to_date(((MTMB_YEAR  * 100) + 4),'yyyymm'))
//            when b.rowno = 5 then last_day(to_date(((MTMB_YEAR  * 100) + 5),'yyyymm'))
//            when b.rowno = 6 then last_day(to_date(((MTMB_YEAR  * 100) + 6),'yyyymm'))
//            when b.rowno = 7 then last_day(to_date(((MTMB_YEAR  * 100) + 7),'yyyymm'))
//            when b.rowno = 8 then last_day(to_date(((MTMB_YEAR  * 100) + 8),'yyyymm'))
//            when b.rowno = 9 then last_day(to_date(((MTMB_YEAR  * 100) + 9),'yyyymm'))
//            when b.rowno = 10 then last_day(to_date(((MTMB_YEAR  * 100) + 10),'yyyymm'))
//            when b.rowno = 11 then last_day(to_date(((MTMB_YEAR  * 100) + 11),'yyyymm'))
//            when b.rowno = 12 then last_day(to_date(((MTMB_YEAR  * 100) + 12),'yyyymm'))
//       end ,'P';
//       
//insert into fb_teamade (TM_DATE, TM_UNITID, TM_AP_IND, TM_RECTYPE, TM_DESC, TM_GL_QNTY, TM_TEAMADE, TM_ENTRY_BY, TM_ENTRY_DT)
//select case when b.rowno = 1 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 1),'yyyymm'))
//            when b.rowno = 2 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 2),'yyyymm'))
//            when b.rowno = 3 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 3),'yyyymm'))
//            when b.rowno = 4 then last_day(to_date(((MTMB_YEAR  * 100) + 4),'yyyymm'))
//            when b.rowno = 5 then last_day(to_date(((MTMB_YEAR  * 100) + 5),'yyyymm'))
//            when b.rowno = 6 then last_day(to_date(((MTMB_YEAR  * 100) + 6),'yyyymm'))
//            when b.rowno = 7 then last_day(to_date(((MTMB_YEAR  * 100) + 7),'yyyymm'))
//            when b.rowno = 8 then last_day(to_date(((MTMB_YEAR  * 100) + 8),'yyyymm'))
//            when b.rowno = 9 then last_day(to_date(((MTMB_YEAR  * 100) + 9),'yyyymm'))
//            when b.rowno = 10 then last_day(to_date(((MTMB_YEAR  * 100) + 10),'yyyymm'))
//            when b.rowno = 11 then last_day(to_date(((MTMB_YEAR  * 100) + 11),'yyyymm'))
//            when b.rowno = 12 then last_day(to_date(((MTMB_YEAR  * 100) + 12),'yyyymm'))
//       end dt,upper(:gs_garden_snm)','P',rec_ty,'Others' recdesc,0,
//      SUM(case when b.rowno = 1 then nvl(jantm,0)
//            when b.rowno = 2 then nvl(febtm,0)
//            when b.rowno = 3 then nvl(martm,0)
//            when b.rowno = 4 then nvl(aprtm,0)
//            when b.rowno = 5 then nvl(maytm,0)
//            when b.rowno = 6 then nvl(juntm,0)
//            when b.rowno = 7 then nvl(jultm,0)
//            when b.rowno = 8 then nvl(augtm,0)
//            when b.rowno = 9 then nvl(septm,0)
//            when b.rowno = 10 then nvl(octtm,0)
//            when b.rowno = 11 then nvl(novtm,0)
//            when b.rowno = 12 then nvl(dectm,0) end) tm, 'PKT',sysdate      
//  from (select MTMB_YEAR,'PURCHASE' rec_ty, (nvl(MTMB_JANTEAMADEPUR,0) + nvl(MTMB_JANTMOF_OWN,0)) jantm, 
//                              (nvl(MTMB_FEBTEAMADEPUR,0) + nvl(MTMB_FEBTMOF_OWN,0)) febtm, 
//                              (nvl(MTMB_MARTEAMADEPUR,0) + nvl(MTMB_MARTMOF_OWN,0)) martm, 
//                              (nvl(MTMB_APRTEAMADEPUR,0) + nvl(MTMB_APRTMOF_OWN,0)) aprtm, 
//                              (nvl(MTMB_MAYTEAMADEPUR,0) + nvl(MTMB_MAYTMOF_OWN,0)) maytm, 
//                              (nvl(MTMB_JUNTEAMADEPUR,0) + nvl(MTMB_JUNTMOF_OWN,0)) juntm, 
//                              (nvl(MTMB_JULTEAMADEPUR,0) + nvl(MTMB_JULTMOF_OWN,0)) jultm, 
//                              (nvl(MTMB_AUGTEAMADEPUR,0) + nvl(MTMB_AUGTMOF_OWN,0)) augtm, 
//                              (nvl(MTMB_SEPTEAMADEPUR,0) + nvl(MTMB_SEPTMOF_OWN,0)) septm, 
//                              (nvl(MTMB_OCTTEAMADEPUR,0) + nvl(MTMB_OCTTMOF_OWN,0)) octtm, 
//                              (nvl(MTMB_NOVTEAMADEPUR,0) + nvl(MTMB_NOVTMOF_OWN,0)) novtm, 
//                              (nvl(MTMB_DECTEAMADEPUR,0) + nvl(MTMB_DECTMOF_OWN,0)) dectm
//                             from npote.FB_MONTHLYTEAMADEBUDGET) a,
// (select rownum rowno from dual connect by level <= 12) b
//group by case when b.rowno = 1 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 1),'yyyymm'))
//            when b.rowno = 2 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 2),'yyyymm'))
//            when b.rowno = 3 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 3),'yyyymm'))
//            when b.rowno = 4 then last_day(to_date(((MTMB_YEAR  * 100) + 4),'yyyymm'))
//            when b.rowno = 5 then last_day(to_date(((MTMB_YEAR  * 100) + 5),'yyyymm'))
//            when b.rowno = 6 then last_day(to_date(((MTMB_YEAR  * 100) + 6),'yyyymm'))
//            when b.rowno = 7 then last_day(to_date(((MTMB_YEAR  * 100) + 7),'yyyymm'))
//            when b.rowno = 8 then last_day(to_date(((MTMB_YEAR  * 100) + 8),'yyyymm'))
//            when b.rowno = 9 then last_day(to_date(((MTMB_YEAR  * 100) + 9),'yyyymm'))
//            when b.rowno = 10 then last_day(to_date(((MTMB_YEAR  * 100) + 10),'yyyymm'))
//            when b.rowno = 11 then last_day(to_date(((MTMB_YEAR  * 100) + 11),'yyyymm'))
//            when b.rowno = 12 then last_day(to_date(((MTMB_YEAR  * 100) + 12),'yyyymm'))
//       end ,'P';
//
//insert into fb_teamade (TM_DATE, TM_UNITID, TM_AP_IND, TM_RECTYPE, TM_DESC, TM_GL_QNTY, TM_TEAMADE, TM_ENTRY_BY, TM_ENTRY_DT) 
//select decode(sign(to_number(to_char(DTMP_SORTDATE,'dd'))-16),-1,to_date('15/'||to_char(DTMP_SORTDATE,'mm/yyyy'),'dd/mm/yyyy'),last_day(DTMP_SORTDATE)) , upper(:gs_garden_snm)', 'A','SORT', TMP_Name,0,sum(nvl(DTMP_SORTQUANTODAYTY,0)) , 'PKT',sysdate
//From npote.fb_DAILYSORTEDTEAMADEPRODUCT a,npote.fb_teamadeproduct b
//where a.tmp_id = b.tmp_id(+) 
//group by decode(sign(to_number(to_char(DTMP_SORTDATE,'dd'))-16),-1,to_date('15/'||to_char(DTMP_SORTDATE,'mm/yyyy'),'dd/mm/yyyy'),last_day(DTMP_SORTDATE)),TMP_Name;
//
//insert into fb_teamade (TM_DATE, TM_UNITID, TM_AP_IND, TM_RECTYPE, TM_DESC, TM_GL_QNTY, TM_TEAMADE, TM_ENTRY_BY, TM_ENTRY_DT) 
//select decode(sign(to_number(to_char(dtp.dtp_date,'dd'))-16),-1,to_date('15/'||to_char(dtp.dtp_date,'mm/yyyy'),'dd/mm/yyyy'),last_day(dtp.dtp_date)), upper(:gs_garden_snm)', 'A','PACK', TMP_Name,0,sum(( (nvl(dtpd.dtpd_srnoend,0) - nvl(dtpd.dtpd_srnostart,0)) + 1)  * nvl(dtpd.dtpd_indwt,0)) , 'PKT',sysdate
//From npote.fb_dailyteapacked dtp,npote.fb_dtpdetails dtpd, npote.fb_teamadeproductcategory tpc, npote.fb_teamadeproduct tmp
//where tpc.tpc_id = tmp.tpc_id  AND dtpd.tmp_id = tmp.tmp_id AND dtp.dtp_id = dtpd.dtp_id 
//group by decode(sign(to_number(to_char(dtp.dtp_date,'dd'))-16),-1,to_date('15/'||to_char(dtp.dtp_date,'mm/yyyy'),'dd/mm/yyyy'),last_day(dtp.dtp_date)),TMP_Name;
//
//
//insert into fb_teamade (TM_DATE, TM_UNITID, TM_AP_IND, TM_RECTYPE, TM_DESC, TM_GL_QNTY, TM_TEAMADE, TM_ENTRY_BY, TM_ENTRY_DT) 
//select decode(sign(to_number(to_char(si.si_date,'dd'))-16),-1,to_date('15/'||to_char(si.si_date,'mm/yyyy'),'dd/mm/yyyy'),last_day(si.si_date)), upper(:gs_garden_snm)', 'A','DESPATCH', TMP_Name,0,sum(((nvl(SID.sid_srnoend,0) - nvl(SID.sid_srnostart,0)) + 1) * nvl(dtpd.dtpd_indwt,0)) , 'PKT',sysdate
//From npote.fb_saleinvoice si, npote.fb_sidetails SID,npote.fb_dtpdetails dtpd, npote.fb_teamadeproductcategory tpc, npote.fb_teamadeproduct tmp
//where tpc.tpc_id = tmp.tpc_id AND dtpd.tmp_id = tmp.tmp_id AND SID.dtpd_id = dtpd.dtpd_id AND si.si_id = SID.si_id AND si.si_active = '1' and (((nvl(SID.sid_srnoend,0) - nvl(SID.sid_srnostart,0)) + 1) * nvl(dtpd.dtpd_indwt,0)) > 0 
//group by decode(sign(to_number(to_char(si.si_date,'dd'))-16),-1,to_date('15/'||to_char(si.si_date,'mm/yyyy'),'dd/mm/yyyy'),last_day(si.si_date)),TMP_Name;



ls_text = "exp USERID=" + ls_USERNAME + "/" + ls_PASSWORD + "@ltcdb FILE=" + ls_path+ls_filename + " Owner="+ls_USERNAME

run(ls_text)
	
ll_retun=0

for ll_retun = 1 to 1000
	sleep(30)
	select distinct sid into :ll_temp from sys.v_$session  where upper(program)='EXP.EXE' and username=:ls_USERNAME;
	if sqlca.sqlcode =100 then
		Messagebox('Confirmation','The Database file Has been Backup Successfully ....!~r'+ls_path+ls_filename)
		return
	end if
next


end event

