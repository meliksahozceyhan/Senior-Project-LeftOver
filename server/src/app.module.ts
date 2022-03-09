import { Module } from '@nestjs/common'
import { ConfigModule } from '@nestjs/config'
import databaseConfig from './config/database.config'
import { DatabaseModule } from './database/database.module'
import { AppController } from './app.controller'
import { AppService } from './app.service'
import { UserModule } from './model/user/user.module'
import { AuthModule } from './auth/auth.module'
import { ItemModule } from './model/item/item.module'
import { ImageModule } from './image/image.module'
import { TypegooseModule } from 'nestjs-typegoose'
import { MongooseModule } from '@nestjs/mongoose'
import { APP_GUARD } from '@nestjs/core'
import { JwtAuthGuard } from './auth/guards/jwt-auth.guard'

@Module({
	imports: [ConfigModule.forRoot({ load: [databaseConfig], isGlobal: true }), DatabaseModule, UserModule, AuthModule, ItemModule, ImageModule, MongooseModule.forRoot(process.env.MONGO_URI)],
	controllers: [AppController],
	providers: [
		AppService,
		{
			provide: APP_GUARD,
			useClass: JwtAuthGuard
		}
	]
})
export class AppModule {}
