import { Module } from '@nestjs/common'
import { ConfigModule } from '@nestjs/config'
import databaseConfig from './config/database.config'
import { DatabaseModule } from './database/database.module'
import { AppController } from './app.controller'
import { AppService } from './app.service'
import { UserModule } from './model/user/user.module';
import { AuthModule } from './auth/auth.module';
import { ItemModule } from './model/item/item.module';

@Module({
	imports: [ConfigModule.forRoot({ load: [databaseConfig], isGlobal: true }), DatabaseModule, UserModule, AuthModule, ItemModule],
	controllers: [AppController],
	providers: [AppService]
})
export class AppModule {}
