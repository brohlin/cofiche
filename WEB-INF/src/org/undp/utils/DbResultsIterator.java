// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 5/6/2013 4:05:25 PM
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   DbResults.java

package org.undp.utils;

import java.util.Iterator;

// Referenced classes of package org.uclbp.utils:
//            DbResults

class DbResultsIterator
    implements Iterator
{

    protected DbResultsIterator(DbResults aRes)
    {
        vRes = aRes;
        vPos = -1;
    }

    public boolean hasNext()
    {
        return vPos + 1 < vRes.getRowCount();
    }

    public Object next()
    {
        vPos++;
        return vRes.getRow(vPos);
    }

    public void remove()
    {
        throw new UnsupportedOperationException("Method remove() not yet implemented.");
    }

    private DbResults vRes;
    private int vPos;
}
