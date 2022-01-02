import { ForbiddenException, Injectable, NotFoundException, UnauthorizedException } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm'
import { getRepository } from 'typeorm'
import { User } from './entity/user.entity'
import * as bcrypt from 'bcrypt'
import { JwtService } from '@nestjs/jwt'

@Injectable()
export class UserService extends TypeOrmCrudService<User> {
	private userRepo = getRepository(User)
	constructor(@InjectRepository(User) userRepository, private readonly jwtService: JwtService) {
		super(userRepository)
	}

	public async saveUser(user: User): Promise<String> {
		user.password = await bcrypt.hash(user.password as string, 10)
		user = await this.userRepo.save(user)
		return this.createToken(user)
	}

	public async login(email: string, password: string): Promise<any> {
		let user = await this.userRepo.findOne({ where: { email: email } })
		if (user !== undefined && user !== null) {
			if (await bcrypt.compare(password, user.password as string)) {
				return this.createToken(user)
			}
			throw new UnauthorizedException({ message: 'Password iss WRONG!', statusCode: 401 })
		} else {
			throw new NotFoundException({ message: 'There is no such USER!', statusCode: 404 })
		}
	}

	public createToken(user: User): string {
		const tokenPayload = { id: user.id, email: user.email, fullName: user.fullName, dateOfBirth: user.dateOfBirth, city: user.city, address: user.address }
		const token = this.jwtService.sign(tokenPayload)
		return token
	}
}
