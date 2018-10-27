package telegram;

import cartago.*;
import jason.asSyntax.Atom;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.camel.CamelContext;
import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.component.telegram.TelegramComponent;
import org.apache.camel.impl.DefaultCamelContext;

import camelartifact.ArtifactComponent;
import camelartifact.CamelArtifact;

@ARTIFACT_INFO(outports = { @OUTPORT(name = "out-1") })

public class BotArtifact extends CamelArtifact {

	static int n = 0;
	
	@OPERATION
	public void startCamel(String chatId) {
		String token = null;
		BufferedReader telegramtoken;
		try {
			telegramtoken = new BufferedReader(new FileReader("../sensitiveData/" + getId().toString() + ".token"));
			token = telegramtoken.readLine();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		String telegramURI = "telegram:bots/" + token + "?" + "chatId=" + chatId;
		final CamelContext camelContext = new DefaultCamelContext();

		// This simple application has only one component receiving messages from the route and producing operations
		camelContext.addComponent("artifact", new ArtifactComponent(this.getIncomingOpQueue(),this.getOutgoingOpQueue()));
		camelContext.addComponent("telegram", new TelegramComponent());
		/* Create the routes */
		try {
			camelContext.addRoutes(new RouteBuilder() {
//			Telegram message structure
//				IncomingMessage{
//				messageId=139, 
//				date=2018-10-25T14:24:22Z, 
//				from=User{
//					id=NNNNN, 
//					firstName='Cleber', 
//					lastName='null', 
//					username='cleberjamaral'
//				}, 
//				text='getIn', 
//				chat=Chat{id='NNNNN', title='null', type='private'}, 
//				photo=null, video=null, audio=null, document=null
//				}					
				@Override
				public void configure() {
					from(telegramURI)
					.process(new Processor() {
						public void process(Exchange exchange) {
							String str = exchange.getIn().getBody(String.class).toLowerCase();
							
							// message is asking for agent's expertice?
							if ((!str.contains("setexpertice"))&&(str.contains("exper"))) 
								str = "giveexpertise";
							// message is asking current quotation / price?
							if ((str.contains("quota")) || (str.contains("price"))) 
								str = "givequotation";
							// message is asking current quotation / price?
							if (str.contains("artifact")) 
								str = "recreateartifact";
							

							exchange.getIn().setHeader("ArtifactName", getId().toString());
							
							List<Object> listObj = new ArrayList<Object>();
							
							// If there is no more parameters
							if (str.indexOf('(') == -1) {
								listObj.add(str);
								exchange.getIn().setHeader("OperationName", "createEvent");
							}
							else {
								listObj.add(str.substring(0, str.indexOf('(')));
								listObj.add(str.substring(str.indexOf('(')+1, str.indexOf(')')));
								exchange.getIn().setHeader("OperationName", "updateProperty");
							}
							
							exchange.getIn().setBody(listObj);							
					}})
					.to("artifact:cartago");

					from("artifact:cartago").process(new Processor() {
						public void process(Exchange exchange) throws Exception {
							exchange.getIn().setBody(exchange.getIn().getBody().toString());
						}
					}).to(telegramURI);
				}
			});
		} catch (Exception e) {
			e.printStackTrace();
		}

		// start routing
		log("Starting camel... (context: "+camelContext+" route definitions: "+camelContext.getRouteDefinitions().toString()+") ");
		try {
			camelContext.start();
		} catch (Exception e) {
			e.printStackTrace();
		}
		log("Starting artifact...");
	}

	@OPERATION
	public void sendString(String msg) {
		List<Object> params  = new ArrayList<Object>();
		params.add(getId().toString());
		params.add(msg);
		sendMsg(getId().toString(),"telegram",params);
	}	

	@OPERATION
	public void createEvent(String eventName) {
		signal(eventName);
	}
	
	@OPERATION
	public void updateProperty(Object... parameters) {
		String argument = parameters[1].toString();
		defineObsProperty(parameters[0].toString(), new Atom(argument));
		//defineObsProperty("setexpertice", 0);
	}
}
