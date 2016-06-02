// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 5/6/2013 4:06:24 PM
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   DynBooleanArray.java

package org.undp.utils.arrays;


public class DynBooleanArray
{

    public DynBooleanArray()
    {
        vAllocAmt = 4;
        vCur = 0;
        vArr = new boolean[vAllocAmt];
    }

    public void add(boolean aVal)
    {
        if(vCur == vAllocAmt)
        {
            vAllocAmt <<= 1;
            boolean sArr[] = new boolean[vAllocAmt];
            System.arraycopy(vArr, 0, sArr, 0, vArr.length);
            vArr = sArr;
        }
        vArr[vCur++] = aVal;
    }

    public boolean get(int aIdx)
    {
        if(aIdx < 0)
            throw new IllegalArgumentException();
        if(aIdx >= vArr.length)
            throw new IllegalArgumentException();
        else
            return vArr[aIdx];
    }

    public int size()
    {
        return vCur;
    }

    private boolean vArr[];
    private int vAllocAmt;
    private int vCur;
}
