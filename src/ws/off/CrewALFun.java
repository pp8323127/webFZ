package ws.off;

import java.io.*;
import java.sql.*;
import java.text.*;
import java.util.*;

import ci.db.*;

import ws.*;
import ws.crew.*;
import eg.off.*;
import eg.off.quota.*;

public class CrewALFun
{

    /**
     * @param args
     */
    private CrewALRObj crewALAL = null;
    private CrewALQuotaRObj crewQuotaAL = null;
    private OffTypeObj offTyep = null;
    private CrewOffListRObj crewOffsAL = null;
    
    ArrayList objAL = null;
    
    public static void main(String[] args)
    {
        // TODO Auto-generated method stub
        CrewALFun fun = new CrewALFun();
        fun.OffsList("2013", "633020", "1");
//        ArrayList objAL = new ArrayList();
//        ArrayList objAL2 = new ArrayList();
//        OffType offtype = new OffType();
//        objAL = null;
//        offtype.offData();
//        objAL = offtype.getObjAL();
//        if(objAL.size()>0){
//            OffTypeObj obj =null;
//            for(int i=0; i<objAL.size();i++){
//                obj = (OffTypeObj) objAL.get(i);
//                if("0".equals(obj.offcode)){
////                    System.out.println(obj.offcode);
//                    objAL2.add(i);
//                }
//            }
//        }
//        System.out.println(objAL2.size());
//        System.out.println("done");
    }
    //��g OffRecordList();
    public String getOffRecord(String empno, String offcode, String type,String offyear)
    {
        Driver dbDriver = null;
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        objAL = new ArrayList();
        String sql ="";
        String offCodeSql= "";
        String errorstr = "";     
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            
//          EGConnDB cn = new EGConnDB();
//            cn.setORP3EGUserCP(); 
//          java.lang.Class.forName(cn.getDriver());
//          conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());   
            
//          EGConnDB cn = new EGConnDB();
//          cn.setORP3EGUser();   
//          java.lang.Class.forName(cn.getDriver());
//          conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());         
           
            stmt = conn.createStatement();

            //******************************************************************************
            if("ALL".equals(offcode))
            {
                if("1".equals(type)){
                    offCodeSql = " and offtype in ('0','8','16','15','27')";
                }else if ("2".equals(type)){
                    offCodeSql = " and offtype in ('3','5','12','13','14','22','23','25','26')";
                }else{
                    offCodeSql = " and offtype not in ('0','8','16','15','27','3','5','12','13','14','22','23','25','26')";
                }
                sql = " SELECT trim(offno) offno,trim(empn) empn,sern,offtype,To_Char(offsdate,'yyyy/mm/dd') offsdate, " +
                      " To_Char(offedate,'yyyy/mm/dd') offedate, offdays,offftno,station,remark,offyear," +
                      " gradeyear,newuser,to_Char(newdate, 'yyyy/mm/dd hh24:mi:ss') newdate, " +
                      " chguser,to_Char(chgdate, 'yyyy/mm/dd hh24:mi:ss') chgdate, form_num,leaverank," +
                      " reassign, ef_judge_status, ef_judge_user," +
                      " to_Char(ef_judge_tmst, 'yyyy/mm/dd hh24:mi:ss') ef_judge_tmst, ed_inform_user," +
                      " to_Char(ed_inform_tmst, 'yyyy/mm/dd hh24:mi:ss') ed_inform_tmst, doc_status, " +
                      " delete_user, to_Char(delete_tmst, 'yyyy/mm/dd hh24:mi:ss') delete_tmst, " +
                      " to_Char(occur_date, 'yyyy/mm/dd') occurdate, o.relation relationid, f.relation relation " +
                      " FROM egtoffs o, egtfldy f " +
                      " WHERE empn = '"+empno+"' " +offCodeSql+
                      " and offyear = '"+offyear+"' and o.relation = f.flid (+) " +
                      " order by offsdate desc ";
            }

//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            while (rs.next())
            {
                OffsObj obj = new OffsObj();      
                obj.setOffno(rs.getString("offno"));
                obj.setEmpn(rs.getString("empn"));
                obj.setSern(rs.getString("sern"));
                obj.setOfftype(rs.getString("offtype"));
                obj.setOffsdate(rs.getString("offsdate"));
                obj.setOffedate(rs.getString("offedate"));
                obj.setOffdays(rs.getString("offdays"));
                obj.setOffftno(rs.getString("offftno"));
                obj.setStation(rs.getString("station"));
                obj.setRemark(rs.getString("remark"));
                obj.setOffyear(rs.getString("offyear"));
                obj.setGradeyear(rs.getString("gradeyear"));
                obj.setNewuser(rs.getString("newuser"));
                obj.setNewdate(rs.getString("newdate"));
                obj.setChguser(rs.getString("chguser"));
                obj.setChgdate(rs.getString("chgdate"));
                obj.setForm_num(rs.getString("form_num"));
                obj.setRank(rs.getString("leaverank"));
                obj.setReassign(rs.getString("reassign"));
                obj.setEf_judge_status(rs.getString("ef_judge_status"));
                obj.setEf_judge_user(rs.getString("ef_judge_user"));
                obj.setEd_inform_user(rs.getString("ed_inform_user"));
                obj.setEd_inform_tmst(rs.getString("ed_inform_tmst"));
                obj.setDoc_status(rs.getString("doc_status"));
                obj.setDelete_user(rs.getString("delete_user"));
                obj.setDelete_tmst(rs.getString("delete_tmst"));
                obj.setOccur_date(rs.getString("occurdate"));
                obj.setRelation(rs.getString("relation"));
                obj.setRelationid(rs.getString("relationid"));
                objAL.add(obj);
            }
            
            errorstr = "Y";
            //******************************************************************************
        }
        catch ( Exception e )
        {
//            System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
        return errorstr;
    }
        
