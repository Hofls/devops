package hofls.com.github.rest.common.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Tag;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@Configuration
@EnableSwagger2
public class SwaggerConfig {

    @Bean
    public Docket postsApi() {
        return new Docket(DocumentationType.SWAGGER_2).select()
                .apis(RequestHandlerSelectors.basePackage("hofls.com.github.rest"))
                .build()
                .useDefaultResponseMessages(false)
                .apiInfo(apiInfo())
                .tags(new Tag("hello-world-service", "Bunch of random endpoints"));
    }

    private ApiInfo apiInfo() {
        return new ApiInfoBuilder().title("Example of REST API").build();
    }

}