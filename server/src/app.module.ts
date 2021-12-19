import { Module } from '@nestjs/common'
import { ConfigModule } from '@nestjs/config'
import databaseConfig from './config/database.config'
import { DatabaseModule } from './database/database.module'
import { AppController } from './app.controller'
import { AppService } from './app.service'

@Module({
	imports: [ConfigModule.forRoot({ load: [databaseConfig], isGlobal: true }), DatabaseModule],
	controllers: [AppController],
	providers: [AppService]
})
export class AppModule {}