    //�ӤHAL�O��
    public void ListOfAL(String empno){
        String type = "1";
        String offcode = "ALL";
        crewALAL = new CrewALRObj();
        try
        {
            GregorianCalendar cal = new GregorianCalendar(); 
            String gdyear = Integer.toString(cal.get(Calendar.YEAR));
        
            boolean hasdelete = false;
            //�C��***************************************
            getOffRecord(empno,offcode,type,gdyear);//��g
            crewALAL.setOffsAL(getObjAL());
            // OffsObj obj = new OffsObj();             
            //�Ѿl�Ѽ�************************************
            OffRecordList orl = new OffRecordList();
//          out.println(orl.getSQL()); 
            crewALAL.setUndeduct(orl.getALUndeduct(empno));
            //out.println(orl.getSQL());
            
            //AL�϶�*************************************
            ALPeriod oys = new ALPeriod();      
            if("Y".equals(oys.getALPeriod(empno))){
                crewALAL.setALperiodAL(oys.getObjAL());
                //ALPeriodObj obj = new ALPeriodObj();
            }
            
            //Crew Info*********************************
            CrewEGinfo egi = new CrewEGinfo(empno);
            ArrayList objAL = new ArrayList();
            objAL = egi.getObjAL();
            if(objAL.size()>0)
            {
                CrewBasicObj obj = (CrewBasicObj) objAL.get(0);
                crewALAL.setEgInfo(obj);
            }       
            
            //�����O*iCrew only AL*************************
//            OffType offtype = new OffType();
            objAL = null;
//            offtype.offData();
//            objAL = offtype.getObjAL();
            OffTypeObj obj = new OffTypeObj();
            obj.setOffcode("0");
            obj.setOfftype("AL") ;
            objAL.add(obj);      
            crewALAL.setOffType(objAL);
//            crewALAL.setMsg("�������Ѽ� + �w�а��Ѽ� ���i�j��30��C\n" +
//                            "AL�C���s�򤣱o�W�L����A�ⵧ�����ܤֶ��j�@��C");
//            OffType offtype = new OffType();
//            offtype.offData();
//            objAL = offtype.getObjAL();
//            ArrayList objAL2 = new ArrayList();
//            objAL = null;
//            offtype.offData();
//            objAL = offtype.getObjAL();
//            if(objAL.size()>0){
//                OffTypeObj obj =null;
//                for(int i=0; i<objAL.size();i++){
//                    obj = (OffTypeObj) objAL.get(i);
//                    if("0".equals(obj.offcode)){
////                        System.out.println(obj.offcode);
//                        objAL2.add(i);
//                    }
//                }
//            }
//          crewALAL.setOffType(objAL2);
            //***************************************
//            int sheetNum = 6;//������ƶq        
            crewALAL.setResultMsg("1");
            crewALAL.setErrorMsg("Done.");
        }
        catch ( Exception e )
        {
            // TODO: handle exception
            crewALAL.setResultMsg("0");
            crewALAL.setErrorMsg(e.toString());
        }
        
    }
    
