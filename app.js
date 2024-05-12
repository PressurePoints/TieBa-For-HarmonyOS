const express = require('express');
const app = express();
const { users, posts} = require('./db');

app.use(express.urlencoded({ extended: true }));
app.use(express.json())

app.post("/post/favourite/increase", async (req, res) => {
    try {
        const {id} = req.body;
        console.info("\n" +id+"\n")
        // 使用 findByPk 查询匹配指定 postId 的数据记录
        const post = await posts.findByPk(id);

        if (post) {
            console.info("found")
            // 如果找到匹配的记录，则增加点赞数
            post.favourites += 1;
            await post.save();
            console.info("Increased")
            res.json({data: post, message: "点赞成功！" });
        } else {
            console.info("Not found")
            res.status(404).json({ message: "帖子不存在" });
        }
    } catch (error) {
        console.error(error);  // 打印错误信息
        res.status(500).json({ message: "服务器内部错误" });
    }
});

app.post("/post/like/increase", async (req, res) => {
    try {
        const {id} = req.body;
        console.info("\n" +id+"\n")
        // 使用 findByPk 查询匹配指定 postId 的数据记录
        const post = await posts.findByPk(id);

        if (post) {
            console.info("found")
            // 如果找到匹配的记录，则增加点赞数
            post.likes += 1;
            await post.save();
            console.info("Increased")
            res.json({data: post, message: "点赞成功！" });
        } else {
            console.info("Not found")
            res.status(404).json({ message: "帖子不存在" });
        }
    } catch (error) {
        console.error(error);  // 打印错误信息
        res.status(500).json({ message: "服务器内部错误" });
    }
});

app.get("/post/get" , async (req, res) => {
    try {
        const result = await posts.findAll();
        res.json(result);
    } catch (error) {
        console.error(error);  // 打印错误信息
        res.status(500).send("error")
    }
})

app.post("/post/publish", async (req, res) => {
    try {
        console.log(req.body)
        const { username, title, content } = req.body;
        await posts.create({
            username, title, content
        });
        res.send("success")
    } catch (error) {
      console.error(error);  // 打印错误信息
      res.status(500).send("error")
    }
})

// 注册账号
app.post("/publish", async (req, res) => {
    try {
        const { username, password, permission } = req.body;
        await users.create({
            username, password, permission
        });
        res.send("success")
    } catch (error) {
      console.error(error);  // 打印错误信息
      res.status(500).send("error")
    }
})
// 注销账号
app.post("/del", async (req, res) => {
    console.log(req.body.username)
    try {
        const { username } = req.body;

        // 使用 destroy 删除匹配指定 username 的数据记录
        const result = await users.destroy({
            where: { username: username }
        });

        if (result) {
            res.json({ message: "删除成功！" });
        } else {
            res.status(404).json({ message: "用户名不存在" });
        }
    } catch (error) {
      res.status(500).send("error");
    }
})
// 修改密码
app.post("/upd/newPassword", async (req, res) => {
    try {
        const { username, newPassword } = req.body;
        console.info("\n" +username+"\n"+newPassword+"\n")
        const result = await users.findOne({ where: { username: username }, attributes: ['id', 'username', 'password', 'permission'] });

        if (result) {
            result.password = newPassword;
            await result.save();
            res.json({ message: "更新成功！"});
        } else {
            res.status(404).json({ message: "用户名不存在" });
        }
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
// 修改账号
app.post("/upd/newUsername", async (req, res) => {
    try {
        console.info("Begin to change username")
        const { username, newUsername } = req.body;
        console.info("\n"+"YYYYYYYYY"+"\n")
        const origin_result = await users.findOne({ where: { username: username }, attributes: ['id', 'username', 'password', 'permission'] });
        const new_result = await users.findOne({ where: { username: newUsername }, attributes: ['id', 'username', 'password', 'permission'] });

        if(new_result){
            res.status(404).json({ message: "用户名已存在" });
        }
        else{
            origin_result.username = newUsername;
            await origin_result.save();
            res.json({ message: "更新成功！"});
        }
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
// 账号登录
app.get("/find/:username/:password", async (req, res) => {
    // 在 axios 中，任何 HTTP 状态码大于或等于 200 且小于 300 都被认为是成功的响应
    try {
        const username = req.params.username;
        const password = req.params.password;

        // 使用 findOne 查询匹配指定 username 和 password 的数据记录
        const result = await users.findOne({ where: { username: username }, attributes: ['id', 'username', 'password', 'permission'] });

        if (result) {
            if(result.password !== password) {
                res.status(401).json({ message: "密码错误" });
            }
            else{
                // 如果找到匹配的记录，则返回匹配的记录
                res.json({data: result, message: "登录成功！" });return;
            }
        } else {
            res.status(404).json({ message: "用户名不存在" });
        }
    } catch (error) {
        console.error(error);  // 打印错误信息
        res.status(500).json({ message: "服务器内部错误" });
    }
});


app.listen(3001, () => {
    console.log('server running')
})

module.exports = app;