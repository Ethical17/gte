$PBExportHeader$w_csvexport_trail.srw
forward
global type w_csvexport_trail from window
end type
type rb_4 from radiobutton within w_csvexport_trail
end type
type rb_3 from radiobutton within w_csvexport_trail
end type
type rb_2 from radiobutton within w_csvexport_trail
end type
type st_2 from statictext within w_csvexport_trail
end type
type dp_1 from datepicker within w_csvexport_trail
end type
type ddlb_1 from dropdownlistbox within w_csvexport_trail
end type
type st_1 from statictext within w_csvexport_trail
end type
type rb_1 from radiobutton within w_csvexport_trail
end type
type rb_113 from radiobutton within w_csvexport_trail
end type
type rb_114 from radiobutton within w_csvexport_trail
end type
type cb_4 from commandbutton within w_csvexport_trail
end type
type gb_1 from groupbox within w_csvexport_trail
end type
end forward

global type w_csvexport_trail from window
integer width = 1678
integer height = 1448
boolean titlebar = true
string title = "Export Tables"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
windowstate windowstate = maximized!
long backcolor = 67108864
boolean center = true
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
st_2 st_2
dp_1 dp_1
ddlb_1 ddlb_1
st_1 st_1
rb_1 rb_1
rb_113 rb_113
rb_114 rb_114
cb_4 cb_4
gb_1 gb_1
end type
global w_csvexport_trail w_csvexport_trail

type variables
string ls_sql,ls_path,ls_destination, ls_st_dt,ls_snm,ls_USERNAME,ls_password,ls_garden, ls_ason
long ll_season
double ld_diff
end variables

on w_csvexport_trail.create
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.st_2=create st_2
this.dp_1=create dp_1
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.rb_1=create rb_1
this.rb_113=create rb_113
this.rb_114=create rb_114
this.cb_4=create cb_4
this.gb_1=create gb_1
this.Control[]={this.rb_4,&
this.rb_3,&
this.rb_2,&
this.st_2,&
this.dp_1,&
this.ddlb_1,&
this.st_1,&
this.rb_1,&
this.rb_113,&
this.rb_114,&
this.cb_4,&
this.gb_1}
end on

on w_csvexport_trail.destroy
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.st_2)
destroy(this.dp_1)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.rb_1)
destroy(this.rb_113)
destroy(this.rb_114)
destroy(this.cb_4)
destroy(this.gb_1)
end on

event open;//select sysdate,:gs_garden_snm, TMP_NAME,a.TMP_ID, tpc_name, a.TPC_ID, (nvl(dstp.sorttodate,0) + nvl(trans_qnty,0) - nvl(dtp1.packtodate,0) - nvl(sds_qnty,0)) sortstocktodate 
//from 
//    (select tmp_id, sum(nvl(dtmp_sortquantodayty,0)) sorttodate from fb_dailysortedteamadeproduct where dtmp_sortdate<= trunc(sysdate)
//      group by tmp_id) dstp,
//    (select dtpd.tmp_id, sum(nvl((dtpd.dtpd_srnoend-dtpd.dtpd_srnostart+1)*dtpd.dtpd_indwt,0)) packtodate from fb_dailyteapacked dtp,fb_dtpdetails dtpd 
//      where dtp.dtp_id=dtpd.dtp_id and dtp_date<= trunc(sysdate)
//      group by dtpd.tmp_id) dtp1,
//     (select TPC_ID,TMP_ID, sum(nvl(SD_QNTY,0)) sds_qnty from fb_sample_dispatch 
//            where SD_TYPE = 'S' group by TPC_ID,TMP_ID) samplediss,
//     (select  TPC_ID,TMP_ID, sum(nvl(PT_QUANTITY,0)) trans_qnty  from fb_packteatransfer 
//              where pt_trantype = 'R' and pt_status = 'S' group by TPC_ID,TMP_ID) madeteareceive, 
//    (select distinct a.TMP_ID, TMP_NAME, a.TPC_ID, tpc_name from fb_teamadeproduct a, fb_teamadeproductcategory b where a.tpc_id = b.tpc_id and nvl(TMP_ACTIVE_IND,'Y') = 'Y') a
//where dstp.tmp_id = dtp1.tmp_id(+) and dstp.tmp_id(+) = a.tmp_id and a.tmp_id = samplediss.tmp_id(+) and dstp.tmp_id = madeteareceive.tmp_id(+) and
//      (nvl(dstp.sorttodate,0) - nvl(dtp1.packtodate,0) - nvl(sds_qnty,0)) > 0


if gs_garden_snm = 'MV' then
	ddlb_1.enabled = true
	ddlb_1.additem('Manuvalley Tea Estate [MV]')
	ddlb_1.additem('Jagannathpur Tea Estate [JP]')
	ddlb_1.additem('Pearacherra Tea Estate [PC]')
	ddlb_1.additem('Golokpur Tea Estate [GP]')	
elseif gs_garden_snm = 'NP' then
	ddlb_1.enabled = true
	ddlb_1.additem('Narayanpur Tea Estate [NP]')
	ddlb_1.additem('Shyanguri Tea Estate [SH]')
else
	DECLARE c1 CURSOR FOR  
	select distinct UNIT_SHORTNAME from fb_gardenmaster 
	where UNIT_ACTIVE_IND='Y'
	order by 1;
			 
	open c1;
	
	setnull(ls_garden)
	
	if sqlca.sqlcode = 0 then
		fetch c1 into :ls_garden;
		do while sqlca.sqlcode <> 100
			ddlb_1.additem(ls_garden)
			setnull(ls_garden)
			fetch c1 into :ls_garden;
		loop
		close c1;
	end if;
	setnull(ls_garden)
//	if gs_opt<> 'HO' then
		ddlb_1.enabled = false
//	elseif gs_opt = 'HO' then
//		ddlb_1.enabled = true
//	end if
end if	

end event

type rb_4 from radiobutton within w_csvexport_trail
boolean visible = false
integer x = 585
integer y = 1276
integer width = 448
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Store Items"
boolean automatic = false
end type

event clicked;string ls_rec,ls_ind,ls_dt, ls_gsn, ls_spc_id, ls_spc_nm, ls_spunit, ls_sp_id, ls_sp_name
double ld_qty, ld_value
integer li_filenum, li_rec, li_ctr 

li_ctr=0;
setpointer(hourglass!) 

setnull(ls_rec);setnull(ls_dt);setnull(ls_gsn);setnull(ls_spc_id);setnull(ls_spc_nm);setnull(ls_spunit);setnull(ls_sp_id);setnull(ls_sp_name);
ld_qty = 0; ld_value = 0;

If not DirectoryExists ("c:\temp") Then
	CreateDirectory ("c:\temp")
End If

select unit_id into :gs_unit from fb_gardenmaster where UNIT_SHORTNAME = :gs_garden_snm;

if fileexists("c:\temp\storeitem_"+gs_garden_snm+".csv") = true then
	filedelete("c:\temp\storeitem_"+gs_garden_snm+".csv")
end if
 
li_filenum =  fileopen("c:\temp\storeitem_"+gs_garden_snm+".csv",linemode!,write!,lockreadwrite!,replace!)

ls_ason = dp_1.text

DECLARE c1 CURSOR FOR
select :ls_ason,:gs_unit,c.SPC_ID, initcap(c.SPC_NAME) SPC_NAME,b.SP_UNIT,SP_ID, initcap(decode(nvl(b.SSP_ID,'x'),'x',SP_NAME,d.SSP_NAME)) SP_NAME,
       sum(decode(ds_rec_ind,'I',-1,1)* ds_QTY) closquantity,
       sum(decode(ds_rec_ind,'I',-1,1)* nvl(ds_Value,0)) closvalue
  from fb_daily_stock a,FB_STOREPRODUCT b, FB_STOREPRODUCTCATEGORY c,fb_storeproduct_std d
 where trunc(ds_date) <= TO_DATE (:ls_ason,'DD/MM/YYYY') and 
       DS_SECTION_ID = 'FD001' and a.DS_ITEM_CD=b.SP_ID AND b.SPC_ID=c.SPC_ID and b.SSP_ID=d.ssp_id(+) 
 group by c.SPC_ID, initcap(c.SPC_NAME),b.SP_UNIT,SP_ID, initcap(decode(nvl(b.SSP_ID,'x'),'x',SP_NAME,d.SSP_NAME))
ORDER BY 3,6; 
			
 open c1;
 if sqlca.sqlcode = -1 then 
	messagebox('Sql Error During Opening Cursor !',sqlca.sqlerrtext)
	return 1
 elseif sqlca.sqlcode = 0 then
   fetch c1 into :ls_dt, :ls_gsn, :ls_spc_id, :ls_spc_nm, :ls_spunit, :ls_sp_id, :ls_sp_name, :ld_qty, :ld_value;

	do while sqlca.sqlcode <> 100
		
		
		if isnull(ls_dt) then; ls_dt=""; end if; 
		if isnull(ls_gsn) then; ls_gsn=""; end if;
		if isnull(ls_spc_id) then; ls_spc_id=""; end if;		
   		if isnull(ls_spc_nm) then; ls_spc_nm =""; end if;
   		if isnull(ls_spunit) then; ls_spunit=""; end if;
		if isnull(ls_sp_id) then; ls_sp_id=""; end if;
		if isnull(ls_sp_name) then; ls_sp_name=""; end if;
		if isnull(ld_qty) then; ld_qty = 0; end if;
		if isnull(ld_value) then; ld_value = 0; end if;
		
		if pos(ls_spc_nm,",") > 0 then
			do while pos(ls_spc_nm,",") > 0
				ls_spc_nm = replace(ls_spc_nm,pos(ls_spc_nm,","),1," "); 
			loop
		end if;

		if pos(ls_sp_name,",") > 0 then
			do while  pos(ls_sp_name,",") > 0
			  ls_sp_name = replace(ls_sp_name,pos(ls_sp_name,","),1," "); 
			loop
		end if	
			
		if ls_dt="" then  ls_rec = "," else	ls_rec = ls_dt + ","
		ls_rec = ls_rec + ls_gsn +","+ls_spc_id+","+ls_spc_nm+","+ls_spunit+","+ls_sp_id+","+ls_sp_name+","+string(ld_qty)+","+string(ld_value)

		
		filewrite(li_filenum,ls_rec)
		
		li_rec++
		li_ctr++
		
			setnull(ls_rec);setnull(ls_dt);setnull(ls_gsn);setnull(ls_spc_id);setnull(ls_spc_nm);setnull(ls_spunit);setnull(ls_sp_id);setnull(ls_sp_name);
			ld_qty = 0; ld_value = 0;
	
   fetch c1 into :ls_dt, :ls_gsn, :ls_spc_id, :ls_spc_nm, :ls_spunit, :ls_sp_id, :ls_sp_name, :ld_qty, :ld_value;
   
   loop
	close c1;
