// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TodoList {
    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todos;

    event TodoAdded(uint256 indexed id, string text);
    event TodoToggled(uint256 indexed id, bool completed);
    event TodoRemoved(uint256 indexed id);

    function addTodo(string memory _text) public {
        todos.push(Todo(_text, false));
        emit TodoAdded(todos.length - 1, _text);
    }

    function toggleTodo(uint256 _index) public {
        require(_index < todos.length, "Todo does not exist");
        todos[_index].completed = !todos[_index].completed;
        emit TodoToggled(_index, todos[_index].completed);
    }

    function removeTodo(uint256 _index) public {
        require(_index < todos.length, "Todo does not exist");
        for (uint i = _index; i < todos.length - 1; i++) {
            todos[i] = todos[i + 1];
        }
        todos.pop();
        emit TodoRemoved(_index);
    }

    function getTodos() public view returns (Todo[] memory) {
        return todos;
    }

    function getTodoCount() public view returns (uint256) {
        return todos.length;
    }
}