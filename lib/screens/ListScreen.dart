import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conectar_api/controllers/pedidoController.dart';
import 'package:conectar_api/models/PedidoModel.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  var controller = PedidoController.pedidoController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.listarPedidos();
    });
  }

  void _showEditModal(BuildContext context, PedidoModel pedido) {

    TextEditingController descricaoController = TextEditingController(text: pedido.descricao);
    TextEditingController valorController = TextEditingController(text: pedido.valor?.toString() ?? '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Editar Pedido"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: descricaoController,
                decoration: InputDecoration(labelText: 'Descrição'),
              ),
              TextField(
                controller: valorController,
                decoration: InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o modal sem salvar
              },
              child: Text("Cancelar"),
            ),

            TextButton(
              onPressed: () {
                pedido.descricao = descricaoController.text;
                pedido.valor = double.tryParse(valorController.text) ?? 0.0;
                controller.atualizarPedido(pedido);
                Navigator.pop(context); // Fecha o modal
              },
              child: Text("Salvar"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Pedidos'),
        backgroundColor: Colors.blue,
      ),
      body: Obx(() {

        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.pedido.isEmpty) {
          return Center(child: Text('Nenhum pedido encontrado'));
        }

        return ListView.builder(
          itemCount: controller.pedido.length,
          itemBuilder: (context, index) {
            PedidoModel pedido = controller.pedido[index];

            return Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  pedido.descricao ?? 'Sem descrição',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Valor: R\$ ${pedido.valor?.toStringAsFixed(2) ?? '0.00'}',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Cliente: ${PedidoController.pedidoController.obterNomeCliente(pedido.clienteId) ?? 'Não informado'}',
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.amber),
                      onPressed: () {
                        _showEditModal(context, pedido); // Abre o modal de edição
                      },
                    ),

                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        controller.deletarPedido(pedido.id); // Exclui o pedido
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}