    //AL�`quota
    public void ListALquota(String jobtype,String year,String month){
        crewQuotaAL = new CrewALQuotaRObj();
        try
        {
            ALQuota aq = new ALQuota(year, month, jobtype);
            aq.getQuota();//ALQuotaObj
            aq.setUsedQuota();//ALQuotaObj
            aq.setReleaseQuota();//ALQuotaObj
            ArrayList quotaAL = aq.getObjAL();
            if(null!=quotaAL &&  quotaAL.size() >0){
                ALQuotaObj[] quotaArr = new ALQuotaObj[quotaAL.size()];
                for(int i=0;i<quotaAL.size() ;i++){
                    quotaArr[i] = (ALQuotaObj) quotaAL.get(i); 
                }
                crewQuotaAL.setQuotaArr(quotaArr);
//                crewQuotaAL.setMsg("����ȨѬd�ߡAQuota�H��ڻ��欰�ǡC\n"+
//                                    "��AL Quota���s�A�C�뻼��I���e����22:00~����I���23:59�����A\n" +
//                                    "�T��W�����P�h�^�w�ӽФ�AL�A��l�ɬq���`�@�~�C\n"+
//                                    "�C�뻼��I���e����23:00�A�i�ۦ�W���ӽ�����X�B�פ�AL�C\n");
                crewQuotaAL.setResultMsg("1");
                crewQuotaAL.setErrorMsg("Done.");
            }else{
                crewQuotaAL.setResultMsg("1");
                crewQuotaAL.setErrorMsg("No Data");
            }
        }
        catch ( Exception e )
        {
            crewQuotaAL.setResultMsg("0");
            crewQuotaAL.setErrorMsg(e.toString());
        }       
        
    }
    
