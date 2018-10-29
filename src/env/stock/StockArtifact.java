package stock;

import java.net.*;
import java.text.NumberFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Locale;
import java.io.*;
import org.jsoup.*;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import cartago.Artifact;
import cartago.OPERATION;
import cartago.OpFeedbackParam;

public class StockArtifact extends Artifact {

	@OPERATION
	void getLastPrice(String stock) {
		URL url;
		try {
			url = new URL("http://cotacoes.economia.uol.com.br/acao/index.html?codigo=" + stock + ".SA");
			log("Looking for last quotation in " + url.toString());
			Document doc = (Document) Jsoup.parse(url, 3000);

			if (doc.select("table").size() > 0) {
				Element table = ((Element) doc).select("table").get(0);
				Elements rows = table.select("tr");
				Element row = rows.get(1);
				Elements cols = row.select("td");
				// [empty], Horario, Var, Var (%), ultima, Maximo, Minimo, Abertura, Volume
				NumberFormat format = NumberFormat.getInstance(Locale.FRANCE);
				Number number = format.parse(cols.get(3).text());
				defineObsProperty("lastquotation", number.doubleValue());

				String description = null;
				Element el = null;
				for (int j = 1; j < doc.select("div").size(); j++) { // first row is the col names so skip it.
					description = doc.select("div").get(j).attr("class");
					if (description.equals("box-conteudo")) {
						el = doc.select("div").get(j).child(0);
						break;
					}
				}
				defineObsProperty("datequotation", el.text() + " " + cols.get(0).text());
				defineObsProperty("sourcequotation", "uol");
				
				log("Last quotation is " + number.toString() + " (" + el.text() + " " + cols.get(0).text() + ")");
			} else {
				log("Error getting quotation!");
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}

	}

}
