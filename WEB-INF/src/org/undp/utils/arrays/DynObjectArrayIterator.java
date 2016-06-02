// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 5/6/2013 4:06:44 PM
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   DynObjectArrayIterator.java

package org.undp.utils.arrays;

import java.util.Iterator;

// Referenced classes of package org.uclbp.utils.arrays:
//            DynObjectArray

public class DynObjectArrayIterator
    implements Iterator
{

    static DynObjectArrayIterator create(DynObjectArray aArr)
    {
        return new DynObjectArrayIterator(aArr);
    }

    protected DynObjectArrayIterator(DynObjectArray aArr)
    {
        vArr = null;
        vArr = aArr;
        vCur = 0;
    }

    public boolean hasNext()
    {
        return vCur < vArr.size();
    }

    public Object next()
    {
        return vArr.getArr()[vCur++];
    }

    public void remove()
    {
        throw new UnsupportedOperationException("Method remove() not yet implemented.");
    }

    DynObjectArray vArr;
    int vCur;
}
