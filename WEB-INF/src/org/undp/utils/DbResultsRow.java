// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 5/6/2013 4:05:33 PM
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   DbResultsRow.java

package org.undp.utils;

import org.undp.utils.arrays.DynStringArray;

// Referenced classes of package org.uclbp.utils:
//            DbResults

public class DbResultsRow extends DynStringArray
{

    private DbResultsRow()
    {
    }

    public DbResultsRow(DbResults aRes)
    {
        vRes = aRes;
    }

    public String get(String aIdx)
    {
        return get(vRes.getColByName(aIdx));
    }

    private DbResults vRes;
}
