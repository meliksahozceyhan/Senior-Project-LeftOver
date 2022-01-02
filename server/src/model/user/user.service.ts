import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm'
import { getRepository } from 'typeorm'
import { User } from './entity/user.entity'

@Injectable()
export class UserService extends TypeOrmCrudService<User> {
	private userRepo = getRepository(User)
	constructor(@InjectRepository(User) userRepository) {
		super(userRepository)
	}

	public async saveUser(user: User): Promise<User> {
		console.log(user)
		return this.userRepo.save(user)
	}

	public async login(email: string, password: string): Promise<User> {
		let user = await this.userRepo.findOne({ where: { email: email } })
		if (user !== undefined && user !== null) {
			return user.password === password ? user : null
		}
		return null
	}
}
