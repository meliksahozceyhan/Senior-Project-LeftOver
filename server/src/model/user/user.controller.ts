import { Body, Controller, Get, Post, Query, Request } from '@nestjs/common'
import { SkipAuth } from 'src/decorators/decorators'
import { User } from './entity/user.entity'
import { UserService } from './user.service'

@Controller('user')
export class UserController {
	constructor(private readonly userService: UserService) {}
	@SkipAuth()
	@Post('/')
	public async saveUser(@Body() user: User): Promise<String> {
		return this.userService.saveUser(user)
	}
	@SkipAuth()
	@Get('/login')
	public async login(@Request() req, @Query('email') email: string, @Query('password') password: string): Promise<any> {
		return this.userService.login(email, password)
	}
}
