import com.jesse.dpp.rcp.utils.ip.DataBlock;
import com.jesse.dpp.rcp.utils.ip.SeekIpAddress;

/**
 * project test script
 * 
 * @author chenxin<chenxin619315@gmail.com>
*/
public class TestUtil 
{
    public static void main(String[] argv)
    {
    	
    	SeekIpAddress seekIpAddress = SeekIpAddress.getInstance();
    	String[] ips = {"192.168.2.3","23.36.2.3", "23.36.2.3", "124.36.2.87"}; 
    	for (int i = 0; i < ips.length; i++) {
		
    		long startTime = System.currentTimeMillis();
    		
    		DataBlock dataBlock = seekIpAddress.getAddressByIp(ips[i]);
        	
        	System.out.println("cost time is " + String.valueOf(System.currentTimeMillis() - startTime));
        	
        	System.out.println("region is " + dataBlock.getRegion());
        	
		}
    	
    }
}
