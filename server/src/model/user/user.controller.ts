import { Body, Controller, Get, Post, Query } from '@nestjs/common'
import { User } from './entity/user.entity'
import { UserService } from './user.service'

@Controller('user')
export class UserController {
	constructor(private readonly userService: UserService) {}
	@Post('/')
	public async saveUser(@Body() user: User): Promise<User> {
		return this.userService.saveUser(user)
	}
	@Get('/login')
	public async login(@Query('email') email: string, @Query('password') password: string): Promise<User> {
		console.log('deneme')
		return this.userService.login(email, password)
	}
}
