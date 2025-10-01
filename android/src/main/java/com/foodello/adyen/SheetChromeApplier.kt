package com.foodello.adyen

import android.content.res.ColorStateList
import android.view.ViewGroup
import android.widget.ImageButton
import android.widget.TextView
import com.foodello.adyen.style.asColorOrNull
import com.foodello.adyen.style.optJSObject
import com.foodello.adyen.style.optNonBlankString
import com.getcapacitor.JSObject

object SheetChromeApplier {
    data class Targets(
        val sheet: ViewGroup,
        val headerTitle: TextView?,
        val headerClose: ImageButton?
    )

    fun apply(style: JSObject?, viewOptions: JSObject?, targets: Targets) {
        // Sheet surface
        style?.optNonBlankString("backgroundColor")?.asColorOrNull()
            ?.let { targets.sheet.setBackgroundColor(it) }

        val titleText = viewOptions?.optNonBlankString("title")

        val titleColor =
            viewOptions?.optNonBlankString("titleColor")?.asColorOrNull()
                ?: style?.optJSObject("header")?.optNonBlankString("color")?.asColorOrNull()

        val titleBg =
            viewOptions?.optNonBlankString("titleBackgroundColor")?.asColorOrNull()
                ?: style?.optNonBlankString("backgroundColor")?.asColorOrNull()

        val titleTint =
            viewOptions?.optNonBlankString("titleTintColor")?.asColorOrNull()
                ?: style?.optNonBlankString("tintColor")?.asColorOrNull()

        targets.headerTitle?.let { tv ->
            if (!titleText.isNullOrEmpty()) tv.text = titleText
            titleColor?.let(tv::setTextColor)
            titleBg?.let(tv::setBackgroundColor)
        }
        titleTint?.let { targets.headerClose?.imageTintList = ColorStateList.valueOf(it) }
    }
}