    //�e�XAL�ӽ�
    public CrewMsgObj sendAL(String off_type,String empno,String[] offsdate,String[] offedate){
        CrewMsgObj sendObj = new CrewMsgObj();
        
        int sheetNum = offsdate.length;
        if(offsdate.length <0 || offsdate.length>6){
            sendObj.setResultMsg("0");
            sendObj.setErrorMsg("����ƶq���~");            
        }else{
            String[] gdyear = new String[sheetNum];
            String[] str = new String[sheetNum];
            String[] str2 = new String[sheetNum];
            String[] str3 = new String[sheetNum];
            String errMsg = "";
            int flag = 0;//���~
            
            for(int i=0; i<sheetNum ;i++){//no.1-no.6
                //offsdate[i] = request.getParameter("validfrm_"+(i+1));//yyyy/mm/dd
                //offedate[i] = request.getParameter("validto_"+(i+1));//yyyy/mm/dd
                //out.println(offsdate[i]+offedate[i]);
                if(offsdate[i] != null && !offsdate[i].equals("") && offedate[i] != null && !offedate[i].equals("")){
                    ALProgress al = new ALProgress(empno,off_type, offsdate[i],offedate[i],empno);
                    //�Ȱ��G��
                    try { Thread.sleep ( 2000 ) ; } catch (InterruptedException ie){}
                    str[i] = al.crewALCheck();
                    //out.println(str);                
                    if("Y".equals(str[i]))
                    {
                        str2[i] = al.insALRequest();//�s�W
                        if("Y".equals(str2[i]))
                        {
                            gdyear[i] = offsdate[i].substring(0,4);     
                            str3[i] = al.ifTrainInPreviousMonth();
                    
                            if("N".equals(str3[i]))
                            {
                                errMsg += "�˷R���ŪA���A�z�n�I\r\n�z�ҥӽЪ� �m"+offsdate[i].substring(5,7)+"��n";
                                flag = 3;               
                            }
                            else //if("Y".equals(str3))
                            {
                                errMsg += "��"+(i+1)+"��:"+offsdate[i] +" ~ "+ offedate[i]+", AL/XL ���榨�\"+"<br>";
                                //response.sendRedirect("viewoffsheet.jsp?offyear="+gdyear);
                            }
                    
                        }
                        else
                        {
                            //Record Error Log
                            //*************************************************************************************
                            String filename = "iCrewOffErrorLog.txt";        
                            String path = "/apsource/csap/projfz/txtin/off/";
                            FileWriter fwlog = null;
                            flag = 2;
                            try
                            {
                                fwlog = new FileWriter(path+filename,true);
                                java.util.Date runDate1 = Calendar.getInstance().getTime();
                                String time1 = new SimpleDateFormat("yyyy/MM/dd EEE HH:mm:ss a").format(runDate1);
                                fwlog.write("empno : "+empno+" Runtime: "+time1+" Empno : "+empno+" Offdate : "+offsdate[i]+"~"+offedate[i]+" Offtype : "+off_type+"  Error Msg : "+str2[i]+"  \r\n");
                                fwlog.write("*************************************** \r\n");    
                                fwlog.close();
                            }
                            catch (Exception e)
                            {
                                errMsg += e.toString();
                            } 
                            finally
                            {
                                
                            }
                            //*************************************************************************************
                            errMsg +="��"+(i+1)+"��:AL/XL"+offsdate[i] +" ~ "+ offedate[i]+", request failed!! Msg: "+str2[i]+"<br>";
                            //String str1 ="AL/XL request failed!!<br> Msg: "+str2+"!!<br><a href='javascript:history.back(-1)'>back</a>";
                            //response.sendRedirect("sm.jsp?messagestring="+URLEncoder.encode(str1));
                        }
                    }
                    else
                    {
                        //Record Error Log
                        //*************************************************************************************
                        String filename = "iCrewOffErrorLog.txt";        
                        String path = "/apsource/csap/projfz/txtin/off/";
                        FileWriter fwlog = null;
                        flag = 1;
                        try
                        {
                            fwlog = new FileWriter(path+filename,true);
                            java.util.Date runDate1 = Calendar.getInstance().getTime();
                            String time1 = new SimpleDateFormat("yyyy/MM/dd EEE HH:mm:ss a").format(runDate1);
                            fwlog.write("empno : "+empno+" Runtime: "+time1+" Empno : "+empno+" Offdate : "+offsdate[i]+"~"+offedate[i]+" Offtype : "+off_type+"  Error Msg : "+str[i]+"  \r\n");
                            fwlog.write("***************************************\r\n");
                            fwlog.close();
                        }
                        catch (Exception e)
                        {
                            errMsg += e.toString();
                        } 
                        finally
                        {
                              
                        }
                        //*************************************************************************************
                        errMsg += "��"+(i+1)+"��:AL/XL"+offsdate[i] +" ~ "+ offedate[i]+", request failed!! Msg: "+str[i]+"<br>";
                        //String str1 ="AL/XL request failed!!<br> Msg: "+str+"!!<br><a href='javascript:history.back(-1)'>back</a>";
                        //response.sendRedirect("sm.jsp?messagestring="+URLEncoder.encode(str1));
                    }
                }          
            
            }   //for(int i=0; i<sheetNum ;i++){//no.1-no.6
            /*******�C�X�T��******************************************************/
            switch(flag){
                case 0:
                    errMsg += "�e�X�h������,�H�i���~�סj�u����ܡC";
                    sendObj.setResultMsg("1");
                    sendObj.setErrorMsg(errMsg); 
                    //response.sendRedirect("viewoffsheet.jsp?offyear="+gdyear[0]+"&msg="+URLEncoder.encode(errMsg));
                    break;
                case 1:
                    errMsg += "\r\n 1";
                    sendObj.setResultMsg("1");
                    sendObj.setErrorMsg(errMsg); 
                    //errMsg +="<br><a href='javascript:history.back(-1)'>back1</a>";
                    //response.sendRedirect("sm.jsp?messagestring="+URLEncoder.encode(errMsg));
                    break;
                case 2:
                    errMsg += "\r\n 2";
                    sendObj.setResultMsg("1");
                    sendObj.setErrorMsg(errMsg); 
                    //errMsg += "<br><a href='javascript:history.back(-1)'>back2</a>";
                    //response.sendRedirect("sm.jsp?messagestring="+URLEncoder.encode(errMsg));
                    break;
                case 3:                    
                    errMsg +="\r\n����𰲡A�A�{ETS���V����A���F���v�T�z�����v�q\r\n�A�аȥ��P�ŰV������6455�pô�A���e�w�ƨ��V�Ʃy�C";   
                    sendObj.setResultMsg("1");
                    sendObj.setErrorMsg(errMsg); 
                    //window.open('trainMonthChk.jsp?offsdate=<%=offsdate[0]%>','','left=800,top=800,width=10,height=10,scrollbars=yes');
                    //window.location.href="viewoffsheet.jsp?offyear=<%=gdyear[0]%>"; 
              
                    break;
            }
        }
        
        
        return sendObj;
    }
      
