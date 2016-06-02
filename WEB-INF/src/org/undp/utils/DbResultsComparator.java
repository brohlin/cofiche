// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 5/6/2013 4:05:18 PM
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   DbResults.java

package org.undp.utils;

import java.util.Comparator;

// Referenced classes of package org.uclbp.utils:
//            DbResultsSortCrit

class DbResultsComparator
    implements Comparator
{

    public DbResultsComparator(Comparator aCrit[])
    {
        vCrit = aCrit;
    }

    public DbResultsComparator(int aCrit[])
    {
        if(aCrit.length % 3 != 0)
            throw new IllegalArgumentException("DbResultsComparator: Sort criteria array must have multiples of 3 elements in it.");
        vCrit = new DbResultsSortCrit[aCrit.length / 3];
        for(int x = 0; x < aCrit.length / 3; x++)
            vCrit[x] = new DbResultsSortCrit(aCrit[x * 3], aCrit[x * 3 + 1], aCrit[x * 3 + 2]);

    }

    public int compare(Object sLeft, Object sRight)
    {
        for(int x = 0; x < vCrit.length; x++)
        {
            int sVal = vCrit[x].compare(sLeft, sRight);
            if(sVal != 0)
                return sVal;
        }

        return 0;
    }

    Comparator vCrit[];
}
