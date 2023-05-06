#include "Flow.h"
#include "FileIO.h"
#include "json/json.h"
#include <filesystem>
#include <CkZip.h>
#include "Log.h"
using namespace std;

void Flow::Deleter(BranchID id) {
	auto del_i_iter = find(this->branch_id_list.begin(), this->branch_id_list.end(), this->activated_branch_id);
	if (del_i_iter == this->branch_id_list.end()) {
		Log::Debug("Flow", "Delete", "Cannot find Activated Branch in branch_id_list -> Fatal Error");
		return;
	}
	this->branch_id_list.erase(del_i_iter);

	BranchID branch_del_id = this->activated_branch_id;
	this->activated_branch_id = this->GetActivatedBranch()->GetOriginBranchID();

	this->branch_table.erase(branch_del_id);
	this->GetActivatedBranch()->Activate();

	string path = this->target_path + ".flowdata\\" + branch_del_id.str();

	filesystem::remove(path + ".branch");
	filesystem::remove_all(path + ".history");
	filesystem::remove(path + ".dat");
}

Flow::Flow() {
	this->id = NULL_ID;
	this->name = "";
	this->storage_type = FLOW_FILE_STORAGE;
	this->branch_id_list.clear();
	this->branch_table.clear();
	this->file_path = "";
	this->activated_branch_id = NULL_ID;
}

Flow::~Flow() {
}

int Flow::CreateFlow(FlowStorageType type) {
	if (this->id != NULL_ID) {
		Log::Debug("Flow", "CreateFlow", "Flow has already assigned");
		return 1;
	}
	Log::Debug("Flow", "CreateFlow");

	string origin_path;
	switch (type) {
	case FLOW_FILE_STORAGE:
		origin_path = FileIO::OpenFileName();
		break;
	case FLOW_FOLDER_STORAGE:
		origin_path = FileIO::OpenFolderName();
		break;
	}

	if (origin_path.empty())
		return 1;

	UUIDv4::UUIDGenerator<std::mt19937_64> uuidGenerator;
	string header_path = origin_path;

	this->target_path = origin_path;
	this->name = "";
	while (header_path.back() != '\\') {
		this->name = header_path.back() + this->name;
		header_path.pop_back();
	}
	this->file_path = header_path + this->name + ".flow";
	this->storage_type = type;
	this->id = uuidGenerator.getUUID();
	filesystem::create_directory(header_path + this->name + ".flowdata");
	Branch main_branch;
	main_branch.CreateBranch(header_path + this->name + ".flowdata\\", "Main", NULL_ID, &this->target_path);
	this->branch_id_list.push_back(main_branch.GetBranchID());
	this->branch_table[main_branch.GetBranchID()] = main_branch;
	this->activated_branch_id = main_branch.GetBranchID();

	CkZip zip;
	zip.NewZip((header_path + this->name + ".flowdata\\" + main_branch.GetBranchID().str() + ".dat").c_str());
	zip.put_OemCodePage(65001);
	zip.WriteZipAndClose();
	return 0;
}

int Flow::LoadFlow() {
	if (this->id != NULL_ID) {
		Log::Debug("Flow", "LoadFlow", "Flow has already assigned");
		return 1;
	}
	Log::Debug("Flow", "LoadFlow");
	string flow_path = FileIO::OpenFlowFile();
	if (flow_path.empty())
		return 1;
	this->file_path = flow_path;
	while (flow_path.back() != '\\')
		flow_path.pop_back();
	Json::Value flow = FileIO::GetJsonFile(this->file_path);
	this->id = UUIDv4::UUID::fromStrFactory(flow["FlowID"].asString().c_str());
	this->name = flow["Name"].asString();
	this->target_path = flow["TargetPath"].asString();
	this->storage_type = static_cast<FlowStorageType>(flow["StorageType"].asInt());
	this->activated_branch_id = UUIDv4::UUID::fromStrFactory(flow["ActivatedBranchID"].asString().c_str());
	for (int i = 0; i < flow["BranchList"].size(); i++) {
		BranchID id = UUIDv4::UUID::fromStrFactory(flow["BranchList"][i].asString().c_str());
		this->branch_id_list.push_back(id);
		Branch branch;
		branch.LoadBranch(flow_path + this->name + ".flowdata\\" + id.str(), &this->target_path);
		this->branch_table[this->branch_id_list.back()] = branch;
	}
	return 0;
}

