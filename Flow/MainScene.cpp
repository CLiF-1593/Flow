#include "MainScene.h"
#include <iostream>
#include <Log.h>
using namespace std;

MainScene::MainScene(int update_delay) : Scene(update_delay) {
    Log::PrintLog("MainScene", "Constructor", "������ ȣ��");
}

MainScene::~MainScene() {
    Log::PrintLog("MainScene", "Destructor", "�Ҹ��� ȣ��");
    this->run = false;
    while (!this->process_completed);
    //TODO : Delete Something
}

int MainScene::Rendering() {
    return 0;
}

int MainScene::EventProcess(Event& evt) {

    return 0;
}

int MainScene::NormalProcess() {

    return 0;
}
