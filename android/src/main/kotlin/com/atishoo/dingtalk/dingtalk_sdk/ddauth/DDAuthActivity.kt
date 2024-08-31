package com.atishoo.dingtalk.dingtalk_sdk.ddauth

import android.app.Activity
import android.os.Bundle
import android.util.Log
import com.android.dingtalk.openauth.utils.DDAuthConstant
import com.atishoo.dingtalk.dingtalk_sdk.constant.AuthResponse
import com.atishoo.dingtalk.dingtalk_sdk.handlers.Responser


open class DDAuthActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try {
            val authCode: String =
                intent.getStringExtra(DDAuthConstant.CALLBACK_EXTRA_AUTH_CODE).toString()
            val state: String =
                intent.getStringExtra(DDAuthConstant.CALLBACK_EXTRA_STATE).toString()
            val error: String =
                intent.getStringExtra(DDAuthConstant.CALLBACK_EXTRA_ERROR).toString()

            Responser.sendAuthBack(AuthResponse(authCode, error, state))
        } catch (e: Exception) {
            e.printStackTrace()
            Log.d("ddauth", "e===========>$e")
        }
        finish()
    }

}