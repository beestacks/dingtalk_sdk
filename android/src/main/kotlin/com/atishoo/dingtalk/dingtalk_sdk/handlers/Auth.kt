package com.atishoo.dingtalk.dingtalk_sdk.handlers

import android.content.Context
import com.atishoo.dingtalk.dingtalk_sdk.constant.CallbackResult
import com.android.dingtalk.openauth.AuthLoginParam
import com.android.dingtalk.openauth.DDAuthApiFactory
import com.android.dingtalk.openauth.IDDAuthApi

object Auth {
    private var appId: String? = null
    private var bundleId: String? = null

    private var context: Context? = null

    fun setRegister(register: Context?) {
        this.context = register
    }

    fun  registApp(appId:String?, bundleId:String?): Boolean {
        this.appId = appId;
        this.bundleId = bundleId;

        return true;
    }

    fun  sendAuth(redirectUrl:String?, scope:String?, responseType:String?, nonce:String?, state:String?, prompt:String? = "consent"): Boolean {
        val builder: AuthLoginParam.AuthLoginParamBuilder = AuthLoginParam.AuthLoginParamBuilder.newBuilder()
        builder.appId(this.appId)
        builder.redirectUri(redirectUrl)
        builder.responseType(responseType)
        builder.scope(scope)
        if (!nonce.isNullOrBlank()) {
            builder.state(nonce)
        }
        if (!state.isNullOrBlank()) {
            builder.state(state)
        }
        builder.prompt(prompt)

        val authApi: IDDAuthApi = DDAuthApiFactory.createDDAuthApi(context, builder.build())
        authApi.authLogin()
        return true;
    }
}