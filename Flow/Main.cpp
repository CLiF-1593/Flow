#include <iostream>
#include <string>
#include <filesystem>
#include "Flow.h"
#include "FileIO.h"
#include "Log.h"
using namespace std;

#define arg(x) (argc > x ? input[x] : "")

int main(int argc, char* argv[]) {
	vector<string> input;
	for (int i = 1; i < argc; i++) {
		input.push_back(argv[i]);
	}

	if (input.empty())
		return 0;
	
	Flow flow;
	string cmd = input.front();

	//Open Flow
	if (cmd == "create") {
		if (arg(1) == "folder") flow.CreateFlow(FLOW_FOLDER_STORAGE);
		else if (arg(1) == "file") flow.CreateFlow(FLOW_FILE_STORAGE);
	}
	else if (cmd == "open") {
		flow.LoadFlow();
	}
	else {
		FILE* f;
		string cur_flow_path = FileIO::OpenFile("flow.cur");
		if (filesystem::exists(cur_flow_path)) {
			flow.LoadWithPath(cur_flow_path);
		}
	}

	// Getter
	if (cmd == "get_branch") {
		flow.PrintBranch();
	}
	else if (cmd == "get_activated_branch") {
		Log::Flow(flow.GetActivatedBranch()->GetBranchID().str());
	}
	else if (cmd == "get_change_log") {
		Metadata::PrintLog(flow.GetActivatedBranch()->GetChange());
	}
	else if (cmd == "get_history") {
		flow.GetActivatedBranch()->PrintHistory();
	}
	else if (cmd == "check_changed") {
		Log::Flow(flow.GetActivatedBranch()->CheckChanged());
	}

	// Branch External Command
	else if (cmd == "create_sub_branch") {
		flow.CreateSubBranch(arg(1));
	}
	else if (cmd == "merge") {
		BranchID id = UUIDv4::UUID::fromStrFactory(arg(1).c_str());
		flow.Merge(id);
	}
	else if (cmd == "replace") {
		BranchID id = UUIDv4::UUID::fromStrFactory(arg(1).c_str());
		flow.Replace(id);
	}
	else if (cmd == "delete_branch") {
		flow.DeleteBranch();
	}
	else if (cmd == "activate_branch") {
		BranchID id = UUIDv4::UUID::fromStrFactory(arg(1).c_str());
		flow.ActivateBranch(id);
	}
	else if (cmd == "change_name") {
		BranchID id = UUIDv4::UUID::fromStrFactory(arg(1).c_str());
		flow.ChangeBranchName(id, arg(2));
	}

	// Branch Internal Command
	else if (cmd == "commit") {
		flow.GetActivatedBranch()->Commit(arg(1), arg(2));
	}
	else if (cmd == "revert") {
		flow.GetActivatedBranch()->Revert(stoi(arg(1)));
	}
	else if (cmd == "delete") {
		flow.GetActivatedBranch()->Delete(stoi(arg(1)));
	}

	flow.SaveFlow();
	FileIO::SaveFile("flow.cur", flow.GetFlowPath());
	return 0;
}

/*
	[Command Table]
	
	flow create file (or folder) #flow �����

	flow open #flow ����

	flow create_sub_branch [name] #sub branch �����

	flow merge [branch id] #branch id�� �ش��ϴ� branch�� activated branch merge
	>> [path string] origin (or target or duplicate)
	>> [path string] origin (or target or duplicate)
	>> ...
	input : list of 0 or 1 or 2 (0�� ���� ����, 1�� origin �ݿ�, 2�� target �ݿ�, �� ��°� ������ŭ�� element�� ������ ����)

	flow replace [branch id] #branch id�� �ش��ϴ� branch�� activated branch�� replace

	flow delete_branch #activated branch ����

	flow activate_branch [branch id] #branch id�� �ش��ϴ� branch Ȱ��ȭ

	flow get_branch
	>> [branch id] [name] [origin branch id] [last commit time]
	>> [branch id] [name] [origin branch id] [last commit time]
	>> ...

	flow get_activated_branch
	>> [activated branch id]

	flow change_name [branch id] [new_name] #�귣ġ �̸� �ٲٱ�

	flow check_changed #�귣ġ�� ��������� �ִ��� Ȯ��
	>> 0 or 1 (0�̸� �ٲ��� ����, 1�̸� �ٲ�)

	flow get_change_log
	>> [path] added or deleted or modified
	>> [path] added or deleted or modified
	>> ...

	flow commit [title] [description] #Ŀ��

	flow revert [n] #n��° �����丮�� revert (0���� ����)

	flow delete [n] #n��° �����丮 ���� (0���� ����)

	flow get_history
	>> [title] [description] [commit time]
	>> [title] [description] [commit time]
	>> ...
*/