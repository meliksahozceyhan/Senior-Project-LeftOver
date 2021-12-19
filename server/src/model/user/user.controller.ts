import { Body, Controller, Post } from '@nestjs/common'
import { User } from './entity/user.entity'
import { UserService } from './user.service'

@Controller('user')
export class UserController {
	constructor(private readonly userService: UserService) {}
	@Post('/')
	public async saveUser(@Body() user: User): Promise<User> {
		return this.userService.saveUser(user)
	}
}