else
	messagebox('Error: During Opening of Cursor',sqlca.sqlerrtext)
	return -1
end if

	fileclose(li_filenum) 

setpointer(arrow!) 
messagebox('Confirmation','Total No Of Records : '+string(li_ctr))
return 1

end event

type rb_3 from radiobutton within w_csvexport_trail
boolean visible = false
integer x = 581
integer y = 1008
integer width = 448
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Expense - MIS"
boolean automatic = false
end type

event clicked;string ls_rec, ls_dt, ls_gsn, ls_ind, ls_eachd_id, ls_eachd_nm, ls_eacshd_id, ls_eacshd_nm, ls_entry_by, ls_entry_dt, ls_stym
double ld_sal, ld_wage, ld_store, ld_other
integer li_filenum, li_rec, li_ctr 

li_ctr=0;
setpointer(hourglass!) 

setnull(ls_rec);setnull(ls_dt);setnull(ls_gsn);setnull(ls_ind);setnull(ls_eachd_id);setnull(ls_eachd_nm);setnull(ls_eacshd_id);setnull(ls_eacshd_nm);setnull(ls_entry_by);setnull(ls_entry_dt);
ld_sal = 0; ld_wage = 0; ld_store = 0; ld_other=0;

ls_stym = f_get_fin_stdt()

ls_st_dt = '01/'+right(ls_stym,2)+'/'+left(ls_stym,4)

If not DirectoryExists ("c:\temp") Then
	CreateDirectory ("c:\temp")
End If

if fileexists("c:\temp\misexpense_"+gs_garden_snm+".csv") = true then
	filedelete("c:\temp\misexpense_"+gs_garden_snm+".csv")
end if

li_filenum =  fileopen("c:\temp\misexpense_"+gs_garden_snm+".csv",linemode!,write!,lockreadwrite!,replace!)
//select 'SH', to_char(SI_DATE,'dd/mm/yyyy'),SI_CN,to_char(SI_CNDATE,'dd/mm/yyyy'),
// 		 decode(SI_TYPE,'AUCTION','AUC','PRICONS','CON','PRILOCAL','LOC','TRANSFREE','TFR','TRANSPRI','TPR',null),
//		 decode(SI_TYPE,'AUCTION',b.CITY_ID,'PRICONS',c.CITY_ID,null) destination,
//		 TRANSP_ID,a.WARE_ID,a.CUS_ID,substr(ADVICE_ID,1,16),SI_DESC,SI_INSURANCEVALUE,BROK_ID,SI_EXCISEDUTY,SI_CESS,SI_EDUCATIONALCESS,
//		 SI_CENTRALEXCISENO,SI_ID,SI_HSECESS,:gs_garden_snm,:gs_unit,SI_WAYBILLNO
//from fb_saleinvoice a, (select WARE_ID, CITY_ID from fb_warehouse) b, (select CUS_ID, CITY_ID from fb_customer) c
//where a.WARE_ID = b.WARE_ID(+) and a.CUS_ID = c.CUS_ID(+) and SI_ROSEND_DT is null order by 2;

DECLARE c1 CURSOR FOR
select to_char(DE_DATE,'dd/mm/yyyy') DE_DATE,upper(:gs_garden_snm),IND,EACHEAD_ID,ACSUBLEDGER_NAME,c.EACSUBHEAD_ID, EACSUBHEAD_NAME,sum(DE_SALARYTODAYTY),sum(DE_WAGESTODAYTY),sum(DE_STORESTODAYTY),sum(DE_OTHERSTODAYTY),:gs_user,to_char(sysdate,'dd/mm/yyyy')
from (SELECT decode(sign(to_number(to_char(DE_DATE,'dd'))-16),-1,to_date('15/'||to_char(DE_DATE,'mm/yyyy'),'dd/mm/yyyy'),last_day(DE_DATE)) DE_DATE,'A' IND,b.EACSUBHEAD_ID, 
            SUM(NVL(DE_SALARYTODAYTY,0)) DE_SALARYTODAYTY, 
            SUM(NVL(DE_WAGESTODAYTY,0)) DE_WAGESTODAYTY,  SUM(NVL(DE_STORESTODAYTY,0)) DE_STORESTODAYTY, 
            SUM(NVL(DE_OTHERSTODAYTY,0)) DE_OTHERSTODAYTY
        FROM  FB_ACSUBLEDGER a, FB_ACLEDGER c, FB_EXPENSEACSUBHEAD d,fb_dailyexpense b
        where  a.ACLEDGER_ID=c.ACLEDGER_ID AND a.ACSUBLEDGER_ID=d.EACHEAD_ID and d.EACSUBHEAD_ID = b.EACSUBHEAD_ID and c.ACLEDGER_LEDGERTYPE = 'REVENUEEXPENDITURE'
      GROUP BY decode(sign(to_number(to_char(DE_DATE,'dd'))-16),-1,to_date('15/'||to_char(DE_DATE,'mm/yyyy'),'dd/mm/yyyy'),last_day(DE_DATE))  , 'A',b.EACSUBHEAD_ID
      UNION 
select case when b.rowno = 1 then last_day(to_date((((MOB_YEAR + 1) * 100) + 1),'yyyymm'))
            when b.rowno = 2 then last_day(to_date((((MOB_YEAR + 1) * 100) + 2),'yyyymm'))
            when b.rowno = 3 then last_day(to_date((((MOB_YEAR + 1) * 100) + 3),'yyyymm'))
            when b.rowno = 4 then last_day(to_date(((MOB_YEAR  * 100) + 4),'yyyymm'))
            when b.rowno = 5 then last_day(to_date(((MOB_YEAR  * 100) + 5),'yyyymm'))
            when b.rowno = 6 then last_day(to_date(((MOB_YEAR  * 100) + 6),'yyyymm'))
            when b.rowno = 7 then last_day(to_date(((MOB_YEAR  * 100) + 7),'yyyymm'))
            when b.rowno = 8 then last_day(to_date(((MOB_YEAR  * 100) + 8),'yyyymm'))
            when b.rowno = 9 then last_day(to_date(((MOB_YEAR  * 100) + 9),'yyyymm'))
            when b.rowno = 10 then last_day(to_date(((MOB_YEAR  * 100) + 10),'yyyymm'))
            when b.rowno = 11 then last_day(to_date(((MOB_YEAR  * 100) + 11),'yyyymm'))
            when b.rowno = 12 then last_day(to_date(((MOB_YEAR  * 100) + 12),'yyyymm'))
       end dt,'P',
       EACSUBHEAD_ID,
      SUM(case when b.rowno = 1 then decode(ind,'S',MOB_JANPRICE,0)
            when b.rowno = 2 then decode(ind,'S',MOB_FEBPRICE,0)
            when b.rowno = 3 then decode(ind,'S',MOB_MARPRICE,0)
            when b.rowno = 4 then decode(ind,'S',MOB_APRPRICE,0)
            when b.rowno = 5 then decode(ind,'S',MOB_MAYPRICE,0)
            when b.rowno = 6 then decode(ind,'S',MOB_JUNPRICE,0)
            when b.rowno = 7 then decode(ind,'S',MOB_JULPRICE,0)
            when b.rowno = 8 then decode(ind,'S',MOB_AUGPRICE,0)
            when b.rowno = 9 then decode(ind,'S',MOB_SEPPRICE,0)
            when b.rowno = 10 then decode(ind,'S',MOB_OCTPRICE,0)
            when b.rowno = 11 then decode(ind,'S',MOB_NOVPRICE,0)
            when b.rowno = 12 then decode(ind,'S',MOB_DECPRICE,0) end) sal,
       SUM(case when b.rowno = 1 then decode(ind,'W',MOB_JANPRICE,0)
            when b.rowno = 2 then decode(ind,'W',MOB_FEBPRICE,0)
            when b.rowno = 3 then decode(ind,'W',MOB_MARPRICE,0)
            when b.rowno = 4 then decode(ind,'W',MOB_APRPRICE,0)
            when b.rowno = 5 then decode(ind,'W',MOB_MAYPRICE,0)
            when b.rowno = 6 then decode(ind,'W',MOB_JUNPRICE,0)
            when b.rowno = 7 then decode(ind,'W',MOB_JULPRICE,0)
            when b.rowno = 8 then decode(ind,'W',MOB_AUGPRICE,0)
            when b.rowno = 9 then decode(ind,'W',MOB_SEPPRICE,0)
            when b.rowno = 10 then decode(ind,'W',MOB_OCTPRICE,0)
            when b.rowno = 11 then decode(ind,'W',MOB_NOVPRICE,0)
            when b.rowno = 12 then decode(ind,'W',MOB_DECPRICE,0) end) wage,     
       SUM(case when b.rowno = 1 then decode(ind,'T',MOB_JANPRICE,0)
            when b.rowno = 2 then decode(ind,'T',MOB_FEBPRICE,0)
            when b.rowno = 3 then decode(ind,'T',MOB_MARPRICE,0)
            when b.rowno = 4 then decode(ind,'T',MOB_APRPRICE,0)
            when b.rowno = 5 then decode(ind,'T',MOB_MAYPRICE,0)
            when b.rowno = 6 then decode(ind,'T',MOB_JUNPRICE,0)
            when b.rowno = 7 then decode(ind,'T',MOB_JULPRICE,0)
            when b.rowno = 8 then decode(ind,'T',MOB_AUGPRICE,0)
            when b.rowno = 9 then decode(ind,'T',MOB_SEPPRICE,0)
            when b.rowno = 10 then decode(ind,'T',MOB_OCTPRICE,0)
            when b.rowno = 11 then decode(ind,'T',MOB_NOVPRICE,0)
            when b.rowno = 12 then decode(ind,'T',MOB_DECPRICE,0) end) stre,
       SUM(case when b.rowno = 1 then decode(ind,'O',MOB_JANPRICE,0)
            when b.rowno = 2 then decode(ind,'O',MOB_FEBPRICE,0)
            when b.rowno = 3 then decode(ind,'O',MOB_MARPRICE,0)
            when b.rowno = 4 then decode(ind,'O',MOB_APRPRICE,0)
            when b.rowno = 5 then decode(ind,'O',MOB_MAYPRICE,0)
            when b.rowno = 6 then decode(ind,'O',MOB_JUNPRICE,0)
            when b.rowno = 7 then decode(ind,'O',MOB_JULPRICE,0)
            when b.rowno = 8 then decode(ind,'O',MOB_AUGPRICE,0)
            when b.rowno = 9 then decode(ind,'O',MOB_SEPPRICE,0)
            when b.rowno = 10 then decode(ind,'O',MOB_OCTPRICE,0)
            when b.rowno = 11 then decode(ind,'O',MOB_NOVPRICE,0)
            when b.rowno = 12 then decode(ind,'O',MOB_DECPRICE,0) end) OTH      
  from (select MOB_YEAR,'O' ind, EACSUBHEAD_ID, MOB_JANPRICE, MOB_FEBPRICE, MOB_MARPRICE, MOB_APRPRICE, MOB_MAYPRICE, MOB_JUNPRICE, MOB_JULPRICE,
             MOB_AUGPRICE, MOB_SEPPRICE, MOB_OCTPRICE, MOB_NOVPRICE, MOB_DECPRICE from fb_monthlyothersbudget union all
        select MWB_YEAR,'W', EACSUBHEAD_ID,(nvl(MWB_JANRATE,0) * nvl(MWB_JANMANDAYS,0)) jan,
               (nvl(MWB_FEBRATE,0) * nvl(MWB_FEBMANDAYS,0)), (nvl(MWB_MARRATE,0) * nvl(MWB_MARMANDAYS,0)),
                (nvl(MWB_APRRATE,0) * nvl(MWB_APRMANDAYS,0)),(nvl(MWB_MAYRATE,0) * nvl(MWB_MAYMANDAYS,0)),
                (nvl(MWB_JUNRATE,0) * nvl(MWB_JUNMANDAYS,0)),(nvl(MWB_JULRATE,0) * nvl(MWB_JULMANDAYS,0)),
                (nvl(MWB_AUGRATE,0) * nvl(MWB_AUGMANDAYS,0)),(nvl(MWB_SEPRATE,0) * nvl(MWB_SEPMANDAYS,0)),
                (nvl(MWB_OCTRATE,0) * nvl(MWB_OCTMANDAYS,0)),(nvl(MWB_NOVRATE,0) * nvl(MWB_NOVMANDAYS,0)),
                (nvl(MWB_DECRATE,0) * nvl(MWB_DECMANDAYS,0)) from FB_MONTHLYWAGESBUDGET  union all
        select MSB_YEAR,'T', EACSUBHEAD_ID, MSB_JANPRICE, MSB_FEBPRICE, MSB_MARPRICE, MSB_APRPRICE, MSB_MAYPRICE, MSB_JUNPRICE, MSB_JULPRICE, MSB_AUGPRICE, MSB_SEPPRICE, MSB_OCTPRICE, MSB_NOVPRICE, MSB_DECPRICE from FB_MONTHLYSTOREBUDGET union all
        select MSAB_YEAR,'S', EACSUBHEAD_ID, MSAB_JANSALARY, MSAB_FEBSALARY, MSAB_MARSALARY, MSAB_APRSALARY, MSAB_MAYSALARY, MSAB_JUNSALARY, MSAB_JULSALARY, MSAB_AUGSALARY, MSAB_SEPSALARY, MSAB_OCTSALARY, MSAB_NOVSALARY, MSAB_DECSALARY from fb_monthlysalarybudget) a,
 (select rownum rowno from dual connect by level <= 12) b
group by case when b.rowno = 1 then last_day(to_date((((MOB_YEAR + 1) * 100) + 1),'yyyymm'))
            when b.rowno = 2 then last_day(to_date((((MOB_YEAR + 1) * 100) + 2),'yyyymm'))
            when b.rowno = 3 then last_day(to_date((((MOB_YEAR + 1) * 100) + 3),'yyyymm'))
            when b.rowno = 4 then last_day(to_date(((MOB_YEAR  * 100) + 4),'yyyymm'))
            when b.rowno = 5 then last_day(to_date(((MOB_YEAR  * 100) + 5),'yyyymm'))
            when b.rowno = 6 then last_day(to_date(((MOB_YEAR  * 100) + 6),'yyyymm'))
            when b.rowno = 7 then last_day(to_date(((MOB_YEAR  * 100) + 7),'yyyymm'))
            when b.rowno = 8 then last_day(to_date(((MOB_YEAR  * 100) + 8),'yyyymm'))
            when b.rowno = 9 then last_day(to_date(((MOB_YEAR  * 100) + 9),'yyyymm'))
            when b.rowno = 10 then last_day(to_date(((MOB_YEAR  * 100) + 10),'yyyymm'))
            when b.rowno = 11 then last_day(to_date(((MOB_YEAR  * 100) + 11),'yyyymm'))
            when b.rowno = 12 then last_day(to_date(((MOB_YEAR  * 100) + 12),'yyyymm'))
       end ,'P',
       EACSUBHEAD_ID) a,fb_acsubledger b,FB_EXPENSEACSUBHEAD c
