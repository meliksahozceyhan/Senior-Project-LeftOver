import { classToPlain, Exclude, instanceToPlain } from 'class-transformer'
import { IsNotEmpty, Length } from 'class-validator'
import { Item } from 'src/model/item/entity/item.entity'
import { Notification } from 'src/model/notification/entity/notification.entity'
import { Column, CreateDateColumn, Entity, OneToMany, PrimaryGeneratedColumn, UpdateDateColumn } from 'typeorm'

export class UpdateUserDTO {
	id: string

	createdAt: Date

	updatedAt: Date

	email: String

	fullName: String

	oldPassword: String

	newPassword: String

	dateOfBirth: Date

	city: String

	address: String

	profileImage: String

	items: Item[]
}
