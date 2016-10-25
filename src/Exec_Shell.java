import java.io.*;
public class Exec_Shell {

	static String projectHome = System.getProperty("user.dir");
    
	public static void main(String[] args) throws Exception {
                try {
                        String target = new String(projectHome+"/script.sh");
// String target = new String("mkdir stackOver");
                        Runtime rt = Runtime.getRuntime();
                        Process proc = rt.exec(target);
                        proc.waitFor();
                        StringBuffer output = new StringBuffer();
                        BufferedReader reader = new BufferedReader(new InputStreamReader(proc.getInputStream()));
                        String line = "";                       
                        while ((line = reader.readLine())!= null) {
                                output.append(line + "\n");
                        }
                        System.out.println("### " + output);
                } catch (Throwable t) {
                        t.printStackTrace();
                }
        }
}