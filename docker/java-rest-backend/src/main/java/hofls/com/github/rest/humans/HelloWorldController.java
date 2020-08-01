package hofls.com.github.rest.humans;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Api(tags = {"hello-world-service"})
@RequestMapping("/hello-world")
@RestController
public class HelloWorldController {

    @ApiOperation(value = "Greets people", notes = "")
    @GetMapping("greeting")
    public String greeting() {
        return "Nice to meet you!";
    }

    @ApiOperation(value = "Returns environment variables", notes = "")
    @GetMapping("environment")
    public String environment() {
        return System.getenv("VAR1");
    }

}
