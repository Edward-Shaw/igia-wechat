package com.cloume.shaw.igia.configuration;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.config.AbstractMongoConfiguration;
import org.springframework.data.mongodb.core.MongoTemplate;

import com.mongodb.Mongo;
import com.mongodb.MongoClient;
import com.mongodb.MongoCredential;
import com.mongodb.ServerAddress;

@Configuration
public class MongoConfiguration extends AbstractMongoConfiguration {
	
	@Value("${spring.data.mongodb.host}") private String mongoHost;
	@Value("${spring.data.mongodb.port}") private int mongoPort;
	@Value("${spring.data.mongodb.username}") private String mongoUsername;
	@Value("${spring.data.mongodb.password}") private String mongoPassword;
	@Value("${spring.data.mongodb.database}") private String mongoDatabase;

	@Override
	protected String getDatabaseName() {
		return mongoDatabase;
	}
	
	@Override @Bean
	public MongoTemplate mongoTemplate() throws Exception {
		return new MongoTemplate(mongo(), getDatabaseName());
	}

	@Override @Bean
	public Mongo mongo() throws Exception {

        // 构建鉴权信息，账号验证数据库名与数据库名一致
        List<MongoCredential> credentials = new ArrayList<MongoCredential>();
        credentials.add(MongoCredential.createScramSha1Credential(mongoUsername,
        		getDatabaseName(), mongoPassword.toCharArray()));

        MongoClient client = new MongoClient(new ServerAddress(mongoHost, mongoPort), credentials);
          
        return client;
	}

}