    //�d�߰���
    public void OffsList(String gdyear,String empno,String type){
        String offcode = "ALL";
        crewOffsAL = new CrewOffListRObj();
        try
        {            
            getOffRecord(empno,offcode,type,gdyear);
            crewOffsAL.setOffsAL(getObjAL());
            
            if("1".equals(type)){
                OffRecordList orl = new OffRecordList();
                crewOffsAL.setUndeduct(orl.getALUndeduct(empno));
                //AL�϶�***************************************
                ALPeriod oys = new ALPeriod();      
                oys.getALPeriod(empno);
                crewOffsAL.setALperiodAL(oys.getObjAL());
//                crewOffsAL.setMsg("Remark : * -->�w�R������BY --> �w��������BN --> ����������\n " +
//                        " ���n����:\n" +
//                        " * �S�𰲱N��𰲥ͮĤ��Ѧ����C\n" +
//                        " * �������C��1���10�餧�S��,�ݴ��e2�Ӥ�10��(�t10��)�H�e�ӽСC\n" +
//                        " * �������C��11��H�ᤧ�S��,�ݴ��e1�Ӥ�10��(�t10��)�H�e�ӽСC\n" +
//                        " �p��������D�Ь��ŪA��F�C");
            }else{
                for(int i=0; i<objAL.size(); i++)
                {
                    OffsObj obj = (OffsObj) objAL.get(i);
                    if(obj.getEf_judge_status() == null | "Y".equals(obj.getEf_judge_status()))
                    {
                        obj.setEf_judge_status("A");
                    }
                    else if ("N".equals(obj.getEf_judge_status()))
                    {
                        obj.setEf_judge_status("R");
                    }
                    else
                    {
                        obj.setEf_judge_status("P");
                    }
                }
//                crewOffsAL.setMsg("Status : A -->Approved�BR --> Rejected�BP --> Processing");
            }
            //Crew Info*********************************
            CrewEGinfo egi = new CrewEGinfo(empno);
            ArrayList objAL = new ArrayList();
            objAL = egi.getObjAL();
            if(null!=objAL && objAL.size()>0)
            {
                CrewBasicObj obj = (CrewBasicObj) objAL.get(0);
                crewOffsAL.setEgInfo(obj);
            } 
            //***************************************
//            OffType offtype = new OffType();
//            offtype.offData();
            
            crewOffsAL.setResultMsg("1");
            crewOffsAL.setErrorMsg("Done.");
        }
        catch ( Exception e )
        {
            crewOffsAL.setResultMsg("0");
            crewOffsAL.setErrorMsg(e.toString());
        }
        
        
    }
    