where a.EACSUBHEAD_ID = c.EACSUBHEAD_ID and EACHEAD_ID = b.ACSUBLEDGER_ID and b.ACLEDGER_ID in (select acledger_id from fb_acledger where ACLEDGER_LEDGERTYPE = 'REVENUEEXPENDITURE') and DE_DATE >= to_date(:ls_st_dt,'dd/mm/yyyy')
group by DE_DATE,upper(:gs_garden_snm),IND,EACHEAD_ID,ACSUBLEDGER_NAME,c.EACSUBHEAD_ID, EACSUBHEAD_NAME
order by 1; 
			
 open c1;
 if sqlca.sqlcode = -1 then 
	messagebox('Sql Error During Opening Cursor !',sqlca.sqlerrtext)
	return 1
 elseif sqlca.sqlcode = 0 then
   fetch c1 into :ls_dt, :ls_gsn, :ls_ind, :ls_eachd_id, :ls_eachd_nm, :ls_eacshd_id, :ls_eacshd_nm, :ld_sal, :ld_wage, :ld_store, :ld_other, :ls_entry_by, :ls_entry_dt;

	do while sqlca.sqlcode <> 100
		
		
		if isnull(ls_dt) then; ls_dt=""; end if;
		if isnull(ls_gsn) then; ls_gsn=""; end if;
		if isnull(ls_ind) then; ls_ind=""; end if;		
   		if isnull(ls_eachd_id) then; ls_eachd_id =""; end if;
   		if isnull(ls_eachd_nm) then; ls_eachd_nm=""; end if;
		if isnull(ls_eacshd_id) then; ls_eacshd_id=""; end if;
		if isnull(ls_eacshd_nm) then; ls_eacshd_nm=""; end if;
		if isnull(ld_sal) then; ld_sal = 0; end if;
		if isnull(ld_wage) then; ld_wage = 0; end if;
		if isnull(ld_store) then; ld_store = 0; end if;
		if isnull(ld_other) then; ld_other = 0; end if;
		if isnull(ls_entry_by) then; ls_entry_by=""; end if;
		if isnull(ls_entry_dt) then; ls_entry_dt=""; end if;
		
		if pos(ls_eachd_nm,",") > 0 then; ls_eachd_nm = replace(ls_eachd_nm,pos(ls_eachd_nm,","),1," "); end if;
		if pos(ls_eacshd_nm,",") > 0 then; ls_eacshd_nm = replace(ls_eacshd_nm,pos(ls_eacshd_nm,","),1," "); end if;
		
		if ls_dt="" then  ls_rec = "," else	ls_rec = ls_dt + ","
		ls_rec = ls_rec + ls_gsn +","+ls_ind+","+ls_eachd_id+","+ls_eachd_nm+","+ls_eacshd_id+","+ls_eacshd_nm+","+string(ld_sal)+","+string(ld_wage)+","+string(ld_store)+","+string(ld_other)+","+ls_entry_by+","
		if ls_entry_dt = "" then ls_rec = ls_rec + "," else	ls_rec = ls_rec+ls_entry_dt 
		
		filewrite(li_filenum,ls_rec)
		
		li_rec++
		li_ctr++
		
				setnull(ls_rec);setnull(ls_dt);setnull(ls_gsn);setnull(ls_ind);setnull(ls_eachd_id);setnull(ls_eachd_nm);setnull(ls_eacshd_id);setnull(ls_eacshd_nm);setnull(ls_entry_by);setnull(ls_entry_dt);
				ld_sal = 0; ld_wage = 0; ld_store = 0; ld_other=0;
	
   fetch c1 into :ls_dt, :ls_gsn, :ls_ind, :ls_eachd_id, :ls_eachd_nm, :ls_eacshd_id, :ls_eacshd_nm, :ld_sal, :ld_wage, :ld_store, :ld_other, :ls_entry_by, :ls_entry_dt;
   
   loop
	close c1;
else
	messagebox('Error: During Opening of Cursor',sqlca.sqlerrtext)
	return -1
end if

	fileclose(li_filenum) 

setpointer(arrow!) 
messagebox('Confirmation','Total No Of Records : '+string(li_ctr))
return 1

end event

type rb_2 from radiobutton within w_csvexport_trail
boolean visible = false
integer x = 581
integer y = 1156
integer width = 466
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Teamade - MIS"
boolean automatic = false
end type

event clicked;string ls_rec, ls_dt, ls_gsn, ls_ind, ls_recind, ls_desc, ls_entry_by, ls_entry_dt,ls_stym, ls_cat, ls_grade
double ld_glqty, ld_teamade, ld_amt
integer li_filenum, li_rec, li_ctr 
li_ctr=0;
setpointer(hourglass!) 

setnull(ls_rec);setnull(ls_dt);setnull(ls_gsn);setnull(ls_ind);setnull(ls_recind);setnull(ls_desc);setnull(ls_entry_by);setnull(ls_entry_dt);
ld_glqty = 0; ld_teamade = 0; ld_amt = 0;

ls_stym = f_get_fin_stdt()

ls_st_dt = '01/'+right(ls_stym,2)+'/'+left(ls_stym,4)

If not DirectoryExists ("c:\temp") Then
	CreateDirectory ("c:\temp")
End If

if fileexists("c:\temp\misteamade_"+gs_garden_snm+".csv") = true then
	filedelete("c:\temp\misteamade_"+gs_garden_snm+".csv")
end if

