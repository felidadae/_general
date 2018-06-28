import java.util.Map;
import java.util.HashMap;
import java.util.Arrays;
public class SimpleParser {
    public static void main(String[] args) {
        String identificationMetadata = "klucz:wartosc,klucz2:wartosc2,klucz3:wartosc3";

        String[] identificationMetadataList = identificationMetadata.split(",");
        Map<String, String> identificationMetadataDictionary = new HashMap<String, String>();

        for (String key_value_pair: identificationMetadataList) {
            String[] key_value_pair_ = key_value_pair.split(":");
            identificationMetadataDictionary.put(key_value_pair_[0], key_value_pair_[1]);
        }

        System.out.println(Arrays.asList(identificationMetadataDictionary));
    }
}