int Flow::SaveFlow() {
	if (this->id == NULL_ID) {
		Log::Debug("Flow", "SaveFlow", "Flow is empty");
		return 1;
	}
	Log::Debug("Flow", "SaveFlow");
	Json::Value flow;
	flow["FlowID"] = this->id.str();
	flow["Name"] = this->name;
	flow["TargetPath"] = this->target_path;
	flow["StorageType"] = this->storage_type;
	flow["ActivatedBranchID"] = this->activated_branch_id.str();
	for (int i = 0; i < this->branch_id_list.size(); i++) {
		this->branch_table[this->branch_id_list[i]].SaveBranch();
		flow["BranchList"].append(this->branch_id_list[i].str());
	}
	FileIO::SaveFile(this->file_path, flow);
	return 0;
}

Branch* Flow::operator[](BranchID id) {
	if (this->id == NULL_ID) {
		Log::Debug("Flow", "operator[]", "Flow is empty");
		return nullptr;
	}
	return &(this->branch_table[id]);
}

int Flow::CreateSubBranch(std::string name) {
	Log::Debug("Flow", "CreateSubBranch");
	Branch sub_branch;
	string header_path = this->target_path;
	while (header_path.back() != '\\') {
		header_path.pop_back();
	}
	BranchID original_id = this->GetActivatedBranch()->GetBranchID();
	this->GetActivatedBranch()->Activate();

	sub_branch.CreateBranch(header_path + this->name + ".flowdata\\", name, original_id, &this->target_path);
	this->branch_id_list.push_back(sub_branch.GetBranchID());
	this->branch_table[sub_branch.GetBranchID()] = sub_branch;
	filesystem::copy((header_path + this->name + ".flowdata\\" + original_id.str() + ".dat"), (header_path + this->name + ".flowdata\\" + sub_branch.GetBranchID().str() + ".dat"), filesystem::copy_options::overwrite_existing);
	this->ActivateBranch(sub_branch.GetBranchID());
	return 0;
}

void FileSearch(string path, vector<string> &files, int remove_size) {
	if (!filesystem::exists(path)) {
		return;
	}
	if (!filesystem::is_directory(path)) {
		path = path.substr(remove_size);
		files.push_back(path);
		return;
	}
	filesystem::directory_iterator itr(path);
	while (itr != filesystem::end(itr)) {
		const filesystem::directory_entry& entry = *itr;
		if (entry.is_directory()) {
			FileSearch(entry.path().string(), files, remove_size);
		}
		else {
			path = path.substr(remove_size);
			files.push_back(path);
		}
		itr++;
	}
}

