// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 5/6/2013 4:05:40 PM
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   DbResults.java

package org.undp.utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.util.Comparator;
import java.util.Date;

// Referenced classes of package org.uclbp.utils:
//            DbResultsRow

class DbResultsSortCrit
    implements Comparator
{

    public DbResultsSortCrit(int aCol, int aType, boolean aAsc)
    {
        vCol = aCol;
        vType = aType;
        vAsc = aAsc;
    }

    public DbResultsSortCrit(int aCol, int aType, int aAsc)
    {
        vCol = aCol;
        vType = aType;
        vAsc = aAsc == 1;
    }

    int compareString(String aLeft, String aRight)
    {
        return aLeft.compareTo(aRight);
    }

    int compareInt(String aLeft, String aRight)
    {
        int i;
        try
        {
            Integer sLeft = new Integer(aLeft);
            Integer sRight = new Integer(aRight);
            int j = sLeft.compareTo(sRight);
            return j;
        }
        catch(NumberFormatException e)
        {
            i = aLeft.compareTo(aRight);
        }
        return i;
    }

    int compareDouble(String aLeft, String aRight)
    {
        int i;
        try
        {
            Double sLeft = new Double(aLeft);
            Double sRight = new Double(aRight);
            int j = sLeft.compareTo(sRight);
            return j;
        }

        catch(NumberFormatException e)
        {
            i = aLeft.compareTo(aRight);
        }
        return i;
    }

    int compareDate(String aLeft, String aRight)
    {
        int i;
        try
        {
            java.util.Date sLeft = DateFormat.getDateInstance().parse(aLeft);
            java.util.Date sRight = DateFormat.getDateInstance().parse(aRight);
            int j = sLeft.compareTo(sRight);
            return j;
        }
        catch(ParseException e)
        {
            i = aLeft.compareTo(aRight);
        }
        return i;
    }

    public int compare(Object aLeft, Object aRight)
    {
        DbResultsRow sLeftObj = (DbResultsRow)aLeft;
        DbResultsRow sRightObj = (DbResultsRow)aRight;
        String sLeft = sLeftObj.get(vCol);
        String sRight = sRightObj.get(vCol);
        int sRes;
        switch(vType)
        {
        case 1: // '\001'
            sRes = compareInt(sLeft, sRight);
            break;

        case 2: // '\002'
            sRes = compareDouble(sLeft, sRight);
            break;

        case 3: // '\003'
            sRes = compareDate(sLeft, sRight);
            break;

        default:
            sRes = compareString(sLeft, sRight);
            break;
        }
        return vAsc ? sRes : -sRes;
    }

    int vCol;
    int vType;
    boolean vAsc;
}
