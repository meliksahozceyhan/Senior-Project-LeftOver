import { ConnectedSocket, MessageBody, SubscribeMessage, WebSocketGateway, WebSocketServer } from '@nestjs/websockets'
import { SocketService } from './socket.service'
import { Socket, Server } from 'socket.io'
import { NotificationBody } from './model/notification_body'
import { RoomService } from 'src/model/room/room.service'
import { Room } from 'src/model/room/entity/room.entity'
import { Message } from 'src/model/message/entity/message.entity'
import { MessageService } from 'src/model/message/message.service'

@WebSocketGateway(3001, { namespace: 'socket', cors: '*', transports: 'websocket' })
export class SocketGateway {
	@WebSocketServer() server: Server
	private connectedClients: String[] = []

	constructor(private readonly socketService: SocketService, private readonly roomService: RoomService, private readonly messageService: MessageService) {}

	/**
	 * * PART 1 Notification Manager */

	@SubscribeMessage('notification')
	public handleEvent(@MessageBody() data: NotificationBody, @ConnectedSocket() client: Socket) {
		console.log(this.connectedClients)
		if (this.connectedClients.includes(data.to.id)) client.to(data.to.id).emit('notification', data)
		else this.socketService.createNotification(data)
	}

	@SubscribeMessage('join')
	public async handleCreateOfRoom(@MessageBody() data: string, @ConnectedSocket() client: Socket) {
		console.log(`The Socket ${client.id} Joined to the room ${data}`)
		client.join(data)
		this.connectedClients.push(data)
		console.log(`The User ${data} Is Trying to get unread Notifications`)
		const unreadNotifications = await this.socketService.getNotificationsOfUser(data)
		this.server.to(data).emit('unreadNotifications', unreadNotifications)
		this.socketService.deleteReadNotifications(unreadNotifications)
	}

	@SubscribeMessage('leaveServer')
	public handleLeaveServer(@MessageBody() data: string, @ConnectedSocket() client: Socket) {
		client.leave(data)
		client.disconnect()
		this.connectedClients.splice(
			this.connectedClients.findIndex((item) => item === data),
			1
		)
		console.log(this.connectedClients)
	}

	/**
	 * * PART2 Messaging. */

	@SubscribeMessage('createRoom')
	public async handleCreateChatRoom(@MessageBody() data: Room, @ConnectedSocket() client: Socket) {
		await this.roomService.save(data)
		client.to(data.participant2.id).emit('roomCreated', data)
	}

	@SubscribeMessage('onNewMessage')
	public handleNewMessage(@MessageBody() data: Message, @ConnectedSocket() client: Socket) {
		if (this.connectedClients.includes(data.to.participant2.id)) data.isRead = true
		this.messageService.save(data)
		if (this.connectedClients.includes(data.to.participant2.id) || this.connectedClients.includes(data.to.participant1.id)) client.to(data.to.id).emit('newMessage', data)
	}

	@SubscribeMessage('messageRead')
	public handleMessageRead(@MessageBody() data: Message) {
		this.messageService.updateMessageRead(data)
	}
}
