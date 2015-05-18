package ws.prac;

import org.apache.axis.AxisFault;
import org.apache.axis.Message;
import org.apache.axis.MessageContext;
import org.apache.axis.handlers.BasicHandler;
import javax.xml.soap.SOAPException;
import javax.xml.soap.SOAPHeader;
import org.apache.axis.message.SOAPHeaderElement;
import org.apache.axis.message.SOAPEnvelope;
import org.apache.axis.message.MessageElement;
import javax.xml.namespace.QName;
import java.util.Iterator;
@SuppressWarnings("unchecked")
public class BSHeaderHandler extends BasicHandler {
	private static final long serialVersionUID = 1L;
	private String username, passwd;
	public void invoke(MessageContext msgContext) throws AxisFault {
		boolean processedHeader = false;
		try {
			Message msg = msgContext.getRequestMessage();
			SOAPEnvelope envelope = msg.getSOAPEnvelope();
			SOAPHeader header = envelope.getHeader();
			Iterator it = header.examineAllHeaderElements();
			SOAPHeaderElement hel;
			while (it.hasNext()) {
				hel = (SOAPHeaderElement) it.next();
				String headerName = hel.getNodeName();
				if (headerName.equals("cp:MessageHeader")) {
					hel.setProcessed(true);
					checkUser(hel);
					processedHeader = true;
				}
			}
		} catch (SOAPException e) {
			throw new AxisFault("can't process header", e);
		}
		if (!processedHeader) {
			throw new AxisFault("receive header failed");
		}
	}
	
	private void checkUser(SOAPHeaderElement hel) throws AxisFault {
		MessageElement fele = hel.getChildElement(new QName(
				"http://cn.zuoguodang.service", "username"));
		if (fele == null) {
			throw new AxisFault("no username");
		}
		MessageElement tele = hel.getChildElement(new QName(
				"http://prac.ws", "passwd"));
		if (tele == null) {
			throw new AxisFault("no passwd");
		}
		username = fele.getValue();
		passwd = tele.getValue();
		if (!"zuoguodang".equals(username) || !"123456".equals(passwd)) {
			throw new AxisFault("not matched ,failed");
		}
	}
}
