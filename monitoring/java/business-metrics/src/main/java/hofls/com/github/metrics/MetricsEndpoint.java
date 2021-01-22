package hofls.com.github.metrics;

import io.micrometer.prometheus.PrometheusMeterRegistry;
import io.prometheus.client.exporter.MetricsServlet;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.servlet.http.HttpServlet;

@Configuration
public class MetricsEndpoint {
    @Bean
    public ServletRegistrationBean<HttpServlet> servletRegistrationBean(
            PrometheusMeterRegistry prometheusMeterRegistry,
            @Value("${live-test.business-metrics-endpoint}") String businessMetricsEndpoint) {
        return new ServletRegistrationBean<>(
                new MetricsServlet(prometheusMeterRegistry.getPrometheusRegistry()),
                businessMetricsEndpoint
        );
    }
}
