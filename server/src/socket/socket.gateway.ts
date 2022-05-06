import { ConnectedSocket, MessageBody, OnGatewayDisconnect, SubscribeMessage, WebSocketGateway, WebSocketServer } from '@nestjs/websockets'
import { SocketService } from './socket.service'
import { Socket, Server } from 'socket.io'
import { NotificationBody } from './model/notification_body'
import { RoomService } from 'src/model/room/room.service'
import { Room } from 'src/model/room/entity/room.entity'
import { Message } from 'src/model/message/entity/message.entity'
import { MessageService } from 'src/model/message/message.service'
import { MessageDTO } from './model/message.dto'

@WebSocketGateway(3001, { namespace: 'socket', cors: '*', transports: 'websocket' })
export class SocketGateway implements OnGatewayDisconnect {
	@WebSocketServer() server: Server
	private connectedClients: { socketId: string; userId: string }[] = []

	constructor(private readonly socketService: SocketService, private readonly roomService: RoomService, private readonly messageService: MessageService) {}

	handleDisconnect(client: Socket) {
		let index = this.connectedClients.findIndex((connectedClient) => connectedClient.socketId === client.id)
		this.connectedClients.splice(index, 1)
	}

	/**
	 * * PART 1 Notification Manager */

	@SubscribeMessage('notification')
	public handleEvent(@MessageBody() data: NotificationBody, @ConnectedSocket() client: Socket) {
		if (this.connectedClients.find((connectedClient) => connectedClient.userId === data.to.id)) client.to(data.to.id).emit('notification', data)
		else this.socketService.createNotification(data)
	}

	@SubscribeMessage('join')
	public async handleCreateOfRoom(@MessageBody() data: string, @ConnectedSocket() client: Socket) {
		client.join(data)
		this.connectedClients.push({ socketId: client.id, userId: data })

		const unreadNotifications = await this.socketService.getNotificationsOfUser(data)
		this.server.to(data).emit('unreadNotifications', unreadNotifications)
		this.socketService.deleteReadNotifications(unreadNotifications)
	}

	@SubscribeMessage('leaveServer')
	public handleLeaveServer(@MessageBody() data: string, @ConnectedSocket() client: Socket) {
		client.leave(data)
		client.disconnect()
		this.connectedClients.splice(
			this.connectedClients.findIndex((item) => item.userId === data),
			1
		)
	}

	/**
	 * * PART2 Messaging. */

	@SubscribeMessage('createRoom')
	public async handleCreateChatRoom(@MessageBody() data: Room, @ConnectedSocket() client: Socket) {
		await this.roomService.save(data)
		client.to(data.participant2.id).emit('roomCreated', data)
	}

	@SubscribeMessage('onNewMessage')
	public async handleNewMessage(@MessageBody() data: MessageDTO, @ConnectedSocket() client: Socket) {
		if (this.connectedClients.find((connectedClient) => connectedClient.userId === data.to.id)) data.isRead = true
		let result = await this.messageService.saveFromDTO(data)
		let receipentId = data.to.participant1.id === data.from.id ? data.to.participant2.id : data.to.participant1.id
		console.log(receipentId)
		client.to(receipentId).emit('onNewMessage', result)
	}

	@SubscribeMessage('messageRead')
	public handleMessageRead(@MessageBody() data: Message) {
		this.messageService.updateMessageRead(data)
	}

	@SubscribeMessage('multipleMessageRead')
	public handleMultipleMessageRead(@MessageBody() data: Message[]) {
		this.messageService.updateMultipleMessageRead(data)
	}
}
