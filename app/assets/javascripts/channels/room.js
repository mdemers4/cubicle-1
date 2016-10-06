App.room = App.cable.subscriptions.create({
  channel: 'RoomChannel',
  room: window.location.pathname.split("/")[2]
},{
  received: function(data){
    $('.messages').append(data.message);
  }
});