li_filenum =  fileopen("c:\temp\misteamade_"+gs_garden_snm+".csv",linemode!,write!,lockreadwrite!,replace!)
//select 'SH', to_char(SI_DATE,'dd/mm/yyyy'),SI_CN,to_char(SI_CNDATE,'dd/mm/yyyy'),
// 		 decode(SI_TYPE,'AUCTION','AUC','PRICONS','CON','PRILOCAL','LOC','TRANSFREE','TFR','TRANSPRI','TPR',null),
//		 decode(SI_TYPE,'AUCTION',b.CITY_ID,'PRICONS',c.CITY_ID,null) destination,
//		 TRANSP_ID,a.WARE_ID,a.CUS_ID,substr(ADVICE_ID,1,16),SI_DESC,SI_INSURANCEVALUE,BROK_ID,SI_EXCISEDUTY,SI_CESS,SI_EDUCATIONALCESS,
//		 SI_CENTRALEXCISENO,SI_ID,SI_HSECESS,:gs_garden_snm,:gs_unit,SI_WAYBILLNO
//from fb_saleinvoice a, (select WARE_ID, CITY_ID from fb_warehouse) b, (select CUS_ID, CITY_ID from fb_customer) c
//where a.WARE_ID = b.WARE_ID(+) and a.CUS_ID = c.CUS_ID(+) and SI_ROSEND_DT is null order by 2;

//select to_char(DDP_PLUCKINGDATE,'dd/mm/yyyy') , upper(:gs_garden_snm), 'A', 'CATTM' ty, null,0,sum(nvl(DDU_QUANTITY,0)) ,0, :gs_user,to_char(sysdate,'dd/mm/yyyy'), null TMP_Name, tpc_name
//from fb_dailydryerproduct,fb_dailydryerunsorted, fb_teamadeproductcategory
//where  fb_dailydryerproduct.DDP_PK = fb_dailydryerunsorted.DDP_PK AND fb_dailydryerunsorted.TPC_ID = fb_teamadeproductcategory.TPC_ID and DDP_PLUCKINGDATE >= to_date(:ls_st_dt,'dd/mm/yyyy')
//group by DDP_PLUCKINGDATE , upper(:gs_garden_snm), 'A', 'CATTM', tpc_name
//order by 1

DECLARE c1 CURSOR FOR
select to_char(GT_DATE,'dd/mm/yyyy') GT_date, upper(:gs_garden_snm),'A',decode(SUP_TYPE,'UNIT',decode(nvl(SUP_GROUPIND,'OTHER'),'OWN',decode(GT_TYPE,'PURCHASE','TRANSFERIN','BROUGHT','TRANSFERIN','SALE','TRANSFEROUT','TRANSFER','TRANSFEROUT',GT_TYPE),decode(GT_TYPE,'BROUGHT','TRANSFERIN',GT_TYPE)),GT_TYPE) TM_RECTYPE,decode(GT_TYPE,'OWNATTE','OWN','OWNUSER','OWN',initcap(b.sup_name)),sum(nvl(GT_QUANTITY,0)),0,sum(nvl(GT_NETAMOUNT,0) + nvl(GT_ADJAMT,0)),:gs_user,to_char(sysdate,'dd/mm/yyyy'), null grade, null category, GT_SEASON
from fb_gltransaction a, fb_supplier b
where a.sup_id = b.sup_id and GT_DATE >= to_date(:ls_st_dt,'dd/mm/yyyy')    
group by GT_DATE, upper(:gs_garden_snm),'A',decode(SUP_TYPE,'UNIT',decode(nvl(SUP_GROUPIND,'OTHER'),'OWN',decode(GT_TYPE,'PURCHASE','TRANSFERIN','BROUGHT','TRANSFERIN','SALE','TRANSFEROUT','TRANSFER','TRANSFEROUT',GT_TYPE),decode(GT_TYPE,'BROUGHT','TRANSFERIN',GT_TYPE)),GT_TYPE),decode(GT_TYPE,'OWNATTE','OWN','OWNUSER','OWN',initcap(b.sup_name)), GT_SEASON
union all
select to_char(GLFP_pluckingdate,'dd/mm/yyyy') , upper(:gs_garden_snm), 'A',decode(GWTM_TYPE,'O','TRANSFEROUT',decode(SUP_TYPE,'OWN','OWNATTE','UNIT',decode(nvl(SUP_GROUPIND,'OTHER'),'OWN','TRANSFERIN','PURCHASE'),'PURCHASE')) ty, initcap(FB_SUPPLIER.sup_name),0,sum(nvl(GWTM_TEAMADE,0)) ,0, :gs_user,to_char(sysdate,'dd/mm/yyyy'), null, null, GWTM_SEASON
from fb_GLFORPRODUCTION,FB_GARDENWISETEAMADE,FB_SUPPLIER 
where  fb_GLFORPRODUCTION.GLFP_PK=FB_GARDENWISETEAMADE.GLFP_PK AND fb_GLFORPRODUCTION.SUP_ID=FB_SUPPLIER.SUP_ID(+)  and GLFP_pluckingdate >= to_date(:ls_st_dt,'dd/mm/yyyy') 
group by GLFP_pluckingdate , upper(:gs_garden_snm), 'A',decode(GWTM_TYPE,'O','TRANSFEROUT',decode(SUP_TYPE,'OWN','OWNATTE','UNIT',decode(nvl(SUP_GROUPIND,'OTHER'),'OWN','TRANSFERIN','PURCHASE'),'PURCHASE')),initcap(FB_SUPPLIER.sup_name), GWTM_SEASON 
union all
select to_char(case when b.rowno = 1 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 1),'yyyymm'))
            when b.rowno = 2 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 2),'yyyymm'))
            when b.rowno = 3 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 3),'yyyymm'))
            when b.rowno = 4 then last_day(to_date(((MTMB_YEAR  * 100) + 4),'yyyymm'))
            when b.rowno = 5 then last_day(to_date(((MTMB_YEAR  * 100) + 5),'yyyymm'))
            when b.rowno = 6 then last_day(to_date(((MTMB_YEAR  * 100) + 6),'yyyymm'))
            when b.rowno = 7 then last_day(to_date(((MTMB_YEAR  * 100) + 7),'yyyymm'))
            when b.rowno = 8 then last_day(to_date(((MTMB_YEAR  * 100) + 8),'yyyymm'))
            when b.rowno = 9 then last_day(to_date(((MTMB_YEAR  * 100) + 9),'yyyymm'))
            when b.rowno = 10 then last_day(to_date(((MTMB_YEAR  * 100) + 10),'yyyymm'))
            when b.rowno = 11 then last_day(to_date(((MTMB_YEAR  * 100) + 11),'yyyymm'))
            when b.rowno = 12 then last_day(to_date(((MTMB_YEAR  * 100) + 12),'yyyymm'))
       end,'dd/mm/yyyy') dt,upper(:gs_garden_snm),'P',rec_ty,'OWN' recdesc,0,
      SUM(case when b.rowno = 1 then nvl(jantm,0)
            when b.rowno = 2 then nvl(febtm,0)
            when b.rowno = 3 then nvl(martm,0)
            when b.rowno = 4 then nvl(aprtm,0)
            when b.rowno = 5 then nvl(maytm,0)
            when b.rowno = 6 then nvl(juntm,0)
            when b.rowno = 7 then nvl(jultm,0)
            when b.rowno = 8 then nvl(augtm,0)
            when b.rowno = 9 then nvl(septm,0)
            when b.rowno = 10 then nvl(octtm,0)
            when b.rowno = 11 then nvl(novtm,0)
            when b.rowno = 12 then nvl(dectm,0) end) tm, 0, :gs_user,to_char(sysdate,'dd/mm/yyyy'), null, null, null      
  from (select MTMB_YEAR,'OWNATTE' rec_ty, (nvl(MTMB_JANTEAMADEOWN,0) + nvl(MTMB_JANTMOWN_OF,0)) jantm, 
                              (nvl(MTMB_FEBTEAMADEOWN,0) + nvl(MTMB_FEBTMOWN_OF,0)) febtm, 
                              (nvl(MTMB_MARTEAMADEOWN,0) + nvl(MTMB_MARTMOWN_OF,0)) martm, 
                              (nvl(MTMB_APRTEAMADEOWN,0) + nvl(MTMB_APRTMOWN_OF,0)) aprtm, 
                              (nvl(MTMB_MAYTEAMADEOWN,0) + nvl(MTMB_MAYTMOWN_OF,0)) maytm, 
                              (nvl(MTMB_JUNTEAMADEOWN,0) + nvl(MTMB_JUNTMOWN_OF,0)) juntm, 
                              (nvl(MTMB_JULTEAMADEOWN,0) + nvl(MTMB_JULTMOWN_OF,0)) jultm, 
                              (nvl(MTMB_AUGTEAMADEOWN,0) + nvl(MTMB_AUGTMOWN_OF,0)) augtm, 
                              (nvl(MTMB_SEPTEAMADEOWN,0) + nvl(MTMB_SEPTMOWN_OF,0)) septm, 
                              (nvl(MTMB_OCTTEAMADEOWN,0) + nvl(MTMB_OCTTMOWN_OF,0)) octtm, 
                              (nvl(MTMB_NOVTEAMADEOWN,0) + nvl(MTMB_NOVTMOWN_OF,0)) novtm, 
                              (nvl(MTMB_DECTEAMADEOWN,0) + nvl(MTMB_DECTMOWN_OF,0)) dectm
                             from FB_MONTHLYTEAMADEBUDGET) a,
 (select rownum rowno from dual connect by level <= 12) b
 where case when b.rowno = 1 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 1),'yyyymm'))
            when b.rowno = 2 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 2),'yyyymm'))
            when b.rowno = 3 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 3),'yyyymm'))
            when b.rowno = 4 then last_day(to_date(((MTMB_YEAR  * 100) + 4),'yyyymm'))
            when b.rowno = 5 then last_day(to_date(((MTMB_YEAR  * 100) + 5),'yyyymm'))
            when b.rowno = 6 then last_day(to_date(((MTMB_YEAR  * 100) + 6),'yyyymm'))
            when b.rowno = 7 then last_day(to_date(((MTMB_YEAR  * 100) + 7),'yyyymm'))
            when b.rowno = 8 then last_day(to_date(((MTMB_YEAR  * 100) + 8),'yyyymm'))
            when b.rowno = 9 then last_day(to_date(((MTMB_YEAR  * 100) + 9),'yyyymm'))
            when b.rowno = 10 then last_day(to_date(((MTMB_YEAR  * 100) + 10),'yyyymm'))
            when b.rowno = 11 then last_day(to_date(((MTMB_YEAR  * 100) + 11),'yyyymm'))
            when b.rowno = 12 then last_day(to_date(((MTMB_YEAR  * 100) + 12),'yyyymm'))
       end >= to_date(:ls_st_dt,'dd/mm/yyyy') 
