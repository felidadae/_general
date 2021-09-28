import java.util.Map;
import java.util.HashMap;
import java.util.Arrays;
public class SampleArrays {
    public static void main(String[] args) {
        String identificationMetadata = "klucz:wartosc,klucz2:wartosc2,klucz3:wartosc3";
        for (int i = 0; i < identificationMetadata.length(); ++i) {
            char c = identificationMetadata.charAt(i);
            System.out.println(c);
        }

        String[] identificationMetadataList = new String[] {"zupa", "wina"};
        System.out.println(identificationMetadataList[3]);

    }
}
