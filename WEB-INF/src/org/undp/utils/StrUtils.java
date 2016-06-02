// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 5/6/2013 4:06:08 PM
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   StrUtils.java

package org.undp.utils;

import java.util.StringTokenizer;
import java.util.Vector;

public class StrUtils
{

    public StrUtils()
    {
    }

    public static String replace(String pLine, String pOld, String pNew)
    {
        if(pLine != null && pOld != null && pNew != null)
        {
            int iIndex = 0;
            StringBuffer sb = new StringBuffer(pLine);
            for(; (iIndex = sb.toString().indexOf(pOld, iIndex)) >= 0; iIndex += pNew.length())
                sb.delete(iIndex, iIndex + pOld.length()).insert(iIndex, pNew);

            pLine = sb.toString();
        }
        return pLine;
    }

    public static String stripLeadingTrailingChar(String aStr, char aChar)
    {
        int sStart;
        for(sStart = 0; aStr.charAt(sStart) == aChar; sStart++);
        int sEnd;
        for(sEnd = aStr.length() - 1; aStr.charAt(sEnd) == aChar; sEnd--);
        if(sStart != 0 || sEnd != aStr.length() - 1)
            aStr = aStr.substring(sStart, sEnd + 1);
        return aStr;
    }

    public static String strReplaceAllWith(String aStr, String aFind, String aRepl)
    {
        int sPos;
        while((sPos = aStr.indexOf(aFind)) != -1)
        {
            String sTemp = aStr.substring(0, sPos) + aRepl + aStr.substring(sPos + aFind.length(), aStr.length());
            aStr = sTemp;
        }
        return aStr;
    }

    public static String striReplaceAllWith(String aStr, String aFind, String aRepl)
    {
        String sStr = aStr.toLowerCase();
        String sFind = aFind.toLowerCase();
        int sPos;
        while((sPos = sStr.indexOf(sFind)) != -1)
        {
            String sTemp = aStr.substring(0, sPos) + aRepl + aStr.substring(sPos + aFind.length(), aStr.length());
            aStr = sTemp;
            sTemp = sStr.substring(0, sPos) + aRepl + sStr.substring(sPos + sFind.length(), sStr.length());
            sStr = sTemp;
        }
        return aStr;
    }

    public static boolean stristr(String aStr, String aSubStr)
    {
        return aStr.toLowerCase().indexOf(aSubStr.toLowerCase()) != -1;
    }

    public static Vector parseListToVector(String aStr, String aDelim)
    {
        Vector sVec = new Vector();
        for(StringTokenizer sStr = new StringTokenizer(aStr, aDelim); sStr.hasMoreTokens(); sVec.add(sStr.nextToken()));
        return sVec;
    }

    public static boolean isBarcode(String barcode)
    {
        if(!isEmptyTrim(barcode) && isNumeric(barcode.substring(0, barcode.length() - 1)))
        {
            char endChar = barcode.toUpperCase().charAt(barcode.length() - 1);
            if(Character.isDigit(endChar) || endChar == 'X')
                return true;
        }
        return false;
    }

    public static String[] parseListToArray(String aStr, String aDelim)
    {
        Vector sVec = parseListToVector(aStr, aDelim);
        String sRet[] = new String[sVec.size()];
        for(int x = 0; x < sVec.size(); x++)
            sRet[x] = (String)sVec.get(x);

        return sRet;
    }

    public static String QuoteStr(String aStr)
    {
        return "'" + aStr + "'";
    }

    public static String DQuoteStr(String aStr)
    {
        return "\"" + aStr + "\"";
    }

    public static boolean isNumeric(String aStr)
    {
        for(int i = 0; i < aStr.length(); i++)
            if(!Character.isDigit(aStr.charAt(i)))
                return false;

        return true;
    }

    public static boolean isAlphanumeric(String aStr)
    {
        for(int i = 0; i < aStr.length(); i++)
            if(!Character.isLetterOrDigit(aStr.charAt(i)))
                return false;

        return true;
    }

    public static boolean isAlphabetical(String aStr)
    {
        for(int i = 0; i < aStr.length(); i++)
            if(!Character.isLetter(aStr.charAt(i)))
                return false;

        return true;
    }

    public static boolean isEmpty(String aStr)
    {
        return aStr == null || aStr.equals("");
    }

    public static boolean isEmptyTrim(String aStr)
    {
        return aStr == null || aStr.trim().equals("");
    }

