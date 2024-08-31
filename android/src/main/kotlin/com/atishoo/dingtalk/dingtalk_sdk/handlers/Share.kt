package com.atishoo.dingtalk.dingtalk_sdk.handlers

import android.content.Context

object Share {
    private var appId: String? = null
    private var bundleId: String? = null

    private var context: Context? = null

    fun setRegister(register: Context?) {
        this.context = register
    }
}