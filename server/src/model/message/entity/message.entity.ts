import { IsNotEmpty } from 'class-validator'
import { Room } from 'src/model/room/entity/room.entity'
import { User } from 'src/model/user/entity/user.entity'
import { Column, CreateDateColumn, Entity, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from 'typeorm'

@Entity()
export class Message {
	@PrimaryGeneratedColumn('uuid')
	id: string

	@CreateDateColumn()
	createdAt: Date

	@UpdateDateColumn()
	updatedAt: Date

	@ManyToOne(() => Room, { nullable: false, eager: true })
	to: Room

	@ManyToOne(() => User, { nullable: true, eager: false })
	from: User

	@IsNotEmpty()
	@Column({ name: 'content', nullable: false })
	content: string

	@Column({ default: false, nullable: false })
	isRead: boolean
}
