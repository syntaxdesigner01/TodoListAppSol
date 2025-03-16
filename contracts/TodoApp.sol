// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TodoList {
    struct Task {
        uint id;
        string content;
        bool completed;
    }

    mapping(uint => Task) public tasks;
    uint public taskCount;

    event TaskCreated(uint id, string content, bool completed);
    event TaskCompleted(uint id, bool completed);
    event TaskRemoved(uint id);

    constructor() {
        taskCount = 0;
    }

    function createTask(string memory _content) public {
        taskCount++;
        tasks[taskCount] = Task(taskCount, _content, false);
        emit TaskCreated(taskCount, _content, false);
    }

    function completeTask(uint _id) public {
        require(_id > 0 && _id <= taskCount, "Task ID is out of range");
        Task storage task = tasks[_id];
        task.completed = true;
        emit TaskCompleted(_id, true);
    }

    function removeTask(uint _id) public {
        require(_id > 0 && _id <= taskCount, "Task ID is out of range");
        delete tasks[_id];
        emit TaskRemoved(_id);
    }

    function getTask(uint _id) public view returns (uint, string memory, bool) {
        require(_id > 0 && _id <= taskCount, "Task ID is out of range");
        Task memory task = tasks[_id];
        return (task.id, task.content, task.completed);
    }

    function getAllTasks() public view returns (Task[] memory) {
        Task[] memory allTasks = new Task[](taskCount);
        for (uint i = 1; i <= taskCount; i++) {
            allTasks[i - 1] = tasks[i];
        }
        return allTasks;
    }
}