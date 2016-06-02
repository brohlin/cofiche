package org.undp.utils.arrays;

import java.io.Serializable;

public class DynStringArray
    implements Serializable
{
	
    public DynStringArray()
    {
        vAllocAmt = 4;
        vCur = 0;
        vArr = new String[vAllocAmt];
    }

    protected final void realloc()
    {
        if(vCur == vAllocAmt)
        {
            vAllocAmt <<= 1;
            String sArr[] = new String[vAllocAmt];
            System.arraycopy(vArr, 0, sArr, 0, vArr.length);
            vArr = sArr;
        }
    }


    public final void add(String aVal)
    {
        if(vCur == vAllocAmt)
            realloc();
        vArr[vCur++] = aVal;
    }

    public final void clear()
    {
        for(int i = 0; i < vCur; i++)
            vArr[i] = "";

        vCur = 0;
    }

    public final String get(int aIdx)
    {
        if(aIdx < 0)
            throw new IllegalArgumentException();
        if(aIdx >= vArr.length)
            throw new IllegalArgumentException();
        else
            return vArr[aIdx];
    }

    public final int size()
    {
        return vCur;
    }

    public final void insert(int aPos, String aVal)
    {
        if(aPos > vCur)
            throw new IllegalArgumentException("DynStringArray.insert: cannot insert beyond the end of the array.");
        if(aPos == vCur)
        {
            add(aVal);
        } else
        {
            if(vCur == vAllocAmt)
                realloc();
            System.arraycopy(vArr, aPos, vArr, aPos + 1, vCur - aPos);
            vArr[aPos] = aVal;
            vCur++;
        }
    }

    public final void insert(int aPos)
    {
        if(aPos > vCur)
            throw new IllegalArgumentException("DynStringArray.insert: cannot insert beyond the end of the array.");
        if(aPos == vCur)
        {
            add("");
        } else
        {
            if(vCur == vAllocAmt)
                realloc();
            System.arraycopy(vArr, aPos, vArr, aPos + 1, vCur - aPos);
            vArr[aPos] = "";
            vCur++;
        }
    }

    public final String remove(int aPos)
    {
        String sRet = vArr[aPos];
        System.arraycopy(vArr, aPos + 1, vArr, aPos, vCur - aPos);
        vCur--;
        return sRet;
    }

    
    private String vArr[];
    private int vAllocAmt;
    private int vCur;
}
