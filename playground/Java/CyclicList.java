import java.util.Map;
import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Arrays;

public class CyclicList {
    public static void main(String[] args) {
        List<String> l_ = new ArrayList<String>(10);
        l_.set(0, "0");
        // l_.add("1");
        // l_.add("2");
        // l_.add("3");
        // l_.set(8, "8");

        System.out.println(Arrays.asList(l_));
    }
}
