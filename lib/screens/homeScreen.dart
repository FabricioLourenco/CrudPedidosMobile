import 'package:conectar_api/components/MenuComponent.dart';
import 'package:conectar_api/controllers/clienteController.dart';
import 'package:conectar_api/controllers/pedidoController.dart';
import 'package:conectar_api/models/ClienteModel.dart';
import 'package:conectar_api/models/PedidoModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();

  var controllerlPedido = PedidoController.pedidoController;
  var controllerlCliente = ClienteController.clienteController;
  ClienteModel? _clienteSelecionado;

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      controllerlCliente.listarClientes();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Criar Pedido"),
        ),
        drawer: MenuComponent(),
        body:
        Obx(()=>
        controllerlPedido.isLoading.value?
        Center(child: CircularProgressIndicator(),) :
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _descricaoController,
                      decoration: InputDecoration(
                          labelText: 'Descrição',
                          border: OutlineInputBorder()
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'Por favor, insira descrição do pedido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height:10),
                    TextFormField(
                      controller: _valorController,
                      decoration: InputDecoration(
                          labelText: 'Valor',
                          border: OutlineInputBorder()
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'Por favor, insira um valor';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height:10),
                    TextFormField(
                      controller: _statusController,
                      decoration: InputDecoration(
                          labelText: 'Status',
                          border: OutlineInputBorder()
                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'Por favor, insira um status';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),

                    InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Selecione um Cliente',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<ClienteModel>(
                            value: _clienteSelecionado,
                            hint: Text('Selecione um Cliente'),
                            isExpanded: true,
                            onChanged: (ClienteModel? cliente){
                              setState(() {
                                _clienteSelecionado = cliente;
                              });
                            },
                            items: controllerlCliente.clientes.map(
                                    (ClienteModel cliente){
                                  return
                                    DropdownMenuItem<ClienteModel>(
                                      value: cliente,
                                      child: Text(cliente.nome),
                                    );
                                }).toList(),
                          ),
                        )
                    ),

                    SizedBox(height: 20,),

                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final pedido = PedidoModel(
                            id: "",
                            status: _statusController.text,
                            descricao: _descricaoController.text,
                            valor: double.tryParse(_valorController.text) ?? 0.0,
                            clienteId: _clienteSelecionado!.id,
                          );

                          var response = await controllerlPedido.salvar(pedido);

                          if (response != null && response != false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    Icon(Icons.check, color: Colors.white),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "Salvo com sucesso",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 2),
                                margin: EdgeInsets.all(10),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text('Enviar'),
                    )
                  ],
                )
            ),

          ],
        )
        )
    );
  }
}