group by case when b.rowno = 1 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 1),'yyyymm'))
            when b.rowno = 2 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 2),'yyyymm'))
            when b.rowno = 3 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 3),'yyyymm'))
            when b.rowno = 4 then last_day(to_date(((MTMB_YEAR  * 100) + 4),'yyyymm'))
            when b.rowno = 5 then last_day(to_date(((MTMB_YEAR  * 100) + 5),'yyyymm'))
            when b.rowno = 6 then last_day(to_date(((MTMB_YEAR  * 100) + 6),'yyyymm'))
            when b.rowno = 7 then last_day(to_date(((MTMB_YEAR  * 100) + 7),'yyyymm'))
            when b.rowno = 8 then last_day(to_date(((MTMB_YEAR  * 100) + 8),'yyyymm'))
            when b.rowno = 9 then last_day(to_date(((MTMB_YEAR  * 100) + 9),'yyyymm'))
            when b.rowno = 10 then last_day(to_date(((MTMB_YEAR  * 100) + 10),'yyyymm'))
            when b.rowno = 11 then last_day(to_date(((MTMB_YEAR  * 100) + 11),'yyyymm'))
            when b.rowno = 12 then last_day(to_date(((MTMB_YEAR  * 100) + 12),'yyyymm'))
       end ,'P'    ,rec_ty
union all
select to_char(case when b.rowno = 1 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 1),'yyyymm'))
            when b.rowno = 2 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 2),'yyyymm'))
            when b.rowno = 3 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 3),'yyyymm'))
            when b.rowno = 4 then last_day(to_date(((MTMB_YEAR  * 100) + 4),'yyyymm'))
            when b.rowno = 5 then last_day(to_date(((MTMB_YEAR  * 100) + 5),'yyyymm'))
            when b.rowno = 6 then last_day(to_date(((MTMB_YEAR  * 100) + 6),'yyyymm'))
            when b.rowno = 7 then last_day(to_date(((MTMB_YEAR  * 100) + 7),'yyyymm'))
            when b.rowno = 8 then last_day(to_date(((MTMB_YEAR  * 100) + 8),'yyyymm'))
            when b.rowno = 9 then last_day(to_date(((MTMB_YEAR  * 100) + 9),'yyyymm'))
            when b.rowno = 10 then last_day(to_date(((MTMB_YEAR  * 100) + 10),'yyyymm'))
            when b.rowno = 11 then last_day(to_date(((MTMB_YEAR  * 100) + 11),'yyyymm'))
            when b.rowno = 12 then last_day(to_date(((MTMB_YEAR  * 100) + 12),'yyyymm'))
       end,'dd/mm/yyyy') dt,upper(:gs_garden_snm),'P',rec_ty,'Others' recdesc,0,
      SUM(case when b.rowno = 1 then nvl(jantm,0)
            when b.rowno = 2 then nvl(febtm,0)
            when b.rowno = 3 then nvl(martm,0)
            when b.rowno = 4 then nvl(aprtm,0)
            when b.rowno = 5 then nvl(maytm,0)
            when b.rowno = 6 then nvl(juntm,0)
            when b.rowno = 7 then nvl(jultm,0)
            when b.rowno = 8 then nvl(augtm,0)
            when b.rowno = 9 then nvl(septm,0)
            when b.rowno = 10 then nvl(octtm,0)
            when b.rowno = 11 then nvl(novtm,0)
            when b.rowno = 12 then nvl(dectm,0) end) tm, 0, :gs_user,to_char(sysdate,'dd/mm/yyyy'), null, null, null      
  from (select MTMB_YEAR,'PURCHASE' rec_ty, (nvl(MTMB_JANTEAMADEPUR,0) + nvl(MTMB_JANTMOF_OWN,0)) jantm, 
                              (nvl(MTMB_FEBTEAMADEPUR,0) + nvl(MTMB_FEBTMOF_OWN,0)) febtm, 
                              (nvl(MTMB_MARTEAMADEPUR,0) + nvl(MTMB_MARTMOF_OWN,0)) martm, 
                              (nvl(MTMB_APRTEAMADEPUR,0) + nvl(MTMB_APRTMOF_OWN,0)) aprtm, 
                              (nvl(MTMB_MAYTEAMADEPUR,0) + nvl(MTMB_MAYTMOF_OWN,0)) maytm, 
                              (nvl(MTMB_JUNTEAMADEPUR,0) + nvl(MTMB_JUNTMOF_OWN,0)) juntm, 
                              (nvl(MTMB_JULTEAMADEPUR,0) + nvl(MTMB_JULTMOF_OWN,0)) jultm, 
                              (nvl(MTMB_AUGTEAMADEPUR,0) + nvl(MTMB_AUGTMOF_OWN,0)) augtm, 
                              (nvl(MTMB_SEPTEAMADEPUR,0) + nvl(MTMB_SEPTMOF_OWN,0)) septm, 
                              (nvl(MTMB_OCTTEAMADEPUR,0) + nvl(MTMB_OCTTMOF_OWN,0)) octtm, 
                              (nvl(MTMB_NOVTEAMADEPUR,0) + nvl(MTMB_NOVTMOF_OWN,0)) novtm, 
                              (nvl(MTMB_DECTEAMADEPUR,0) + nvl(MTMB_DECTMOF_OWN,0)) dectm
                             from FB_MONTHLYTEAMADEBUDGET) a,
 (select rownum rowno from dual connect by level <= 12) b
 where case when b.rowno = 1 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 1),'yyyymm'))
            when b.rowno = 2 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 2),'yyyymm'))
            when b.rowno = 3 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 3),'yyyymm'))
            when b.rowno = 4 then last_day(to_date(((MTMB_YEAR  * 100) + 4),'yyyymm'))
            when b.rowno = 5 then last_day(to_date(((MTMB_YEAR  * 100) + 5),'yyyymm'))
            when b.rowno = 6 then last_day(to_date(((MTMB_YEAR  * 100) + 6),'yyyymm'))
            when b.rowno = 7 then last_day(to_date(((MTMB_YEAR  * 100) + 7),'yyyymm'))
            when b.rowno = 8 then last_day(to_date(((MTMB_YEAR  * 100) + 8),'yyyymm'))
            when b.rowno = 9 then last_day(to_date(((MTMB_YEAR  * 100) + 9),'yyyymm'))
            when b.rowno = 10 then last_day(to_date(((MTMB_YEAR  * 100) + 10),'yyyymm'))
            when b.rowno = 11 then last_day(to_date(((MTMB_YEAR  * 100) + 11),'yyyymm'))
            when b.rowno = 12 then last_day(to_date(((MTMB_YEAR  * 100) + 12),'yyyymm'))
       end >= to_date(:ls_st_dt,'dd/mm/yyyy') 
group by case when b.rowno = 1 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 1),'yyyymm'))
            when b.rowno = 2 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 2),'yyyymm'))
            when b.rowno = 3 then last_day(to_date((((MTMB_YEAR + 1) * 100) + 3),'yyyymm'))
            when b.rowno = 4 then last_day(to_date(((MTMB_YEAR  * 100) + 4),'yyyymm'))
            when b.rowno = 5 then last_day(to_date(((MTMB_YEAR  * 100) + 5),'yyyymm'))
            when b.rowno = 6 then last_day(to_date(((MTMB_YEAR  * 100) + 6),'yyyymm'))
            when b.rowno = 7 then last_day(to_date(((MTMB_YEAR  * 100) + 7),'yyyymm'))
            when b.rowno = 8 then last_day(to_date(((MTMB_YEAR  * 100) + 8),'yyyymm'))
            when b.rowno = 9 then last_day(to_date(((MTMB_YEAR  * 100) + 9),'yyyymm'))
            when b.rowno = 10 then last_day(to_date(((MTMB_YEAR  * 100) + 10),'yyyymm'))
            when b.rowno = 11 then last_day(to_date(((MTMB_YEAR  * 100) + 11),'yyyymm'))
            when b.rowno = 12 then last_day(to_date(((MTMB_YEAR  * 100) + 12),'yyyymm'))
       end ,'P'   ,rec_ty
