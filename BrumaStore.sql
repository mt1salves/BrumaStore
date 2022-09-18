-- SHOW DATABASES;

CREATE SCHEMA BrumaStore;

USE BrumaStore;

CREATE TABLE Endereco(
	idEndereco INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(45) NOT NULL,
    numero VARCHAR(45) NOT NULL,
    cep VARCHAR(8) NOT NULL,
    bairro VARCHAR(45) NOT NULL,
	cidade VARCHAR(45) NOT NULL,
    estado VARCHAR(45) NOT NULL
);

CREATE TABLE Telefone(
	idTelefone INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ddd VARCHAR(2) NOT NULL,
    numero VARCHAR(45) NOT NULL
);

CREATE TABLE Vendedor(
	idVendedor INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    salario_base VARCHAR(45) NOT NULL,
    matricula VARCHAR(45) NOT NULL,
    nome VARCHAR(45) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    Endereco_idEndereco INT NOT NULL,
    Telefone_idTelefone INT NOT NULL,
    FOREIGN KEY (Endereco_idEndereco) REFERENCES Endereco(idEndereco),
    FOREIGN KEY (Telefone_idTelefone) REFERENCES Telefone(idTelefone)
);

CREATE TABLE Cliente(
	idCliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    rg VARCHAR(9) NOT NULL,
    Endereco_idEndereco INT NOT NULL,
    Telefone_idTelefone INT NOT NULL, 
    FOREIGN KEY (Endereco_idEndereco) REFERENCES Endereco(idEndereco),
    FOREIGN KEY (Telefone_idTelefone) REFERENCES Telefone(idTelefone)
);

CREATE TABLE Venda(
	idVenda INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    valor VARCHAR(45) NOT NULL,
    a_prazo TINYINT NOT NULL,
    numero_nota_fiscal VARCHAR(45) NOT NULL,
    data_hora DATETIME NOT NULL,
    Vendedor_idVendedor INT NOT NULL,
    Cliente_idCliente INT NOT NULL,
    FOREIGN KEY (Vendedor_idVendedor) REFERENCES Vendedor(idVendedor),
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Parcela(
    parcelas TINYINT NOT NULL,
    vencimento DATE NOT NULL,
    valor FLOAT NOT NULL,
    Venda_idVenda INT NOT NULL,
    FOREIGN KEY (Venda_idVenda) REFERENCES Venda(idVenda)
);

CREATE TABLE Produto(
	idProduto INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    codigo VARCHAR(10) NOT NULL,
    nome VARCHAR(45) NOT NULL,
    descricao TINYTEXT NOT NULL,
    preco FLOAT NOT NULL,
    quantidade_em_estoque INT NOT NULL
);

CREATE TABLE Venda_tem_Produto(
	quantidade_produto INT NOT NULL,
	Venda_idVenda INT NOT NULL,
    Produto_idProduto INT NOT NULL,
    FOREIGN KEY (Venda_idVenda) REFERENCES Venda(idVenda),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
);

INSERT INTO Endereco(idEndereco, logradouro, numero, cep, bairro, cidade, estado)
VALUES(1, 'Rua Zélio Lima', '240', '46100000', 'Ginásio Industrial', 'Brumado', 'Bahia'), (2, 'Rua Rio de Contas', '170', '46100000', 'Feliciano Santos', 'Brumado', 'Bahia'), (3, 'Avenida Soteropolitana', '220', '46100000', 'Malhada Branca', 'Brumado', 'Bahia');

INSERT INTO Telefone(idTelefone, ddd, numero)
VALUES(1, '77', '990913456'), (2, '77', '990861234'), (3, '77', '997679234');

INSERT INTO Vendedor(idVendedor, salario_base, matricula, nome, cpf, Endereco_idEndereco, Telefone_idTelefone)
Values(1, '5000', '0912345678', 'Juliano Gustavo', '0978652431', 1, 1), (2, '4500', '0987645321', 'João Franco', '1234567890', 2, 2), (3, '2600', '0978645132', 'José Augusto', '0193872465', 3, 3);

INSERT INTO Cliente(idCliente, nome, cpf, rg, Endereco_idEndereco, Telefone_idTelefone)
VALUES(1, 'Flaviano', '12345678912', '987654321', 1, 1), (2, 'Maria de Fátima', '5647839210', '0987654321', 2, 2), (3, 'Maria Isabel', '0987645321', '0986753421', 3, 3);

INSERT INTO Venda(idVenda, valor, a_prazo, numero_nota_fiscal, data_hora, Vendedor_idVendedor, Cliente_idCliente)
VALUES(1, '1300', true, '1', '2022-06-22 18:37:13', 1, 1), (2, '2800', true, '2', '2022-08-23 16:03:18', 2, 2), (3, '3500', true, '3', '2022-08-22 15:03:18', 3, 3);

INSERT INTO Parcela(parcelas, vencimento, valor, Venda_idVenda)
VALUES(true, '2022-08-22', '180', 1), (true, '2022-12-23', '270', 2), (true, '2022-12-22', '360', 3);

INSERT INTO Produto(idProduto, codigo, nome, descricao, preco, quantidade_em_estoque)
VALUES(1, '1234567891', 'Blusa de Zebra', 'Venha você zebrar conosco', 1000, 100), (2, '0915094567','Bolsa de Couro', 'Desembolse a liberdade', 2000, 200), (3, '09123457','Sapato Pegada', 'A marca que conquista', 3000, 300);

INSERT INTO Venda_tem_Produto(quantidade_produto, Venda_idVenda, Produto_idProduto)
VALUES(2, 1, 1), (4, 2, 2), (8, 3, 3);

SELECT * FROM Endereco;

SELECT * FROM Telefone;

SELECT * FROM Vendedor;

SELECT * FROM Cliente;

SELECT * FROM Venda;

SELECT * FROM Parcelas;

SELECT * FROM Produto;

SELECT * FROM Venda_tem_Produto;

SELECT
	p.codigo AS 'Código',
    p.nome AS 'Nome Produto',
    v.valor AS 'Valor da Venda',
    v.numero_nota_fiscal AS 'Número da Nota Fiscal'
FROM Produto p
INNER JOIN Venda_tem_Produto vtp
ON vtp.Produto_idProduto = p.idProduto
INNER JOIN Venda v
ON vtp.Venda_idVenda = v.idVenda;

SELECT
	v.valor AS 'Valor da Venda',
    v.numero_nota_fiscal AS 'Número da Nota Fiscal',
    p.parcelas AS 'Parcela',
    p.vencimento AS 'Data de Vencimento',
    p.valor AS 'Valor da Parcela'
FROM Venda v
INNER JOIN Parcela p
ON p.Venda_idVenda = v.idVenda;

SELECT c.nome AS 'Nome Cliente', c.cpf AS 'CPF', v.valor AS 'Valor', vd.nome AS 'Vendedor'
FROM Cliente c
INNER JOIN Venda v
ON v.Cliente_idCliente = c.idCliente
INNER JOIN Vendedor vd
ON vd.idVendedor = v.Vendedor_idVendedor;

SELECT vd.nome, e.cidade
FROM Vendedor vd
INNER JOIN Endereco e
ON e.idEndereco = vd.endereco_idEndereco;

SELECT c.nome, t.numero
FROM Cliente c
INNER JOIN Telefone t
ON t.idTelefone = c.Telefone_idTelefone;

SELECT v.nome, e.cidade
FROM Vendedor v
INNER JOIN Endereco e
ON e.idEndereco = v.Endereco_idEndereco;