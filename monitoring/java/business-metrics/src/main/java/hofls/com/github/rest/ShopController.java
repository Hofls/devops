package hofls.com.github.rest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Random;

@RestController
public class ShopController {

    public static final String BUSINESS_ENDPOINT = "findProduct";

    @GetMapping(value = BUSINESS_ENDPOINT)
    public String findProduct() {
        if (new Random().nextBoolean()) {
            return "Extra thick potato";
        } else {
            throw new IllegalArgumentException("Something went wrong");
        }
    }
}