int Flow::Merge(BranchID target_branch) {
	if (this->GetActivatedBranch()->GetOriginBranchID() == NULL_ID) {
		Log::Debug("Flow", "Replace", "Main Branch cannot be merged");
		return 1;
	}

	if (this->GetActivatedBranch()->CheckChanged()) {
		Log::Debug("Flow", "Replace", "You must commit first");
		return 1;
	}

	string header_path = this->target_path;
	while (header_path.back() != '\\') {
		header_path.pop_back();
	}

	string target_dat = header_path + this->name + ".flowdata\\" + this->branch_table[target_branch].GetBranchID().str() + ".dat";
	string origin_dat = header_path + this->name + ".flowdata\\" + this->GetActivatedBranch()->GetBranchID().str() + ".dat";
	string target_dat_path = header_path + this->name + ".flowdata\\" + ".merge_tmp\\target";
	string origin_dat_path = header_path + this->name + ".flowdata\\" + ".merge_tmp\\origin";
	string merge_dat_path = header_path + this->name + ".flowdata\\" + ".merge_tmp\\merge";

	filesystem::create_directories(target_dat_path);
	filesystem::create_directories(origin_dat_path);
	filesystem::create_directories(merge_dat_path);
	CkZip zip;
	zip.OpenZip(target_dat.c_str());
	zip.Unzip(target_dat_path.c_str());
	zip.CloseZip();
	zip.OpenZip(origin_dat.c_str());
	zip.Unzip(origin_dat_path.c_str());
	zip.CloseZip();

	vector<string> origin_files, target_files;
	FileSearch(target_dat_path, target_files, target_dat_path.size());
	FileSearch(origin_dat_path, origin_files, origin_dat_path.size());

	vector<pair<string, string>> total_files;
	for (int i = 0; i < origin_files.size(); i++) {
		total_files.push_back(make_pair(origin_files[i], "origin"));
	}
	for (int i = 0; i < target_files.size(); i++) {
		auto pos = find(total_files.begin(), total_files.end(), make_pair(target_files[i], "origin"));
		if (pos == total_files.end()) {
			total_files.push_back(make_pair(target_files[i], "target"));
		}
		else {
			pos->second = "duplicate";
		}
	}
	sort(total_files.begin(), total_files.end());

	for (int i = 0; i < total_files.size(); i++) {
		Log::Flow(total_files[i].first, total_files[i].second);
	}

	vector<int> input;
	for (int i = 0; i < total_files.size(); i++) {
		int in;
		cin >> in;
		input.push_back(in);
	}

	for (int i = 0; i < total_files.size(); i++) {
		if (input[i] == 1) {
			filesystem::copy(origin_dat_path + "\\" + total_files[i].first, merge_dat_path + "\\" + total_files[i].first, filesystem::copy_options::overwrite_existing);
		}
		else if (input[i] == 2) {
			filesystem::copy(target_dat_path + "\\" + total_files[i].first, merge_dat_path + "\\" + total_files[i].first, filesystem::copy_options::overwrite_existing);
		}
	}

	string merge_dat = merge_dat_path + "\\merge.dat";
	zip.NewZip(merge_dat.c_str());
	string target_path = merge_dat_path + "\\" + this->name;
	zip.put_OemCodePage(65001);
	if (filesystem::is_directory(target_path)) {
		zip.AppendFiles((target_path + "\\*").c_str(), true);
	}
	else {
		zip.AppendFiles(target_path.c_str(), true);
	}
	zip.WriteZipAndClose();

	this->branch_table[target_branch].Commmiter(target_dat, merge_dat, REPLACE, "Replace", "From \"" + this->GetActivatedBranch()->GetName()) + "\" Branch";
	filesystem::remove_all(header_path + this->name + ".flowdata\\" + ".merge_tmp");
	return 0;
}

int Flow::Replace(BranchID target_branch) {
	if (this->GetActivatedBranch()->GetOriginBranchID() == NULL_ID) {
		Log::Debug("Flow", "Replace", "Main Branch cannot be merged");
		return 1;
	}

	if (this->GetActivatedBranch()->CheckChanged()) {
		Log::Debug("Flow", "Replace", "You must commit first");
		return 1;
	}
	
	string header_path = this->target_path;
	while (header_path.back() != '\\') {
		header_path.pop_back();
	}
	
	string target_dat = header_path + this->name + ".flowdata\\" + this->branch_table[target_branch].GetBranchID().str();
	string origin_dat = header_path + this->name + ".flowdata\\" + this->GetActivatedBranch()->GetBranchID().str();
	this->branch_table[target_branch].Commmiter(target_dat + ".dat", origin_dat + ".dat", REPLACE, "Replace", "From \"" + this->GetActivatedBranch()->GetName()) + "\" Branch";
	return 0;
}

int Flow::DeleteBranch() {
	if (this->GetActivatedBranch()->GetOriginBranchID() == NULL_ID) {
		Log::Debug("Flow", "Delete", "Main Branch cannot be deleted");
		return 1;
	}
	
	vector<BranchID> to_delete;
	to_delete.push_back(this->GetActivatedBranch()->GetBranchID());
	while (to_delete.empty()) {
		BranchID target = to_delete.back();
		to_delete.pop_back();
		this->Deleter(target);
		for (int i = 0; i < this->branch_id_list.size(); i++) {
			if (this->branch_table[this->branch_id_list[i]].GetOriginBranchID() == target) {
				to_delete.push_back(this->branch_id_list[i]);
			}
		}
	}
	return 0;
}

int Flow::ActivateBranch(BranchID branch) {
	if (branch == this->activated_branch_id) {
		return 0;
	}
	this->GetActivatedBranch()->SaveCache();
	this->activated_branch_id = branch;
	this->GetActivatedBranch()->Activate();
	return 0;
}

Branch* Flow::GetActivatedBranch() {
	if (this->activated_branch_id == NULL_ID) {
		Log::Debug("Flow", "GetActivatedBranch", "Activated Branch does not exist");
		return nullptr;
	}
	return (*this)[this->activated_branch_id];
}

const std::vector<BranchID>& Flow::GetBranchIDList() const {
	return this->branch_id_list;
}
