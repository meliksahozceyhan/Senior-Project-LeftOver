import { Body, Controller, Get, Post, Put, Query, Request } from '@nestjs/common'
import { SkipAuth } from 'src/decorators/decorators'
import { UpdateUserDTO } from './entity/update-user.dto'
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

	@Put('/updateProfile')
	public async updateProfile(@Body() user: UpdateUserDTO): Promise<String> {
		return this.userService.updateUser(user)
	}
}
