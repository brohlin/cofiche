// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 5/6/2013 4:06:38 PM
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   DynObjectArray.java

package org.undp.utils.arrays;

import java.io.Serializable;
import java.util.Collection;
import java.util.Iterator;

// Referenced classes of package org.uclbp.utils.arrays:
//            DynObjectArrayIterator

public class DynObjectArray
    implements Collection, Serializable
{

    protected Object[] getArr()
    {
        return vArr;
    }

    public DynObjectArray()
    {
        vAllocAmt = 4;
        vCur = 0;
        vArr = new Object[vAllocAmt];
    }

    public boolean add(Object aVal)
    {
        if(vCur == vAllocAmt)
        {
            vAllocAmt <<= 1;
            Object sArr[] = new Object[vAllocAmt];
            System.arraycopy(((Object) (vArr)), 0, ((Object) (sArr)), 0, vArr.length);
            vArr = sArr;
        }
        vArr[vCur++] = aVal;
        return true;
    }

    public Object get(int aIdx)
    {
        return vArr[aIdx];
    }

    public int size()
    {
        return vCur;
    }

    public boolean isEmpty()
    {
        return vCur == 0;
    }

    public boolean contains(Object o)
    {
        if(o == null)
            return false;
        if(vCur == 0)
            return false;
        for(int x = 0; x < vCur; x++)
            if(vArr[x] != null && vArr[x].equals(o))
                return true;

        return false;
    }

    public Iterator iterator()
    {
        return DynObjectArrayIterator.create(this);
    }

    public Object[] toArray()
    {
        Object sRet[] = new Object[vCur];
        for(int x = 0; x < vCur; x++)
            sRet[x] = vArr[x];

        return sRet;
    }

    public Object[] toArray(Object a[])
    {
        throw new UnsupportedOperationException("Method toArray(Object[]) not yet implemented.");
    }

    public boolean remove(Object o)
    {
        throw new UnsupportedOperationException("Method remove() not yet implemented.");
    }

    public boolean containsAll(Collection c)
    {
        throw new UnsupportedOperationException("Method containsAll() not yet implemented.");
    }

    public boolean addAll(Collection c)
    {
        for(Iterator sIter = c.iterator(); sIter.hasNext(); add(sIter.next()));
        return true;
    }

    public boolean removeAll(Collection c)
    {
        throw new UnsupportedOperationException("Method removeAll() not yet implemented.");
    }

    public boolean retainAll(Collection c)
    {
        throw new UnsupportedOperationException("Method retainAll() not yet implemented.");
    }

    public void clear()
    {
        vAllocAmt = 4;
        vArr = new Object[vAllocAmt];
        vCur = 0;
    }

    public boolean equals(Object o)
    {
        return o == this;
    }

    private Object vArr[];
    private int vAllocAmt;
    private int vCur;
}