    public static boolean isAlphanumericOrUDD(String aStr)
    {
        for(int i = 0; i < aStr.length(); i++)
            if(!Character.isLetterOrDigit(aStr.charAt(i)) && aStr.charAt(i) != '_' && aStr.charAt(i) != '-' && aStr.charAt(i) != '.')
                return false;

        return true;
    }

    public static boolean isAlphanumericOrSpace(String aStr)
    {
        for(int i = 0; i < aStr.length(); i++)
            if(!Character.isLetterOrDigit(aStr.charAt(i)) && aStr.charAt(i) != ' ')
                return false;

        return true;
    }

    public static boolean isEmailAddress(String aStr)
    {
        if(aStr.length() < 5)
            return false;
        if(!Character.isLetterOrDigit(aStr.charAt(0)))
            return false;
        StringTokenizer st = new StringTokenizer(aStr, "@");
        if(st.countTokens() != 2)
            return false;
        String aHalf = st.nextToken();
        String bHalf = st.nextToken();
        if(bHalf.charAt(0) == '.')
            return false;
        st = new StringTokenizer(bHalf, ".");
        if(st.countTokens() <= 1)
            return false;
        if(!isAlphanumericOrUDD(aHalf.substring(1)))
            return false;
        while(st.hasMoreTokens())
        {
            bHalf = st.nextToken();
            int i = 0;
            while(i < bHalf.length())
            {
                if(!Character.isLetterOrDigit(bHalf.charAt(i)) && bHalf.charAt(i) != '-' && aHalf.charAt(i) != '_')
                    return false;
                i++;
            }
        }
        return true;
    }

    public static boolean isZipcode(String aStr)
    {
        if(aStr.length() != 5 && aStr.length() != 9 && aStr.length() != 10)
            return false;
        StringBuffer sb = new StringBuffer(aStr);
        if(sb.length() == 10)
        {
            if(sb.charAt(5) != '-')
                return false;
            sb.deleteCharAt(5);
        }
        return isNumeric(sb.toString());
    }

    public static String parseTrimString(String sString, String sDefault)
    {
        return parseString(sString, sDefault).trim();
    }

    public static String parseString(String sString, String sDefault)
    {
        return sString != null ? sString : sDefault;
    }

    public static int parseInt(String sNumeric, int iDefault)
    {
        try
        {
            int i = Integer.parseInt(sNumeric.trim());
            return i;
        }
        catch(Exception e)
        {
            int j = iDefault;
            return j;
        }
    }

    public static String normalize(String aStr)
    {
        StringTokenizer st = new StringTokenizer(aStr.toLowerCase());
        StringBuffer sb = new StringBuffer();
        int index = 0;
        do
        {
            if(!st.hasMoreTokens())
                break;
            String str = st.nextToken();
            if(str.equalsIgnoreCase("CD") || str.equalsIgnoreCase("DVD") || str.equalsIgnoreCase("I") || str.equalsIgnoreCase("II") || str.equalsIgnoreCase("JVC") || str.equalsIgnoreCase("III") || str.equalsIgnoreCase("PHD") || str.equalsIgnoreCase("IV") || str.equalsIgnoreCase("V") || str.equalsIgnoreCase("VI") || str.equalsIgnoreCase("VII") || str.equalsIgnoreCase("VIII") || str.equalsIgnoreCase("IX") || str.equalsIgnoreCase("X") || str.equalsIgnoreCase("TCPIP"))
                sb.append(str.toUpperCase());
            else
            if(index == 0 && str.length() == 1)
                sb.append(Character.toUpperCase(str.charAt(0)));
            else
            if(str.length() > 1)
            {
                sb.append(Character.toUpperCase(str.charAt(0)));
                sb.append(str.substring(1));
            }
            index += str.length();
            if(st.hasMoreTokens())
            {
                sb.append(' ');
                index++;
            }
        } while(true);
        return sb.toString();
    }

    public static String dayEnder(int day)
    {
        String sDay = String.valueOf(day);
        if(sDay.endsWith("1") && !sDay.equals("11"))
            return "st";
        if(sDay.endsWith("2") && !sDay.equals("12"))
            return "nd";
        if(sDay.endsWith("3") && !sDay.equals("13"))
            return "rd";
        else
            return "th";
    }

    public static int avoidDivByZero(int aInt)
    {
        if(aInt == 0)
            return 1;
        else
            return aInt;
    }

    public static final String lpad(String aString, int aLength, char aChar)
    {
        String vString = aString;
        if(aString.length() < aLength)
        {
            int vDiff = aLength - aString.length();
            for(int i = 0; i < vDiff; i++)
                vString = aChar + vString;

        }
        return vString;
    }
}
