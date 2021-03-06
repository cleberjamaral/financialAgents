package dynamic.telegram;

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
	List<String> menu = new ArrayList<String>();
	
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
				// Telegram message structure
				// IncomingMessage{
				// messageId=139,
				// date=2018-10-25T14:24:22Z,
				// from=User{
				// id=NNNNN,
				// firstName='Cleber',
				// lastName='null',
				// username='cleberjamaral'
				// },
				// text='getIn',
				// chat=Chat{id='NNNNN', title='null', type='private'},
				// photo=null, video=null, audio=null, document=null
				// }
				@Override
				public void configure() {
					from(telegramURI).process(new Processor() {
						public void process(Exchange exchange) {
							try {
								String str = exchange.getIn().getBody(String.class).toLowerCase();
								log("Content to process: " + str);

								exchange.getIn().setHeader("ArtifactName", getId().toString());
								List<Object> listObj = new ArrayList<Object>();

								// The text has parenthesis (property instead of a signal)?
								String option = "";
								if (str.indexOf('(') == -1) {
									option = str;
								} else {
									option = str.substring(0, str.indexOf('('));
								}
								
								// The option is supported by the agent?
								if (!menu.contains(option)) {
									exchange.getIn().setHeader("OperationName", "generateSignal");
									listObj.add("invalidoption");
									exchange.getIn().setBody(null);

								} else {

									// if there is no more parameters
									if (str.indexOf('(') == -1) {
										listObj.add(str);
										exchange.getIn().setHeader("OperationName", "generateSignal");
									} else {
										listObj.add(option);
										String arguments = str.substring(str.indexOf('(') + 1, str.indexOf(')'));
										listObj.add(arguments);
//										do {
//											if (str.indexOf(',') == -1) {
//												listObj.add(arguments);
//												arguments = "";
//											} else {
//												listObj.add(arguments.substring(0, str.indexOf(',')));
//												arguments = arguments.substring(arguments.indexOf(',') + 1,
//														arguments.length());
//											}
//										} while (arguments.length() > 0);
										exchange.getIn().setHeader("OperationName", "generateSignalListParams");
									}
								}
								exchange.getIn().setBody(listObj);
							} catch (Exception e) {
								e.printStackTrace();
							}
						}
					}).to("artifact:cartago");

					from("artifact:cartago").process(new Processor() {
						public void process(Exchange exchange) throws Exception {
							try {
								//String str = exchange.getIn().getBody().toString();
								//exchange.getIn().setBody(str.replaceAll("\\[", "").replaceAll("\\]", ""));
								System.out.println("testing");
								float tempC = Float.parseFloat(exchange.getIn().getBody().toString().replaceAll("\\[", "").replaceAll("\\]", ""));
								exchange.getIn().setBody(Float.toString((float) (tempC * 1.8 + 32)));
							} catch (Exception e) {
								e.printStackTrace();
							}
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
		params.add(msg);
		sendMsg(getId().toString(),"telegram",params);
	}	

	@INTERNAL_OPERATION
	public void generateSignal(String eventName) {
		signal(eventName);
		log("signal: " + eventName);
	}
	
	//TODO: Why it cannot be @INTERNAL_OPERATION as createEvent?
	@OPERATION
	public void generateSignalListParams(Object... parameters) {
		String argument = parameters[1].toString();
		signal(parameters[0].toString(), new Atom(argument));
		log("signal: " + parameters[0].toString() + " / " + argument);
	}

	@OPERATION
	public void clearMenu() {
		menu.clear();
	}

	@OPERATION
	public void addMenuOption(String str) {
		menu.add(str.toLowerCase());
	}
}
