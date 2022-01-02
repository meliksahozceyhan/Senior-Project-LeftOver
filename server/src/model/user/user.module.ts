import { Module } from '@nestjs/common'
import { UserService } from './user.service'
import { UserController } from './user.controller'
import { User } from './entity/user.entity'
import { TypeOrmModule } from '@nestjs/typeorm'
import { JwtModule } from '@nestjs/jwt'

@Module({
	imports: [
		TypeOrmModule.forFeature([User]),
		JwtModule.register({
			secret: 'CTIS411',
			signOptions: {
				expiresIn: '1y'
			}
		})
	],
	controllers: [UserController],
	providers: [UserService]
})
export class UserModule {}