union all
select to_char(DTMP_SORTDATE,'dd/mm/yyyy') , upper(:gs_garden_snm), 'A','SORT', TMP_Name,0,sum(nvl(DTMP_SORTQUANTODAYTY,0)) , 0, :gs_user,to_char(sysdate,'dd/mm/yyyy'), TMP_Name, tpc_name, DTMP_SEASON
From fb_DAILYSORTEDTEAMADEPRODUCT a,fb_teamadeproduct b, fb_teamadeproductcategory c
where a.tmp_id = b.tmp_id(+) and b.tpc_id = c.tpc_id and DTMP_SORTDATE >= to_date(:ls_st_dt,'dd/mm/yyyy')
group by DTMP_SORTDATE,TMP_Name,tpc_name, DTMP_SEASON
union all
select to_char(dtp.dtp_date,'dd/mm/yyyy'), upper(:gs_garden_snm), 'A','PACK', TMP_Name,0,sum(( (nvl(dtpd.dtpd_srnoend,0) - nvl(dtpd.dtpd_srnostart,0)) + 1)  * nvl(dtpd.dtpd_indwt,0)) , 0, :gs_user,to_char(sysdate,'dd/mm/yyyy'),TMP_Name, tpc_name, DTP_SEASON
From fb_dailyteapacked dtp,fb_dtpdetails dtpd, fb_teamadeproductcategory tpc, fb_teamadeproduct tmp
where tpc.tpc_id = tmp.tpc_id  AND dtpd.tmp_id = tmp.tmp_id AND dtp.dtp_id = dtpd.dtp_id and dtp.dtp_date >= to_date(:ls_st_dt,'dd/mm/yyyy')
group by dtp.dtp_date,TMP_Name, tpc_name, DTP_SEASON
union all
select to_char(si.si_date,'dd/mm/yyyy'), upper(:gs_garden_snm), 'A','DESPATCH', TMP_Name,0,sum(((nvl(SID.sid_srnoend,0) - nvl(SID.sid_srnostart,0)) + 1) * nvl(dtpd.dtpd_indwt,0)) , 0, :gs_user,to_char(sysdate,'dd/mm/yyyy'),TMP_Name, tpc_name, SID_SEASON
From fb_saleinvoice si, fb_sidetails SID,fb_dtpdetails dtpd, fb_teamadeproductcategory tpc, fb_teamadeproduct tmp
where tpc.tpc_id = tmp.tpc_id AND dtpd.tmp_id = tmp.tmp_id AND SID.dtpd_id = dtpd.dtpd_id AND si.si_id = SID.si_id AND si.si_active = '1' and (((nvl(SID.sid_srnoend,0) - nvl(SID.sid_srnostart,0)) + 1) * nvl(dtpd.dtpd_indwt,0)) > 0 and si.si_date >= to_date(:ls_st_dt,'dd/mm/yyyy')
group by si.si_date,TMP_Name, tpc_name, SID_SEASON
union all
select to_char(sysdate,'dd/mm/yyyy'), upper(:gs_garden_snm), 'A','CLSTK', recty,0, sum(decode(sign(trunc(pludate) - trunc(sysdate)),1,0,QUANTITY)) , 0, :gs_user,to_char(sysdate,'dd/mm/yyyy'), grade, category, null
from ( SELECT   'UNSORTED' recty, 'ALL', tpc.tpc_manid category,null grade, pludate, SUM (qty) QUANTITY 
 FROM (SELECT ddu.tpc_id tpc_id, ddp.ddp_pluckingdate pludate, NVL (SUM (ddu.ddu_quantity), 0) qty  
         FROM fb_dailydryerproduct ddp, fb_dailydryerunsorted ddu  
        WHERE ddp.ddp_pk = ddu.ddp_pk AND ddp.ddp_type <> 'O'  
       GROUP BY (ddu.tpc_id, ddp.ddp_pluckingdate)  
       UNION ALL  
       SELECT   tmp.tpc_id tpc_id, dtmp_sortdate pludate, -NVL (SUM (dtmp.dtmp_sortquantodayty), 0) qty  
         FROM fb_dailysortedteamadeproduct dtmp, fb_teamadeproduct tmp WHERE dtmp.tmp_id = tmp.tmp_id  
        GROUP BY (tmp.tpc_id, dtmp.dtmp_sortdate)) d1, fb_teamadeproductcategory tpc  
  WHERE (tpc.tpc_id = d1.tpc_id)  
 GROUP BY (tpc.tpc_manid, pludate)  
 HAVING SUM (qty) <> 0  
 UNION ALL  
 SELECT 'SORTED', 'ALL', tpc.tpc_manid,TMP_NAME, pludate, SUM (qty)  
   FROM (SELECT tmp.tpc_id tpc_id,TMP_NAME, dtmp_sortdate pludate, NVL (SUM (dtmp.dtmp_sortquantodayty), 0) qty 
           FROM fb_dailysortedteamadeproduct dtmp, fb_teamadeproduct tmp  
          WHERE dtmp.tmp_id = tmp.tmp_id  
         GROUP BY (tmp.tpc_id,TMP_NAME, dtmp.dtmp_sortdate)  
         UNION ALL  
         SELECT tmp.tpc_id tpc_id, TMP_NAME, dtp.dtp_date pludate, -NVL (SUM((dtpd.dtpd_srnoend - dtpd.dtpd_srnostart + 1 ) * dtpd.dtpd_indwt),0 ) qty  
           FROM fb_dailyteapacked dtp, fb_dtpdetails dtpd, fb_teamadeproduct tmp  
          WHERE dtp.dtp_id = dtpd.dtp_id AND tmp.tmp_id = dtpd.tmp_id  
         GROUP BY (tmp.tpc_id,TMP_NAME, dtp.dtp_date)) d1, fb_teamadeproductcategory tpc  
  WHERE (tpc.tpc_id = d1.tpc_id)  
 GROUP BY (tpc.tpc_manid, TMP_NAME, pludate) HAVING SUM (qty) <> 0  
 union all 
 select  'UNSORTED','ALL', tpc_manid, null, PT_DATE, sum(nvl(PT_QUANTITY,0)) 
 from fb_packteatransfer a, fb_teamadeproductcategory b
 where a.tpc_id = b.tpc_id and pt_trantype = 'R' group by a.TPC_ID, tpc_manid, PT_DATE  
 UNION ALL 
 SELECT 'PACKED', 'ALL', tpc.tpc_manid,TMP_NAME,  pludate, SUM (qty)  
   FROM (SELECT tmp.tpc_id tpc_id,TMP_NAME, dtp.dtp_date pludate, NVL(SUM((dtpd.dtpd_srnoend - dtpd.dtpd_srnostart + 1 ) * dtpd.dtpd_indwt ), 0 ) qty  
           FROM fb_dailyteapacked dtp, fb_dtpdetails dtpd,fb_teamadeproduct tmp  
          WHERE dtp.dtp_id = dtpd.dtp_id AND tmp.tmp_id = dtpd.tmp_id  
         GROUP BY (tmp.tpc_id,TMP_NAME, dtp.dtp_date)  
         UNION ALL  
         SELECT tmp.tpc_id tpc_id,TMP_NAME, si.si_date pludate, -NVL (SUM((SID.sid_srnoend - SID.sid_srnostart + 1) * dtpd.dtpd_indwt ),0) qty  
           FROM fb_dtpdetails dtpd LEFT OUTER JOIN fb_sidetails SID ON dtpd.dtpd_id = SID.dtpd_id LEFT OUTER JOIN fb_saleinvoice si ON SID.si_id = si.si_id,fb_teamadeproduct tmp  
          WHERE dtpd.tmp_id = tmp.tmp_id AND si.si_active = '1'  
          GROUP BY (tmp.tpc_id,TMP_NAME, si.si_date)) d1, fb_teamadeproductcategory tpc  
  WHERE (tpc.tpc_id = d1.tpc_id) 
 GROUP BY (tpc.tpc_manid,TMP_NAME, pludate)  
 HAVING SUM (qty) <> 0) 
where trunc(pludate) <=  trunc(sysdate)
group by grade, category, recty
HAVING sum(decode(sign(trunc(pludate) - trunc(sysdate)),1,0,QUANTITY)) <> 0                      
union all
select to_char(DDP_DT,'dd/mm/yyyy') , upper(:gs_garden_snm), 'A', 'CATTM' ty, null,0,sum(nvl(DDU_QUANTITY,0)) ,0, :gs_user,to_char(sysdate,'dd/mm/yyyy'), null TMP_Name, tpc_name, DDP_SEASON
from fb_dailydryerproduct,fb_dailydryerunsorted, fb_teamadeproductcategory
where  fb_dailydryerproduct.DDP_PK = fb_dailydryerunsorted.DDP_PK AND fb_dailydryerunsorted.TPC_ID = fb_teamadeproductcategory.TPC_ID and ddp_type <> 'O' and DDP_DT >= to_date(:ls_st_dt,'dd/mm/yyyy')
group by DDP_DT , upper(:gs_garden_snm), 'A', 'CATTM', tpc_name, DDP_SEASON
order by 1; 
			
 open c1;
 if sqlca.sqlcode = -1 then
	messagebox('Sql Error During Opening Cursor !',sqlca.sqlerrtext)
	return 1
 elseif sqlca.sqlcode = 0 then
   fetch c1 into :ls_dt, :ls_gsn, :ls_ind, :ls_recind, :ls_desc, :ld_glqty, :ld_teamade, :ld_amt, :ls_entry_by, :ls_entry_dt, :ls_grade, :ls_cat,:ll_season;

	do while sqlca.sqlcode <> 100
		
		
		if isnull(ls_dt) then; ls_dt=""; end if;
		if isnull(ls_gsn) then; ls_gsn=""; end if;
		if isnull(ls_ind) then; ls_ind=""; end if;	
		if isnull(ls_recind) then; ls_recind=""; end if;		
   		if isnull(ls_desc) then; ls_desc =""; end if;
		if isnull(ld_glqty) then; ld_glqty = 0; end if;
		if isnull(ld_teamade) then; ld_teamade = 0; end if;
		if isnull(ld_amt) then; ld_amt = 0; end if;
		if isnull(ls_entry_by) then; ls_entry_by=""; end if;
		if isnull(ls_entry_dt) then; ls_entry_dt=""; end if;
		if isnull(ls_cat) then; ls_cat=""; end if;
		if isnull(ls_grade) then; ls_grade=""; end if;
		if isnull(ll_season) then; ll_season=0; end if;
		
		if pos(ls_desc,",") > 0 then; ls_desc = replace(ls_desc,pos(ls_desc,","),1," "); end if;
		
		if ls_dt="" then  ls_rec = "," else	ls_rec = ls_dt + ","
		ls_rec = ls_rec + ls_gsn +","+ls_ind+","+ls_recind+","+ls_desc+","+string(ld_glqty)+","+string(ld_teamade)+","+string(ld_amt)+","+ls_entry_by+","
		if ls_entry_dt = "" then ls_rec = ls_rec + "," else	ls_rec = ls_rec+ls_entry_dt+","
		ls_rec =ls_rec +ls_grade +","+  ls_cat+","+string(ll_season)
		
		filewrite(li_filenum,ls_rec)
		
		li_rec++
		li_ctr++
		
		setnull(ls_rec);setnull(ls_dt);setnull(ls_gsn);setnull(ls_ind);setnull(ls_recind);setnull(ls_desc);setnull(ls_entry_by);setnull(ls_entry_dt);setnull(ls_cat);setnull(ls_grade);
		ld_glqty = 0; ld_teamade = 0; ld_amt = 0; ll_season = 0;
	
    fetch c1 into :ls_dt, :ls_gsn, :ls_ind, :ls_recind, :ls_desc, :ld_glqty, :ld_teamade, :ld_amt, :ls_entry_by, :ls_entry_dt, :ls_grade, :ls_cat,:ll_season;
   
   loop
	close c1;
else
	messagebox('Error: During Opening of Cursor',sqlca.sqlerrtext)
	return -1
end if

	fileclose(li_filenum) 

setpointer(arrow!) 
messagebox('Confirmation','Total No Of Records : '+string(li_ctr))
return 1

end event

type st_2 from statictext within w_csvexport_trail
integer x = 210
integer y = 280
integer width = 626
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Trail && Expense As On"
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_csvexport_trail
integer x = 855
integer y = 264
integer width = 512
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2024-11-05"), Time("13:31:30.000000"))
integer textsize = -10
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type ddlb_1 from dropdownlistbox within w_csvexport_trail
integer x = 375
integer y = 60
integer width = 1166
integer height = 496
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//if upper(left(gs_user_nm,2)) <> 'NP' and upper(left(gs_user_nm,2)) <> 'MV' and upper(left(gs_user_nm,2)) <> 'LU' and gs_opt <> 'HO' then
	
	ls_snm = left(right(ddlb_1.text,3),2)

	ls_USERNAME = lower(ls_snm)+"ote"
	ls_password = lower(ls_snm)+"ote"
	
	disconnect using sqlca;
	
	
	SQLCA.DBMS = "O10 Oracle10g (10.1.0)"
