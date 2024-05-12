// const mysql = require("mysql")

// const connection = mysql.createConnection({
//   host: "localhost", // MySQL 地址
//   port: 3306, // MySQL 端口
//   user: "username", // MySQL 用户名
//   password: "password", // MySQL 密码
//   database: "database" // 数据库名称
// })
// connection.connect((err) => {
//     if (err) throw err;
//     console.log('Connected to MySQL!');
// });

const Sequelize = require('sequelize');

const sequelize = new Sequelize('database-for-tieba', 'root', 'MySQL@4code', {
  host: 'localhost',
  dialect: 'mysql'
});

sequelize.authenticate()
  .then(() => {
    console.log('Connection has been established successfully.');
  })
  .catch(err => {
    console.error('Unable to connect to the database:', err);
  });

const Users = sequelize.define('users', { //users表
  id: {
    type: Sequelize.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  username: {
    type: Sequelize.STRING,
    allowNull: false,
    unique: true  // 确保 username 的值是唯一的
  },
  password: {
    type: Sequelize.STRING,
    allowNull: false
  },
  permission: {
    type: Sequelize.STRING,
    allowNull: false
  }
});
Users.sync({ force: true });

//Sequelize 默认会将模型名称转换为复数形式，作为数据库中对应的表名。
const Posts = sequelize.define('posts', {
  id: {
    type: Sequelize.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  username: {
    type: Sequelize.STRING,
    allowNull: false
  },
  title: {
    type: Sequelize.STRING,
    allowNull: false
  },
  content: {
    type: Sequelize.TEXT,
    allowNull: false
  },
  likes: {
    type: Sequelize.INTEGER,
    defaultValue: 0
  },
  favourites: {
    type: Sequelize.INTEGER,
    defaultValue: 0
  }
});
Posts.sync({ force: true });


module.exports = {
  users: Users,
  posts: Posts
};