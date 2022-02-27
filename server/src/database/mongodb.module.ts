import { Module } from '@nestjs/common'
import { ConfigModule, ConfigService } from '@nestjs/config'
import { TypegooseModule } from 'nestjs-typegoose'
import { config } from 'process'
import { async } from 'rxjs'

@Module({
	imports: [
		TypegooseModule.forRootAsync({
			imports: [ConfigModule],
			inject: [ConfigService],
			useFactory: async (config: ConfigService) => ({
				uri: config.get('mongodb.url'),
				useNewUrlParser: true,
				useUnifiedTopology: true
			})
		})
	]
})
export class DatabaseModule {}
