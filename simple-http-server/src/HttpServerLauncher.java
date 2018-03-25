import com.amazonaws.util.EC2MetadataUtils;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Dummy HTTP server that dumps some AWS instance characteristics.
 */
public class HttpServerLauncher {

    public static void main(String[] args) {
        new HttpServerLauncher().run();
    }

    private final AtomicInteger requestCount = new AtomicInteger();

    private void run() {
        HttpServer server = null;
        try {
            server = HttpServer.create(new InetSocketAddress(8000), 0);
            server.createContext("/", new DumpAwsInstanceInfoHandler());
            server.start();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private class DumpAwsInstanceInfoHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange exchange) throws IOException {
            ArrayList<String> infos = new ArrayList<>();
            infos.add("Request count     : " + requestCount.incrementAndGet());
            infos.add("===================");
            infos.add("InstanceId        : " + EC2MetadataUtils.getInstanceId());
            infos.add("Private IP        : " + EC2MetadataUtils.getPrivateIpAddress());
            infos.add("AMI ID            : " + EC2MetadataUtils.getAmiId());
            infos.add("Region            : " + EC2MetadataUtils.getEC2InstanceRegion());
            infos.add("Availability Zone : " + EC2MetadataUtils.getAvailabilityZone());
            infos.add("Instance type     : " + EC2MetadataUtils.getInstanceType());
            infos.add("Security groups   : " + EC2MetadataUtils.getSecurityGroups());

            String response = String.join("\n", infos);
            exchange.sendResponseHeaders(200, response.length());
            OutputStream os = exchange.getResponseBody();
            os.write(response.getBytes(Charset.forName("UTF-8")));
            os.close();
        }
    }
}
