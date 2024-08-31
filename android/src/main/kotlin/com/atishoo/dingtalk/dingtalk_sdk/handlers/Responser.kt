package com.atishoo.dingtalk.dingtalk_sdk.handlers

import com.atishoo.dingtalk.dingtalk_sdk.constant.AuthResponse
import io.flutter.plugin.common.MethodChannel

object Responser {
    private var channel: MethodChannel? = null

    fun setMethodChannel(channel: MethodChannel) {
        Responser.channel = channel
    }

    fun sendAuthBack(resp: AuthResponse) {
        val result = mapOf(
            "authCode" to resp.authCode,
            "state" to resp.state,
            "error" to resp.error,
        )
        channel?.invokeMethod("onAuthResp", result)
    }
}