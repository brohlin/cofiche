package org.undp.log;

public class Log
    implements Logable
{

    public Log()
    {
    }

    public String getLogString()
    {
        return vMessage;
    }

    public void setLogString(String aMessage)
    {
        vMessage = aMessage;
    }

    private String vMessage;
}