//	SQLCA.ServerName = "ltcdbho"
	SQLCA.ServerName = "ltcdb"
	SQLCA.LogPass = ls_USERNAME
	SQLCA.LogId = ls_password
	SQLCA.AutoCommit = False 
	SQLCA.DBParm = ""
	connect using sqlca;
	if sqlca.sqlcode = -1 then
		messagebox('SQL Error: During Connection At HO : ',sqlca.sqlerrtext)
		return 1
	end if
//end if

gs_garden_snm = ls_snm
end event

type st_1 from statictext within w_csvexport_trail
integer x = 78
integer y = 60
integer width = 261
integer height = 88
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Garden"
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_csvexport_trail
integer x = 603
integer y = 504
integer width = 466
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "ALL"
boolean automatic = false
end type

event clicked;string ls_asondt

ls_asondt = string(dp_1.value,'dd/mm/yyyy') 

string  fy_st_dt,fy_end_dt

select to_char(to_date('01/04'||decode(sign(to_number(to_char(to_date(:ls_asondt,'dd/mm/yyyy'),'mm'))-4),-1,decode(sign(to_number(to_char(to_date(:ls_asondt,'dd/mm/yyyy'),'mm'))-3),1,0,to_number(to_char(to_date(:ls_asondt,'dd/mm/yyyy'),'YYYY'))-1),to_number(to_char(to_date(:ls_asondt,'dd/mm/yyyy'),'YYYY'))),'dd/mm/yyyy'),'dd/mm/yyyy') fy_stdt ,
		to_char(to_date('31/03'||(decode(sign(to_number(to_char(to_date(:ls_asondt,'dd/mm/yyyy'),'mm'))-4),-1,decode(sign(to_number(to_char(to_date(:ls_asondt,'dd/mm/yyyy'),'mm'))-3),1,0,to_number(to_char(to_date(:ls_asondt,'dd/mm/yyyy'),'YYYY'))-1),to_number(to_char(to_date(:ls_asondt,'dd/mm/yyyy'),'YYYY')))+1),'dd/mm/yyyy'),'dd/mm/yyyy') fy_enddt
		into :fy_st_dt,:fy_end_dt
  from dual;
  
 select  sum(decode(ty,'mes',amount,0)) - sum(decode(ty,'vou',amount,0)) diff into :ld_diff
from ( select de_date,'mes' ty,ACSUBLEDGER_ID,a.EACSUBHEAD_ID, sum(nvl(DE_SALARYTODAYTY,0)+nvl(DE_WAGESTODAYTY,0)+nvl(DE_STORESTODAYTY,0)+nvl(DE_OTHERSTODAYTY,0)) amount
           from FB_DAILYEXPENSE a,fb_expenseacsubhead b,fb_acsubledger c
         where a.EACSUBHEAD_ID=b.EACSUBHEAD_ID and b.EACHEAD_ID=c.ACSUBLEDGER_ID and c.ACLEDGER_ID in('LEG0015') and
                   trunc(DE_DATE) between to_date(:fy_st_dt,'dd/mm/yyyy') and to_date(:ls_asondt,'dd/mm/yyyy')
         group by de_date,ACSUBLEDGER_ID,a.EACSUBHEAD_ID
         union all
         select vh_vou_date,'vou',VD_SGL_CD,VD_EXPSUBHEAD,sum(decode(VD_DC_IND,'D',1,-1)* nvl(VD_AMOUNT,0)) amount
          from fb_vou_head, fb_vou_det
        where VH_DOC_SRL=VD_DOC_SRL and VD_GL_CD in ('LEG0015') and trunc(VH_VOU_DATE) between to_date(:fy_st_dt,'dd/mm/yyyy') and to_date(:ls_asondt,'dd/mm/yyyy')
         group by vh_vou_date,VD_SGL_CD,VD_EXPSUBHEAD)
having sum(decode(ty,'mes',amount,0)) - sum(decode(ty,'vou',amount,0)) <> 0;

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error During Getting Mes Vou Diff !',sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 0 then
	if isnull(ld_diff) then ld_diff = 0;
	if ld_diff > 2 or ld_diff < -2 then
		messagebox('Warning !!!', 'There Is Difference In Trail and Revenue Expenditure, Please Resolve First !!!')
		rollback using sqlca;
		return 1
	end if
end if

rb_113.triggerevent(clicked!)
rb_114.triggerevent(clicked!)
rb_3.triggerevent(clicked!)
rb_2.triggerevent(clicked!)
rb_4.triggerevent(clicked!)

setpointer(arrow!) 
messagebox('Confirmation','Five File Generated At C:\temp For Trail, Expesnse, MIS Teamade, MIS Expense and Store Items, Please Send all of them to HO !!!')
return 1		





end event

type rb_113 from radiobutton within w_csvexport_trail
boolean visible = false
integer x = 581
integer y = 788
integer width = 448
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Trial"
boolean automatic = false
end type

event clicked;string ls_rec, ls_dt, ls_gsn, ls_ind, ls_gl_cd, ls_gl_name,ls_frym, ls_ym
double ld_dr_cls, ld_cr_cls
integer li_filenum, li_rec, li_ctr 

li_ctr=0;
setpointer(hourglass!) 

setnull(ls_ym); setnull(ls_rec);setnull(ls_gsn);setnull(ls_gl_cd);setnull(ls_gl_name);
ld_dr_cls = 0; ld_cr_cls = 0;

ls_frym = string(dp_1.value,'dd/mm/yyyy')

//ls_stym = f_get_fin_stdt()

//ls_st_dt = '01/'+right(ls_stym,2)+'/'+left(ls_stym,4)

string  fy_st_dt,fy_end_dt

select to_char(to_date('01/04'||decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-4),-1,decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-3),1,0,to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY'))-1),to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY'))),'dd/mm/yyyy'),'dd/mm/yyyy') fy_stdt ,
		to_char(to_date('31/03'||(decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-4),-1,decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-3),1,0,to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY'))-1),to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY')))+1),'dd/mm/yyyy'),'dd/mm/yyyy') fy_enddt
		into :fy_st_dt,:fy_end_dt
  from dual;
  
// select  sum(decode(ty,'mes',amount,0)) - sum(decode(ty,'vou',amount,0)) diff into :ld_diff
//from ( select de_date,'mes' ty,ACSUBLEDGER_ID,a.EACSUBHEAD_ID, sum(nvl(DE_SALARYTODAYTY,0)+nvl(DE_WAGESTODAYTY,0)+nvl(DE_STORESTODAYTY,0)+nvl(DE_OTHERSTODAYTY,0)) amount
//           from FB_DAILYEXPENSE a,fb_expenseacsubhead b,fb_acsubledger c
//         where a.EACSUBHEAD_ID=b.EACSUBHEAD_ID and b.EACHEAD_ID=c.ACSUBLEDGER_ID and c.ACLEDGER_ID in('LEG0015') and
//                   trunc(DE_DATE) between to_date(:fy_st_dt,'dd/mm/yyyy') and to_date(:ls_frym,'dd/mm/yyyy')
//         group by de_date,ACSUBLEDGER_ID,a.EACSUBHEAD_ID
//         union all
//         select vh_vou_date,'vou',VD_SGL_CD,VD_EXPSUBHEAD,sum(decode(VD_DC_IND,'D',1,-1)* nvl(VD_AMOUNT,0)) amount
//          from fb_vou_head, fb_vou_det
//        where VH_DOC_SRL=VD_DOC_SRL and VD_GL_CD in ('LEG0015') and trunc(VH_VOU_DATE) between to_date(:fy_st_dt,'dd/mm/yyyy') and to_date(:ls_frym,'dd/mm/yyyy') 
//         group by vh_vou_date,VD_SGL_CD,VD_EXPSUBHEAD)
//having sum(decode(ty,'mes',amount,0)) - sum(decode(ty,'vou',amount,0)) <> 0;
//
//if sqlca.sqlcode = -1 then 
//	messagebox('Sql Error During Getting Mes Vou Diff !',sqlca.sqlerrtext)
//	return 1
//elseif sqlca.sqlcode = 0 then
//	if isnull(ld_diff) then ld_diff = 0;
//	if ld_diff <> 0 then
//		messagebox('Warning !!!', 'There Id Difference In Trail and Revinue Expenditure, Please Resolve First !!!')
//		rollback using sqlca;
//		return 1
//	end if
//end if

If not DirectoryExists ("c:\temp") Then
	CreateDirectory ("c:\temp")
End If

if fileexists("c:\temp\trail_"+gs_garden_snm+".csv") = true then
	filedelete("c:\temp\trail_"+gs_garden_snm+".csv")
end if

li_filenum =  fileopen("c:\temp\trail_"+gs_garden_snm+".csv",linemode!,write!,lockreadwrite!,replace!)

DECLARE c1 CURSOR FOR
SELECT to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYYMM'), :gs_garden_snm,VD_GL_CD gl_code,initcap(a.ACLEDGER_NAME) gl_desc,
    sum(decode(a.ACLEDGER_CUMLATIVE_IND,'C',decode(a.ACLEDGER_ACTYPE,'A',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),'E',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),0),
                                                  'H',decode(trunc(VH_VOU_DATE),to_date(:fy_end_dt,'dd/mm/yyyy'),0,decode(a.ACLEDGER_ACTYPE,'A',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),'E',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),0)),
                                                        decode(sign(trunc(VH_VOU_DATE)- to_date(:fy_st_dt,'dd/mm/yyyy')),-1,0,decode(a.ACLEDGER_ACTYPE,'A',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),'E',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),0)))) dr_cols,
    sum(decode(a.ACLEDGER_CUMLATIVE_IND,'C',decode(a.ACLEDGER_ACTYPE,'L',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),'I',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),0),
                                                  'H',decode(trunc(VH_VOU_DATE),to_date(:fy_end_dt,'dd/mm/yyyy'),0,decode(a.ACLEDGER_ACTYPE,'L',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),'I',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),0)),
                                                        decode(sign(trunc(VH_VOU_DATE) - to_date(:fy_st_dt,'dd/mm/yyyy')),-1,0,decode(a.ACLEDGER_ACTYPE,'L',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),'I',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),0)))) cr_cols    
from FB_ACLEDGER a,fb_vou_head,Fb_vou_DET
where VH_DOC_SRL = vd_doc_srl and vd_gl_cd = ACLEDGER_ID AND 
   trunc(VH_VOU_DATE) <= to_date(:ls_frym,'dd/mm/yyyy') and VH_APPROVED_DT is not null