    //�R��AL
    public CrewMsgObj DelAL(String[] checkdel,String empno,String offyear){
        //checkdel -> <%=obj.getOffsdate()%><%=obj.getOffedate()%><%=obj.getOffno()%>
        //offyear ->gdyear
        CrewMsgObj updObj = new CrewMsgObj();
        String chkresult = "Y";
        String str = "Y";
        String updresult = "N";
        if (checkdel == null)
        {
            updObj.setResultMsg("0");
            updObj.setErrorMsg("No Delete Offsheet!!");

        }
        else
        {
            //Check deletable
            for(int i =0; i<checkdel.length; i++)
            {
                CancelALCheck calc = new CancelALCheck(empno, checkdel[i].substring(20), checkdel[i].substring(0,10), checkdel[i].substring(10,20), empno);
                String temp_str = calc.getALCheckResult();
                if (!"Y".equals(temp_str))
                {
                    str = temp_str;
                    chkresult = "N";
                }
            }

            //Deletable
            if("Y".equals(str) && "Y".equals(chkresult))
            {
                for(int i =0; i<checkdel.length; i++)
                {
                    ALProgress ap = new ALProgress(empno, "0", checkdel[i].substring(0,10), checkdel[i].substring(10,20), empno);
                    updresult = ap.delALRequest(checkdel[i].substring(20), empno);
                    if(!"Y".equals(updresult))
                    {
                        updObj.setResultMsg("0");
                        updObj.setErrorMsg("Update Result:"+updresult);
                    }               
                }
                updObj.setResultMsg("1");
                updObj.setErrorMsg("Update Result:"+str);
                //response.sendRedirect("viewoffsheet.jsp?offyear="+offyear);
            }
            else
            {
                updObj.setResultMsg("0");
                updObj.setErrorMsg("Cancel AL request failed!!"+str);
            }       
        }
        return updObj;
    }
    

    public CrewALRObj getCrewALAL()
    {
        return crewALAL;
    }
    public void setCrewALAL(CrewALRObj crewALAL)
    {
        this.crewALAL = crewALAL;
    }
    public CrewALQuotaRObj getCrewQuotaAL()
    {
        return crewQuotaAL;
    }
    public void setCrewQuotaAL(CrewALQuotaRObj crewQuotaAL)
    {
        this.crewQuotaAL = crewQuotaAL;
    }

    public CrewOffListRObj getCrewOffsAL()
    {
        return crewOffsAL;
    }

    public void setCrewOffsAL(CrewOffListRObj crewOffsAL)
    {
        this.crewOffsAL = crewOffsAL;
    }
    public OffTypeObj getOffTyep()
    {
        return offTyep;
    }
    public void setOffTyep(OffTypeObj offTyep)
    {
        this.offTyep = offTyep;
    }
    public ArrayList getObjAL()
    {
        return objAL;
    }
    public void setObjAL(ArrayList objAL)
    {
        this.objAL = objAL;
    }
    
    
   

}
