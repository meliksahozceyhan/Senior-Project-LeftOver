import { User } from 'src/model/user/entity/user.entity'
import { CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from 'typeorm'

@Entity()
export class Room {
	@PrimaryGeneratedColumn('uuid')
	id: string

	@CreateDateColumn()
	createdAt: Date

	@UpdateDateColumn()
	updatedAt: Date

	@ManyToOne(() => User, { nullable: false, eager: true })
	@JoinColumn({ name: 'participant1_id' })
	participant1: User

	@ManyToOne(() => User, { nullable: false, eager: true })
	@JoinColumn({ name: 'participant2_id' })
	participant2: User
}