group by to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYYMM'), :gs_garden_snm,VD_GL_CD ,initcap(a.ACLEDGER_NAME); 
			
 open c1;
 if sqlca.sqlcode = -1 then 
	messagebox('Sql Error During Opening Cursor !',sqlca.sqlerrtext)
	return 1
 elseif sqlca.sqlcode = 0 then
   fetch c1 into :ls_ym,:ls_gsn,:ls_gl_cd, :ls_gl_name, :ld_dr_cls, :ld_cr_cls;

	do while sqlca.sqlcode <> 100
		
		
		if isnull(ls_gsn) then; ls_gsn=""; end if;
		if isnull(ls_ym) then; ls_ym=""; end if;
		if isnull(ls_gl_cd) then; ls_gl_cd=""; end if;		
   		if isnull(ls_gl_name) then; ls_gl_name =""; end if;
		if isnull(ld_dr_cls) then; ld_dr_cls = 0; end if;
		if isnull(ld_cr_cls) then; ld_cr_cls = 0; end if;
		
		if pos(ls_gl_name,",") > 0 then
			do while pos(ls_gl_name,",") > 0
				ls_gl_name = replace(ls_gl_name,pos(ls_gl_name,","),1," "); 
			loop
		end if;

		
//		if pos(ls_gl_name,",") > 0 then; ls_gl_name = replace(ls_gl_name,pos(ls_gl_name,","),1," "); end if;
		
//		if ls_dt="" then  ls_rec = "," else	ls_rec = ls_dt + ","
		ls_rec = ls_ym+ "," + ls_gsn +","+ls_gl_cd+","+ls_gl_name+","+string(ld_dr_cls)+","+string(ld_cr_cls)+","+"T"

		
		filewrite(li_filenum,ls_rec)
		
		li_rec++
		li_ctr++
		
				setnull(ls_ym); setnull(ls_rec);setnull(ls_gsn);setnull(ls_gl_cd);setnull(ls_gl_name);
				ld_dr_cls = 0; ld_cr_cls = 0;
	
   fetch c1 into :ls_ym,:ls_gsn,:ls_gl_cd, :ls_gl_name, :ld_dr_cls, :ld_cr_cls;
   
   loop
	close c1;
else
	messagebox('Error: During Opening of Cursor',sqlca.sqlerrtext)
	return -1
end if

	fileclose(li_filenum) 

setpointer(arrow!) 
messagebox('Confirmation','Total No Of Records : '+string(li_ctr))
return 1

end event

type rb_114 from radiobutton within w_csvexport_trail
boolean visible = false
integer x = 581
integer y = 876
integer width = 466
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "MES"
boolean automatic = false
end type

event clicked;string ls_rec, ls_dt, ls_gsn, ls_ind, ls_exphead_cd, ls_exphead_nm, ls_ym
double ld_value
integer li_filenum, li_rec, li_ctr 
li_ctr=0;
setpointer(hourglass!) 

setnull(ls_ym); setnull(ls_rec);setnull(ls_gsn);setnull(ls_exphead_cd);setnull(ls_exphead_nm);
ld_value = 0; 

//ls_stym = f_get_fin_stdt()

//ls_st_dt = '01/'+right(ls_stym,2)+'/'+left(ls_stym,4)

string ls_asondt

ls_asondt = string(dp_1.value,'dd/mm/yyyy') 

string  fy_st_dt,fy_end_dt

select to_char(to_date('01/04'||decode(sign(to_number(to_char(to_date(:ls_asondt,'dd/mm/yyyy'),'mm'))-4),-1,decode(sign(to_number(to_char(to_date(:ls_asondt,'dd/mm/yyyy'),'mm'))-3),1,0,to_number(to_char(to_date(:ls_asondt,'dd/mm/yyyy'),'YYYY'))-1),to_number(to_char(to_date(:ls_asondt,'dd/mm/yyyy'),'YYYY'))),'dd/mm/yyyy'),'dd/mm/yyyy') fy_stdt ,
		to_char(to_date('31/03'||(decode(sign(to_number(to_char(to_date(:ls_asondt,'dd/mm/yyyy'),'mm'))-4),-1,decode(sign(to_number(to_char(to_date(:ls_asondt,'dd/mm/yyyy'),'mm'))-3),1,0,to_number(to_char(to_date(:ls_asondt,'dd/mm/yyyy'),'YYYY'))-1),to_number(to_char(to_date(:ls_asondt,'dd/mm/yyyy'),'YYYY')))+1),'dd/mm/yyyy'),'dd/mm/yyyy') fy_enddt
		into :fy_st_dt,:fy_end_dt
  from dual;
  
// select  sum(decode(ty,'mes',amount,0)) - sum(decode(ty,'vou',amount,0)) diff into :ld_diff
//from ( select de_date,'mes' ty,ACSUBLEDGER_ID,a.EACSUBHEAD_ID, sum(nvl(DE_SALARYTODAYTY,0)+nvl(DE_WAGESTODAYTY,0)+nvl(DE_STORESTODAYTY,0)+nvl(DE_OTHERSTODAYTY,0)) amount
//           from FB_DAILYEXPENSE a,fb_expenseacsubhead b,fb_acsubledger c
//         where a.EACSUBHEAD_ID=b.EACSUBHEAD_ID and b.EACHEAD_ID=c.ACSUBLEDGER_ID and c.ACLEDGER_ID in('LEG0015') and
//                   trunc(DE_DATE) between to_date(:fy_st_dt,'dd/mm/yyyy') and to_date(:ls_asondt,'dd/mm/yyyy')
//         group by de_date,ACSUBLEDGER_ID,a.EACSUBHEAD_ID
//         union all
//         select vh_vou_date,'vou',VD_SGL_CD,VD_EXPSUBHEAD,sum(decode(VD_DC_IND,'D',1,-1)* nvl(VD_AMOUNT,0)) amount
//          from fb_vou_head, fb_vou_det
//        where VH_DOC_SRL=VD_DOC_SRL and VD_GL_CD in ('LEG0015') and trunc(VH_VOU_DATE) between to_date(:fy_st_dt,'dd/mm/yyyy') and to_date(:ls_asondt,'dd/mm/yyyy')
//         group by vh_vou_date,VD_SGL_CD,VD_EXPSUBHEAD)
//having sum(decode(ty,'mes',amount,0)) - sum(decode(ty,'vou',amount,0)) <> 0;
//
//if sqlca.sqlcode = -1 then 
//	messagebox('Sql Error During Getting Mes Vou Diff !',sqlca.sqlerrtext)
//	return 1
//elseif sqlca.sqlcode = 0 then
//	if isnull(ld_diff) then ld_diff = 0;
//	if ld_diff <> 0 then
//		messagebox('Warning !!!', 'There Id Difference In Trail and Revinue Expenditure, Please Resolve First !!!')
//		rollback using sqlca;
//		return 1
//	end if
//end if


If not DirectoryExists ("c:\temp") Then
	CreateDirectory ("c:\temp")
End If

if fileexists("c:\temp\mis_"+gs_garden_snm+".csv") = true then
	filedelete("c:\temp\mis_"+gs_garden_snm+".csv")
end if

li_filenum =  fileopen("c:\temp\mis_"+gs_garden_snm+".csv",linemode!,write!,lockreadwrite!,replace!)

DECLARE c1 CURSOR FOR
select  to_char(to_date(:ls_asondt,'dd/mm/yyyy'),'YYYYMM'), :gs_garden_snm,EACHEAD_ID, initcap(ACSUBLEDGER_NAME) ACSUBLEDGER_NAME, sum(nvl(DE_SALARYTODAYTY,0) + nvl(DE_WAGESTODAYTY,0) + nvl(DE_STORESTODAYTY,0) + nvl(DE_OTHERSTODAYTY,0)) amt
from fb_dailyexpense a, FB_EXPENSEACSUBHEAD b, fb_acsubledger c
where a.EACSUBHEAD_ID = b.EACSUBHEAD_ID and b.EACHEAD_ID = ACSUBLEDGER_ID and ACLEDGER_ID = 'LEG0015' and de_date between to_date((decode(sign(to_number(to_char(to_date(:ls_asondt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_asondt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_asondt,'dd/mm/yyyy'),'yyyy')))||'0401'),'yyyymmdd') AND to_date(:ls_asondt,'dd/mm/yyyy')
group by to_char(to_date(:ls_asondt,'dd/mm/yyyy'),'YYYYMM'), :gs_garden_snm,EACHEAD_ID, initcap(ACSUBLEDGER_NAME)
order by 1; 
			
 open c1;
 if sqlca.sqlcode = -1 then
	messagebox('Sql Error During Opening Cursor !',sqlca.sqlerrtext)
	return 1
 elseif sqlca.sqlcode = 0 then
   fetch c1 into :ls_ym,:ls_gsn, :ls_exphead_cd, :ls_exphead_nm, :ld_value;

	do while sqlca.sqlcode <> 100
		
		
		if isnull(ls_ym) then; ls_ym=""; end if;
		if isnull(ls_gsn) then; ls_gsn=""; end if;
		if isnull(ls_exphead_cd) then; ls_exphead_cd=""; end if;	
		if isnull(ls_exphead_nm) then; ls_exphead_nm=""; end if;		
		if isnull(ld_value) then; ld_value = 0; end if;

		
		if pos(ls_exphead_nm,",") > 0 then
			do while pos(ls_exphead_nm,",") > 0
				ls_exphead_nm = replace(ls_exphead_nm,pos(ls_exphead_nm,","),1," "); 
			loop
		end if;
		
		ls_rec = ls_ym+ "," + ls_gsn +","+ls_exphead_cd+","+ls_exphead_nm+","+string(ld_value)+","+"E"

		
		filewrite(li_filenum,ls_rec)
		
		li_rec++
		li_ctr++
		
		setnull(ls_ym); setnull(ls_rec);setnull(ls_exphead_cd);setnull(ls_exphead_nm);
		ld_value = 0;
	
    fetch c1 into  :ls_ym,:ls_gsn, :ls_exphead_cd, :ls_exphead_nm, :ld_value;
   
   loop
	close c1;
else
	messagebox('Error: During Opening of Cursor',sqlca.sqlerrtext)
	return -1
end if

	fileclose(li_filenum) 

setpointer(arrow!) 
messagebox('Confirmation','Total No Of Records : '+string(li_ctr))
return 1

end event

type cb_4 from commandbutton within w_csvexport_trail
integer x = 654
integer y = 696
integer width = 297
integer height = 96
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;IF MessageBox("Exit Alert", 'Do You Want To Exit....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	close(parent)
else
	return
end if

end event

type gb_1 from groupbox within w_csvexport_trail
integer x = 425
integer y = 428
integer width = 795
integer height = 196
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

